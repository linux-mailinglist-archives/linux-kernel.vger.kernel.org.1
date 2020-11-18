Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 931D52B7B34
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 11:25:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbgKRKXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 05:23:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727446AbgKRKXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 05:23:53 -0500
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF81C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 02:23:52 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id n11so1256697ota.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 02:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IYc15g665JLoBoA6gcQrZ5fSunfsJmR8gly3tzeAHTw=;
        b=GevZ8t82vGheX2W9TMQuCjKxM80eBfu11aUooZwolIHJH/OfR+bEyhU2ZijjrFzD+q
         3PNGjHJOFsTue7T84D2mFBgId1I0w11RZy9SQS4ER8LvJtMR2aCI2hzZcAqALOwC3zJV
         wWqwfwxbogusEPnFy+BZrXkJffy+PcD14Iq/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IYc15g665JLoBoA6gcQrZ5fSunfsJmR8gly3tzeAHTw=;
        b=o14eT4E/MiGK/3iNx7Ee0JR9bejRfqQUR2nMqJxUcxh1p7uz/escWDYewGmjJl1C6y
         Mdj0IiyynpIADUaTtyBwHGF7NPgbrICLfBk+gLq43od4+I8z7dwd4+EBUjobm6tBkBCx
         Yuid9oG/Y27KcAmRneS/xYC2WeAYhPfPaFIhmGA9FAUhRqft8ATkTW23Rk6KWOdt0NcP
         X/SDq/cE1qYF67/BUkDyoak8zzN/99UFy8fjQpV4T8/CCOXZP8JvjpXGvXD8T0+xPFFK
         KUARN9+VlQ7e4OujMf9uZidIl8nRchT6xl2sFdwPwExkkWzbY/JV57lppOqGS46ieB4v
         SRgQ==
X-Gm-Message-State: AOAM530TRuZwBoQ9w4B8DqNGaEjxo3bKIGoHEKhzXp8eyh5uMRUGQMwc
        PF516dRXU8UZ+Q6342JVpEQDcvl3GCBnTj7ivGjAtg==
X-Google-Smtp-Source: ABdhPJwM6SyyOtWsE0KW2tESF/f80QfbP7+PRn3Epw2LJiOWPMdeo1c1/zSCuabUltApbBFzMAa2N5IHukc0khWVaBw=
X-Received: by 2002:a9d:3b4:: with SMTP id f49mr6380545otf.188.1605695031632;
 Wed, 18 Nov 2020 02:23:51 -0800 (PST)
MIME-Version: 1.0
References: <20201117155229.9837-1-mark.jonas@de.bosch.com>
 <e089d4d5-3bd8-c2cd-3011-ed87ae4284e8@suse.de> <CAKMK7uEpEt4w4kVJLOd2Yw1MnsrCn-NMgT4TjcxROpZBa_xvYg@mail.gmail.com>
 <68af913c-9f4e-73b5-a2cb-8692902a2847@suse.de> <38c2d92ac5f04a228e55af43a12a4bd7@de.bosch.com>
