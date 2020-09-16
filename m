Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2207C26B977
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 03:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgIPBms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 21:42:48 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:36294 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726023AbgIPBmr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 21:42:47 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id EFEAF68F0E45DF751A7D;
        Wed, 16 Sep 2020 09:42:45 +0800 (CST)
Received: from [10.57.101.250] (10.57.101.250) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Wed, 16 Sep 2020 09:42:42 +0800
Subject: Re: [PATCH v3 6/6] ARM: dts: hisilicon: Fix SP805 clocks
To:     Andre Przywara <andre.przywara@arm.com>, <soc@kernel.org>
References: <20200907121831.242281-1-andre.przywara@arm.com>
 <20200907121831.242281-7-andre.przywara@arm.com>
CC:     Rob Herring <robh@kernel.org>, <devicetree@vger.kernel.org>,
        Chanho Min <chanho.min@lge.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
From:   Wei Xu <xuwei5@hisilicon.com>
Message-ID: <5F616D92.3070201@hisilicon.com>
Date:   Wed, 16 Sep 2020 09:42:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
In-Reply-To: <20200907121831.242281-7-andre.przywara@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.57.101.250]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



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
Applied to the hisilicon arm32 dt tree.

Best Regards,
Wei

> ---
>  arch/arm/boot/dts/hisi-x5hd2.dtsi | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/hisi-x5hd2.dtsi b/arch/arm/boot/dts/hisi-x5hd2.dtsi
> index 3ee7967c202d..e2dbf1d8a67b 100644
> --- a/arch/arm/boot/dts/hisi-x5hd2.dtsi
> +++ b/arch/arm/boot/dts/hisi-x5hd2.dtsi
> @@ -370,8 +370,9 @@
>  				arm,primecell-periphid = <0x00141805>;
>  				reg = <0xa2c000 0x1000>;
>  				interrupts = <0 29 4>;
> -				clocks = <&clock HIX5HD2_WDG0_RST>;
> -				clock-names = "apb_pclk";
> +				clocks = <&clock HIX5HD2_WDG0_RST>,
> +					 <&clock HIX5HD2_WDG0_RST>;
> +				clock-names = "wdog_clk", "apb_pclk";
>  			};
>  		};
>  
> 
