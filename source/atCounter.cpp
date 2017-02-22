#pragma hdrstop
#include "atCounter.h"
//---------------------------------------------------------------------------


Counter::Counter()
:
mCount(0),
mCountTo(10),
mOnCountCallBack(NULL)
{}

void Counter::increase(int count)
{
	mCount += count;
    //Check....
    if(mCount >= mCountTo)
    {
    	if(mOnCountCallBack)
        {
        	mOnCountCallBack(mCount);
        }
		//reset count
        mCount = 0;
    }
}

void Counter::decrease()
{
	mCount--;
    if(mCount <= mCountTo)
    {
    	if(mOnCountCallBack)
        {
        	mOnCountCallBack(mCount);
        }
    }
}

void Counter::reset(int count, int countTo)
{
	mCount = count;
    mCountTo = countTo;
}

int	Counter::getCount()
{
	return mCount;
}

int& Counter::getCountReference()
{
	return mCount;
}

int& Counter::getCountToReference()
{
	return mCountTo;
}

void Counter::assignOnCountCallBack(OnCountCallBack cb)
{
	mOnCountCallBack = cb;
}
