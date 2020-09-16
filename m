Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 718F526B979
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 03:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgIPBoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 21:44:09 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:36200 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726023AbgIPBoI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 21:44:08 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E14206F8034D24EA6691;
        Wed, 16 Sep 2020 09:44:05 +0800 (CST)
Received: from [10.57.101.250] (10.57.101.250) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Wed, 16 Sep 2020 09:44:03 +0800
Subject: Re: [PATCH v3 1/6] ARM: dts: hisilicon: Fix SP804 users
To:     Andre Przywara <andre.przywara@arm.com>, <soc@kernel.org>
References: <20200907121831.242281-1-andre.przywara@arm.com>
 <20200907121831.242281-2-andre.przywara@arm.com>
CC:     Rob Herring <robh@kernel.org>, <devicetree@vger.kernel.org>,
        Chanho Min <chanho.min@lge.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
From:   Wei Xu <xuwei5@hisilicon.com>
Message-ID: <5F616DE3.7080801@hisilicon.com>
Date:   Wed, 16 Sep 2020 09:44:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
In-Reply-To: <20200907121831.242281-2-andre.przywara@arm.com>
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
> The SP804 binding only specifies one or three clocks, but does not allow
> just two clocks.
> The HiSi 3620 .dtsi specified two clocks for the two timers, plus gave
> one "apb_pclk" clock-name to appease the primecell bus driver.
> 
> Extend the clocks by duplicating the first clock to the end of the clock
> list, and add two dummy clock-names to make the primecell driver happy.
> 
> I don't know what the real APB clock for the IP is, but with the current
> DT the first timer clock was used for that, so this change keeps the
> current status.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Thanks!
Applied to the hisilicon arm32 dt tree.

Best Regards,
Wei

> ---
>  arch/arm/boot/dts/hi3620.dtsi | 30 ++++++++++++++++++++----------
>  arch/arm/boot/dts/hip04.dtsi  |  4 ++--
>  2 files changed, 22 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/hi3620.dtsi b/arch/arm/boot/dts/hi3620.dtsi
> index f0af1bf2b4d8..355175b25fd6 100644
> --- a/arch/arm/boot/dts/hi3620.dtsi
> +++ b/arch/arm/boot/dts/hi3620.dtsi
> @@ -111,8 +111,10 @@
>  			reg = <0x800000 0x1000>;
>  			/* timer00 & timer01 */
>  			interrupts = <0 0 4>, <0 1 4>;
> -			clocks = <&clock HI3620_TIMER0_MUX>, <&clock HI3620_TIMER1_MUX>;
> -			clock-names = "apb_pclk";
> +			clocks = <&clock HI3620_TIMER0_MUX>,
> +				 <&clock HI3620_TIMER1_MUX>,
> +				 <&clock HI3620_TIMER0_MUX>;
> +			clock-names = "timer0clk", "timer1clk", "apb_pclk";
>  			status = "disabled";
>  		};
>  
> @@ -121,8 +123,10 @@
>  			reg = <0x801000 0x1000>;
>  			/* timer10 & timer11 */
>  			interrupts = <0 2 4>, <0 3 4>;
> -			clocks = <&clock HI3620_TIMER2_MUX>, <&clock HI3620_TIMER3_MUX>;
> -			clock-names = "apb_pclk";
> +			clocks = <&clock HI3620_TIMER2_MUX>,
> +				 <&clock HI3620_TIMER3_MUX>,
> +				 <&clock HI3620_TIMER2_MUX>;
> +			clock-names = "timer0clk", "timer1clk", "apb_pclk";
>  			status = "disabled";
>  		};
>  
> @@ -131,8 +135,10 @@
>  			reg = <0xa01000 0x1000>;
>  			/* timer20 & timer21 */
>  			interrupts = <0 4 4>, <0 5 4>;
> -			clocks = <&clock HI3620_TIMER4_MUX>, <&clock HI3620_TIMER5_MUX>;
> -			clock-names = "apb_pclk";
> +			clocks = <&clock HI3620_TIMER4_MUX>,
> +				 <&clock HI3620_TIMER5_MUX>,
> +				 <&clock HI3620_TIMER4_MUX>;
> +			clock-names = "timer0lck", "timer1clk", "apb_pclk";
>  			status = "disabled";
>  		};
>  
> @@ -141,8 +147,10 @@
>  			reg = <0xa02000 0x1000>;
>  			/* timer30 & timer31 */
>  			interrupts = <0 6 4>, <0 7 4>;
> -			clocks = <&clock HI3620_TIMER6_MUX>, <&clock HI3620_TIMER7_MUX>;
> -			clock-names = "apb_pclk";
> +			clocks = <&clock HI3620_TIMER6_MUX>,
> +				 <&clock HI3620_TIMER7_MUX>,
> +				 <&clock HI3620_TIMER6_MUX>;
> +			clock-names = "timer0clk", "timer1clk", "apb_pclk";
>  			status = "disabled";
>  		};
>  
> @@ -151,8 +159,10 @@
>  			reg = <0xa03000 0x1000>;
>  			/* timer40 & timer41 */
>  			interrupts = <0 96 4>, <0 97 4>;
> -			clocks = <&clock HI3620_TIMER8_MUX>, <&clock HI3620_TIMER9_MUX>;
> -			clock-names = "apb_pclk";
> +			clocks = <&clock HI3620_TIMER8_MUX>,
> +				 <&clock HI3620_TIMER9_MUX>,
> +				 <&clock HI3620_TIMER8_MUX>;
> +			clock-names = "timer0clk", "timer1clk", "apb_pclk";
>  			status = "disabled";
>  		};
>  
> diff --git a/arch/arm/boot/dts/hip04.dtsi b/arch/arm/boot/dts/hip04.dtsi
> index 4263a9339c2e..f5871b1d1ec4 100644
> --- a/arch/arm/boot/dts/hip04.dtsi
> +++ b/arch/arm/boot/dts/hip04.dtsi
> @@ -226,8 +226,8 @@
>  			compatible = "arm,sp804", "arm,primecell";
>  			reg = <0x3000000 0x1000>;
>  			interrupts = <0 224 4>;
> -			clocks = <&clk_50m>, <&clk_50m>;
> -			clock-names = "apb_pclk";
> +			clocks = <&clk_50m>, <&clk_50m>, <&clk_50m>;
> +			clock-names = "timer0clk", "timer1clk", "apb_pclk";
>  		};
>  
>  		arm-pmu {
> 
