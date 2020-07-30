Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 817BF23357E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jul 2020 17:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729960AbgG3PaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jul 2020 11:30:04 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:36618 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726581AbgG3PaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 11:30:02 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id D404A20039;
        Thu, 30 Jul 2020 17:29:59 +0200 (CEST)
Date:   Thu, 30 Jul 2020 17:29:58 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        od@zcrc.me, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] drm/ingenic: ipu: Only enable clock when needed
Message-ID: <20200730152958.GB1474381@ravnborg.org>
References: <20200730144830.10479-1-paul@crapouillou.net>
 <20200730144830.10479-4-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200730144830.10479-4-paul@crapouillou.net>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=f+hm+t6M c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=ER_8r6IbAAAA:8 a=7gkXJVJtAAAA:8
        a=Yn18W8vto3fq7zB7h7oA:9 a=jL7zRBsIsWRRgqwc:21 a=VT3nyDlhJkvOL4Sv:21
        a=CjuIK1q_8ugA:10 a=9LHmKk7ezEChjTCyhBa9:22 a=E9Po1WZjFZOl8hwRPBS3:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 04:48:30PM +0200, Paul Cercueil wrote:
> Instead of keeping the IPU clock enabled constantly, enable and disable
> it on demand, when the IPU plane is used. That way, we won't use any
> extra power when the IPU is not used.
> 
> v2: Explain the reason of this patch
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

And thanks for the quick update!

	Sam

> ---
>  drivers/gpu/drm/ingenic/ingenic-ipu.c | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ingenic/ingenic-ipu.c b/drivers/gpu/drm/ingenic/ingenic-ipu.c
> index 7dd2a6ae4994..fc8c6e970ee3 100644
> --- a/drivers/gpu/drm/ingenic/ingenic-ipu.c
> +++ b/drivers/gpu/drm/ingenic/ingenic-ipu.c
> @@ -49,6 +49,7 @@ struct ingenic_ipu {
>  	struct regmap *map;
>  	struct clk *clk;
>  	const struct soc_info *soc_info;
> +	bool clk_enabled;
>  
>  	unsigned int num_w, num_h, denom_w, denom_h;
>  
> @@ -288,12 +289,23 @@ static void ingenic_ipu_plane_atomic_update(struct drm_plane *plane,
>  	const struct drm_format_info *finfo;
>  	u32 ctrl, stride = 0, coef_index = 0, format = 0;
>  	bool needs_modeset, upscaling_w, upscaling_h;
> +	int err;
>  
>  	if (!state || !state->fb)
>  		return;
>  
>  	finfo = drm_format_info(state->fb->format->format);
>  
> +	if (!ipu->clk_enabled) {
> +		err = clk_enable(ipu->clk);
> +		if (err) {
> +			dev_err(ipu->dev, "Unable to enable clock: %d\n", err);
> +			return;
> +		}
> +
> +		ipu->clk_enabled = true;
> +	}
> +
>  	/* Reset all the registers if needed */
>  	needs_modeset = drm_atomic_crtc_needs_modeset(state->crtc->state);
>  	if (needs_modeset) {
> @@ -578,6 +590,11 @@ static void ingenic_ipu_plane_atomic_disable(struct drm_plane *plane,
>  	regmap_clear_bits(ipu->map, JZ_REG_IPU_CTRL, JZ_IPU_CTRL_CHIP_EN);
>  
>  	ingenic_drm_plane_disable(ipu->master, plane);
> +
> +	if (ipu->clk_enabled) {
> +		clk_disable(ipu->clk);
> +		ipu->clk_enabled = false;
> +	}
>  }
>  
>  static const struct drm_plane_helper_funcs ingenic_ipu_plane_helper_funcs = {
> @@ -761,9 +778,9 @@ static int ingenic_ipu_bind(struct device *dev, struct device *master, void *d)
>  	drm_object_attach_property(&plane->base, ipu->sharpness_prop,
>  				   ipu->sharpness);
>  
> -	err = clk_prepare_enable(ipu->clk);
> +	err = clk_prepare(ipu->clk);
>  	if (err) {
> -		dev_err(dev, "Unable to enable clock\n");
> +		dev_err(dev, "Unable to prepare clock\n");
>  		return err;
>  	}
>  
> @@ -775,7 +792,7 @@ static void ingenic_ipu_unbind(struct device *dev,
>  {
>  	struct ingenic_ipu *ipu = dev_get_drvdata(dev);
>  
> -	clk_disable_unprepare(ipu->clk);
> +	clk_unprepare(ipu->clk);
>  }
>  
>  static const struct component_ops ingenic_ipu_ops = {
> -- 
> 2.27.0
