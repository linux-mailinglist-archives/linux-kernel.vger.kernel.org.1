Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ACBA2C7146
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 22:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732736AbgK1Vzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Nov 2020 16:55:43 -0500
Received: from foss.arm.com ([217.140.110.172]:37590 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387686AbgK1UWA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Nov 2020 15:22:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E6D7F1042;
        Sat, 28 Nov 2020 12:21:14 -0800 (PST)
Received: from [192.168.2.22] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B4CE53F23F;
        Sat, 28 Nov 2020 12:21:13 -0800 (PST)
Subject: Re: [RESEND PATCH 11/19] arm64: dts: allwinner: a100: add watchdog
 node
To:     Frank Lee <frank@allwinnertech.com>, tiny.windzz@gmail.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Jernej Skrabec <jernej.skrabec@siol.net>
References: <cover.1604988979.git.frank@allwinnertech.com>
 <7a7fc132cf3fa07f069d473d4600ec1449fb45ff.1604988979.git.frank@allwinnertech.com>
From:   =?UTF-8?Q?Andr=c3=a9_Przywara?= <andre.przywara@arm.com>
Organization: ARM Ltd.
Message-ID: <197ac654-7258-205c-c34f-2559d2ff5010@arm.com>
Date:   Sat, 28 Nov 2020 20:20:58 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <7a7fc132cf3fa07f069d473d4600ec1449fb45ff.1604988979.git.frank@allwinnertech.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/2020 06:38, Frank Lee wrote:
> From: Yangtao Li <frank@allwinnertech.com>
> 
> Declare A100's watchdog in the device-tree.
> 
> Signed-off-by: Yangtao Li <frank@allwinnertech.com>

I don't have any manual nor hardware, but this node looks alright, when
compared to the H6 one.

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
>  arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
> index 01ff53b5a7a8..6aa3337ce0e9 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
> @@ -144,6 +144,14 @@ ths_calibration: calib@14 {
>  			};
>  		};
>  
> +		watchdog@30090a0 {
> +			compatible = "allwinner,sun50i-a100-wdt",
> +				     "allwinner,sun6i-a31-wdt";
> +			reg = <0x030090a0 0x20>;
> +			interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&dcxo24M>;
> +		};
> +
>  		pio: pinctrl@300b000 {
>  			compatible = "allwinner,sun50i-a100-pinctrl";
>  			reg = <0x0300b000 0x400>;
> 

