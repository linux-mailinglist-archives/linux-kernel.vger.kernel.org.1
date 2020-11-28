Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 503F12C714D
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 22:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391578AbgK1V4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Nov 2020 16:56:12 -0500
Received: from foss.arm.com ([217.140.110.172]:37778 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387738AbgK1Usq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Nov 2020 15:48:46 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F7C030E;
        Sat, 28 Nov 2020 12:48:00 -0800 (PST)
Received: from [192.168.2.22] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E0B0F3F23F;
        Sat, 28 Nov 2020 12:47:58 -0800 (PST)
Subject: Re: [RESEND PATCH 07/19] arm64: dts: allwinner: A100: Add PMU mode
To:     Frank Lee <frank@allwinnertech.com>, tiny.windzz@gmail.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Jernej Skrabec <jernej.skrabec@siol.net>
References: <cover.1604988979.git.frank@allwinnertech.com>
 <5aede9ac5069e61913905617b20cdcf1ec84fe26.1604988979.git.frank@allwinnertech.com>
From:   =?UTF-8?Q?Andr=c3=a9_Przywara?= <andre.przywara@arm.com>
Organization: ARM Ltd.
Message-ID: <803fa6fb-31a2-e90d-a7cc-98f282cec2b1@arm.com>
Date:   Sat, 28 Nov 2020 20:47:43 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <5aede9ac5069e61913905617b20cdcf1ec84fe26.1604988979.git.frank@allwinnertech.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/2020 06:31, Frank Lee wrote:

Hi,

> From: Yangtao Li <frank@allwinnertech.com>
> 
> Add the Performance Monitoring Unit (PMU) device tree node to the A100
> .dtsi, which tells DT users which interrupts are triggered by PMU overflow
> events on each core.

Have you tested that the interrupts actually work? For the A64 there
were wrong in the manual, and we realised only later.
"perf stat" works even without interrupts, but "perf record" requires
interrupts, and will return empty-handed if they don't work.
Can you confirm this?

> 
> Signed-off-by: Yangtao Li <frank@allwinnertech.com>

Without being able to test or verify this, the nodes looks correct, so:

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
>  arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
> index c34ed8045363..01ff53b5a7a8 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
> @@ -25,21 +25,21 @@ cpu0: cpu@0 {
>  			enable-method = "psci";
>  		};
>  
> -		cpu@1 {
> +		cpu1: cpu@1 {
>  			compatible = "arm,cortex-a53";
>  			device_type = "cpu";
>  			reg = <0x1>;
>  			enable-method = "psci";
>  		};
>  
> -		cpu@2 {
> +		cpu2: cpu@2 {
>  			compatible = "arm,cortex-a53";
>  			device_type = "cpu";
>  			reg = <0x2>;
>  			enable-method = "psci";
>  		};
>  
> -		cpu@3 {
> +		cpu3: cpu@3 {
>  			compatible = "arm,cortex-a53";
>  			device_type = "cpu";
>  			reg = <0x3>;
> @@ -47,6 +47,15 @@ cpu@3 {
>  		};
>  	};
>  
> +	pmu {
> +		compatible = "arm,cortex-a53-pmu";
> +		interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-affinity = <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>;
> +	};
> +
>  	psci {
>  		compatible = "arm,psci-1.0";
>  		method = "smc";
> 

