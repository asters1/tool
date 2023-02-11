#!/bin/bash
main(){
echo "1.网络调试"
echo "2.工具"
echo -n "请选择菜单：";read num
if [ $num == 1 ];then
    clear
    network
elif [ $num == 2  ];then
    clear
    tools
fi
}
network(){
    echo "1.发送请求"
    echo "0.返回上一级"
    echo -n "请选择菜单：";read tools_num
    if [ $tools_num == 1 ];then
        echo "1.GET"
        echo "2.POST"
        echo "0.返回上一级"

        echo -n "请求方法：";read get_or_post
            if [ $get_or_post == 1 ];then

                get
            elif [ $get_or_post == 2  ];then
                post
            fi

    elif [ $tools_num == 0 ];then
        clear
        main
    fi
}
tools(){
    echo "1.base64解码"
    echo "2.base64编码"
    echo "0.返回上一级"
    echo -n "请选择菜单：";read tools_num
    if [ $tools_num == 1 ];then
        clear
        echo "base64解码"
        while true
        do
            echo -n "请输入要解码的文本：";read base64_text
            base64_to_text $base64_text

        done
    elif [ $tools_num == 2 ];then
        clear
        echo "base64编码"
        while true
        do
            echo -n "请输入要编码的文本：";read text_base64
            text_to_base64 $text_base64

        done
    elif [ $tools_num == 0 ];then
        clear
        main
    fi

}
text_to_base64(){
    echo "$1" | base64
}
base64_to_text(){
    echo "$1" | base64 -d
}
get(){
    echo "GET"
    echo -n "请输入url：";read url
    echo $url
    echo -n "请输入headers(0为默认，1为继续使用以前的header)：";read header
    if [ "$header" == "0" ];then
        echo 'User-Agent":"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/103.0.5060.71 Safari/537.36")' > ./header.txt
    elif [ "$header" == "" ];then
        echo 'User-Agent":"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/103.0.5060.71 Safari/537.36")' > ./header.txt
    elif [ "$header" == "1" ];then
        echo -n ""
    else
        echo $header > ./header.txt
    fi
    chmod +x ./network
    ./network get $url ./header.txt
}
post(){
    echo "POST"
    echo -n "请输入url：";read url
    echo $url
    echo -n "请输入headers(0为默认，1为继续使用以前的header)：";read header
    if [ "$header" == "0" ];then
        echo 'User-Agent":"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/103.0.5060.71 Safari/537.36")' > ./header.txt
    elif [ "$header" == "" ];then
        echo 'User-Agent":"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/103.0.5060.71 Safari/537.36")' > ./header.txt
    elif [ "$header" == "1" ];then
        echo -n ""
    else
        echo $header > ./header.txt
    fi
    echo -n "请输入data(1为继续使用以前的data)：";read data
    if [ "$data" == "" ];then
        echo '' > ./data.txt
    elif [ "$data" == "1" ];then
        echo -n ""
    else
        echo $data > ./data.txt
    fi
    chmod +x ./network
    ./network post $url ./header.txt ./data.txt
}
main
