Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D88492CDB6D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 17:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731337AbgLCQkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 11:40:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbgLCQkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 11:40:23 -0500
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8945DC061A4E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 08:39:37 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id p126so2804455oif.7
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 08:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=77vctl4dWxdrgEMXlMd4GIgDppT00p1Hbkr925ijqBE=;
        b=cTn668FDRvyHPw5XUB+ZeX0rZERlVKTGHjtXGWeI8Q37CBpJlJU7B//c2JCVW2jKUr
         zP7yukOue5qQt/AaIQBw0mxHPci+UUblty6yGjuQ3HTfOK2elDOsLtZneywmm4PVrEyJ
         Ie53BmAr5LFr8uHgFcumPbQ5X4kuRzAT6KxZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=77vctl4dWxdrgEMXlMd4GIgDppT00p1Hbkr925ijqBE=;
        b=l7K8lL/lnLXHxmC0mHcEPQsdBFGs6NTgn1S2fmTsgy+fVwp34CEe3NYWkB2VnZCiLX
         sE3U3DOPD+G4LUZAC+CC9Ogf8OwJoEMX2Dq8Ae7ef7vbqLlp+BzUzauYZ/svZZdcGdlj
         mR1mIiOHFHL3/xtgzrRjGn0LhGTuNKFoGNY7b1BL3QyhV9K7rTo7nvRE1vp/vCh1yrCY
         KuonpPvl+fPP5FpNGtSluAm+XdHudo3bRMCMFTpHYSnxpwHLtXZBjBQg7acPRe5/brWK
         +h7/wasnTUH8SO+fciuDLs7TqTiGBr9PW1k3Hg8QuLF3nnLjQ9b9tUAqGIDjU6J+KiM/
         F38A==
X-Gm-Message-State: AOAM530P7xxFbyR8/5DmPCOUvyvZD0t3zJ647F/+BWngF3sysjTaF0Mz
        ZDeKWHCVRnIbmKZBTLm9YmQt2RcY65D8ncHmZQCaFA==
X-Google-Smtp-Source: ABdhPJx1vxrvYOB+icZnIcSfpB5MlI5l8ra5SPaX6r27Su/2FSepiwln9iKH+6uHQm3VowvObDnQF95MjTdDlG/uRm0=
X-Received: by 2002:aca:47cf:: with SMTP id u198mr3548oia.14.1607013576964;
 Thu, 03 Dec 2020 08:39:36 -0800 (PST)
MIME-Version: 1.0
References: <20201203144248.418281-1-hslester96@gmail.com> <e6ebb634-4cb5-34d4-c661-4cebbe2fdbf1@axentia.se>
In-Reply-To: <e6ebb634-4cb5-34d4-c661-4cebbe2fdbf1@axentia.se>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Thu, 3 Dec 2020 17:39:25 +0100
Message-ID: <CAKMK7uE3Mr2aOEvdnVrQWE=xc-8OQ1vkv9MdURaMVPHXKF5jwQ@mail.gmail.com>
Subject: Re: [PATCH] drm/fb-helper: Add missed unlocks in setcmap_legacy()
To:     Peter Rosin <peda@axentia.se>
Cc:     Chuhong Yuan <hslester96@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 3, 2020 at 5:11 PM Peter Rosin <peda@axentia.se> wrote:
>
> Hi!
>
> On 2020-12-03 15:42, Chuhong Yuan wrote:
> > setcmap_legacy() does not call drm_modeset_unlock_all() in some exits,
> > add the missed unlocks with goto to fix it.
> >
> > Fixes: 964c60063bff ("drm/fb-helper: separate the fb_setcmap helper into atomic and legacy paths")
> > Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
>
> Yup, my patch fumbled the locking. Sorry, and thanks for cleaning up my mess!
>
> Acked-by: Peter Rosin <peda@axentia.se>
>
> (Spelled that as Ached-by at first, what does that mean??)

Merged already before I've seen your ack here (and we don't rebase so
can't add it now), thanks for the patch and all.
-Daniel

>
> Cheers,
> Peter
>
> > ---
> >  drivers/gpu/drm/drm_fb_helper.c | 15 ++++++++++-----
> >  1 file changed, 10 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
> > index 1543d9d10970..8033467db4be 100644
> > --- a/drivers/gpu/drm/drm_fb_helper.c
> > +++ b/drivers/gpu/drm/drm_fb_helper.c
> > @@ -923,11 +923,15 @@ static int setcmap_legacy(struct fb_cmap *cmap, struct fb_info *info)
> >       drm_modeset_lock_all(fb_helper->dev);
> >       drm_client_for_each_modeset(modeset, &fb_helper->client) {
> >               crtc = modeset->crtc;
> > -             if (!crtc->funcs->gamma_set || !crtc->gamma_size)
> > -                     return -EINVAL;
> > +             if (!crtc->funcs->gamma_set || !crtc->gamma_size) {
> > +                     ret = -EINVAL;
> > +                     goto out;
> > +             }
> >
> > -             if (cmap->start + cmap->len > crtc->gamma_size)
> > -                     return -EINVAL;
> > +             if (cmap->start + cmap->len > crtc->gamma_size) {
> > +                     ret = -EINVAL;
> > +                     goto out;
> > +             }
> >
> >               r = crtc->gamma_store;
> >               g = r + crtc->gamma_size;
> > @@ -940,8 +944,9 @@ static int setcmap_legacy(struct fb_cmap *cmap, struct fb_info *info)
> >               ret = crtc->funcs->gamma_set(crtc, r, g, b,
> >                                            crtc->gamma_size, NULL);
> >               if (ret)
> > -                     return ret;
> > +                     goto out;
> >       }
> > +out:
> >       drm_modeset_unlock_all(fb_helper->dev);
> >
> >       return ret;
> >



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
