Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73D582C3B60
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 09:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbgKYIu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 03:50:57 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:60750 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbgKYIu5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 03:50:57 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 52AD9FB03;
        Wed, 25 Nov 2020 09:50:54 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id l84pxCrkMIBA; Wed, 25 Nov 2020 09:50:53 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id F17D54068E; Wed, 25 Nov 2020 09:50:51 +0100 (CET)
Date:   Wed, 25 Nov 2020 09:50:51 +0100
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     "Lukas F. Hartmann" <lukas@mntre.com>
Cc:     laurentiu.palcu@nxp.com, Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: nwl-dsi: fixup mode only for LCDIF input, not DCSS
Message-ID: <20201125085051.GA9364@bogon.m.sigxcpu.org>
References: <20201124171216.980628-1-lukas@mntre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124171216.980628-1-lukas@mntre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukas,
On Tue, Nov 24, 2020 at 06:12:17PM +0100, Lukas F. Hartmann wrote:
> The fixup of HSYNC and VSYNC should not be done when the input source is
> DCSS, or internal display does not work on MNT Reform 2 (open hardware 
> laptop based on NXP i.MX8M using DCSS->DSI->eDP for internal display).
> 
> Signed-off-by: Lukas F. Hartmann <lukas@mntre.com>
> ---
>  drivers/gpu/drm/bridge/nwl-dsi.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/nwl-dsi.c b/drivers/gpu/drm/bridge/nwl-dsi.c
> index 66b67402f..6735ab2a2 100644
> --- a/drivers/gpu/drm/bridge/nwl-dsi.c
> +++ b/drivers/gpu/drm/bridge/nwl-dsi.c
> @@ -807,10 +807,16 @@ static bool nwl_dsi_bridge_mode_fixup(struct drm_bridge *bridge,
>  				      const struct drm_display_mode *mode,
>  				      struct drm_display_mode *adjusted_mode)
>  {
> -	/* At least LCDIF + NWL needs active high sync */
> -	adjusted_mode->flags |= (DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC);
> -	adjusted_mode->flags &= ~(DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC);
> +	struct device_node *remote;
> +	struct nwl_dsi *dsi = bridge_to_dsi(bridge);
> +
> +	remote = of_graph_get_remote_node(dsi->dev->of_node, 0,
> +						NWL_DSI_ENDPOINT_LCDIF);
> +	if (remote) {
> +		/* At least LCDIF + NWL needs active high sync */
> +		adjusted_mode->flags |= (DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC);
> +		adjusted_mode->flags &= ~(DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC);
> +	}

When submitting the NWL driver i was told to not change properties based
on the endpoint. The argument is that this breaks when putting the
bridge into another chain and that there might be other bridges in
between. Maybe Laurent and Andrzej have a suggetion?

I intend to respin the input mux bridge
(https://lore.kernel.org/dri-devel/cover.1589548223.git.agx@sigxcpu.org/)
at some point but even then we need to carry over the flags, so any
input on how that should best be done would be welcome.

Cheers,
 -- Guido

> 
>  	return true;
>  }
> --
> 2.28.0
> 
