Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9C872F272C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 05:39:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731027AbhALEim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 23:38:42 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:40570 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728687AbhALEil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 23:38:41 -0500
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id EBFB63E;
        Tue, 12 Jan 2021 05:37:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1610426279;
        bh=JXMwIpyboCcKzCJXsNtKWX/esNzMw9e7pfIvcu3n2vE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rEkgccxGm3jhwLQrWHkwt00pU9LMdLL4/NwfyadZHiYkyKbsC0/gpEw40yCrLzOWX
         aUV1UsghW7ijFQThJLPscXA7hCcdTgB5x6wtcUvMhEv8EXcb7jyyGuMa3uQWSlGL5+
         agrb6waRf06ib+OX9eLqkj8sn0wYAYmVtybJY1Ys=
Date:   Tue, 12 Jan 2021 06:37:45 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/bridge: nwl-dsi: Avoid potential multiplication
 overflow on 32-bit
Message-ID: <X/0nmQ/XBpj6PJAh@pendragon.ideasonboard.com>
References: <20210111125702.360745-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210111125702.360745-1-geert+renesas@glider.be>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

Thank you for the patch.

On Mon, Jan 11, 2021 at 01:57:02PM +0100, Geert Uytterhoeven wrote:
> As nwl_dsi.lanes is u32, and NSEC_PER_SEC is 1000000000L, the second
> multiplication in
> 
>     dsi->lanes * 8 * NSEC_PER_SEC
> 
> will overflow on a 32-bit platform.  Fix this by making the constant
> unsigned long long, forcing 64-bit arithmetic.
> 
> While iMX8 is arm64, this driver is currently used on 64-bit platforms
> only, where long is 64-bit, so this cannot happen.  But the issue may
> start to happen when the driver is reused for a 32-bit SoC, or when code
> is copied for a new driver.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Compile-tested only.
> ---
>  drivers/gpu/drm/bridge/nwl-dsi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/nwl-dsi.c b/drivers/gpu/drm/bridge/nwl-dsi.c
> index 66b67402f1acd57d..a8da3081efdcc84e 100644
> --- a/drivers/gpu/drm/bridge/nwl-dsi.c
> +++ b/drivers/gpu/drm/bridge/nwl-dsi.c
> @@ -195,7 +195,7 @@ static u32 ps2bc(struct nwl_dsi *dsi, unsigned long long ps)
>  	u32 bpp = mipi_dsi_pixel_format_to_bpp(dsi->format);
>  
>  	return DIV64_U64_ROUND_UP(ps * dsi->mode.clock * bpp,
> -				  dsi->lanes * 8 * NSEC_PER_SEC);
> +				  dsi->lanes * 8ULL * NSEC_PER_SEC);

I wonder if we could get rid of a whole class of bugs by turning
NSEC_PER_SEC into a ULL, but I suppose there are valid cases where a
32-bit integer is enough.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

How did you come across this by the way ?

>  }
>  
>  /*

-- 
Regards,

Laurent Pinchart
