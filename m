Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5600D2C5510
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 14:12:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390119AbgKZNK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 08:10:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389879AbgKZNK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 08:10:58 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD67C0617A7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:10:57 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id o9so2899418ejg.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VKmIqZxCI8NVNA08P3qFAEJ1Jf8cRqufRdNCDIZ8fmI=;
        b=SMFhwQdd/FUceNer8PQ4A+C0KcPg5v+hnaZYigmnjSV8yKrE2GzjQRueVFtM4TpbAu
         cmgbHAmic236ekNfRN2SUTghmEpHOsVLpdhH2Hf7H547+oqvX5AimGGKaFbUwWGzCbQo
         nZhET82cRJ7aqa0UPkZ2WFUs9pqcNJD9ykyIoOhGp1Bqx3SjPib/lQj7JOeF/XVqTXir
         FYxYbGKGgOO7yyapNz8hLdnTOzllOCz3My/wC3xKmDzkIux73aV9gLJ0l4tcwSSHhMQi
         aL9yUPuMLetaZi2JSrwTASrRCLdqyhPiHRAifNqqXUjimWUI6kgkiMIvIpW7FrVMUVwo
         nVYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VKmIqZxCI8NVNA08P3qFAEJ1Jf8cRqufRdNCDIZ8fmI=;
        b=MamlwSGS2PWPpzWQoHwsMuMnlYWQuooDJac3lRXsKxp8elYXEfl4Xzan6501hh58V/
         3y9+HL951t9tr2tNnLDGSAzTjlbUdce43dmLrj6rX+jXcsN0zjCV00HTgL8Ta4Z3oApD
         e+YUTnEPykgXsxpiqBmIrF2K24FhBh49hDGbf9nYt4x3LFkLfveP56HsaDLaYabSf7JE
         eiARH75+CJbwsy4eh5Q0JFKClIHmJE7YiaDTWh/8dBLrmQATlsbgX0hzI5faBfUfQtG8
         hkTQ/fk8qTL4upvpwFDtPJzUvw45Vgny0U6Q3uoWT6hCy27fT1uR1I+6jprA1k3H21eU
         747w==
X-Gm-Message-State: AOAM532rG8uLh80tKAmoJfM7Qcbsitmq8waA6FLgYLeXnZ4u2iXF7hSf
        199D1Mm+DX0pJd+f8Xb5B4K3MQ==
X-Google-Smtp-Source: ABdhPJw3QZVqa9++OYXekeackK5FEka69eO0OrwCcnysj0j9rTL7Tx65KKp0fmd09Pk05BtFrnneFA==
X-Received: by 2002:a17:906:a052:: with SMTP id bg18mr2616021ejb.550.1606396256167;
        Thu, 26 Nov 2020 05:10:56 -0800 (PST)
