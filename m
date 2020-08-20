Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BAA424C295
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Aug 2020 17:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729464AbgHTPxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Aug 2020 11:53:08 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:48410 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728549AbgHTPxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 11:53:07 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 410C580503;
        Thu, 20 Aug 2020 17:53:03 +0200 (CEST)
Date:   Thu, 20 Aug 2020 17:53:02 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Thierry Reding <thierry.reding@gmail.com>, od@zcrc.me,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] drm/panel: novatek,nt39016: Reorder calls in probe
Message-ID: <20200820155302.GA194134@ravnborg.org>
References: <20200820121256.32037-1-paul@crapouillou.net>
 <20200820121256.32037-2-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200820121256.32037-2-paul@crapouillou.net>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=aP3eV41m c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=ER_8r6IbAAAA:8 a=7gkXJVJtAAAA:8
        a=LjHVGngA6e6DaZ_9Yd0A:9 a=CjuIK1q_8ugA:10 a=9LHmKk7ezEChjTCyhBa9:22
        a=E9Po1WZjFZOl8hwRPBS3:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20, 2020 at 02:12:55PM +0200, Paul Cercueil wrote:
> The drm_panel_of_backlight() function must be called after
> drm_panel_init(), according to the function's documentation; otherwise
> the backlight won't be properly initialized.
> 
> v2: New patch
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> ---
>  drivers/gpu/drm/panel/panel-novatek-nt39016.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-novatek-nt39016.c b/drivers/gpu/drm/panel/panel-novatek-nt39016.c
> index 39f7be679da5..daa583030246 100644
> --- a/drivers/gpu/drm/panel/panel-novatek-nt39016.c
> +++ b/drivers/gpu/drm/panel/panel-novatek-nt39016.c
> @@ -285,6 +285,9 @@ static int nt39016_probe(struct spi_device *spi)
>  		return PTR_ERR(panel->map);
>  	}
>  
> +	drm_panel_init(&panel->drm_panel, dev, &nt39016_funcs,
> +		       DRM_MODE_CONNECTOR_DPI);
> +
>  	err = drm_panel_of_backlight(&panel->drm_panel);
>  	if (err) {
>  		if (err != -EPROBE_DEFER)
> @@ -292,9 +295,6 @@ static int nt39016_probe(struct spi_device *spi)
>  		return err;
>  	}
>  
> -	drm_panel_init(&panel->drm_panel, dev, &nt39016_funcs,
> -		       DRM_MODE_CONNECTOR_DPI);
> -
>  	drm_panel_add(&panel->drm_panel);
>  
>  	return 0;
> -- 
> 2.28.0
