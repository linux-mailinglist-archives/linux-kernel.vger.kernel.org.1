Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4754C2C4D1C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 03:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732416AbgKZCGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 21:06:22 -0500
Received: from gproxy2-pub.mail.unifiedlayer.com ([69.89.18.3]:47545 "EHLO
        gproxy2-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732212AbgKZCGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 21:06:22 -0500
Received: from cmgw15.unifiedlayer.com (unknown [10.9.0.15])
        by gproxy2.mail.unifiedlayer.com (Postfix) with ESMTP id 419D81E0CF1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 19:06:21 -0700 (MST)
Received: from bh-25.webhostbox.net ([208.91.199.152])
        by cmsmtp with ESMTP
        id i6fskg6ENh41li6ftkjrdh; Wed, 25 Nov 2020 19:06:21 -0700
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.3 cv=MuZ8FVSe c=1 sm=1 tr=0
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=kj9zAlcOel0A:10:nop_charset_1
 a=nNwsprhYR40A:10:nop_rcvd_month_year
 a=evQFzbml-YQA:10:endurance_base64_authed_username_1 a=bGMl5HoiAAAA:8
 a=_jlGtV7tAAAA:8 a=HUTit5NPLnmaScQUXtkA:9 a=CjuIK1q_8ugA:10:nop_charset_2
 a=4zD4jYFdOPo6jgvxhsoC:22 a=nlm17XC03S6CtCLSeiRr:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=SSGA6C8SJG8ggIgsy6+8Sb9pPcWegu4f1TVOacXrf5c=; b=qYP7lPvju2VTJR9XozD0QGM9uH
        OXYScDVf3xqKdckN4+lXv0/k8plXfMaGmbY7kI5cv2Nkjjl/mQLcIcJAANwVIZZc18A3ZurCLhAg2
        AMLhX8vfBNssMu/3oCBliaM3aa4vtqSNaIzQ66HVZMyK1wAPt1yjMTME/Fs2Iy6mHAsmeSRYXDs70
        Dcq8MnR5tkyQBOyAoye/6vc6UdlAsFe+Aknl6Inc1U6FnnUcGOH5UmgrFIt805zFZ2cwCX3Br8u39
        NqgmG2u2MotgF3pY+LVwOk2DeXWEjm7k+Z07ReCcuhosHh/yuSavXHsjeRJSB4H1cCGEJFtQg/5em
        ogI0EqHQ==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:36454 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.93)
        (envelope-from <linux@roeck-us.net>)
        id 1ki6fs-002lTk-AH; Thu, 26 Nov 2020 02:06:20 +0000
Date:   Wed, 25 Nov 2020 18:06:19 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Michael Brunner <Michael.Brunner@kontron.com>
Cc:     "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "mibru@gmx.de" <mibru@gmx.de>,
        "vkrasnov@dev.rtsoft.ru" <vkrasnov@dev.rtsoft.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mfd: kempld-core: Add support for additional devices
