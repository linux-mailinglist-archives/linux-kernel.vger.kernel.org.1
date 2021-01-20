Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 704732FD5A7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 17:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404040AbhATQ2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 11:28:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391398AbhATQ1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 11:27:18 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C0EC0613ED
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 08:26:13 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id v1so5836310ott.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 08:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TR4A8q6K02DxTiaXZ3lXiS7PoGiZ905DDYVFaKV6hJs=;
        b=X+6XC27e9NvRxAXSFcJCX7sBLTclDZaFZztT0rBtKNzuYzjxhbDoOceu3gLmc7RRCG
         jJYxKFy0VDUwRGiSiNWileQMSufEJIZvnv2Lm7VGg7bRZF63rBoiyNMPWnVjrdckTwIc
         bBeX+A5PFbrlPkTNtMd6QGzwA2TjoCRzbkA1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TR4A8q6K02DxTiaXZ3lXiS7PoGiZ905DDYVFaKV6hJs=;
        b=O+jlZsyBPWAFoFOayltu3WzD+moNla/wAG49685FaK64zsT/ZhN7WWy9DVbF1/VuN7
         zRlDVl1rl52fFqbsm2k6K99OC0a272rTcgzOv4vtw0kuk3faTR3PVNSiUfVxM5DvZvN6
         XMWiLsGa2GxyIVXVFtxDun/zD1uNTKXg2F/ZNAGyz8a9zovrF1oDjvJ60OQusWaG5JZh
         UnQt4aJdBQBLiL7c99XXXsWcTYL4OJf/SA6eUQvCa0qOc9aGkD4oaOmH4xlsDshYmGuv
         29At4qb9RCuUOY2a8iDo6DGYtoYbTJd0KZ5hOT6aaJDBoHfL1fps8DwqY5+LmdqVQZKp
         GRzw==
X-Gm-Message-State: AOAM532giiHefmkAH7vfeDLS5d184mBebvC9B+O4C4PRyVxyyj8pkJgA
        CvLAawf0Ptz1d5YlZdp6VFsl1MMg74w7/MAzpIhHxQ==
X-Google-Smtp-Source: ABdhPJyqk40fmfS7gqlnqy6/UClYuooRH8LNmG2/KUb4n6AFXeVUr0ep1ChY8yMP9+rjQYw6gpo15Az+wTN1pS5m+oA=
X-Received: by 2002:a05:6830:1bef:: with SMTP id k15mr7418547otb.303.1611159973120;
 Wed, 20 Jan 2021 08:26:13 -0800 (PST)
MIME-Version: 1.0
References: <20210120123535.40226-1-paul@crapouillou.net> <20210120123535.40226-4-paul@crapouillou.net>
In-Reply-To: <20210120123535.40226-4-paul@crapouillou.net>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 20 Jan 2021 17:26:02 +0100
Message-ID: <CAKMK7uFWUWtsOK-tcnon5p6-8ek3ZD2HeexUE7s7vUKKNXFXkg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] drm/ingenic: Fix non-OSD mode
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     David Airlie <airlied@linux.ie>, Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        od@zcrc.me, dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 1:36 PM Paul Cercueil <paul@crapouillou.net> wrote:
>
> Even though the JZ4740 did not have the OSD mode, it had (according to
> the documentation) two DMA channels, but there is absolutely no
> information about how to select the second DMA channel.
>
> Make the ingenic-drm driver work in non-OSD mode by using the
> foreground0 plane (which is bound to the DMA0 channel) as the primary
> plane, instead of the foreground1 plane, which is the primary plane
> when in OSD mode.
>
> Fixes: 3c9bea4ef32b ("drm/ingenic: Add support for OSD mode")
> Cc: <stable@vger.kernel.org> # v5.8+
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

Does what it says on the tin^Wcommit message.

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> ---
>  drivers/gpu/drm/ingenic/ingenic-drm-drv.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
> index 158433b4c084..963dcbfeaba2 100644
> --- a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
> +++ b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
> @@ -554,7 +554,7 @@ static void ingenic_drm_plane_atomic_update(struct drm_plane *plane,
>                 height = state->src_h >> 16;
>                 cpp = state->fb->format->cpp[0];
>
> -               if (priv->soc_info->has_osd && plane->type == DRM_PLANE_TYPE_OVERLAY)
> +               if (!priv->soc_info->has_osd || plane->type == DRM_PLANE_TYPE_OVERLAY)
>                         hwdesc = &priv->dma_hwdescs->hwdesc_f0;
>                 else
>                         hwdesc = &priv->dma_hwdescs->hwdesc_f1;
> @@ -826,6 +826,7 @@ static int ingenic_drm_bind(struct device *dev, bool has_components)
>         const struct jz_soc_info *soc_info;
>         struct ingenic_drm *priv;
>         struct clk *parent_clk;
> +       struct drm_plane *primary;
>         struct drm_bridge *bridge;
>         struct drm_panel *panel;
>         struct drm_encoder *encoder;
> @@ -940,9 +941,11 @@ static int ingenic_drm_bind(struct device *dev, bool has_components)
>         if (soc_info->has_osd)
>                 priv->ipu_plane = drm_plane_from_index(drm, 0);
>
> -       drm_plane_helper_add(&priv->f1, &ingenic_drm_plane_helper_funcs);
> +       primary = priv->soc_info->has_osd ? &priv->f1 : &priv->f0;
>
> -       ret = drm_universal_plane_init(drm, &priv->f1, 1,
> +       drm_plane_helper_add(primary, &ingenic_drm_plane_helper_funcs);
> +
> +       ret = drm_universal_plane_init(drm, primary, 1,
>                                        &ingenic_drm_primary_plane_funcs,
>                                        priv->soc_info->formats_f1,
>                                        priv->soc_info->num_formats_f1,
> @@ -954,7 +957,7 @@ static int ingenic_drm_bind(struct device *dev, bool has_components)
>
>         drm_crtc_helper_add(&priv->crtc, &ingenic_drm_crtc_helper_funcs);
>
> -       ret = drm_crtc_init_with_planes(drm, &priv->crtc, &priv->f1,
> +       ret = drm_crtc_init_with_planes(drm, &priv->crtc, primary,
>                                         NULL, &ingenic_drm_crtc_funcs, NULL);
>         if (ret) {
>                 dev_err(dev, "Failed to init CRTC: %i\n", ret);
> --
> 2.29.2
>


-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
