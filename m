Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0CFB2E024C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 23:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726022AbgLUWEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 17:04:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgLUWEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 17:04:43 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3787C0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 14:04:02 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id 11so10170553oty.9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 14:04:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tFoNtn1mxZtEpIyJCM6fuyZ5ldvhyAJ8z+JEBrhpwBE=;
        b=FcgfYkL8C2xzZZeZt724HXeFYPfBGaJDSzKdZgf+mUZz2FLaQAfADg8QcVwYlMJcI6
         YyfRDUKr8CwANRDb2X3JkaqiJQyMMNc1wBGlCJK8sIEy/RZeM2+GZ8nlt781fMFenWDc
         RHOj4I0J1yWWQa+/Yt927Ujz9VkYm9dSDQoLQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tFoNtn1mxZtEpIyJCM6fuyZ5ldvhyAJ8z+JEBrhpwBE=;
        b=nU3AoyYKIYdPOwfh6XYPMzVhsnYqT3ZOEsWOOdPkVGQs2CGufR9UQ08d7zN4flIyvq
         7TvFCvoD4qupi7XFCvFMPWpeKVLnwVNW6ZFGuro93XWpKvpndI27Vjk9TYBfzaZusLSY
         SVUbNIFCTqoUdQJAplxCl0kH9whlvZwCnwyhDlDCH99ItnzfiRFdMFoYuFQnSxX8mDO3
         mHeUU00MmAlnwx62XgmiN5hNAa5rpl2hz4iPyfFBHMO9vquUewmic+kZKXaasLfiaC+q
         hkcF0BqQ5n3KnH0EZqngVv9lsbugZLTUltsUb72moqTyzupvrtFykmtwZjb20ybK3tV+
         tfSg==
X-Gm-Message-State: AOAM531mccAqmrKmdk93c9gKfvNcEUZKmKVIdeL0xc8AEfsjFFCPEiV4
        LBojr/J7Lj/yzQ1EFEv7dMC106TwygabHVQvP1JAJA==
X-Google-Smtp-Source: ABdhPJyjwY8sHHvZxTszRZSNURVZSRWIrFxn66lY/Ozir0IZkZoCx3fhnHwOnvUFllSRZbF1kyIxXS3i4w+yt6XQJOY=
X-Received: by 2002:a9d:23ca:: with SMTP id t68mr13903904otb.281.1608588242338;
 Mon, 21 Dec 2020 14:04:02 -0800 (PST)
MIME-Version: 1.0
References: <1606898835-40775-1-git-send-email-tiantao6@hisilicon.com>
 <1606898835-40775-2-git-send-email-tiantao6@hisilicon.com> <f6c14465-53a5-1cd3-df8a-d1895ca20656@suse.de>
In-Reply-To: <f6c14465-53a5-1cd3-df8a-d1895ca20656@suse.de>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Mon, 21 Dec 2020 23:03:51 +0100
Message-ID: <CAKMK7uGnotVEuo_MNi0YRuU8bFt5HiJ-ETHmV+ykcrLbjFeuzg@mail.gmail.com>
Subject: Re: [PATCH drm/hisilicon 1/3] drm/hisilicon: Code refactoring for hibmc_drm_drv
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Tian Tao <tiantao6@hisilicon.com>, Dave Airlie <airlied@linux.ie>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Xinliang Liu <xinliang.liu@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 2, 2020 at 10:02 AM Thomas Zimmermann <tzimmermann@suse.de> wro=
te:
>
>
>
> Am 02.12.20 um 09:47 schrieb Tian Tao:
> > Use the devm_drm_dev_alloc provided by the drm framework to alloc
> > a structure hibmc_drm_private.
> >
> > Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
>
> This looks good now. Thanks for sticking to it.
>
> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>

For the future: devm_drm_dev_alloc means no more explicit drm_dev_put
in error and unload paths. This patch didn't remove these, so needs to
be fixed up with a follow up patch.
-Daniel

