Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 082DC2B79D6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 10:00:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbgKRJAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 04:00:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727160AbgKRJAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 04:00:08 -0500
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54004C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 01:00:07 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id t16so1382277oie.11
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 01:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1FsQN+8izne3JfHZCqz8SHsDVQ3dYaFlVE4Pg17Uqps=;
        b=KKiI8JWq3PzgGVdBzPB030iFoJN+YRlGzkWc20wD1gh6GwiGKs7t7/95GoT+NUQHyb
         EX5kThkhYbCx1tBn1mbtCIUYPPr8ebFEs2oS+ZC4WgVnU1ZeIr+gf3zzMHpuePpRf31L
         3U3LMs6URzNHC23Cr9GDaf0Q6tM8bYD4x8uP8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1FsQN+8izne3JfHZCqz8SHsDVQ3dYaFlVE4Pg17Uqps=;
        b=C5lPTMdDXkVMQX0/XWdbG2y2G0vUC6mMfmjaSfUv3x+OdmSn1ayHltpjo5ajZqAGno
         dORkQi+as2aAmlX4t4eNte1N68AcgJ0TcFmBoTlhoggdITaMxuH422538KMCNiMKlihs
         nOfCYWUD/3WZMOlUYOWObOj0jccYvGyWSK+Dczph1oXgoNVFry+ONkMPk9LWdEhEGZsK
         HzN0j3QOsHW+2K4cV5Gb9Yj6kYxLR69NWNPnXTkvk4CAM5dAykG8SNoOpajEMkVn928o
         a2s/DcMJIQKPSEvOMM3ZLxpVf5GGXZ6NcGG9L8wdrpIdBw0aGsi0ARTu51WmdFXcfYr0
         QYoA==
X-Gm-Message-State: AOAM5339PkXYJW/OPfLeoIEhewwHW10D8nVDS4ZxAU1Plzgpsnek8HTN
        PIWMIjT1fvj/ftNytm2ftLVV0LJFXizT2Y1gyNOvBg==
X-Google-Smtp-Source: ABdhPJyPn9yquhxjYhFS4h9ZTn/G+AO/koeMNkor10wNSKkR/ie+hTCpZdf19Ki8PBhbStq+LVOeKmujydpa/PCr7No=
X-Received: by 2002:aca:4f14:: with SMTP id d20mr2107464oib.14.1605690006733;
 Wed, 18 Nov 2020 01:00:06 -0800 (PST)
MIME-Version: 1.0
References: <20201117155229.9837-1-mark.jonas@de.bosch.com> <e089d4d5-3bd8-c2cd-3011-ed87ae4284e8@suse.de>
In-Reply-To: <e089d4d5-3bd8-c2cd-3011-ed87ae4284e8@suse.de>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 18 Nov 2020 09:59:55 +0100
Message-ID: <CAKMK7uEpEt4w4kVJLOd2Yw1MnsrCn-NMgT4TjcxROpZBa_xvYg@mail.gmail.com>
Subject: Re: [PATCH] drm: imx: Move fbdev setup to before output polling
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Mark Jonas <mark.jonas@de.bosch.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Leo Ruan <tingquan.ruan@cn.bosch.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18, 2020 at 9:10 AM Thomas Zimmermann <tzimmermann@suse.de> wro=
te:
>
> Hi
>
> Am 17.11.20 um 16:52 schrieb Mark Jonas:
> > From: Leo Ruan <tingquan.ruan@cn.bosch.com>
> >
> > The generic fbdev has to be setup before enabling output polling.
> > Otherwise the fbdev client is not ready to handle delayed events.
> >
> > Since f53705fd, the generic fbdev is setup after the output polling
> > init. During fbdev setup, when fbdev probes attached outputs and a
> > status changes from unknown to connected, the delayed event is
> > marked and the output_poll_work thread is scheduled without delay.
> > If output_poll_execute() is runs immediately, the delayed event
> > is handled without actually polling the output because the fbdev is not
> > registered yet. So the delayed event is lost. This leads to a dark
> > screen until a KMS application (or fbcon) sets the screen mode.
> >
> > This patch fixes the issue by moving the setup of generic fbdev before
> > initializing and enabling output polling.
> >
> > Signed-off-by: Leo Ruan <tingquan.ruan@cn.bosch.com>
> > Signed-off-by: Mark Jonas <mark.jonas@de.bosch.com>
> > ---
> >  drivers/gpu/drm/imx/imx-drm-core.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/imx/imx-drm-core.c b/drivers/gpu/drm/imx/i=
mx-drm-core.c
> > index 9bf5ad6d18a2..2665040e11c7 100644
> > --- a/drivers/gpu/drm/imx/imx-drm-core.c
> > +++ b/drivers/gpu/drm/imx/imx-drm-core.c
> > @@ -240,14 +240,18 @@ static int imx_drm_bind(struct device *dev)
> >               legacyfb_depth =3D 16;
> >       }
> >
> > +     /*
> > +      * The generic fbdev has to be setup before enabling output polli=
ng.
> > +      * Otherwise the fbdev client is not ready to handle delayed even=
ts.
> > +      */
> > +     drm_fbdev_generic_setup(drm, legacyfb_depth);
> > +
> >       drm_kms_helper_poll_init(drm);
> >
> >       ret =3D drm_dev_register(drm, 0);
> >       if (ret)
> >               goto err_poll_fini;
> >
> > -     drm_fbdev_generic_setup(drm, legacyfb_depth);
> > -
>
> This does not work well. fbdev is supposed to be another regular DRM
> client. It has to be enabled after registering the DRM device.
>
> I'd rather improve fbdev or the driver to handle this gracefully.

Yeah I'm not understanding the point here. Once fbcon is running, you
have a screen. Any fbdev userspace client  also should do a modeset
first. And if they dont and it's expected uapi for fbdev chardev that
the display boots up enabled, then we need to fix that in the fbdev
helpers, not through clever reordering in drivers so that a
side-effect causes a modeset.

Note that this is a bit tricky since fbdev shouldn't take over the
screen by default, so we'd need to delay this until first open of
/dev/fb0. And we should probably also delay the hotplug handling until
the first open. fbcon also fake-opens the fbdev file, so it's the same
code path.
-Daniel

>
> Best regards
> Thomas
>
> >       return 0;
> >
> >  err_poll_fini:
> >
>
> --
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
> (HRB 36809, AG N=C3=BCrnberg)
> Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer



--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
