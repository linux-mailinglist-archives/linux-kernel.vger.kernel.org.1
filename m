Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 631B92A1CB5
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 09:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbgKAIyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 03:54:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:47918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726152AbgKAIyx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 03:54:53 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3AA220874;
        Sun,  1 Nov 2020 08:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604220892;
        bh=KWEU8GjV78nOgqqkOpMK6rv5pSbvIQbKBaSFkKJhZTk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uCwhQJ3vkfNonYysbbnAEKDIFWfuT6HiLQbwDBDAD8uoIkkossf6NRLsiXOZmrmtT
         +x/BPguLtW7sInKhZF8MdNeQ/Eh8Iqj0oY7qNcM+QIJPuADWrCS5vuapo6anmo5y0T
         uEKX85Uy8pgr+Z8f2PQi62+8S5SQQ+XLpvyWOxDs=
Date:   Sun, 1 Nov 2020 16:54:47 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        leoyang.li@nxp.com, Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: Re: [PATCHv9] arm64: dts: layerscape: Add PCIe EP node for ls1088a
Message-ID: <20201101085447.GJ31601@dragon>
References: <20201026042759.15155-1-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026042759.15155-1-Zhiqiang.Hou@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 12:27:59PM +0800, Zhiqiang Hou wrote:
> From: Xiaowei Bao <xiaowei.bao@nxp.com>
> 
> Add PCIe EP node for ls1088a to support EP mode.
> 
> Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> Reviewed-by: Andrew Murray <andrew.murray@arm.com>
> ---
> V9:
>  - Rebase the patch since V8 patch was not accepted due to conflict.
>  - Correct the number of outbound windows.
>  - Add lables for EP nodes.
> 
>  .../arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 31 +++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> index ff5805206a28..8d8e610acba6 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> @@ -517,6 +517,17 @@
>  			status = "disabled";
>  		};
>  
> +		pcie_ep1: pcie-ep@3400000 {
> +			compatible = "fsl,ls1088a-pcie-ep","fsl,ls-pcie-ep";

Missing space in between compatibles.

Shawn

> +			reg = <0x00 0x03400000 0x0 0x00100000
> +			       0x20 0x00000000 0x8 0x00000000>;
> +			reg-names = "regs", "addr_space";
> +			num-ib-windows = <24>;
> +			num-ob-windows = <256>;
> +			max-functions = /bits/ 8 <2>;
> +			status = "disabled";
> +		};
> +
>  		pcie2: pcie@3500000 {
>  			compatible = "fsl,ls1088a-pcie";
>  			reg = <0x00 0x03500000 0x0 0x00100000   /* controller registers */
> @@ -543,6 +554,16 @@
>  			status = "disabled";
>  		};
>  
> +		pcie_ep2: pcie-ep@3500000 {
> +			compatible = "fsl,ls1088a-pcie-ep","fsl,ls-pcie-ep";
> +			reg = <0x00 0x03500000 0x0 0x00100000
> +			       0x28 0x00000000 0x8 0x00000000>;
> +			reg-names = "regs", "addr_space";
> +			num-ib-windows = <6>;
> +			num-ob-windows = <6>;
> +			status = "disabled";
> +		};
> +
>  		pcie3: pcie@3600000 {
>  			compatible = "fsl,ls1088a-pcie";
>  			reg = <0x00 0x03600000 0x0 0x00100000   /* controller registers */
> @@ -569,6 +590,16 @@
>  			status = "disabled";
>  		};
>  
> +		pcie_ep3: pcie-ep@3600000 {
> +			compatible = "fsl,ls1088a-pcie-ep","fsl,ls-pcie-ep";
> +			reg = <0x00 0x03600000 0x0 0x00100000
> +			       0x30 0x00000000 0x8 0x00000000>;
> +			reg-names = "regs", "addr_space";
> +			num-ib-windows = <6>;
> +			num-ob-windows = <6>;
> +			status = "disabled";
> +		};
> +
>  		smmu: iommu@5000000 {
>  			compatible = "arm,mmu-500";
>  			reg = <0 0x5000000 0 0x800000>;
> -- 
> 2.17.1
> 
