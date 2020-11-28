Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69EEF2C714B
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 22:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391574AbgK1V4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Nov 2020 16:56:04 -0500
Received: from foss.arm.com ([217.140.110.172]:37696 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387713AbgK1Uft (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Nov 2020 15:35:49 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B23CA30E;
        Sat, 28 Nov 2020 12:35:03 -0800 (PST)
Received: from [192.168.2.22] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 816AF3F23F;
        Sat, 28 Nov 2020 12:35:02 -0800 (PST)
Subject: Re: [RESEND PATCH 06/19] arm64: allwinner: a100: Add device node for
 DMA controller
To:     Frank Lee <frank@allwinnertech.com>, tiny.windzz@gmail.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Jernej Skrabec <jernej.skrabec@siol.net>
References: <cover.1604988979.git.frank@allwinnertech.com>
 <1b15266045edbcfff2fc3791c88a5390d7bb3185.1604988979.git.frank@allwinnertech.com>
From:   =?UTF-8?Q?Andr=c3=a9_Przywara?= <andre.przywara@arm.com>
Organization: ARM Ltd.
Message-ID: <496f7773-1141-5f1b-2187-ac15da4c8576@arm.com>
Date:   Sat, 28 Nov 2020 20:34:47 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <1b15266045edbcfff2fc3791c88a5390d7bb3185.1604988979.git.frank@allwinnertech.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/2020 06:29, Frank Lee wrote:
> From: Yangtao Li <frank@allwinnertech.com>
> 
> The A100 SoC has a DMA controller that supports 8 DMA channels
> to and from various peripherals.
> 
> Add a device node for it.
> 
> Signed-off-by: Yangtao Li <frank@allwinnertech.com>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
> index cc321c04f121..c34ed8045363 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
> @@ -101,6 +101,18 @@ ccu: clock@3001000 {
>  			#reset-cells = <1>;
>  		};
>  
> +		dma: dma-controller@3002000 {
> +			compatible = "allwinner,sun50i-a100-dma";

So at it appears to work with the exact same settings in the driver as
the H6, we should have that as a compatible fallback:
  compatible = "allwinner,sun50i-a100-dma", "allwinner,sun50i-h6-dma";

Cheers,
Andre

> +			reg = <0x03002000 0x1000>;
> +			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&ccu CLK_BUS_DMA>, <&ccu CLK_MBUS_DMA>;
> +			clock-names = "bus", "mbus";
> +			dma-channels = <8>;
> +			dma-requests = <51>;
> +			resets = <&ccu RST_BUS_DMA>;
> +			#dma-cells = <1>;
> +		};
> +
>  		gic: interrupt-controller@3021000 {
>  			compatible = "arm,gic-400";
>  			reg = <0x03021000 0x1000>, <0x03022000 0x2000>,
> 

