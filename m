Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A85927A486
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 01:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbgI0Xgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 19:36:32 -0400
Received: from crapouillou.net ([89.234.176.41]:35014 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726421AbgI0Xgc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 19:36:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1601249789; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pUN8bXktpOva2was0urG22E/o7HGJDL0e0yo+m0sKgw=;
        b=Ea+EjrEmRRVHpyDOSuxwwOWIbdUT2ILpx9+HREckTyrGZmvCw1f8uD7okkQed5An65UQjR
        FcQyQljT1EgYiaaeVcXKvGS0hYDcV47AeteFiyVWVG+m/ZW7nyHZmV0UrYGpsUygRapgd5
        xs761EnzADyyShTFv/Wlx0kBmYHbllU=
Date:   Mon, 28 Sep 2020 01:36:18 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v3 1/1] drm/ingenic: Add support for paletted 8bpp
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        od@zcrc.me, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Message-Id: <I8CCHQ.3C2N46UNN7BA3@crapouillou.net>
In-Reply-To: <20200927202757.GA245066@ravnborg.org>
References: <20200927193645.262612-1-paul@crapouillou.net>
        <20200927193645.262612-2-paul@crapouillou.net>
        <20200927202757.GA245066@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le dim. 27 sept. 2020 =E0 22:27, Sam Ravnborg <sam@ravnborg.org> a=20
=E9crit :
> On Sun, Sep 27, 2020 at 09:36:45PM +0200, Paul Cercueil wrote:
>>  On JZ4725B and newer, the F0 plane supports paletted 8bpp with a
>>  256-entry palette. Add support for it.
>>=20
>>  v3: Only accept a full 256-entry palette.
>>=20
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>=20
> Looks good.
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

Pushed to drm-misc-next.

Thanks!
-Paul