In-Reply-To: <38c2d92ac5f04a228e55af43a12a4bd7@de.bosch.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 18 Nov 2020 11:23:40 +0100
Message-ID: <CAKMK7uFofJ2f4ozx=QMkfYHLAy0euOf6S0wou5qYC--QiEe5Qw@mail.gmail.com>
Subject: Re: [PATCH] drm: imx: Move fbdev setup to before output polling
To:     "Jonas Mark (BT-FIR/ENG1-Grb)" <Mark.Jonas@de.bosch.com>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        "RUAN Tingquan (BT-FIR/ENG1-Zhu)" <Tingquan.Ruan@cn.bosch.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18, 2020 at 10:47 AM Jonas Mark (BT-FIR/ENG1-Grb)
<Mark.Jonas@de.bosch.com> wrote:
>
> Hi Thomas and Daniel,
>
> Thank you very much for your feedback. We appreciate it.
>
> > >>> diff --git a/drivers/gpu/drm/imx/imx-drm-core.c
> > >>> b/drivers/gpu/drm/imx/imx-drm-core.c
> > >>> index 9bf5ad6d18a2..2665040e11c7 100644
> > >>> --- a/drivers/gpu/drm/imx/imx-drm-core.c
> > >>> +++ b/drivers/gpu/drm/imx/imx-drm-core.c
> > >>> @@ -240,14 +240,18 @@ static int imx_drm_bind(struct device *dev)
> > >>>                legacyfb_depth = 16;
> > >>>        }
> > >>>
> > >>> +     /*
> > >>> +      * The generic fbdev has to be setup before enabling output polling.
> > >>> +      * Otherwise the fbdev client is not ready to handle delayed events.
> > >>> +      */
> > >>> +     drm_fbdev_generic_setup(drm, legacyfb_depth);
> > >>> +
> > >>>        drm_kms_helper_poll_init(drm);
> > >>>
> > >>>        ret = drm_dev_register(drm, 0);
> > >>>        if (ret)
> > >>>                goto err_poll_fini;
> > >>>
> > >>> -     drm_fbdev_generic_setup(drm, legacyfb_depth);
> > >>> -
> > >>
> > >> This does not work well. fbdev is supposed to be another regular DRM
> > >> client. It has to be enabled after registering the DRM device.
> > >>
> > >> I'd rather improve fbdev or the driver to handle this gracefully.
> > >
> > > Yeah I'm not understanding the point here. Once fbcon is running, you
> > > have a screen. Any fbdev userspace client  also should do a modeset
> > > first. And if they dont and it's expected uapi for fbdev chardev that
> > > the display boots up enabled, then we need to fix that in the fbdev
> > > helpers, not through clever reordering in drivers so that a
> > > side-effect causes a modeset.
> > >
> > > Note that this is a bit tricky since fbdev shouldn't take over the
> > > screen by default, so we'd need to delay this until first open of
> > > /dev/fb0. And we should probably also delay the hotplug handling until
> > > the first open. fbcon also fake-opens the fbdev file, so it's the same
> > > code path.
> >
> > As far as I understand the commit message, the problem is that the display
> > blanks out after registering the driver. And fbdev somewhat mitigates this by
> > doing an early modeset. Users with fbdev disabled (most of them in
> > embedded, I guess) would still run into the issue until userspace makes a
> > modeset.
> >
> > Mark, if that's the case, an option might be to pick up the device settings
> > instead of calling drm_mode_config_reset(). The driver would then continue
> > to display whatever is on the screen.
>
> We are started using fbdev in our embedded application with Linux 3.10, later
> updated to 4.14 and are now in the process of updating to 5.4. So far the uapi
> appeared to us as if we could rely on an already enabled fbdev. That is, none
> of our applications does a modeset.
>
> When switching to 5.4 we noticed that the fbdev uapi changed. That is, the
> LCD is switched off until it is explicitly enabled. It could be enabled by
> writing to /sys/class/graphics/fb0/blank.
>
> You are right, we are not using fbcon. fbcon will still enable the LCD but in our
> embedded domain we have it disabled because we must not show a console.
>
> Do we understand your proposal correctly to replace the call to
> drm_mode_config_reset() in imx_drm_bind() [imx-drm-core.c] with picking up
> the device settings instead?
>
> https://elixir.bootlin.com/linux/v5.10-rc4/source/drivers/gpu/drm/imx/imx-drm-core.c#L231
>
> We are a little clueless right now: How do we pick up the device settings?

Nope, not what I had in mind.

Instead intercept the fb_ops->open call and in there if it's a
userspace open (user parameter of the callback tells you that) and kms
is not in use, then try to light up the display for the fbdev
userspace to use. drm fbdev helpers already have that callback as
drm_fbdev_fb_open(). I think you could try and just call
drm_fbdev_client_hotplug directly, that should do the trick. Or maybe
calling drm_fb_helper_dpms is the better option, not sure. fbmem.c
seems to not store any blanking state at all, so this is probably all
ill-defined.

Important part is to do this only for the user fb_open case, since
fbcon will do its own thing too.

Plus I guess we need to document that this is the uapi we're having
for fbdev clients, so ideally this should be cc'ed widely so we can
get some acks from former fbdev maintainers.

Also ideally we'd have an igt for this uapi to make sure it never
breaks again. Something like:
1. open the kms driver for this, make sure display is completely off.
2. close kms file
3. open fbdev file
4. check (through opening kms side again) that the display has been enabled.

See https://dri.freedesktop.org/docs/drm/gpu/drm-uapi.html#validating-changes-with-igt
for some details on our validation testing, there's already a very
basic fbdev testcase there.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
