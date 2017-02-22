#ifndef atCounterH
#define atCounterH
#include "atABObject.h"
//---------------------------------------------------------------------------
typedef void (__closure *OnCountCallBack)(int count);


class AT_CORE Counter : public ABObject
{
	public:
    								Counter();
		void						increase(int count = 1);
		void						decrease();
		void						reset(int count = 0, int countTo = 10);
        int							getCount();
        int&		  				getCountReference();
        int&		  				getCountToReference();
		void 						assignOnCountCallBack(OnCountCallBack cb);

    private:
    	int							mCount;
        int							mCountTo;
        OnCountCallBack				mOnCountedToCallBack;
        OnCountCallBack				mOnCountCallBack;
};

#endif
