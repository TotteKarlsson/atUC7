#pragma hdrstop
#include "atUC7MessageSender.h"
#include "mtkStringUtils.h"
#include "Poco/Mutex.h"
#include "mtkLogger.h"
#include "mtkUtils.h"
#include "atUC7Component.h"
#include "atUC7ApplicationMessages.h"
#include "atUC7DataStructures.h"
//---------------------------------------------------------------------------

using Poco::Mutex;
using namespace mtk;

//----------------------------------------------------------------
UC7MessageSender::UC7MessageSender(UC7& uc7)
:
mtk::Thread(""),
mAllowProcessing(true),
mUC7(uc7),
mProcessedCount(0),
mProcessTimeDelay(50)
{}

//----------------------------------------------------------------
UC7MessageSender::~UC7MessageSender()
{
	if(mIsRunning)
    {
		stop();
    }
}

bool UC7MessageSender::start(bool inThread)
{
	if(isRunning())
	{
		Log(lWarning) << "Tried to start a runnning thread";
		return true;
	}
	if(inThread)
	{
		return mtk::Thread::start();
	}
	else
	{
		worker();
		return true;
	}
}

void UC7MessageSender::pauseProcessing()
{
	mAllowProcessing = false;
}

void UC7MessageSender::resumeProcessing()
{
	mAllowProcessing = true;
}

void UC7MessageSender::stop()
{
	//Sets time to die to true
	mtk::Thread::stop();

	//If thread is waiting.. get it out of wait state
	mUC7.mNewMessageToSendCondition.signal();
}

void UC7MessageSender::run()
{
	worker();
}

void UC7MessageSender::worker()
{
	Log(lDebug)<<"Entering UC7 message sender worker function";
	while(mIsTimeToDie == false)
	{
		{
			Poco::ScopedLock<Poco::Mutex> lock(mUC7.mSendBufferMutex);
			if(mUC7.mOutgoingMessagesBuffer.size() == 0)
			{
				Log(lDebug3) << "Waiting for UC7 message.";
				mUC7.mNewMessageToSendCondition.wait(mUC7.mSendBufferMutex);
			}

            while(mUC7.mOutgoingMessagesBuffer.size() && mIsTimeToDie == false)
            {
            	try
                {
                    string msg = mUC7.mOutgoingMessagesBuffer.front();
                    mUC7.mOutgoingMessagesBuffer.pop_front();

                    //Send windows message and let UI handle the message
                    if(!mUC7.mSerial.send(msg))
                    {
                        Log(lError) << "Sending UC7 message failed..";
                    }

                    sleep(mProcessTimeDelay);
                }
                catch(...)
                {
                	Log(lError) << "Bad stuff in message consumer..";
                }
            }

		}//scoped lock
	}

    Log(lInfo) << "UC7 Message Sender thread finished";
	mIsFinished = true;
	mIsRunning = false;
}
