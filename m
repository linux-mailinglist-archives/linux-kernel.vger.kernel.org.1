Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC80626884E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 11:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbgINJ3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 05:29:49 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:46300 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726239AbgINJ3o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 05:29:44 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 5E50A54CCD72579BDE52;
        Mon, 14 Sep 2020 17:29:41 +0800 (CST)
Received: from [10.57.101.250] (10.57.101.250) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Mon, 14 Sep 2020 17:29:33 +0800
Subject: Re: [PATCH 3/3] ARM: dts: add SD5203 dts
To:     Zhen Lei <thunder.leizhen@huawei.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20200903122734.2369-1-thunder.leizhen@huawei.com>
 <20200903122734.2369-4-thunder.leizhen@huawei.com>
CC:     Kefeng Wang <wangkefeng.wang@huawei.com>
From:   Wei Xu <xuwei5@hisilicon.com>
Message-ID: <5F5F37FD.8090401@hisilicon.com>
Date:   Mon, 14 Sep 2020 17:29:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
In-Reply-To: <20200903122734.2369-4-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.57.101.250]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhen,

On 2020/9/3 20:27, Zhen Lei wrote:
> From: Kefeng Wang <wangkefeng.wang@huawei.com>
> 
> Add sd5203.dts for Hisilicon SD5203 SoC platform.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  arch/arm/boot/dts/Makefile   |  2 +
>  arch/arm/boot/dts/sd5203.dts | 90 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 92 insertions(+)
>  create mode 100644 arch/arm/boot/dts/sd5203.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 4572db3fa5ae..1d1262df5c55 100644
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
> index 000000000000..99da46072f72
> --- /dev/null
> +++ b/arch/arm/boot/dts/sd5203.dts
> @@ -0,0 +1,90 @@
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
> +	compatible = "hisilicon,sd5203";

Can you please add the binding document as well?

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
> +	cpu {
> +		compatible = "arm,arm926ej-s";
> +		device_type = "cpu";
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
> +			compatible = "hisilicon,sd5203-vic";

Ditto.
Thanks!

Best Regards,
Wei

> +			reg = <0x10130000 0x1000>;
> +			interrupt-controller;
> +			#interrupt-cells = <1>;
> +		};
> +
> +		refclk125mhz: refclk125mhz {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <125000000>;
> +		};
> +
> +		timer0: timer@16002000 {
> +			compatible = "arm,sp804", "arm,primecell";
> +			reg = <0x16002000 0x1000>;
> +			interrupts = <4>;
> +			clocks = <&refclk125mhz>;
> +			clock-names = "apb_pclk";
> +		};
> +
> +		timer1: timer@16003000 {
> +			compatible = "arm,sp804", "arm,primecell";
> +			reg = <0x16003000 0x1000>;
> +			interrupts = <5>;
> +			clocks = <&refclk125mhz>;
> +			clock-names = "apb_pclk";
> +		};
> +
> +		uart0: serial@1600D000 {
> +			compatible = "snps,dw-apb-uart";
> +			reg = <0x1600D000 0x1000>;
> +			bus_id = "uart0";
> +			clocks = <&refclk125mhz>;
> +			clock-names = "apb_pclk";
> +			reg-shift = <2>;
> +			interrupts = <17>;
> +		};
> +
> +		uart1: serial@1600C000 {
> +			compatible = "snps,dw-apb-uart";
> +			reg = <0x1600C000 0x1000>;
> +			clocks = <&refclk125mhz>;
> +			clock-names = "apb_pclk";
> +			reg-shift = <2>;
> +			interrupts = <16>;
> +			status = "disabled";
> +		};
> +	};
> +};
> 
