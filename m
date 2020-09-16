Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0519326B97B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 03:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgIPBpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 21:45:24 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12277 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726023AbgIPBpY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 21:45:24 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id BBF4DC145AD14191E557;
        Wed, 16 Sep 2020 09:45:21 +0800 (CST)
Received: from [10.57.101.250] (10.57.101.250) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Wed, 16 Sep 2020 09:45:20 +0800
Subject: Re: [PATCH v3 4/6] arm64: dts: hisilicon: Fix SP805 clocks
To:     Andre Przywara <andre.przywara@arm.com>, <soc@kernel.org>
References: <20200907121831.242281-1-andre.przywara@arm.com>
 <20200907121831.242281-5-andre.przywara@arm.com>
CC:     Rob Herring <robh@kernel.org>, <devicetree@vger.kernel.org>,
        Chanho Min <chanho.min@lge.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
From:   Wei Xu <xuwei5@hisilicon.com>
Message-ID: <5F616E30.3090705@hisilicon.com>
Date:   Wed, 16 Sep 2020 09:45:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
In-Reply-To: <20200907121831.242281-5-andre.przywara@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.57.101.250]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andre,

On 2020/9/7 20:18, Andre Przywara wrote:
> The SP805 DT binding requires two clocks to be specified, but
> Hisilicon platform DTs currently only specify one clock.
> 
> In practice, Linux would pick a clock named "apb_pclk" for the bus
> clock, and the Linux and U-Boot SP805 driver would use the first clock
> to derive the actual watchdog counter frequency.
> 
> Since currently both are the very same clock, we can just double the
> clock reference, and add the correct clock-names, to match the binding.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Thanks!
Applied to the hisilicon arm64 dt tree.

Best Regards,
Wei

> ---
>  arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 10 ++++++----
>  arch/arm64/boot/dts/hisilicon/hi6220.dtsi |  5 +++--
>  2 files changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> index d25aac5e0bf8..994140fbc916 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> @@ -1089,16 +1089,18 @@
>  			compatible = "arm,sp805-wdt", "arm,primecell";
>  			reg = <0x0 0xe8a06000 0x0 0x1000>;
>  			interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&crg_ctrl HI3660_OSC32K>;
> -			clock-names = "apb_pclk";
> +			clocks = <&crg_ctrl HI3660_OSC32K>,
> +				 <&crg_ctrl HI3660_OSC32K>;
> +			clock-names = "wdog_clk", "apb_pclk";
>  		};
>  
>  		watchdog1: watchdog@e8a07000 {
>  			compatible = "arm,sp805-wdt", "arm,primecell";
>  			reg = <0x0 0xe8a07000 0x0 0x1000>;
>  			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&crg_ctrl HI3660_OSC32K>;
> -			clock-names = "apb_pclk";
> +			clocks = <&crg_ctrl HI3660_OSC32K>,
> +				 <&crg_ctrl HI3660_OSC32K>;
> +			clock-names = "wdog_clk", "apb_pclk";
>  		};
>  
>  		tsensor: tsensor@fff30000 {
> diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> index 3d189d9f0d24..6578f8191d71 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> @@ -843,8 +843,9 @@
>  			compatible = "arm,sp805-wdt", "arm,primecell";
>  			reg = <0x0 0xf8005000 0x0 0x1000>;
>  			interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks = <&ao_ctrl HI6220_WDT0_PCLK>;
> -			clock-names = "apb_pclk";
> +			clocks = <&ao_ctrl HI6220_WDT0_PCLK>,
> +				 <&ao_ctrl HI6220_WDT0_PCLK>;
> +			clock-names = "wdog_clk", "apb_pclk";
>  		};
>  
>  		tsensor: tsensor@0,f7030700 {
> 
