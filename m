Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6C172B5C98
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 11:08:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727404AbgKQKFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 05:05:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbgKQKFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 05:05:15 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A38C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 02:05:13 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id k2so22590622wrx.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 02:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=a5Wi2WgEQj4V/fZoMbuAUA0hIayxQxzUHqeI84Mc1FE=;
        b=jcwtfN8McGJzUoRDkq8qC68cj8dg0fKU3MjNMXmKmi/lxXkV95Q937dwb0jm5ofyRw
         b29Vkb7ZV6YcZYcAc08tixve5ngaIO9o4Ny/iiwjCUJUGUi7xdXJIT2lv1bq+/LdkU/Z
         aBCiT57QqqqzZCgmbnseFCB2XKKyzy29xnO9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=a5Wi2WgEQj4V/fZoMbuAUA0hIayxQxzUHqeI84Mc1FE=;
        b=Baw8ym1zjvIpB9WVvY+jhYr6LAWPlLA6HBE4FCP02GsmTX2cdXpys+x9hLmFzJv89c
         D6ZSYLdc1+2DtTI/5ljJS8w+6YTyl8eEdpYibRz4G0I3wC6DbBwg4qafLsAlK/AcOjPM
         3V5yD6k8C+ufoQwywLLGNrfYBWIprhHje8Mgv0QcglAwk9FQPhpThcFH36KpDAxTUovy
         YLXrBatyDfr7pdb3ZPIwgAfd0/9wm/FLW1H06DL+fibDXDG4e+4cxkJ98CSxBASXxFtB
         6F3WOoYv0gNVMRqdnP9e3AQeMItkkBGvxS3wwId3xlDZfja/+Y/OgembcNxbPj3OiWge
         3bAw==
X-Gm-Message-State: AOAM533wDpqE1hZT1X/VsGTNmKQ+OOW90Qij/f7JoD4M1jFkgDE3v29l
        XVWWTzKVN6I67dx3kn4o8Tm34Q==
X-Google-Smtp-Source: ABdhPJyRMGrawjvmO5x/3ra1IWyMGFjfgvN36ipmgsKrzL1M9MQ0E0rIX/0e1m6SBMTLUu/PiZ0Mww==
X-Received: by 2002:a5d:4d02:: with SMTP id z2mr16395374wrt.109.1605607512109;
        Tue, 17 Nov 2020 02:05:12 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id t5sm2923320wmg.19.2020.11.17.02.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 02:05:11 -0800 (PST)
Date:   Tue, 17 Nov 2020 11:05:09 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>, Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH 02/30] include: drm: drm_atomic: Artificially use 'crtc'
 to avoid 'not used' warning
Message-ID: <20201117100509.GJ401619@phenom.ffwll.local>
Mail-Followup-To: Lee Jones <lee.jones@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@linux.ie>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
References: <20201112190039.2785914-1-lee.jones@linaro.org>
 <20201112190039.2785914-3-lee.jones@linaro.org>
 <20201112202516.GA3340631@ravnborg.org>
 <20201113204959.GW401619@phenom.ffwll.local>
 <CAF2Aj3j6+fEFS66qg-a-0Z1XtNQ7EAEnu4ECZ9gLiH7buH=PLw@mail.gmail.com>
 <CAKMK7uEQwFLj+D4LfdQNfb+cQZCH34HZU7oJh8r=mjozuKmZGQ@mail.gmail.com>
 <CAF2Aj3jRFM95R7VaV_4Chi3Tr3ja31EjdVTeHeDkUWETweqCGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF2Aj3jRFM95R7VaV_4Chi3Tr3ja31EjdVTeHeDkUWETweqCGA@mail.gmail.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 10:01:57PM +0000, Lee Jones wrote:
> On Fri, 13 Nov 2020, 21:31 Daniel Vetter, <daniel@ffwll.ch> wrote:
> 
> > On Fri, Nov 13, 2020 at 9:53 PM Lee Jones <lee.jones@linaro.org> wrote:
> > >
> > >
> > >
> > > On Fri, 13 Nov 2020, 20:50 Daniel Vetter, <daniel@ffwll.ch> wrote:
> > >>
> > >> On Thu, Nov 12, 2020 at 09:25:16PM +0100, Sam Ravnborg wrote:
> > >> > Hi Lee,
> > >> >
> > >> > On Thu, Nov 12, 2020 at 07:00:11PM +0000, Lee Jones wrote:
> > >> > > The precedent has already been set by other macros in the same file.
> > >> > >
> > >> > > Fixes the following W=1 kernel build warning(s):
> > >> > >
> > >> > >  drivers/gpu/drm/vkms/vkms_drv.c:55:19: warning: variable ‘crtc’
> > set but not used [-Wunused-but-set-variable]
> > >> > >  55 | struct drm_crtc *crtc;
> > >> > >  | ^~~~
> > >> > >
> > >> > > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > >> > > Cc: Maxime Ripard <mripard@kernel.org>
> > >> > > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > >> > > Cc: David Airlie <airlied@linux.ie>
> > >> > > Cc: Daniel Vetter <daniel@ffwll.ch>
> > >> > > Cc: Rob Clark <robdclark@gmail.com>
> > >> > > Cc: dri-devel@lists.freedesktop.org
> > >> > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > >> >
> > >> > Also applied to drm-misc-next.
> > >> > This was the last patch from this batch I will process.
> > >> > The others are left for the maintainers to pick up.
> > >>
> > >> btw for patches that maintainers don't pick up, the usual process is
> > that
> > >> we give them 2 weeks, then just mass apply. Now you're producing a lot
> > of
> > >> patches, too much for me to keep track, so please just ping me with a
> > >> resend for those that expired and I'll go through and pick them all up.
> > >
> > >
> > > That's great Daniel. Thanks for your support.
> > >
> > > I can do one better than that.
> > >
> > > Would a pull-request suit you?
> >
> > We have a few trees going on, and your patches are landing through all
> > kinds of them. So this might be more coordination pain. If you can
> > exclude patches for the separately and usually fairly well maintained
> > drivers out of the pull it should work (drm/amd, drm/radeon, drm/i915,
> > drm/nouveau, drm/msm and drm/omapdrm probably the usual ones).
> >
> > Or you just send the next pile and we'll see.
> >
> > Also I guess I can't really interest you in commit rights so this
> > patch bombs get off my back again? :-)
> >
> 
> What does that mean? Merge my own patches?
> 
> Not sure how that works with your group maintenance setup.
> 
> Is it just a `git push`?

It's a bunch of scripting and setup, might not be worth it for just one
of. Plus we still take pull requests from submaintainers so it's all just
if you feel like it. Some docs if you're curious:

https://drm.pages.freedesktop.org/maintainer-tools/getting-started.html

Cheers, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
