Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3C82AAA7B
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 11:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbgKHKGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 05:06:49 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:48114 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbgKHKGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 05:06:48 -0500
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 6646C8051F;
        Sun,  8 Nov 2020 11:06:44 +0100 (CET)
Date:   Sun, 8 Nov 2020 11:06:42 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Nishanth Menon <nm@ti.com>
Cc:     Swapnil Jakhade <sjakhade@cadence.com>, Jyri Sarha <jsarha@ti.com>,
        Yuti Amonkar <yamonkar@cadence.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        ssantosh@kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] drm: bridge: cdns: Kconfig: Switch over dependency to
 ARCH_K3
Message-ID: <20201108100642.GC1129714@ravnborg.org>
References: <20201026165441.22894-1-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026165441.22894-1-nm@ti.com>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VafZwmh9 c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=VwQbUJbxAAAA:8 a=Br2UW1UjAAAA:8 a=sozttTNsAAAA:8
        a=P1BnusSwAAAA:8 a=e5mUnYsNAAAA:8 a=pvJ_OQDZk5l-5GHyAecA:9
        a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22 a=WmXOPjafLNExVIMTj843:22
        a=aeg5Gbbo78KNqacMgKqU:22 a=D0XLA9XvdZm18NrgonBM:22
        a=Vxmtnl_E_bksehYqCbjh:22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nishanth

On Mon, Oct 26, 2020 at 11:54:41AM -0500, Nishanth Menon wrote:
> With the integration of chip-id detection scheme in kernel[1], there
> is no specific need to maintain multitudes of SoC specific config
> options, discussed as per [2], we have deprecated the usage in other
> places for v5.10-rc1. Fix the missing user so that we can clean up the
> configs in v5.11.
> 
> [1] drivers/soc/ti/k3-socinfo.c commit 907a2b7e2fc7 ("soc: ti: add k3 platforms chipid module driver")
> [2] https://lore.kernel.org/linux-arm-kernel/20200908112534.t5bgrjf7y3a6l2ss@akan/
> 
> Fixes: afba7e6c5fc1 ("rm: bridge: cdns-mhdp8546: Add TI J721E wrapper")
> Cc: Swapnil Jakhade <sjakhade@cadence.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Yuti Amonkar <yamonkar@cadence.com>
> Cc: Jyri Sarha <jsarha@ti.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Applied to drm-misc-fixes with Tomi's r-b
Fixed the "Fixes" line while applying - someone ate a 'd'

	Sam

> ---
>  drivers/gpu/drm/bridge/cadence/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/cadence/Kconfig b/drivers/gpu/drm/bridge/cadence/Kconfig
> index 511d67b16d14..ef8c230e0f62 100644
> --- a/drivers/gpu/drm/bridge/cadence/Kconfig
> +++ b/drivers/gpu/drm/bridge/cadence/Kconfig
> @@ -13,7 +13,7 @@ config DRM_CDNS_MHDP8546
>  if DRM_CDNS_MHDP8546
>  
>  config DRM_CDNS_MHDP8546_J721E
> -	depends on ARCH_K3_J721E_SOC || COMPILE_TEST
> +	depends on ARCH_K3 || COMPILE_TEST
>  	bool "J721E Cadence DPI/DP wrapper support"
>  	default y
>  	help
> -- 
> 2.28.0
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
