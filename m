Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDE1829A518
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 07:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732557AbgJ0G7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 02:59:34 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42218 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728363AbgJ0G7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 02:59:32 -0400
Received: by mail-wr1-f67.google.com with SMTP id j7so576434wrt.9
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 23:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=4PeQAWWuYS/MWPTCKu5ob6YvoGvcUynBjWkXWMhZ0tk=;
        b=NEcAMFs3LjVruiLrzO7+Swoi0lYGzf32SOfQAjvtnZiMLBvEytWuPeNFevkUZm5Hzp
         12iy17q1gHPdwoh5Ygxl3H1991m0eRoYg1K5vVtt+62Fg/WVC5sruKV7dbt0G/0B5lDL
         h4hRPgD5Ki8ohwCcTTF50WXlheWTUNOJnlO5zW2tyNyWJ1zDxcFcM3AXKVyRA6uRhCe9
         2YeIy1GLI+Uktk7DzwmanN9CwEycEPp5Lz6PVuWpMT1y0e/h+qPJFeB1wfZRhDMfGDyg
         Ot4tm964EQN+zYXAkmQrba1C4579UvgTuaEgk7hSZJWIwPpMXanCgKTBas1MS6mtAXWT
         BiZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=4PeQAWWuYS/MWPTCKu5ob6YvoGvcUynBjWkXWMhZ0tk=;
        b=rJW7d2rCxJTRr7ysQJq/BfoevuaKGYiPv3xa7OzH7aL1ZY3ha4bI6d3494xEpgyxya
         gmfftdzUpH/wBfUcdJeOzE/Ft1JVNsfJG0kfxPRjztoaoXf+sJVF0qML3Nxkuaw+g/e9
         x4YnG5AxvP2E5niibAgnFWca8HEsZZyySxsih23DWQerw6IwIdvbhZKgAjXCvYrQA/Ao
         HdLq22zGEdj6q9nrnJefA5xKVLwvnfzIqrF3xz+JcP0JynKsmhMlAIt/xKxewyxUUwIb
         oreDf80rx29pfrOj3UVNPncAU32yhTD/Eu3uI2+/3/sPa3+1aBaQ79jXgzDOEU6eCduw
         d9rA==
X-Gm-Message-State: AOAM533IQIjdS+rQkE+kDLa6xKrz0eb4P/gk8WzrwEpJ0/1UKHGojuU3
        7I3zaMaOklXZAxlQQ/y5GvY=
X-Google-Smtp-Source: ABdhPJzjHfJDiU3WRlDEBebIz0QIgO3wqfbs8a8otS0qP3GMNSZEpl6e14NsjjKMOOT7IX+xAQNgIg==
X-Received: by 2002:adf:edcf:: with SMTP id v15mr884929wro.291.1603781969711;
        Mon, 26 Oct 2020 23:59:29 -0700 (PDT)
Received: from felia ([2001:16b8:2de9:3700:3160:107b:5425:634f])
        by smtp.gmail.com with ESMTPSA id j5sm757252wrx.88.2020.10.26.23.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 23:59:29 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@gmail.com>
Date:   Tue, 27 Oct 2020 07:59:27 +0100 (CET)
X-X-Sender: lukas@felia
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
cc:     John Stultz <john.stultz@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-safety@lists.elisa.tech
Subject: Re: [linux-safety] [PATCH] misc: hisi_hikey_usb: use
 PTR_ERR_OR_ZERO
In-Reply-To: <20201026180026.3350-1-sudipm.mukherjee@gmail.com>
Message-ID: <alpine.DEB.2.21.2010270636470.7937@felia>
References: <20201026180026.3350-1-sudipm.mukherjee@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 26 Oct 2020, Sudip Mukherjee wrote:

> Coccinelle suggested using PTR_ERR_OR_ZERO() and looking at the code,
> we can use PTR_ERR_OR_ZERO() instead of checking IS_ERR() and then
> doing 'return 0'.
> 
> Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>

A nice small local clean up.

Here is my test report:

Build requires HISI_HIKEY_USB in config:

Symbol: HISI_HIKEY_USB [=n]
Type: tristate
Defined at drivers/misc/Kconfig:459
Prompt: USB GPIO Hub on HiSilicon Hikey 960/970 Platform
Depends on: (OF [=n] && GPIOLIB [=n] || COMPILE_TEST [=n]) && 
USB_ROLE_SWITCH [=n]

Build Preparation:

make defconfig
./scripts/config -e CONFIG_OF
./scripts/config -e CONFIG_GPIOLIB
./scripts/config -e CONFIG_USB_ROLE_SWITCH
./scripts/config -e CONFIG_HISI_HIKEY_USB
make olddefconfig

Build on next-20201027:

make
md5sum ./drivers/misc/hisi_hikey_usb.o
770db9ff0c1ca193eda2207a28deee4a  ./drivers/misc/hisi_hikey_usb.o
objdump -d ./drivers/misc/hisi_hikey_usb.o > hisi_hikey_usb.next-20201027.objdump

Build with patch on next-20201027:

make clean && make
md5sum ./drivers/misc/hisi_hikey_usb.o
770db9ff0c1ca193eda2207a28deee4a  ./drivers/misc/hisi_hikey_usb.o

objdump -d ./drivers/misc/hisi_hikey_usb.o > hisi_hikey_usb.cleanup-on-next-20201027.objdump

Compare objdump:

diff hisi_hikey_usb.next-20201027.objdump hisi_hikey_usb.cleanup-on-next-20201027.objdump

Summary:

'{md5sum,objdump -d} ./drivers/misc/hisi_hikey_usb.o' are identical before 
and after patch.

So, no functional change and no change in object code.

Tested-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

> ---
>  drivers/misc/hisi_hikey_usb.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/misc/hisi_hikey_usb.c b/drivers/misc/hisi_hikey_usb.c
> index cc93569e601c..989d7d129469 100644
> --- a/drivers/misc/hisi_hikey_usb.c
> +++ b/drivers/misc/hisi_hikey_usb.c
> @@ -168,10 +168,7 @@ static int hisi_hikey_usb_parse_kirin970(struct platform_device *pdev,
>  
>  	hisi_hikey_usb->reset = devm_gpiod_get(&pdev->dev, "hub_reset_en_gpio",
>  					       GPIOD_OUT_HIGH);
> -	if (IS_ERR(hisi_hikey_usb->reset))
> -		return PTR_ERR(hisi_hikey_usb->reset);
> -
> -	return 0;
> +	return PTR_ERR_OR_ZERO(hisi_hikey_usb->reset);
>  }
>  
>  static int hisi_hikey_usb_probe(struct platform_device *pdev)
> -- 
> 2.11.0
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#121): https://lists.elisa.tech/g/linux-safety/message/121
> Mute This Topic: https://lists.elisa.tech/mt/77821561/1714638
> Group Owner: linux-safety+owner@lists.elisa.tech
> Unsubscribe: https://lists.elisa.tech/g/linux-safety/unsub [lukas.bulwahn@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 
> 
> 
