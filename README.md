# EnforceAdobeReader32bit
Removes Adobe 64bit, sets the reg entry to prevent Adobe to upgrade to 64 bit, calls the setup.

Adobe updates the Reader to 64bit in background. There are applications that require the 32bit version of Adobe to work properly. The script will... 

...remove any installations with the name "Adobe Acrobat Reader - English", "Adobe Acrobat Reader - Deutsch" (add other languages as required)
...set the reg entries to prevent the upgrade behavior:  "bUpdateToSingleApp=0" under HKLM\SOFTWARE\Policies\Adobe\Acrobat Reader\DC\FeatureLockDown" both in the 32 and 64 branch 
-	Run "setup.exe /sAll /ini .\setup.ini /rs". The intention is to install Adobe Reader again. Place Adobe in that folder to make the script work.
-	Write a log, c:\windows\Logs\CleanAdobe.log