>=20
>>  ---
>>   drivers/gpu/drm/ingenic/ingenic-drm-drv.c | 66=20
>> +++++++++++++++++++++--
>>   1 file changed, 62 insertions(+), 4 deletions(-)
>>=20
>>  diff --git a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c=20
>> b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
>>  index 589fc0c60716..0225dc1f5eb8 100644
>>  --- a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
>>  +++ b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
>>  @@ -21,6 +21,7 @@
>>   #include <drm/drm_atomic.h>
>>   #include <drm/drm_atomic_helper.h>
>>   #include <drm/drm_bridge.h>
>>  +#include <drm/drm_color_mgmt.h>
>>   #include <drm/drm_crtc.h>
>>   #include <drm/drm_crtc_helper.h>
>>   #include <drm/drm_damage_helper.h>
>>  @@ -50,6 +51,8 @@ struct ingenic_dma_hwdesc {
>>   struct ingenic_dma_hwdescs {
>>   	struct ingenic_dma_hwdesc hwdesc_f0;
>>   	struct ingenic_dma_hwdesc hwdesc_f1;
>>  +	struct ingenic_dma_hwdesc hwdesc_pal;
>>  +	u16 palette[256] __aligned(16);
>>   };
>>=20
>>   struct jz_soc_info {
>>  @@ -249,6 +252,12 @@ static int=20
>> ingenic_drm_crtc_atomic_check(struct drm_crtc *crtc,
>>   	struct ingenic_drm *priv =3D drm_crtc_get_priv(crtc);
>>   	struct drm_plane_state *f1_state, *f0_state, *ipu_state =3D NULL;
>>=20
>>  +	if (state->gamma_lut &&
>>  +	    drm_color_lut_size(state->gamma_lut) !=3D=20
>> ARRAY_SIZE(priv->dma_hwdescs->palette)) {
>>  +		dev_dbg(priv->dev, "Invalid palette size\n");
>>  +		return -EINVAL;
>>  +	}
>>  +
>>   	if (drm_atomic_crtc_needs_modeset(state) &&=20
>> priv->soc_info->has_osd) {
>>   		f1_state =3D drm_atomic_get_plane_state(state->state, &priv->f1);
>>   		if (IS_ERR(f1_state))
>>  @@ -470,6 +479,9 @@ void ingenic_drm_plane_config(struct device=20
>> *dev,
>>   				   JZ_LCD_OSDCTRL_BPP_MASK, ctrl);
>>   	} else {
>>   		switch (fourcc) {
>>  +		case DRM_FORMAT_C8:
>>  +			ctrl |=3D JZ_LCD_CTRL_BPP_8;
>>  +			break;
>>   		case DRM_FORMAT_XRGB1555:
>>   			ctrl |=3D JZ_LCD_CTRL_RGB555;
>>   			fallthrough;
>>  @@ -541,16 +553,34 @@ void ingenic_drm_sync_data(struct device *dev,
>>   	}
>>   }
>>=20
>>  +static void ingenic_drm_update_palette(struct ingenic_drm *priv,
>>  +				       const struct drm_color_lut *lut)
>>  +{
>>  +	unsigned int i;
>>  +
>>  +	for (i =3D 0; i < ARRAY_SIZE(priv->dma_hwdescs->palette); i++) {
>>  +		u16 color =3D drm_color_lut_extract(lut[i].red, 5) << 11
>>  +			| drm_color_lut_extract(lut[i].green, 6) << 5
>>  +			| drm_color_lut_extract(lut[i].blue, 5);
>>  +
>>  +		priv->dma_hwdescs->palette[i] =3D color;
>>  +	}
>>  +}
>>  +
>>   static void ingenic_drm_plane_atomic_update(struct drm_plane=20
>> *plane,
>>   					    struct drm_plane_state *oldstate)
>>   {
>>   	struct ingenic_drm *priv =3D drm_device_get_priv(plane->dev);
>>   	struct drm_plane_state *state =3D plane->state;
>>  +	struct drm_crtc_state *crtc_state;
>>   	struct ingenic_dma_hwdesc *hwdesc;
>>  -	unsigned int width, height, cpp;
>>  +	unsigned int width, height, cpp, offset;
>>   	dma_addr_t addr;
>>  +	u32 fourcc;
>>=20
>>   	if (state && state->fb) {
>>  +		crtc_state =3D state->crtc->state;
>>  +
>>   		ingenic_drm_sync_data(priv->dev, oldstate, state);
>>=20
>>   		addr =3D drm_fb_cma_get_gem_addr(state->fb, state, 0);
>>  @@ -566,9 +596,23 @@ static void=20
>> ingenic_drm_plane_atomic_update(struct drm_plane *plane,
>>   		hwdesc->addr =3D addr;
>>   		hwdesc->cmd =3D JZ_LCD_CMD_EOF_IRQ | (width * height * cpp / 4);
>>=20
>>  -		if (drm_atomic_crtc_needs_modeset(state->crtc->state))
>>  -			ingenic_drm_plane_config(priv->dev, plane,
>>  -						 state->fb->format->format);
>>  +		if (drm_atomic_crtc_needs_modeset(crtc_state)) {
>>  +			fourcc =3D state->fb->format->format;
>>  +
>>  +			ingenic_drm_plane_config(priv->dev, plane, fourcc);
>>  +
>>  +			if (fourcc =3D=3D DRM_FORMAT_C8)
>>  +				offset =3D offsetof(struct ingenic_dma_hwdescs, hwdesc_pal);
>>  +			else
>>  +				offset =3D offsetof(struct ingenic_dma_hwdescs, hwdesc_f0);
>>  +
>>  +			priv->dma_hwdescs->hwdesc_f0.next =3D priv->dma_hwdescs_phys +=20
>> offset;
>>  +
>>  +			crtc_state->color_mgmt_changed =3D fourcc =3D=3D DRM_FORMAT_C8;
>>  +		}
>>  +
>>  +		if (crtc_state->color_mgmt_changed)
>>  +			ingenic_drm_update_palette(priv, crtc_state->gamma_lut->data);
>>   	}
>>   }
>>=20
>>  @@ -964,6 +1008,15 @@ static int ingenic_drm_bind(struct device=20
>> *dev, bool has_components)
>>   	priv->dma_hwdescs->hwdesc_f1.next =3D dma_hwdesc_phys_f1;
>>   	priv->dma_hwdescs->hwdesc_f1.id =3D 0xf1;
>>=20
>>  +	/* Configure DMA hwdesc for palette */
>>  +	priv->dma_hwdescs->hwdesc_pal.next =3D priv->dma_hwdescs_phys
>>  +		+ offsetof(struct ingenic_dma_hwdescs, hwdesc_f0);
>>  +	priv->dma_hwdescs->hwdesc_pal.id =3D 0xc0;
>>  +	priv->dma_hwdescs->hwdesc_pal.addr =3D priv->dma_hwdescs_phys
>>  +		+ offsetof(struct ingenic_dma_hwdescs, palette);
>>  +	priv->dma_hwdescs->hwdesc_pal.cmd =3D JZ_LCD_CMD_ENABLE_PAL
>>  +		| (sizeof(priv->dma_hwdescs->palette) / 4);
>>  +
>>   	if (soc_info->has_osd)
>>   		priv->ipu_plane =3D drm_plane_from_index(drm, 0);
>>=20
>>  @@ -990,6 +1043,9 @@ static int ingenic_drm_bind(struct device=20
>> *dev, bool has_components)
>>   		return ret;
>>   	}
>>=20
>>  +	drm_crtc_enable_color_mgmt(&priv->crtc, 0, false,
>>  +				   ARRAY_SIZE(priv->dma_hwdescs->palette));
>>  +
>>   	if (soc_info->has_osd) {
>>   		drm_plane_helper_add(&priv->f0,
>>   				     &ingenic_drm_plane_helper_funcs);
>>  @@ -1225,6 +1281,7 @@ static const u32 jz4725b_formats_f1[] =3D {
>>   };
>>=20
>>   static const u32 jz4725b_formats_f0[] =3D {
>>  +	DRM_FORMAT_C8,
>>   	DRM_FORMAT_XRGB1555,
>>   	DRM_FORMAT_RGB565,
>>   	DRM_FORMAT_XRGB8888,
>>  @@ -1239,6 +1296,7 @@ static const u32 jz4770_formats_f1[] =3D {
>>   };
>>=20
>>   static const u32 jz4770_formats_f0[] =3D {
>>  +	DRM_FORMAT_C8,
>>   	DRM_FORMAT_XRGB1555,
>>   	DRM_FORMAT_RGB565,
>>   	DRM_FORMAT_RGB888,
>>  --
>>  2.28.0