>
> > ---
> >   drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c   |  2 +-
> >   drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c  | 46 +++++++++++----=
---------
> >   drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h  |  4 +--
> >   drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c |  2 +-
> >   drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c      |  8 +++--
> >   5 files changed, 30 insertions(+), 32 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c b/drivers/g=
pu/drm/hisilicon/hibmc/hibmc_drm_de.c
> > index ea962ac..096eea9 100644
> > --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
> > +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
> > @@ -499,7 +499,7 @@ static const struct drm_crtc_helper_funcs hibmc_crt=
c_helper_funcs =3D {
> >
> >   int hibmc_de_init(struct hibmc_drm_private *priv)
> >   {
> > -     struct drm_device *dev =3D priv->dev;
> > +     struct drm_device *dev =3D &priv->dev;
> >       struct drm_crtc *crtc =3D &priv->crtc;
> >       struct drm_plane *plane =3D &priv->primary_plane;
> >       int ret;
> > diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/=
gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> > index d845657..13e8a28 100644
> > --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> > +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> > @@ -79,31 +79,32 @@ static const struct dev_pm_ops hibmc_pm_ops =3D {
> >
> >   static int hibmc_kms_init(struct hibmc_drm_private *priv)
> >   {
> > +     struct drm_device *dev =3D &priv->dev;
> >       int ret;
> >
> > -     drm_mode_config_init(priv->dev);
> > +     drm_mode_config_init(dev);
> >       priv->mode_config_initialized =3D true;
> >
> > -     priv->dev->mode_config.min_width =3D 0;
> > -     priv->dev->mode_config.min_height =3D 0;
> > -     priv->dev->mode_config.max_width =3D 1920;
> > -     priv->dev->mode_config.max_height =3D 1200;
> > +     dev->mode_config.min_width =3D 0;
> > +     dev->mode_config.min_height =3D 0;
> > +     dev->mode_config.max_width =3D 1920;
> > +     dev->mode_config.max_height =3D 1200;
> >
> > -     priv->dev->mode_config.fb_base =3D priv->fb_base;
> > -     priv->dev->mode_config.preferred_depth =3D 32;
> > -     priv->dev->mode_config.prefer_shadow =3D 1;
> > +     dev->mode_config.fb_base =3D priv->fb_base;
> > +     dev->mode_config.preferred_depth =3D 32;
> > +     dev->mode_config.prefer_shadow =3D 1;
> >
> > -     priv->dev->mode_config.funcs =3D (void *)&hibmc_mode_funcs;
> > +     dev->mode_config.funcs =3D (void *)&hibmc_mode_funcs;
> >
> >       ret =3D hibmc_de_init(priv);
> >       if (ret) {
> > -             drm_err(priv->dev, "failed to init de: %d\n", ret);
> > +             drm_err(dev, "failed to init de: %d\n", ret);
> >               return ret;
> >       }
> >
> >       ret =3D hibmc_vdac_init(priv);
> >       if (ret) {
> > -             drm_err(priv->dev, "failed to init vdac: %d\n", ret);
> > +             drm_err(dev, "failed to init vdac: %d\n", ret);
> >               return ret;
> >       }
> >
> > @@ -113,7 +114,7 @@ static int hibmc_kms_init(struct hibmc_drm_private =
*priv)
> >   static void hibmc_kms_fini(struct hibmc_drm_private *priv)
> >   {
> >       if (priv->mode_config_initialized) {
> > -             drm_mode_config_cleanup(priv->dev);
> > +             drm_mode_config_cleanup(&priv->dev);
> >               priv->mode_config_initialized =3D false;
> >       }
> >   }
> > @@ -202,7 +203,7 @@ static void hibmc_hw_config(struct hibmc_drm_privat=
e *priv)
> >
> >   static int hibmc_hw_map(struct hibmc_drm_private *priv)
> >   {
> > -     struct drm_device *dev =3D priv->dev;
> > +     struct drm_device *dev =3D &priv->dev;
> >       struct pci_dev *pdev =3D dev->pdev;
> >       resource_size_t addr, size, ioaddr, iosize;
> >
> > @@ -258,17 +259,9 @@ static int hibmc_unload(struct drm_device *dev)
> >
> >   static int hibmc_load(struct drm_device *dev)
> >   {
> > -     struct hibmc_drm_private *priv;
> > +     struct hibmc_drm_private *priv =3D to_hibmc_drm_private(dev);
> >       int ret;
> >
> > -     priv =3D drmm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > -     if (!priv) {
> > -             drm_err(dev, "no memory to allocate for hibmc_drm_private=
\n");
> > -             return -ENOMEM;
> > -     }
> > -     dev->dev_private =3D priv;
> > -     priv->dev =3D dev;
> > -
> >       ret =3D hibmc_hw_init(priv);
> >       if (ret)
> >               goto err;
> > @@ -310,6 +303,7 @@ static int hibmc_load(struct drm_device *dev)
> >   static int hibmc_pci_probe(struct pci_dev *pdev,
> >                          const struct pci_device_id *ent)
> >   {
> > +     struct hibmc_drm_private *priv;
> >       struct drm_device *dev;
> >       int ret;
> >
> > @@ -318,12 +312,14 @@ static int hibmc_pci_probe(struct pci_dev *pdev,
> >       if (ret)
> >               return ret;
> >
> > -     dev =3D drm_dev_alloc(&hibmc_driver, &pdev->dev);
> > -     if (IS_ERR(dev)) {
> > +     priv =3D devm_drm_dev_alloc(&pdev->dev, &hibmc_driver,
> > +                               struct hibmc_drm_private, dev);
> > +     if (IS_ERR(priv)) {
> >               DRM_ERROR("failed to allocate drm_device\n");
> > -             return PTR_ERR(dev);
> > +             return PTR_ERR(priv);
> >       }
> >
> > +     dev =3D &priv->dev;
> >       dev->pdev =3D pdev;
> >       pci_set_drvdata(pdev, dev);
> >
> > diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h b/drivers/=
gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
> > index f310a83..7e0c756 100644
> > --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
> > +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
> > @@ -37,7 +37,7 @@ struct hibmc_drm_private {
> >       resource_size_t  fb_size;
> >
> >       /* drm */
> > -     struct drm_device  *dev;
> > +     struct drm_device dev;
> >       struct drm_plane primary_plane;
> >       struct drm_crtc crtc;
> >       struct drm_encoder encoder;
> > @@ -52,7 +52,7 @@ static inline struct hibmc_connector *to_hibmc_connec=
tor(struct drm_connector *c
> >
> >   static inline struct hibmc_drm_private *to_hibmc_drm_private(struct d=
rm_device *dev)
> >   {
> > -     return dev->dev_private;
> > +     return container_of(dev, struct hibmc_drm_private, dev);
> >   }
> >
> >   void hibmc_set_power_mode(struct hibmc_drm_private *priv,
> > diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c b/drivers=
/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
> > index 74e26c2..d35548d 100644
> > --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
> > +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
> > @@ -96,7 +96,7 @@ static const struct drm_encoder_funcs hibmc_encoder_f=
uncs =3D {
> >
> >   int hibmc_vdac_init(struct hibmc_drm_private *priv)
> >   {
> > -     struct drm_device *dev =3D priv->dev;
> > +     struct drm_device *dev =3D &priv->dev;
> >       struct hibmc_connector *hibmc_connector =3D &priv->connector;
> >       struct drm_encoder *encoder =3D &priv->encoder;
> >       struct drm_connector *connector =3D &hibmc_connector->base;
> > diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c b/drivers/gpu/=
drm/hisilicon/hibmc/hibmc_ttm.c
> > index 602ece1..e84fb81 100644
> > --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c
> > +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c
> > @@ -25,7 +25,7 @@ int hibmc_mm_init(struct hibmc_drm_private *hibmc)
> >   {
> >       struct drm_vram_mm *vmm;
> >       int ret;
> > -     struct drm_device *dev =3D hibmc->dev;
> > +     struct drm_device *dev =3D &hibmc->dev;
> >
> >       vmm =3D drm_vram_helper_alloc_mm(dev,
> >                                      pci_resource_start(dev->pdev, 0),
> > @@ -41,10 +41,12 @@ int hibmc_mm_init(struct hibmc_drm_private *hibmc)
> >
> >   void hibmc_mm_fini(struct hibmc_drm_private *hibmc)
> >   {
> > -     if (!hibmc->dev->vram_mm)
> > +     struct drm_device *dev =3D &hibmc->dev;
> > +
> > +     if (!dev->vram_mm)
> >               return;
> >
> > -     drm_vram_helper_release_mm(hibmc->dev);
> > +     drm_vram_helper_release_mm(dev);
> >   }
> >
> >   int hibmc_dumb_create(struct drm_file *file, struct drm_device *dev,
> >
>
> --
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
> (HRB 36809, AG N=C3=BCrnberg)
> Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer
>


--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