Received: from [192.168.0.105] (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id f16sm3193187edc.44.2020.11.26.05.10.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2020 05:10:55 -0800 (PST)
Subject: Re: [PATCH v2] ARM: zynq: Add Z-turn board V5
To:     agriveaux@deutnet.info, michal.simek@xilinx.com, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20201126070516.85882-1-agriveaux@deutnet.info>
From:   Michal Simek <monstr@monstr.eu>
Message-ID: <88764538-1c7e-ca7f-e138-08090091ae3f@monstr.eu>
Date:   Thu, 26 Nov 2020 14:10:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201126070516.85882-1-agriveaux@deutnet.info>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26. 11. 20 8:05, agriveaux@deutnet.info wrote:
> From: Alexandre GRIVEAUX <agriveaux@deutnet.info>
> 
> Adding Z-turn board V5 to resolve the change between:
> 
> "Z-TURNBOARD_schematic.pdf" schematics state version 1 to 4 has Atheros AR8035
> "Z-Turn_Board_sch_V15_20160303.pdf" schematics state version 5 has Micrel KSZ9031
> 
> Changes v1 -> v2: Instead of using new board, the v2 using a common devicetree
> for z-turn boards (zynq-zturn-common.dtsi) and for each board a specific DT
> 
> Signed-off-by: Alexandre GRIVEAUX <agriveaux@deutnet.info>
> ---
>  arch/arm/boot/dts/Makefile               |   1 +
>  arch/arm/boot/dts/zynq-zturn-common.dtsi | 112 +++++++++++++++++++++++
>  arch/arm/boot/dts/zynq-zturn-v5.dts      |  15 +++
>  arch/arm/boot/dts/zynq-zturn.dts         | 101 +-------------------
>  4 files changed, 129 insertions(+), 100 deletions(-)
>  create mode 100644 arch/arm/boot/dts/zynq-zturn-common.dtsi
>  create mode 100644 arch/arm/boot/dts/zynq-zturn-v5.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index ce66ffd5a1bb..3de85fe42f76 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -1302,6 +1302,7 @@ dtb-$(CONFIG_ARCH_ZYNQ) += \
>  	zynq-zc770-xm013.dtb \
>  	zynq-zed.dtb \
>  	zynq-zturn.dtb \
> +	zynq-zturn-v5.dtb \
>  	zynq-zybo.dtb \
>  	zynq-zybo-z7.dtb
>  dtb-$(CONFIG_MACH_ARMADA_370) += \
> diff --git a/arch/arm/boot/dts/zynq-zturn-common.dtsi b/arch/arm/boot/dts/zynq-zturn-common.dtsi
> new file mode 100644
> index 000000000000..84f3c85c5bab
> --- /dev/null
> +++ b/arch/arm/boot/dts/zynq-zturn-common.dtsi
> @@ -0,0 +1,112 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + *  Copyright (C) 2015 Andrea Merello <adnrea.merello@gmail.com>
> + *  Copyright (C) 2017 Alexander Graf <agraf@suse.de>
> + *
> + *  Based on zynq-zed.dts which is:
> + *  Copyright (C) 2011 - 2014 Xilinx
> + *  Copyright (C) 2012 National Instruments Corp.
> + *
> + */
> +
> +/dts-v1/;
> +/include/ "zynq-7000.dtsi"
> +
> +/ {
> +	compatible = "xlnx,zynq-7000";
> +
> +	aliases {
> +		ethernet0 = &gem0;
> +		serial0 = &uart1;
> +		serial1 = &uart0;
> +		mmc0 = &sdhci0;
> +	};
> +
> +	memory@0 {
> +		device_type = "memory";
> +		reg = <0x0 0x40000000>;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	gpio-leds {
> +		compatible = "gpio-leds";
> +		usr-led1 {
> +			label = "usr-led1";
> +			gpios = <&gpio0 0x0 0x1>;
> +			default-state = "off";
> +		};
> +
> +		usr-led2 {
> +			label = "usr-led2";
> +			gpios = <&gpio0 0x9 0x1>;
> +			default-state = "off";
> +		};
> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +		autorepeat;
> +		K1 {
> +			label = "K1";
> +			gpios = <&gpio0 0x32 0x1>;
> +			linux,code = <0x66>;
> +			wakeup-source;
> +			autorepeat;
> +		};
> +	};
> +};
> +
> +&clkc {
> +	ps-clk-frequency = <33333333>;
> +};
> +
> +&gem0 {
> +	status = "okay";
> +	phy-mode = "rgmii-id";
> +	phy-handle = <&ethernet_phy>;
> +
> +	ethernet_phy: ethernet-phy@0 {
> +	};
> +};
> +
> +&sdhci0 {
> +	status = "okay";
> +};
> +
> +&uart0 {
> +	status = "okay";
> +};
> +
> +&uart1 {
> +	status = "okay";
> +};
> +
> +&usb0 {
> +	status = "okay";
> +	dr_mode = "host";
> +};
> +
> +&can0 {
> +	status = "okay";
> +};
> +
> +&i2c0 {
> +	status = "okay";
> +	clock-frequency = <400000>;
> +
> +	stlm75@49 {
> +		status = "okay";
> +		compatible = "lm75";
> +		reg = <0x49>;
> +	};
> +
> +	accelerometer@53 {
> +		compatible = "adi,adxl345", "adxl345", "adi,adxl34x", "adxl34x";
> +		reg = <0x53>;
> +		interrupt-parent = <&intc>;
> +		interrupts = <0x0 0x1e 0x4>;
> +	};
> +};
> diff --git a/arch/arm/boot/dts/zynq-zturn-v5.dts b/arch/arm/boot/dts/zynq-zturn-v5.dts
> new file mode 100644
> index 000000000000..536632a09a25
> --- /dev/null
> +++ b/arch/arm/boot/dts/zynq-zturn-v5.dts
> @@ -0,0 +1,15 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/dts-v1/;
> +/include/ "zynq-zturn-common.dtsi"
> +
> +/ {
> +	model = "Zynq Z-Turn MYIR Board V5";
> +	compatible = "myir,zynq-zturn-v5", "xlnx,zynq-7000";
> +};
> +
> +&gem0 {
> +	ethernet_phy: ethernet-phy@0 {
> +		reg = <0x3>;
> +	};
> +};
> diff --git a/arch/arm/boot/dts/zynq-zturn.dts b/arch/arm/boot/dts/zynq-zturn.dts
> index 5ec616ebca08..620b24a25e06 100644
> --- a/arch/arm/boot/dts/zynq-zturn.dts
> +++ b/arch/arm/boot/dts/zynq-zturn.dts
> @@ -1,114 +1,15 @@
>  // SPDX-License-Identifier: GPL-2.0
> -/*
> - *  Copyright (C) 2015 Andrea Merello <adnrea.merello@gmail.com>
> - *  Copyright (C) 2017 Alexander Graf <agraf@suse.de>
> - *
> - *  Based on zynq-zed.dts which is:
> - *  Copyright (C) 2011 - 2014 Xilinx
> - *  Copyright (C) 2012 National Instruments Corp.
> - *
> - */
>  
>  /dts-v1/;
> -/include/ "zynq-7000.dtsi"
> +/include/ "zynq-zturn-common.dtsi"
>  
>  / {
>  	model = "Zynq Z-Turn MYIR Board";
>  	compatible = "myir,zynq-zturn", "xlnx,zynq-7000";
> -
> -	aliases {
> -		ethernet0 = &gem0;
> -		serial0 = &uart1;
> -		serial1 = &uart0;
> -		mmc0 = &sdhci0;
> -	};
> -
> -	memory@0 {
> -		device_type = "memory";
> -		reg = <0x0 0x40000000>;
> -	};
> -
> -	chosen {
> -		stdout-path = "serial0:115200n8";
> -	};
> -
> -	gpio-leds {
> -		compatible = "gpio-leds";
> -		usr-led1 {
> -			label = "usr-led1";
> -			gpios = <&gpio0 0x0 0x1>;
> -			default-state = "off";
> -		};
> -
> -		usr-led2 {
> -			label = "usr-led2";
> -			gpios = <&gpio0 0x9 0x1>;
> -			default-state = "off";
> -		};
> -	};
> -
> -	gpio-keys {
> -		compatible = "gpio-keys";
> -		autorepeat;
> -		K1 {
> -			label = "K1";
> -			gpios = <&gpio0 0x32 0x1>;
> -			linux,code = <0x66>;
> -			wakeup-source;
> -			autorepeat;
> -		};
> -	};
> -};
> -
> -&clkc {
> -	ps-clk-frequency = <33333333>;
>  };
>  
>  &gem0 {
> -	status = "okay";
> -	phy-mode = "rgmii-id";
> -	phy-handle = <&ethernet_phy>;
> -
>  	ethernet_phy: ethernet-phy@0 {
>  		reg = <0x0>;
>  	};
>  };
> -
> -&sdhci0 {
> -	status = "okay";
> -};
> -
> -&uart0 {
> -	status = "okay";
> -};
> -
> -&uart1 {
> -	status = "okay";
> -};
> -
> -&usb0 {
> -	status = "okay";
> -	dr_mode = "host";
> -};
> -
> -&can0 {
> -	status = "okay";
> -};
> -
> -&i2c0 {
> -	status = "okay";
> -	clock-frequency = <400000>;
> -
> -	stlm75@49 {
> -		status = "okay";
> -		compatible = "lm75";
> -		reg = <0x49>;
> -	};
> -
> -	accelerometer@53 {
> -		compatible = "adi,adxl345", "adxl345", "adi,adxl34x", "adxl34x";
> -		reg = <0x53>;
> -		interrupt-parent = <&intc>;
> -		interrupts = <0x0 0x1e 0x4>;
> -	};
> -};
> 

Applied.

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs

