Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 521D12B5CF8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 11:34:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbgKQKeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 05:34:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727439AbgKQKeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 05:34:08 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36F1C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 02:34:07 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id j7so22628742wrp.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 02:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Sud3D2o5i/2sKQgZl/D7nnujJzuFFholMZb2B2KvWWM=;
        b=RGpqDPpFmT5G7SLxjr4yX6NK5dr/9nYyj3C/p65ke0uLMsIvEFmNrGtPWv2NsIy/C6
         w+6xb49utWRuAe6ghTEpCM3mkh7TE5ACOZsfVXBs/7BiQaajfy6AH2pM3NaodxjAz/D8
         TLYtR4aFmK4BA0wi6T9Hll8ND398GpXmmf+ELBDpJMFadc3cA5XzP85KJ02gFlHN+kBu
         0zwN1K4sUPMNGrfseUYM7M45k/OLSxKV93SRm93IYBV+Vpw9R3mFoiEt18aJn1WMnRDy
         C9KUGjjgC7h+UprkQvyVJCwkQi6Q1w6pYwArQWRadqDn19nESVxmJMemdcX9wLXxkM0i
         tQNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Sud3D2o5i/2sKQgZl/D7nnujJzuFFholMZb2B2KvWWM=;
        b=ZUfRrIJATDy7IF62rg7QVrQj8mMqghW7xZclEUzLOFe7fc9oTdwY1oT90Sv1JBhqoo
         kV1fook8dnseveJFOXNwwDPsgm1ziz+5Rjr51PwSkjm/f5NbnVNIecNLGfsgEN7qQYpq
         cMak4B8uuo68AO2PTCx5BhRjZrsumb0xk+hPbr5mzZ9k89XYpnEvjNjUrc/Ty6+LEIZF
         L7E0hgLsKqrFQjSWMQk3Zl5+4NPCdwysNclXn0kqHHC7bCE1yfINdiY91uIUskBsZRXc
         UegI73Jc9er5vOQnc2o0xnKZniamo9WI2h3L/nQlw8HGUPo5Jd0b/EqMWw1GE2SriHqf
         d8Tw==
X-Gm-Message-State: AOAM530ok+DKKwxVXotdH6Ths4Hwskb83X/gYWNHeCgqJtJ5899WMi0M
        AIiqCuAPp4U9wiW/9g23Rc38Kg==
X-Google-Smtp-Source: ABdhPJxtIQ23iZHX7uQawoEIGGH345+Ol3HRW/RC+sRVxjokZR9d24k5wZsq7t1rf1Uq/aibvoAMeA==
X-Received: by 2002:a5d:4388:: with SMTP id i8mr24032522wrq.262.1605609246430;
        Tue, 17 Nov 2020 02:34:06 -0800 (PST)
Received: from dell ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id j71sm3094716wmj.10.2020.11.17.02.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 02:34:05 -0800 (PST)
Date:   Tue, 17 Nov 2020 10:34:04 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@linux.ie>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 02/30] include: drm: drm_atomic: Artificially use 'crtc'
 to avoid 'not used' warning
Message-ID: <20201117103404.GF1869941@dell>
References: <20201112190039.2785914-1-lee.jones@linaro.org>
 <20201112190039.2785914-3-lee.jones@linaro.org>
 <20201112202516.GA3340631@ravnborg.org>
 <20201113204959.GW401619@phenom.ffwll.local>
 <CAF2Aj3j6+fEFS66qg-a-0Z1XtNQ7EAEnu4ECZ9gLiH7buH=PLw@mail.gmail.com>
 <CAKMK7uEQwFLj+D4LfdQNfb+cQZCH34HZU7oJh8r=mjozuKmZGQ@mail.gmail.com>
 <CAF2Aj3jRFM95R7VaV_4Chi3Tr3ja31EjdVTeHeDkUWETweqCGA@mail.gmail.com>
 <20201117100509.GJ401619@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201117100509.GJ401619@phenom.ffwll.local>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel,

