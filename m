Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 538A52E911E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 08:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbhADHb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 02:31:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:57214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727230AbhADHby (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 02:31:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CF6C720784;
        Mon,  4 Jan 2021 07:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609745473;
        bh=LGA++ysg+W0W0iCJjPTyOhYxG4L7+MlwveYCqYw2H6o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gEwZrPDEGMb65+h33sNBHdkVBY+jY4f2LwKq31M48z66uMQWyfMb5e77pHG+h1zUc
         vRGv7sAMgvQB5UFhitm8lGpixubGaic4LgaTMdpVlzSRPN4vAWBp0scWq8EFkt7sMI
         HVsh2GVtaN1LblFvzvxyWKbMLepmtbfvfJqKsExgqAYqzrri5VwEHOWrSrrnqJT8VS
         evM2RIAcLvUo89VEDm8V28UsLIFB5HDQSkICDknZo7dncWNeTjK1Q8GrjYQLklH8i2
         j/eM02+yYavMsmLva10zJYgCvEJh1J2KOc0oXcdNb13M2MTanDOWbbW9JYfdqfPAe7
         BHRXp6l4u8Mqg==
Date:   Mon, 4 Jan 2021 13:01:09 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Colin Ian King <colin.king@canonical.com>,
        CK Hu <ck.hu@mediatek.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] phy: mediatek: allow compile-testing the dsi phy
Message-ID: <20210104073109.GF120946@vkoul-mobl>
References: <20210103135524.3678664-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210103135524.3678664-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-01-21, 14:55, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Randconfig builds show another broken dependency:
> 
> WARNING: unmet direct dependencies detected for PHY_MTK_MIPI_DSI
>   Depends on [n]: ARCH_MEDIATEK [=n] && OF [=y]
>   Selected by [m]:
>   - DRM_MEDIATEK [=m] && HAS_IOMEM [=y] && DRM [=m] && (ARCH_MEDIATEK [=n] || ARM [=y] && COMPILE_TEST [=y]) && COMMON_CLK [=y] &&
> HAVE_ARM_SMCCC [=y] && OF [=y] && MTK_MMSYS [=y]
> 
> This is similar to the hdmi driver I fixed earlier, and I guess the
> common-clk bug would sooner or later also manifest here, so just use
> the exact same solution I chose for the other driver, and hope that
> any future drivers just copy it from here.

Applied, thanks

> 
> Fixes: 90f80d95992f ("phy: mediatek: Move mtk_mipi_dsi_phy driver into drivers/phy/mediatek folder")
> Fixes: f5f6e01f9164 ("phy: mediatek: allow compile-testing the hdmi phy")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/phy/mediatek/Kconfig | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/phy/mediatek/Kconfig b/drivers/phy/mediatek/Kconfig
> index d38def43b1bf..55f8e6c048ab 100644
> --- a/drivers/phy/mediatek/Kconfig
> +++ b/drivers/phy/mediatek/Kconfig
> @@ -49,7 +49,9 @@ config PHY_MTK_HDMI
>  
>  config PHY_MTK_MIPI_DSI
>  	tristate "MediaTek MIPI-DSI Driver"
> -	depends on ARCH_MEDIATEK && OF
> +	depends on ARCH_MEDIATEK || COMPILE_TEST
> +	depends on COMMON_CLK
> +	depends on OF
>  	select GENERIC_PHY
>  	help
>  	  Support MIPI DSI for Mediatek SoCs.
> -- 
> 2.29.2

-- 
~Vinod
