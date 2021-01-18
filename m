Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB2872F9760
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 02:38:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730867AbhARBid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 20:38:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:43944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726592AbhARBi3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 20:38:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5E3FC20770;
        Mon, 18 Jan 2021 01:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610933869;
        bh=cCm+JVvnQAgF1evJgKFLFRJplHjdh61BaTGyRO4FUPE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ex2ghdkzguXFgFWur/exr6FzzVopk8TQcrhugsytJx3ibnsdTttMUGXP+qSTOC3J3
         n4+llnkjbrON96cBpWNs+b66lcdbESjAIJ9BLphNfnLV8mZGQqO+6hjW/YpexDMjry
         jY/3IrCThT584SoBpmbQPWmXQUBhSil9l1Hrg9//JOb3DKfPbLrIlte2bBDZQ7GTmL
         KjQUohqWrEIF4XY7eUJ+VCJ4ck7/L3S4pHxmHgfcphJjEBTZ+0qtFCn+m6zvOf7ZiO
         LhOZ8IflVKcCZcjW3i2XB7tYyOP9n+IJ8/9PCaAoTxzUfg1HyG6FeMsl4mhrAdHEMT
         DB/a9oQQMcV7w==
Date:   Mon, 18 Jan 2021 09:37:44 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Kuldeep Singh <kuldeep.singh@nxp.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: Re: [PATCH 1/3] arm64: dts: lx2160a: Add flexcan support
Message-ID: <20210118013744.GG28365@dragon>
References: <1610350729-21287-1-git-send-email-kuldeep.singh@nxp.com>
 <1610350729-21287-2-git-send-email-kuldeep.singh@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1610350729-21287-2-git-send-email-kuldeep.singh@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 01:08:47PM +0530, Kuldeep Singh wrote:
> LX2160A supports two flexcan controllers. Add the support.
> Enable support further for LX2160A-RDB/QDS.
> 
> Signed-off-by: Kuldeep Singh <kuldeep.singh@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts |  8 ++++++++
>  arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts | 16 ++++++++++++++++
>  arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi    | 20 ++++++++++++++++++++
>  3 files changed, 44 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
> index 16ae3b0..d858d9c 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
> @@ -33,6 +33,14 @@
>  	};
>  };
>  
> +&can0 {
> +	status = "okay";
> +};
> +
> +&can1 {
> +	status = "okay";
> +};
> +
>  &crypto {
>  	status = "okay";
>  };
> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> index 6f82759..5dbf274 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> @@ -89,6 +89,22 @@
>  	};
>  };
>  
> +&can0 {
> +	status = "okay";
> +
> +	can-transceiver {
> +		max-bitrate = <5000000>;
> +	};
> +};
> +
> +&can1 {
> +	status = "okay";
> +
> +	can-transceiver {
> +		max-bitrate = <5000000>;
> +	};
> +};
> +
>  &esdhc0 {
>  	sd-uhs-sdr104;
>  	sd-uhs-sdr50;
> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> index 0d4bce1..63a3ef6 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> @@ -878,6 +878,26 @@
>  			status = "disabled";
>  		};
>  
> +		can0: can@2180000 {
> +			compatible = "fsl,lx2160ar1-flexcan";
> +			reg = <0x0 0x2180000 0x0 0x10000>;
> +			interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clockgen 4 7>, <&sysclk>;

Can defines in dt-bindings/clock/fsl,qoriq-clockgen.h be useful?

Shawn

> +			clock-names = "ipg", "per";
> +			fsl,clk-source = <0>;
> +			status = "disabled";
> +		};
> +
> +		can1: can@2190000 {
> +			compatible = "fsl,lx2160ar1-flexcan";
> +			reg = <0x0 0x2190000 0x0 0x10000>;
> +			interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clockgen 4 7>, <&sysclk>;
> +			clock-names = "ipg", "per";
> +			fsl,clk-source = <0>;
> +			status = "disabled";
> +		};
> +
>  		uart0: serial@21c0000 {
>  			compatible = "arm,sbsa-uart","arm,pl011";
>  			reg = <0x0 0x21c0000 0x0 0x1000>;
> -- 
> 2.7.4
> 
