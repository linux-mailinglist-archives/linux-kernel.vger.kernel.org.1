Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2C12FD895
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 19:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbhATSkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 13:40:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:51262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390333AbhATS2e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 13:28:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 37755233FC;
        Wed, 20 Jan 2021 18:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611167274;
        bh=vjunBYcfmoEhuHi9C00Jr/Jy+8HJAFrvRPfYznGtIKg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gOl9shjTzknM9YiyVLg9dZpn6FPVTXhF3re+4Dh0axFEclqb8yWnyEHrKdOmMjR+i
         vkKu30xXDhQ9/ZOu/EdxM6Bf2LDygaMhNq7CQY/0OXxeucuA+89zc0gZj6YG+fo/L8
         KpT/C8dtakbHF3pKeFXKDqoR0IsE1XjLCZTkq62DlAHw+jyn+Ej0FmY+Qdrn99+Tun
         eq/Btp6HnjeAEmzuy+B8SAPWVnLsN7I9X0/dIoN9Qfa8CBrY9E3LV5nElSVNjTtvl4
         J0vx02VldRiUZgcLrRTbpNUmYeUgqkgFHbFdi6DdhGiXHAgktbfNxMb6xj7JoxhAwh
         q4DXrejRfHD/w==
Date:   Wed, 20 Jan 2021 19:27:48 +0100
From:   Matthias Brugger <matthias.bgg@kernel.org>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, CK Hu <ck.hu@mediatek.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 3/5] drm/mediatek: Change disp/ddp term to mutex in
 mtk mutex driver
Message-ID: <YAh2JGUUpMcgyke0@ziggy.stardust>
References: <20210106231729.17173-1-chunkuang.hu@kernel.org>
 <20210106231729.17173-4-chunkuang.hu@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210106231729.17173-4-chunkuang.hu@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 07, 2021 at 07:17:27AM +0800, Chun-Kuang Hu wrote:
> From: CK Hu <ck.hu@mediatek.com>
> 
> mtk mutex is used by both drm and mdp driver, so change disp/ddp term to
> mutex to show that it's a common driver for drm and mdp.
> 
> Signed-off-by: CK Hu <ck.hu@mediatek.com>
> Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_crtc.c |  30 +--
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c  |   2 +-
>  drivers/gpu/drm/mediatek/mtk_drm_drv.h  |   2 +-
>  drivers/gpu/drm/mediatek/mtk_mutex.c    | 305 ++++++++++++------------
>  drivers/gpu/drm/mediatek/mtk_mutex.h    |  26 +-
>  5 files changed, 182 insertions(+), 183 deletions(-)
> 
[...]
> diff --git a/drivers/gpu/drm/mediatek/mtk_mutex.c b/drivers/gpu/drm/mediatek/mtk_mutex.c
> index 1c8a253f4788..98a060bf225d 100644
> --- a/drivers/gpu/drm/mediatek/mtk_mutex.c
> +++ b/drivers/gpu/drm/mediatek/mtk_mutex.c
[...]
>  
> -static const struct of_device_id ddp_driver_dt_match[] = {
> +static const struct of_device_id mutex_driver_dt_match[] = {
>  	{ .compatible = "mediatek,mt2701-disp-mutex",
> -	  .data = &mt2701_ddp_driver_data},
> +	  .data = &mt2701_mutex_driver_data},
>  	{ .compatible = "mediatek,mt2712-disp-mutex",
> -	  .data = &mt2712_ddp_driver_data},
> +	  .data = &mt2712_mutex_driver_data},
>  	{ .compatible = "mediatek,mt8167-disp-mutex",
> -	  .data = &mt8167_ddp_driver_data},
> +	  .data = &mt8167_mutex_driver_data},
>  	{ .compatible = "mediatek,mt8173-disp-mutex",
> -	  .data = &mt8173_ddp_driver_data},
> +	  .data = &mt8173_mutex_driver_data},
>  	{},
>  };
> -MODULE_DEVICE_TABLE(of, ddp_driver_dt_match);
> +MODULE_DEVICE_TABLE(of, mutex_driver_dt_match);

I think it would make sense in a follow-up patch to update the binding
to use "mediatek,mt2701-mutex" to reflect that mutex is used for drm and
mdp driver. Make sense?

Regards,
Matthias
