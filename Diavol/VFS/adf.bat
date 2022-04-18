%USERPROFILE%\Desktop\Diavol\adfind\AdFind.exe -f "(objectcategory=person)" > %USERPROFILE%\Desktop\Diavol\adfind\results\ad-users.txt
%USERPROFILE%\Desktop\Diavol\adfind\AdFind.exe -f "objectcategory=computer" > %USERPROFILE%\Desktop\Diavol\adfind\results\ad_computers.txt
%USERPROFILE%\Desktop\Diavol\adfind\AdFind.exe -f "(objectcategory=organizationalUnit)" > %USERPROFILE%\Desktop\Diavol\adfind\results\ad_ou.txt
%USERPROFILE%\Desktop\Diavol\adfind\AdFind.exe -sc trustdmp > %USERPROFILE%\Desktop\Diavol\adfind\results\ad_trustdmp.txt
%USERPROFILE%\Desktop\Diavol\adfind\AdFind.exe -subnets -f (objectCategory=subnet) > %USERPROFILE%\Desktop\Diavol\adfind\results\ad_subnet.txt
%USERPROFILE%\Desktop\Diavol\adfind\AdFind.exe -f "(objectcategory=group)" > %USERPROFILE%\Desktop\Diavol\adfind\results\ad_group.txt
%USERPROFILE%\Desktop\Diavol\adfind\AdFind.exe -gcb -sc trustdmp > %USERPROFILE%\Desktop\Diavol\adfind\results\ad_trustdmp2.txt
