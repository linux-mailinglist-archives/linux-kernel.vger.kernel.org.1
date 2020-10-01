Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18C4227F98A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 08:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730301AbgJAGg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 02:36:58 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:45973 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbgJAGg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 02:36:58 -0400
Received: by mail-ej1-f66.google.com with SMTP id i26so6307209ejb.12;
        Wed, 30 Sep 2020 23:36:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sihoIIR1T+XV8pIaHvxkkGpsDFWAH7E2gjDd1woe3nQ=;
        b=O9qrc/wPhUkLYL9QSby0t8c81uY2WKz1PO974CAHANsENGOtoR4aHxTT+pxTUaUikp
         /2C1BY8YhlzVPoyFEJXrn6k6q7N0ptabI+oELhKWzr58rvnca9KKd3MIzPTGcm/QJlsK
         /kj/HBvqqGp6ifJSSqPTgD2Rb/1fSZ/KZRCP4N4ATqVSRD5uGSMOiC86yN+vNDp5NMrQ
         CNTdFMXNkYQmUHqSwEca/k+DLJV47JS/fhAFvkObd9d7GGNKcS/eNo52vpOHQtA05IAa
         Cz9GNU838BedG22a3TnX4tp1IiWRWAi8Wd2UuMV7cpEmX1KuRkg64Diq8nOKybNZ/Mza
         CNnA==
X-Gm-Message-State: AOAM5315z1nP7QHZf/3oQtXOf1JpGWNoBcloeFIiR2GI5K+jxk+Ks4WA
        0xYP46Z+2EsiTIoEO8M7z6Q=
X-Google-Smtp-Source: ABdhPJxzENJ3Dhl8zzXtpXBgMHEv+rVLDKLGfR2tKJZbPYLEGdgt+iZqRheAXy+b9/7OxWCRXoKqrA==
X-Received: by 2002:a17:907:2115:: with SMTP id qn21mr6431866ejb.278.1601534215857;
        Wed, 30 Sep 2020 23:36:55 -0700 (PDT)
Received: from kozik-lap ([194.230.155.194])
        by smtp.googlemail.com with ESMTPSA id a20sm3341930ejb.81.2020.09.30.23.36.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Sep 2020 23:36:54 -0700 (PDT)
Date:   Thu, 1 Oct 2020 08:36:52 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Libin <huawei.libin@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH v6 08/17] ARM: dts: add SD5203 dts
Message-ID: <20201001063652.GD3018@kozik-lap>
References: <20200930031712.2365-1-thunder.leizhen@huawei.com>
 <20200930031712.2365-9-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200930031712.2365-9-thunder.leizhen@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 11:17:03AM +0800, Zhen Lei wrote:
> From: Kefeng Wang <wangkefeng.wang@huawei.com>
> 
> Add sd5203.dts for Hisilicon SD5203 SoC platform.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  arch/arm/boot/dts/Makefile   |  2 +
>  arch/arm/boot/dts/sd5203.dts | 96 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 98 insertions(+)
>  create mode 100644 arch/arm/boot/dts/sd5203.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 4572db3fa5ae302..1d1262df5c55907 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -357,6 +357,8 @@ dtb-$(CONFIG_ARCH_MPS2) += \
>  	mps2-an399.dtb
>  dtb-$(CONFIG_ARCH_MOXART) += \
>  	moxart-uc7112lx.dtb
> +dtb-$(CONFIG_ARCH_SD5203) += \
> +	sd5203.dtb
>  dtb-$(CONFIG_SOC_IMX1) += \
>  	imx1-ads.dtb \
>  	imx1-apf9328.dtb
> diff --git a/arch/arm/boot/dts/sd5203.dts b/arch/arm/boot/dts/sd5203.dts
> new file mode 100644
> index 000000000000000..3cc9a23910be62e
> --- /dev/null
> +++ b/arch/arm/boot/dts/sd5203.dts
> @@ -0,0 +1,96 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2020 Hisilicon Limited.
> + *
> + * DTS file for Hisilicon SD5203 Board
> + */
> +
> +/dts-v1/;
> +
> +/ {
> +	model = "Hisilicon SD5203";
> +	compatible = "H836ASDJ", "hisilicon,sd5203";
> +	interrupt-parent = <&vic>;
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +
> +	chosen {
> +		bootargs="console=ttyS0,9600 earlycon=uart8250,mmio32,0x1600d000";
> +	};
> +
> +	aliases {
> +		serial0 = &uart0;
> +	};
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu0 {
> +			device_type = "cpu";
> +			compatible = "arm,arm926ej-s";
> +			reg = <0x0>;
> +		};
> +	};
> +
> +	memory@30000000 {
> +		device_type = "memory";
> +		reg = <0x30000000 0x8000000>;
> +	};
> +
> +	soc {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "simple-bus";
> +		ranges;
> +
> +		vic: interrupt-controller@10130000 {
> +			compatible = "snps,dw-apb-ictl";
> +			reg = <0x10130000 0x1000>;
> +			interrupt-controller;
> +			#interrupt-cells = <1>;
> +		};
> +
> +		refclk125mhz: refclk125mhz {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <125000000>;

Is this a reference clock really in the SoC? Not outside, e.g. property
of the board?

Best regards,
Krzysztof
