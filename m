Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 771DE2B3E39
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 09:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbgKPIB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 03:01:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:51112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727132AbgKPIBZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 03:01:25 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7AB67206B7;
        Mon, 16 Nov 2020 08:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605513684;
        bh=+YuBH5NgvMdSGbHhfVMYwR2CKEj6o0vjeBiRlHGxZQk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LksTzPVMzCYnuzYbzF949ecfR9BAFFoHdrA9F8PbnPb9tLHG03Gqn9wTamyegNieH
         xPc7fi+vr7hqS5HwbLhTYiTjr515FAJXp9hEEVYNaKCvIqx+mIovZo/nTNvy6u1IAw
         XAd0Zjsv9X2/jrRBi4ACJhSBUOh46ZQf552X6JEA=
Date:   Mon, 16 Nov 2020 16:01:19 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     robh+dt@kernel.org, s.hauer@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, krzk@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2] arm64: dts: freescale: fix typo Makefile
Message-ID: <20201116080118.GD5849@dragon>
References: <20201110152631.3007779-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110152631.3007779-1-anders.roxell@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 04:26:31PM +0100, Anders Roxell wrote:
> While trying to do 'make dtbs_install' the following error shows up
> 
> make[3]: *** No rule to make target
>   '/tmp/out/obj-dir/dtbinstallfreescale/imx8mm-kontron-n801x-s.dts', needed by '__dtbs_install'.
> 
> Fix typo in imx8mm-kontron-n801x-s.dts change file ending to *.dtb
> 
> Fixes: 8668d8b2e67f ("arm64: dts: Add the Kontron i.MX8M Mini SoMs and baseboards")
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

Thanks for the patch, Anders.  We have already applied the patch from
Nathan Chancellor [1].

Shawn

[1] https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git/commit/?h=imx/dt64&id=889e0fb16e36d35bac443dede3ad203be97e042d

> ---
>  arch/arm64/boot/dts/freescale/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index 876bf484bbe6..6f0777ee6cd6 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -32,7 +32,7 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2162a-qds.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-beacon-kit.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-evk.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-ddr4-evk.dtb
> -dtb-$(CONFIG_ARCH_MXC) += imx8mm-kontron-n801x-s.dts
> +dtb-$(CONFIG_ARCH_MXC) += imx8mm-kontron-n801x-s.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-var-som-symphony.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mn-evk.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mn-ddr4-evk.dtb
> -- 
> 2.28.0
> 
