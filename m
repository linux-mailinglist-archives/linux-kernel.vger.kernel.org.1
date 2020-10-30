Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3496029F961
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 01:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725828AbgJ3ACh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 20:02:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:36350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725379AbgJ3ACh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 20:02:37 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3097E2076B;
        Fri, 30 Oct 2020 00:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604016117;
        bh=wFLBF7ORF1OPFwY3KmaUkvNtNujBSGgmRFJeS09PCx0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xJ1oifeAKe85i4DYdLmDv13RK4suJEgUpn2dWfXhYIuX6HqYV6WFTHKKfuvKYreU8
         xsmzCKUIAKB8qSup63aCWEgVjAgHfw/2lvLkqTOM60xP01LaHeAjQVnU+wffdMKY1X
         SPYiU2FYSbw5YIgG0rBMex5lA+Y9lDzTEt2I/AN4=
Date:   Fri, 30 Oct 2020 08:01:53 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Ioana Ciornei <ioana.ciornei@nxp.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/9] arm64: dts: ls1088a: add external MDIO device nodes
Message-ID: <20201030000151.GS28755@dragon>
References: <20200925132503.30206-1-ioana.ciornei@nxp.com>
 <20200925132503.30206-2-ioana.ciornei@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200925132503.30206-2-ioana.ciornei@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 04:24:55PM +0300, Ioana Ciornei wrote:
> Add the external MDIO device nodes found in the WRIOP global memory
> region. This is needed for management of external PHYs.
> 
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> index 169f4742ae3b..22544e3b7737 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> @@ -654,6 +654,24 @@ ptp-timer@8b95000 {
>  			fsl,extts-fifo;
>  		};
>  
> +		emdio1: mdio@0x8B96000 {

Drop leading '0x' and use lowercase in unit-address.

Shawn

> +			compatible = "fsl,fman-memac-mdio";
> +			reg = <0x0 0x8B96000 0x0 0x1000>;
> +			little-endian;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
> +		emdio2: mdio@0x8B97000 {
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
> 2.25.1
> 
