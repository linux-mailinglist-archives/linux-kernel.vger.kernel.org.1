Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 426FF2F9AAC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 08:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732932AbhARHjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 02:39:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:44598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732733AbhARHjG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 02:39:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BDE08221E5;
        Mon, 18 Jan 2021 07:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610955505;
        bh=7oHB7NQzZBBuIwVDW4GoZ51rO4/VcaQdYrs8EhPQSAE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UeqbX3Kq1gKB9ohMu6aJnAU5aTocwuAU1VEGvjtHK2/f8hIm7YOHW7ttQCs1ak8Zg
         u9CrRLP0Nta36Hq5ha/PIA4+zRmBrGn3ov6hUWJqUGG6scUITYHipc/yiPgdpfFsXs
         rntbBxUSoVsXjj+Y9cygHjhz+/o16/ZgwdpcPH/y8qPAmabEjI6ARlZMGKMZWwiGWt
         W34j54mbWQ9D+R8IW9j/ezTYomIhEDUa5/2sMrGOiwmcMOZKip2AAak/Sl91/D+GTX
         pXJBuou5HWgI2JiARSyuPWPVcCfA+37Xb1CdLsQxtJgL5v1luzWkAKZ50ZChiDFNN7
         mfqFKb6DnXhrA==
Date:   Mon, 18 Jan 2021 15:38:09 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Pawel Dembicki <paweldembicki@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Yangbo Lu <yangbo.lu@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: fsl-ls1012a-frdm: add spi-uart device
Message-ID: <20210118073806.GR28365@dragon>
References: <20210115101613.1490837-1-paweldembicki@gmail.com>
 <20210115101613.1490837-2-paweldembicki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210115101613.1490837-2-paweldembicki@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021 at 11:16:13AM +0100, Pawel Dembicki wrote:
> This patch adds spi-uart controller  to LS1012A-FRDM board dts.
> Device is equipped in SC16IS740 from NXP.
> 
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
> ---
>  .../boot/dts/freescale/fsl-ls1012a-frdm.dts   | 21 +++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dts b/arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dts
> index 67702667ed8a..9473d16336a2 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dts
> @@ -7,6 +7,7 @@
>   */
>  /dts-v1/;
>  
> +#include <dt-bindings/interrupt-controller/irq.h>
>  #include "fsl-ls1012a.dtsi"
>  
>  / {
> @@ -57,6 +58,26 @@ simple-audio-card,codec {
>  	};
>  };
>  
> +&dspi {
> +	status = "okay";
> +	bus-num = <0>;

Let's end property list with `status`.

> +
> +	serial@0 {
> +		reg = <0>;
> +		compatible = "nxp,sc16is740";

Let's start property list with `compatible`.

> +		spi-max-frequency = <4000000>;
> +		clocks = <&sc16is7xx_clk>;
> +		interrupt-parent = <&gpio1>;
> +		interrupts = <13 IRQ_TYPE_EDGE_FALLING>;
> +
> +		sc16is7xx_clk: sc16is7xx_clk {

clock-sc16is7xx for node name maybe.

Shawn

> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <24000000>;
> +		};
> +	};
> +};
> +
>  &duart0 {
>  	status = "okay";
>  };
> -- 
> 2.25.1
> 
