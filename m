Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE01429FF83
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 09:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726095AbgJ3IQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 04:16:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:43588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726065AbgJ3IQf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 04:16:35 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3506722210;
        Fri, 30 Oct 2020 08:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604045794;
        bh=+GDUUmeAF0/LHVRvmxpjlUJjlXa4FbcBiJo80zHyOFU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DEJE+8wIfaZrVMukOf5Q+TJWS5nEGahA5Cu8bLak8juzi/wXySOUbVAIdfmpDppYU
         DKLNVXkWpCYO+gRMx3QMK+kmBiXoYeC6jPDJ3VHPXL8VUGVZ/977PukyrogxA9BPWb
         rEwnYQl/dXY8tmIqwHm28QBTeyQ+9Y8uyn7CTOhE=
Date:   Fri, 30 Oct 2020 16:16:21 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Ioana Ciornei <ioana.ciornei@nxp.com>
Cc:     robh+dt@kernel.org, leoyang.li@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 03/11] arm64: dts: ls1088a: add external MDIO device
 nodes
Message-ID: <20201030081617.GM28755@dragon>
References: <20201026161005.5421-1-ioana.ciornei@nxp.com>
 <20201026161005.5421-4-ioana.ciornei@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026161005.5421-4-ioana.ciornei@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 06:09:57PM +0200, Ioana Ciornei wrote:
> Add the external MDIO device nodes found in the WRIOP global memory
> region. This is needed for management of external PHYs.
> 
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> ---
> Changes in v2:
>  - removed the 0x from the unit addresses
> Changes in v3:
>  - none
> Changes in v4:
>  - none
> 
>  arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> index ff5805206a28..aea42e9e947f 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> @@ -672,6 +672,24 @@ ptp-timer@8b95000 {
>  			fsl,extts-fifo;
>  		};
>  
> +		emdio1: mdio@8b96000 {
> +			compatible = "fsl,fman-memac-mdio";
> +			reg = <0x0 0x8B96000 0x0 0x1000>;

Use lowercase for hex values.

Shawn

> +			little-endian;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
> +		emdio2: mdio@8b97000 {
> +			compatible = "fsl,fman-memac-mdio";
> +			reg = <0x0 0x8B97000 0x0 0x1000>;
> +			little-endian;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
>  		cluster1_core0_watchdog: wdt@c000000 {
>  			compatible = "arm,sp805-wdt", "arm,primecell";
>  			reg = <0x0 0xc000000 0x0 0x1000>;
> -- 
> 2.28.0
> 
