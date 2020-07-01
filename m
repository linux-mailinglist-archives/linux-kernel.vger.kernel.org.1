Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79C79211008
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jul 2020 18:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732292AbgGAQC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jul 2020 12:02:27 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:34414 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728534AbgGAQC1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 12:02:27 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 9CCCFFB04;
        Wed,  1 Jul 2020 18:02:24 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id vPbvHeupN1Nh; Wed,  1 Jul 2020 18:02:23 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 3891B40972; Wed,  1 Jul 2020 18:02:23 +0200 (CEST)
Date:   Wed, 1 Jul 2020 18:02:23 +0200
From:   Guido =?iso-8859-1?Q?G=FCnther?= <guido.gunther@puri.sm>
To:     Ondrej Jirman <megous@megous.com>
Cc:     linux-sunxi@googlegroups.com,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Purism Kernel Team <kernel@puri.sm>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Samuel Holland <samuel@sholland.org>,
        Martijn Braam <martijn@brixit.nl>, Luca Weiss <luca@z3ntu.xyz>,
        Bhushan Shah <bshah@kde.org>
Subject: Re: [PATCH v6 07/13] drm/panel: st7703: Move code specific to jh057n
 closer together
Message-ID: <20200701160223.GF174356@bogon.m.sigxcpu.org>
References: <20200701103126.1512615-1-megous@megous.com>
 <20200701103126.1512615-8-megous@megous.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200701103126.1512615-8-megous@megous.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Wed, Jul 01, 2020 at 12:31:20PM +0200, Ondrej Jirman wrote:
> It's better than having it spread around the driver.

Reviewed-by: Guido G�nther <agx@sigxcpu.org> 
> 
> Signed-off-by: Ondrej Jirman <megous@megous.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/gpu/drm/panel/panel-sitronix-st7703.c | 50 +++++++++----------
>  1 file changed, 25 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7703.c b/drivers/gpu/drm/panel/panel-sitronix-st7703.c
> index 08cbc316266c..d03aab10cfef 100644
> --- a/drivers/gpu/drm/panel/panel-sitronix-st7703.c
> +++ b/drivers/gpu/drm/panel/panel-sitronix-st7703.c
> @@ -153,6 +153,31 @@ static int jh057n_init_sequence(struct st7703 *ctx)
>  	return 0;
>  }
>  
> +static const struct drm_display_mode jh057n00900_mode = {
> +	.hdisplay    = 720,
> +	.hsync_start = 720 + 90,
> +	.hsync_end   = 720 + 90 + 20,
> +	.htotal	     = 720 + 90 + 20 + 20,
> +	.vdisplay    = 1440,
> +	.vsync_start = 1440 + 20,
> +	.vsync_end   = 1440 + 20 + 4,
> +	.vtotal	     = 1440 + 20 + 4 + 12,
> +	.vrefresh    = 60,
> +	.clock	     = 75276,
> +	.flags	     = DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC,
> +	.width_mm    = 65,
> +	.height_mm   = 130,
> +};
> +
> +struct st7703_panel_desc jh057n00900_panel_desc = {
> +	.mode = &jh057n00900_mode,
> +	.lanes = 4,
> +	.mode_flags = MIPI_DSI_MODE_VIDEO |
> +		MIPI_DSI_MODE_VIDEO_BURST | MIPI_DSI_MODE_VIDEO_SYNC_PULSE,
> +	.format = MIPI_DSI_FMT_RGB888,
> +	.init_sequence = jh057n_init_sequence,
> +};
> +
>  static int st7703_enable(struct drm_panel *panel)
>  {
>  	struct st7703 *ctx = panel_to_st7703(panel);
> @@ -226,31 +251,6 @@ static int st7703_prepare(struct drm_panel *panel)
>  	return ret;
>  }
>  
> -static const struct drm_display_mode jh057n00900_mode = {
> -	.hdisplay    = 720,
> -	.hsync_start = 720 + 90,
> -	.hsync_end   = 720 + 90 + 20,
> -	.htotal	     = 720 + 90 + 20 + 20,
> -	.vdisplay    = 1440,
> -	.vsync_start = 1440 + 20,
> -	.vsync_end   = 1440 + 20 + 4,
> -	.vtotal	     = 1440 + 20 + 4 + 12,
> -	.vrefresh    = 60,
> -	.clock	     = 75276,
> -	.flags	     = DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC,
> -	.width_mm    = 65,
> -	.height_mm   = 130,
> -};
> -
> -struct st7703_panel_desc jh057n00900_panel_desc = {
> -	.mode = &jh057n00900_mode,
> -	.lanes = 4,
> -	.mode_flags = MIPI_DSI_MODE_VIDEO |
> -		MIPI_DSI_MODE_VIDEO_BURST | MIPI_DSI_MODE_VIDEO_SYNC_PULSE,
> -	.format = MIPI_DSI_FMT_RGB888,
> -	.init_sequence = jh057n_init_sequence,
> -};
> -
>  static int st7703_get_modes(struct drm_panel *panel,
>  			    struct drm_connector *connector)
>  {
> -- 
> 2.27.0
> 
