#!/bin/bash
# Program:
#       Automatic install some package to allow you to customize your elementary OS.
#
# History:
# 2013/08/17 Duye Chen release Chinese version

PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

function show_package()
{
    echo -e "安裝項目：\n"\
            "1. Elementary Tweak\t協助調整系統用的工具\n"\
            "2. WINGPANEL SLIM\t美化系統欄\n"\
            "3. INDICATOR SYNAPSE\t取代附屬應用程式選單的好套件\n"\
            "4. Audience\t\t與eOS高度融合的影片播放軟體\n"\
            "5. 佈景主題\n"\
            "6. 圖示主題\n"\
            "7. 其他佈景主題\n"\
            "8. 桌布集"
}

function install_choice()
{
    user_choice=$@

    for ((i=$#; i>0; i=i-1))
    do
        install_package $i $user_choice;
    done
}

function install_package()
{
    shift $1
    option=$@

    case $1 in
        "1")
            echo -e "安裝 Elementary Tweak"
            sudo apt-get install elementary-tweaks -y
            ;;
        "2")
            echo -e "安裝 WINGPANEL SLIM"
            sudo apt-get install wingpanel-slim -y
            ;;
        "3")
            echo -e "安裝 WINGPANEL SLIM"
            sudo apt-get install indicator-synapse -y 
            ;;
        "4")
            echo -e "安裝 Audience"
            sudo apt-get install audience -y
            ;;
        "5")
            echo -e "安裝 佈景主題"
            sudo apt-get install elementary-blue-theme elementary-champagne-theme elementary-colors-theme elementary-dark-theme elementary-harvey-theme elementary-lion-theme elementary-matteblack-theme elementary-milk-theme elementary-plastico-theme elementary-whit-e-theme -y
            ;;
        "6")
            echo -e "安裝 圖示主題"
            sudo apt-get install elementary-elfaenza-icons elementary-emod-icons elementary-enumix-utouch-icons elementary-nitrux-icons elementary-taprevival-icons -y
            ;;
        "7")
            echo -e "安裝 其他佈景主題"
            sudo apt-get install elementary-thirdparty-icons elementary-plank-themes -y
            ;;
        "8")
            echo -e "安裝 桌布集"
            sudo apt-get install elementary-wallpaper-collection -y
            ;;
    esac
}

echo -e "檢查更新...如果沒有要安裝更新請於稍候按下(n)即可."
sudo apt-get update && sudo apt-get upgrade

echo -e "檢查完畢，接下來會進行第三方應用來源的加入，這是為了安裝後續程式所需要的一個動作，若選擇否將會離開整個程式。"
read -p "請問，是否要加入第三方應用的來源？(Y/n): " yn

if [ "$yn" == "y" ] || [ "$yn" == "Y" ] || [ "$yn" == "" ]; then
    sudo apt-add-repository ppa:versable/elementary-update
    sudo apt-get update
    echo -e "新增完成"
else
    exit
fi

echo -e "即將進行第三方應用與佈景主題等的安裝，請選擇你想要進行的動作："

while [ "$option" != "1" -a "$option" != "2" -a "$option" != "3" ]
do
echo -e  " 1.全自動安裝\n 2.選擇要安裝的項目\n 3.離開"
read option
    case $option in
        "1")
            show_package;
            sudo apt-get install elementary-tweaks wingpanel-slim indicator-synapse elementary-blue-theme elementary-champagne-theme elementary-colors-theme elementary-dark-theme elementary-harvey-theme elementary-lion-theme elementary-matteblack-theme elementary-milk-theme elementary-plastico-theme elementary-whit-e-theme elementary-elfaenza-icons elementary-emod-icons elementary-enumix-utouch-icons elementary-nitrux-icons elementary-taprevival-icons elementary-thirdparty-icons elementary-plank-themes elementary-wallpaper-collection audience -y
           ;;
        "2")
            show_package;
            echo -e "請以空白鍵當作分隔來選擇要安裝的項目。"
            read choice
            install_choice $choice;
            ;;
        "3")
            exit
            ;;
         *)
            echo -e "機會，命運請選擇...不對，你只能選123喔～\n"
            ;;
    esac
done

echo -e "您的選擇已經安裝完成了，如果途中有錯誤絕對不是我的問題，這樣..."
echo -e "Elementary Tewak 會出現在系統設定中，他可以讓你調整剛剛所裝的許多內容以及你的系統"
echo -e "祝你使用愉快～"
