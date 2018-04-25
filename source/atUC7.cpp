#include <vcl.h>
#pragma hdrstop
#include <tchar.h>
//---------------------------------------------------------------------------
#include <Vcl.Styles.hpp>
#include <Vcl.Themes.hpp>
USEFORM("UI\TMainForm.cpp", MainForm);
//---------------------------------------------------------------------------
#include "dslUtils.h"
#include "dslVCLUtils.h"
#include "dslIniKey.h"
#include "dslRestartApplicationUtils.h"
#include "dslLogger.h"
#include "dslException.h"
#include "dslSQLite.h"
#pragma package(smart_init)

using namespace dsl;
using std::string;

extern HWND         gOtherAppWindow             = NULL;
extern bool 		gAppIsStartingUp 			= true;
extern string       gApplicationRegistryRoot    = "\\Software\\Allen Institute\\atUC7";
extern string       gAppMutexName           	= "UC7AppMutex";
extern string       gRestartMutexName           = "UC7RestartMutex";
extern string       gFullDateTimeFormat         = "%Y-%m-%dT%H:%M:%S";
extern string       gDateFormat                 = "%Y-%m-%d";
extern string       gTimeFormat                 = "%H:%M:%S";

extern string       gCommonAppDataLocation      = ""; //Filled out later
extern string       gLogFileLocation            = "";
extern string       gLogFileName                = "atUC7.log";

BOOL CALLBACK FindOtherWindow(HWND hwnd, LPARAM lParam) ;

void setupLogging();
//---------------------------------------------------------------------------
int WINAPI _tWinMain(HINSTANCE, HINSTANCE, LPTSTR, int)
{
    //The app mutex is used to check for already running instances
    try
    {

        setupLogging();
        Log(lInfo) << "The Logfile was opened..";

        //Setup globals
        gCommonAppDataLocation = joinPath(getSpecialFolder(CSIDL_LOCAL_APPDATA), "atUC7");
        if(!folderExists(gCommonAppDataLocation))
        {
            Log(lError) << "The local app data folder("<<gCommonAppDataLocation<<") don't exists! Catastrophe..";
        }

        Application->Initialize();
        Application->MainFormOnTaskBar = true;
		TStyleManager::TrySetStyle("Iceberg Classico");
		Application->Title = "atUC7";
        Application->ProcessMessages();
		Application->CreateForm(__classid(TMainForm), &MainForm);
		Application->Run();
	}
	catch (Exception &exception)
	{
		Application->ShowException(&exception);
	}
	catch(const DSLException &e)
	{
		throw Exception(e.what());
	}

	catch (...)
	{
		try
		{
			throw Exception("There was something bad happening! We have to close atDB.");
		}
		catch (Exception &exception)
		{
			Application->ShowException(&exception);
		}
	}
	return 0;
}

void setupLogging()
{
	//Get Application folder
	string fldr =  joinPath(getSpecialFolder(CSIDL_LOCAL_APPDATA), "atUC7");
	if(!folderExists(fldr))
	{
		createFolder(fldr);
	}

	gLogFileLocation = fldr;
	string fullLogFileName(joinPath(gLogFileLocation, gLogFileName));
	clearFile(fullLogFileName);
	dsl::gLogger.logToFile(fullLogFileName);
	LogOutput::mShowLogLevel = true;
	LogOutput::mShowLogTime = true;
	LogOutput::mUseLogTabs = false;
	Log(lInfo) << "Logger was setup";
}