Message-ID: <20201126020619.GF111386@roeck-us.net>
References: <0474e39790ab7351b1b11b565b995b94d49fb87c.camel@kontron.com>
 <76458fc9615cf2fb805ccd4196e3e9824ad18523.camel@kontron.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76458fc9615cf2fb805ccd4196e3e9824ad18523.camel@kontron.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1ki6fs-002lTk-AH
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (localhost) [108.223.40.66]:36454
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 6
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 23, 2020 at 03:53:27PM +0000, Michael Brunner wrote:
> This update includes DMI IDs for the following Kontron modules and
> systems:
> COMe-bDV7, COMe-cDV7, COMe-m4AL, COMe-mCT10, SMARC-sXAL, SMARC-sXA4,
> Qseven-Q7AL, mITX-APL, pITX-APL and KBox A-203
> 
> Furthermore the ACPI HID KEM0000 is added, as it is also reserved for
> kempld devices.
> 
> Instead of also adding the newly supported devices to the Kconfig
> description this patch removes the lengthy list. With future usage of
> the ACPI HIDs it will not be necessary to explicitly add support for
> each individual device to the driver and therefore the list would
> become incomplete anyway.
> 
> Signed-off-by: Michael Brunner <michael.brunner@kontron.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> 
>  v2: Corrected a board name, only use 4 digits for IDs
> 
>  drivers/mfd/Kconfig       | 30 ++--------------
>  drivers/mfd/kempld-core.c | 76 +++++++++++++++++++++++++++++++++++++--
>  2 files changed, 77 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 8b99a13669bf..befd19da8562 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -720,33 +720,9 @@ config MFD_KEMPLD
>  	select MFD_CORE
>  	help
>  	  This is the core driver for the PLD (Programmable Logic Device) found
> -	  on some Kontron ETX and COMexpress (ETXexpress) modules. The PLD
> -	  device may provide functions like watchdog, GPIO, UART and I2C bus.
> -
> -	  The following modules are supported:
> -		* COMe-bBD#
> -		* COMe-bBL6
> -		* COMe-bHL6
> -		* COMe-bSL6
> -		* COMe-bIP#
> -		* COMe-bKL6
> -		* COMe-bPC2 (ETXexpress-PC)
> -		* COMe-bSC# (ETXexpress-SC T#)
> -		* COMe-cAL6
> -		* COMe-cBL6
> -		* COMe-cBT6
> -		* COMe-cBW6
> -		* COMe-cCT6
> -		* COMe-cDC2 (microETXexpress-DC)
> -		* COMe-cHL6
> -		* COMe-cKL6
> -		* COMe-cPC2 (microETXexpress-PC)
> -		* COMe-cSL6
> -		* COMe-mAL10
> -		* COMe-mBT10
> -		* COMe-mCT10
> -		* COMe-mTT10 (nanoETXexpress-TT)
> -		* ETX-OH
> +	  on some Kontron ETX and nearly all COMexpress (ETXexpress) modules as
> +	  well as on some other Kontron products. The PLD device may provide
> +	  functions like watchdog, GPIO, UART and I2C bus.
>  
>  	  This driver can also be built as a module. If so, the module
>  	  will be called kempld-core.
> diff --git a/drivers/mfd/kempld-core.c b/drivers/mfd/kempld-core.c
> index ecd26271b9a4..9166075c1f32 100644
> --- a/drivers/mfd/kempld-core.c
> +++ b/drivers/mfd/kempld-core.c
> @@ -552,6 +552,7 @@ static int kempld_remove(struct platform_device *pdev)
>  
>  #ifdef CONFIG_ACPI
>  static const struct acpi_device_id kempld_acpi_table[] = {
> +	{ "KEM0000", (kernel_ulong_t)&kempld_platform_data_generic },
>  	{ "KEM0001", (kernel_ulong_t)&kempld_platform_data_generic },
>  	{}
>  };
> @@ -584,6 +585,14 @@ static const struct dmi_system_id kempld_dmi_table[] __initconst = {
>  		},
>  		.driver_data = (void *)&kempld_platform_data_generic,
>  		.callback = kempld_create_platform_device,
> +	}, {
> +		.ident = "BDV7",
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Kontron"),
> +			DMI_MATCH(DMI_BOARD_NAME, "COMe-bDV7"),
> +		},
> +		.driver_data = (void *)&kempld_platform_data_generic,
> +		.callback = kempld_create_platform_device,
>  	}, {
>  		.ident = "BHL6",
>  		.matches = {
> @@ -648,6 +657,14 @@ static const struct dmi_system_id kempld_dmi_table[] __initconst = {
>  		},
>  		.driver_data = (void *)&kempld_platform_data_generic,
>  		.callback = kempld_create_platform_device,
> +	}, {
> +		.ident = "CDV7",
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Kontron"),
> +			DMI_MATCH(DMI_BOARD_NAME, "COMe-cDV7"),
> +		},
> +		.driver_data = (void *)&kempld_platform_data_generic,
> +		.callback = kempld_create_platform_device,
>  	}, {
>  		.ident = "CHL6",
>  		.matches = {
> @@ -767,6 +784,22 @@ static const struct dmi_system_id kempld_dmi_table[] __initconst = {
>  		},
>  		.driver_data = (void *)&kempld_platform_data_generic,
>  		.callback = kempld_create_platform_device,
> +	}, {
> +		.ident = "A203",
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Kontron"),
> +			DMI_MATCH(DMI_BOARD_NAME, "KBox A-203"),
> +		},
> +		.driver_data = (void *)&kempld_platform_data_generic,
> +		.callback = kempld_create_platform_device,
> +	}, {
> +		.ident = "M4A1",
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Kontron"),
> +			DMI_MATCH(DMI_BOARD_NAME, "COMe-m4AL"),
> +		},
> +		.driver_data = (void *)&kempld_platform_data_generic,
> +		.callback = kempld_create_platform_device,
>  	}, {
>  		.ident = "MAL1",
>  		.matches = {
> @@ -775,6 +808,14 @@ static const struct dmi_system_id kempld_dmi_table[] __initconst = {
>  		},
>  		.driver_data = (void *)&kempld_platform_data_generic,
>  		.callback = kempld_create_platform_device,
> +	}, {
> +		.ident = "MAPL",
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Kontron"),
> +			DMI_MATCH(DMI_BOARD_NAME, "mITX-APL"),
> +		},
> +		.driver_data = (void *)&kempld_platform_data_generic,
> +		.callback = kempld_create_platform_device,
>  	}, {
>  		.ident = "MBR1",
>  		.matches = {
> @@ -823,6 +864,30 @@ static const struct dmi_system_id kempld_dmi_table[] __initconst = {
>  		},
>  		.driver_data = (void *)&kempld_platform_data_generic,
>  		.callback = kempld_create_platform_device,
> +	}, {
> +		.ident = "PAPL",
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Kontron"),
> +			DMI_MATCH(DMI_BOARD_NAME, "pITX-APL"),
> +		},
> +		.driver_data = (void *)&kempld_platform_data_generic,
> +		.callback = kempld_create_platform_device,
> +	}, {
> +		.ident = "SXAL",
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Kontron"),
> +			DMI_MATCH(DMI_BOARD_NAME, "SMARC-sXAL"),
> +		},
> +		.driver_data = (void *)&kempld_platform_data_generic,
> +		.callback = kempld_create_platform_device,
> +	}, {
> +		.ident = "SXAL4",
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Kontron"),
> +			DMI_MATCH(DMI_BOARD_NAME, "SMARC-sXA4"),
> +		},
> +		.driver_data = (void *)&kempld_platform_data_generic,
> +		.callback = kempld_create_platform_device,
>  	}, {
>  		.ident = "UNP1",
>  		.matches = {
> @@ -863,8 +928,7 @@ static const struct dmi_system_id kempld_dmi_table[] __initconst = {
>  		},
>  		.driver_data = (void *)&kempld_platform_data_generic,
>  		.callback = kempld_create_platform_device,
> -	},
> -	{
> +	}, {
>  		.ident = "UTH6",
>  		.matches = {
>  			DMI_MATCH(DMI_BOARD_VENDOR, "Kontron"),
> @@ -872,6 +936,14 @@ static const struct dmi_system_id kempld_dmi_table[] __initconst = {
>  		},
>  		.driver_data = (void *)&kempld_platform_data_generic,
>  		.callback = kempld_create_platform_device,
> +	}, {
> +		.ident = "Q7AL",
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Kontron"),
> +			DMI_MATCH(DMI_BOARD_NAME, "Qseven-Q7AL"),
> +		},
> +		.driver_data = (void *)&kempld_platform_data_generic,
> +		.callback = kempld_create_platform_device,
>  	},
>  	{}
>  };
> -- 
> 2.25.1
> 
