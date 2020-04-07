Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 641001A0D14
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Apr 2020 13:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728460AbgDGLxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Apr 2020 07:53:51 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:38540 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbgDGLxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 07:53:51 -0400
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id DD9D759E;
        Tue,  7 Apr 2020 13:53:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1586260429;
        bh=Tpiom0/9HXYeqjAE4DHHDRRZxBkeLOXqxIpsYWIHF6g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ebfedmCea0DfNA0f42wlzHUJ2BLM0TWCtj0eEBAhriSjwzr+qKv8H2+0Lx01A4caG
         4OkfkWpzk03YQcri6vBUkj8jqfzHs4PRp3P2krRIerPxxioqldAa6fk2Y8ZlF2dKf1
         aeddqev8gIsaNCw8Z5vfBkNMMp++zEf/oT8a8Gcg=
Date:   Tue, 7 Apr 2020 14:53:38 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Max Krummenacher <max.oss.09@gmail.com>
Cc:     Max Krummenacher <max.krummenacher@toradex.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Will Deacon <will@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Olof Johansson <olof@lixom.net>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH 1/4] arm64: defconfig: DRM_DUMB_VGA_DAC: follow changed
 config symbol name
Message-ID: <20200407115338.GB4751@pendragon.ideasonboard.com>
References: <20200407103537.4138-1-max.krummenacher@toradex.com>
 <20200407103537.4138-2-max.krummenacher@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200407103537.4138-2-max.krummenacher@toradex.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Max,

Thank you for the patch.

On Tue, Apr 07, 2020 at 12:35:34PM +0200, Max Krummenacher wrote:
> This occurrence wasn't changed in the original rename commit.
> 
> Fixes commit 0411374bdf2b3 ("drm/bridge: dumb-vga-dac: Rename driver to
> simple-bridge").
> 
> Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>

My bad, sorry about the trouble.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> 
> ---
> 
>  arch/arm64/configs/defconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 24e534d850454..ae908c3f43c76 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -610,7 +610,7 @@ CONFIG_DRM_MSM=m
>  CONFIG_DRM_TEGRA=m
>  CONFIG_DRM_PANEL_LVDS=m
>  CONFIG_DRM_PANEL_SIMPLE=m
> -CONFIG_DRM_DUMB_VGA_DAC=m
> +CONFIG_DRM_SIMPLE_BRIDGE=m
>  CONFIG_DRM_PANEL_TRULY_NT35597_WQXGA=m
>  CONFIG_DRM_SII902X=m
>  CONFIG_DRM_THINE_THC63LVD1024=m

-- 
Regards,

Laurent Pinchart
