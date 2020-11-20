Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC4562BA6DC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 10:59:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbgKTJ6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 04:58:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:34350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727248AbgKTJ6b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 04:58:31 -0500
Received: from localhost (unknown [122.171.203.152])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1F2422240;
        Fri, 20 Nov 2020 09:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605866310;
        bh=CwM4Ql9VFjQL2OMCE3BfD6NXMX4JW1TDIfSQgSQ0h5E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pqMfTg3kmaI2DtarD3Qt8jW1WZQMadVaY+9vEyfl1Qjc3gd9zld+oq1PYYjtBCt7n
         naWBhTDMT/ZkEdiUDW2gwNd7gQSS6hIwVsj3QytJ9DJ9/6JwRk6Pk1UGhfzYyZ1bmL
         vjav65BtL7WTjgHI/LRXN1BICbSDfZaAmdDqfEJU=
Date:   Fri, 20 Nov 2020 15:28:25 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Remi Pommarel <repk@triplefau.lt>
Subject: Re: [RESEND PATCH v3 3/3] phy: amlogic:
 phy-meson-axg-mipi-pcie-analog: add support for MIPI DSI analog
Message-ID: <20201120095825.GD2925@vkoul-mobl>
References: <20201116101647.73448-1-narmstrong@baylibre.com>
 <20201116101647.73448-4-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201116101647.73448-4-narmstrong@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-11-20, 11:16, Neil Armstrong wrote:
> The AXG Analog MIPI-DSI PHY also provides functions to the PCIe PHY,
> thus we need to have inclusive support for both interfaces at runtime.
> 
> This fixes the regmap get from parent node, removes cell param
> to select a mode and implement runtime configuration & power on/off
> for both functions since they are not exclusive.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> Reviewed-by: Remi Pommarel <repk@triplefau.lt>
> ---
>  drivers/phy/amlogic/Kconfig                   |   1 +
>  .../amlogic/phy-meson-axg-mipi-pcie-analog.c  | 204 ++++++++++++------
>  2 files changed, 136 insertions(+), 69 deletions(-)
> 
> diff --git a/drivers/phy/amlogic/Kconfig b/drivers/phy/amlogic/Kconfig
> index 99e8a4c7f1f3..db5d0cd757e3 100644
> --- a/drivers/phy/amlogic/Kconfig
> +++ b/drivers/phy/amlogic/Kconfig
> @@ -66,6 +66,7 @@ config PHY_MESON_AXG_MIPI_PCIE_ANALOG
>  	depends on OF && (ARCH_MESON || COMPILE_TEST)
>  	select GENERIC_PHY
>  	select REGMAP_MMIO
> +	select GENERIC_PHY_MIPI_DPHY
>  	help
>  	  Enable this to support the Meson MIPI + PCIE analog PHY
>  	  found in Meson AXG SoCs.
> diff --git a/drivers/phy/amlogic/phy-meson-axg-mipi-pcie-analog.c b/drivers/phy/amlogic/phy-meson-axg-mipi-pcie-analog.c
> index 1431cbf885e1..6eb21551bdd9 100644
> --- a/drivers/phy/amlogic/phy-meson-axg-mipi-pcie-analog.c
> +++ b/drivers/phy/amlogic/phy-meson-axg-mipi-pcie-analog.c
> @@ -4,9 +4,13 @@
>   *
>   * Copyright (C) 2019 Remi Pommarel <repk@triplefau.lt>
>   */
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
>  #include <linux/module.h>
>  #include <linux/phy/phy.h>
>  #include <linux/regmap.h>
> +#include <linux/delay.h>
> +#include <linux/mfd/syscon.h>
>  #include <linux/platform_device.h>
>  #include <dt-bindings/phy/phy.h>
>  
> @@ -14,10 +18,10 @@
>  #define		HHI_MIPI_CNTL0_COMMON_BLOCK	GENMASK(31, 28)
>  #define		HHI_MIPI_CNTL0_ENABLE		BIT(29)
>  #define		HHI_MIPI_CNTL0_BANDGAP		BIT(26)
> -#define		HHI_MIPI_CNTL0_DECODE_TO_RTERM	GENMASK(15, 12)
> -#define		HHI_MIPI_CNTL0_OUTPUT_EN	BIT(3)
> +#define		HHI_MIPI_CNTL0_DIF_REF_CTL1	GENMASK(25, 16)
> +#define		HHI_MIPI_CNTL0_DIF_REF_CTL0	GENMASK(15, 0)
>  
> -#define HHI_MIPI_CNTL1 0x01
> +#define HHI_MIPI_CNTL1 0x04
>  #define		HHI_MIPI_CNTL1_CH0_CML_PDR_EN	BIT(12)
>  #define		HHI_MIPI_CNTL1_LP_ABILITY	GENMASK(5, 4)
>  #define		HHI_MIPI_CNTL1_LP_RESISTER	BIT(3)
> @@ -25,100 +29,170 @@
>  #define		HHI_MIPI_CNTL1_INPUT_SEL	BIT(1)
>  #define		HHI_MIPI_CNTL1_PRBS7_EN		BIT(0)
>  
> -#define HHI_MIPI_CNTL2 0x02
> +#define HHI_MIPI_CNTL2 0x08
>  #define		HHI_MIPI_CNTL2_CH_PU		GENMASK(31, 25)
>  #define		HHI_MIPI_CNTL2_CH_CTL		GENMASK(24, 19)
>  #define		HHI_MIPI_CNTL2_CH0_DIGDR_EN	BIT(18)
>  #define		HHI_MIPI_CNTL2_CH_DIGDR_EN	BIT(17)
>  #define		HHI_MIPI_CNTL2_LPULPS_EN	BIT(16)
> -#define		HHI_MIPI_CNTL2_CH_EN(n)		BIT(15 - (n))
> +#define		HHI_MIPI_CNTL2_CH_EN		GENMASK(15, 11)
>  #define		HHI_MIPI_CNTL2_CH0_LP_CTL	GENMASK(10, 1)
>  
> +#define DSI_LANE_0              (1 << 4)
> +#define DSI_LANE_1              (1 << 3)
> +#define DSI_LANE_CLK            (1 << 2)
> +#define DSI_LANE_2              (1 << 1)
> +#define DSI_LANE_3              (1 << 0)
> +#define DSI_LANE_MASK		(0x1F)

This should use BIT(), also there are interesting helpers in bitfield.h
to help with register fields, do send follow up patches..

-- 
~Vinod