For some reason, you're not appearing in the recipents list when I
reply to all.  You're not in the Mail-Followup-To header.  Any idea
why this might be?

Anyway, please see below:

On Tue, 17 Nov 2020, Daniel Vetter wrote:
> On Fri, Nov 13, 2020 at 10:01:57PM +0000, Lee Jones wrote:
> > On Fri, 13 Nov 2020, 21:31 Daniel Vetter, <daniel@ffwll.ch> wrote:
> > 
> > > On Fri, Nov 13, 2020 at 9:53 PM Lee Jones <lee.jones@linaro.org> wrote:
> > > >
> > > >
> > > >
> > > > On Fri, 13 Nov 2020, 20:50 Daniel Vetter, <daniel@ffwll.ch> wrote:
> > > >>
> > > >> On Thu, Nov 12, 2020 at 09:25:16PM +0100, Sam Ravnborg wrote:
> > > >> > Hi Lee,
> > > >> >
> > > >> > On Thu, Nov 12, 2020 at 07:00:11PM +0000, Lee Jones wrote:
> > > >> > > The precedent has already been set by other macros in the same file.
> > > >> > >
> > > >> > > Fixes the following W=1 kernel build warning(s):
> > > >> > >
> > > >> > >  drivers/gpu/drm/vkms/vkms_drv.c:55:19: warning: variable ‘crtc’
> > > set but not used [-Wunused-but-set-variable]
> > > >> > >  55 | struct drm_crtc *crtc;
> > > >> > >  | ^~~~
> > > >> > >
> > > >> > > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > > >> > > Cc: Maxime Ripard <mripard@kernel.org>
> > > >> > > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > > >> > > Cc: David Airlie <airlied@linux.ie>
> > > >> > > Cc: Daniel Vetter <daniel@ffwll.ch>
> > > >> > > Cc: Rob Clark <robdclark@gmail.com>
> > > >> > > Cc: dri-devel@lists.freedesktop.org
> > > >> > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > >> >
> > > >> > Also applied to drm-misc-next.
> > > >> > This was the last patch from this batch I will process.
> > > >> > The others are left for the maintainers to pick up.
> > > >>
> > > >> btw for patches that maintainers don't pick up, the usual process is
> > > that
> > > >> we give them 2 weeks, then just mass apply. Now you're producing a lot
> > > of
> > > >> patches, too much for me to keep track, so please just ping me with a
> > > >> resend for those that expired and I'll go through and pick them all up.
> > > >
> > > >
> > > > That's great Daniel. Thanks for your support.
> > > >
> > > > I can do one better than that.
> > > >
> > > > Would a pull-request suit you?
> > >
> > > We have a few trees going on, and your patches are landing through all
> > > kinds of them. So this might be more coordination pain. If you can
> > > exclude patches for the separately and usually fairly well maintained
> > > drivers out of the pull it should work (drm/amd, drm/radeon, drm/i915,
> > > drm/nouveau, drm/msm and drm/omapdrm probably the usual ones).
> > >
> > > Or you just send the next pile and we'll see.
> > >
> > > Also I guess I can't really interest you in commit rights so this
> > > patch bombs get off my back again? :-)
> > >
> > 
> > What does that mean? Merge my own patches?
> > 
> > Not sure how that works with your group maintenance setup.
> > 
> > Is it just a `git push`?
> 
> It's a bunch of scripting and setup, might not be worth it for just one
> of. Plus we still take pull requests from submaintainers so it's all just
> if you feel like it. Some docs if you're curious:
> 
> https://drm.pages.freedesktop.org/maintainer-tools/getting-started.html

As *fun* as that looks, I think I'll give it a miss, thanks. :)

So for the final merge of the non-Radeon set [0] to date (Alex just
pulled in all of the outstanding Radeon patches), we have a few
options:

 1. Take them directly from the most recent set [0]
 2. I can rebase and resubmit again in a few days
 3. I can submit a PR

Whatever works for you.

[0] "[PATCH v2 00/42] Rid W=1 warnings from GPU (non-Radeon)"

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
