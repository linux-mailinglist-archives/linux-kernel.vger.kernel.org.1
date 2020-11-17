Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BFCF2B5DFB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 12:08:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbgKQLIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 06:08:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgKQLIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 06:08:12 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32DB9C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 03:08:11 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id m6so5559240wrg.7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 03:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=n6eCU59I1t0nmoUX/JMABtcH5UW5JkFeV2XR6hvO1PI=;
        b=wm7D0wAEo/rWM9cDVPNP5RJ17YGDvBs3Tv2wZAk+20keQeqxp782e2psf5adEkIAJw
         sBzqmKCyhVS9E/+1ZFLwEgN3IGBwv06ht4IKnvs3OdAZ/BSIrESIv6+YNUhFSivZUN3g
         bHTUf04wf+adxGk6uiLU0VYv/h2+FF9fe1ba7+XebaHBxy+Fwklt8xJiqTkqh/rgccdz
         6mvX0bJM9e0n3niU4ktFpOUEYcqJZuH1a5cjr8asHLStTp15n0noMZqXMOwpawMzLk34
         UHtHlyUEZlJTjy0VxYitue+UMwBcb7116/uy9rSHCJ7jaNkAygkvzsjFAdahI5uualMJ
         teFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=n6eCU59I1t0nmoUX/JMABtcH5UW5JkFeV2XR6hvO1PI=;
        b=Oo+LeSPW68W1dBoJd0pifnICWX36xErrMa3DwlLtKd6nLhjqfzZS9FdyTRj9Gm1+pQ
         +9Kv2AMnOMUgcjcVa/a9UejDm0s3vv4H2YN5QSDs7TIeZEhhZGTcb8GnZJejyp3w9giN
         BLmky85r6N+anPfCYX1a6dEEMgnJb1h4NftO3oKsjZIodZ8q6H6YeDjcvZQzjUKoK7c5
         m2zBYwt0LWTu5ycfaoJ4UXb1PNU8wVLwBZrde2GTGlBurhxpvD6O26OmrHgcx8UifCp8
         aCy9/yqJcqS+XBUcoUncaeO9HDHH9cdwKT71cvUN610vN84YwpW7rCQJSq9WdH5k+UvH
         YCOA==
X-Gm-Message-State: AOAM530GuoG6SqU3f/UCQOqIFJFz3fxahw9lb8MFejqSs22Le2A8yQg+
        LQNUCELgMY2UOShoa2X7kEm9tw==
X-Google-Smtp-Source: ABdhPJyt5w/xfOns8zFWyU7ejsnKVtooG6J4Era6ZK54EsNK4dAphhyhJTCzhXH1vwllX5WPUSGCyQ==
X-Received: by 2002:adf:d0c8:: with SMTP id z8mr25144803wrh.288.1605611289487;
        Tue, 17 Nov 2020 03:08:09 -0800 (PST)
Received: from dell ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id t11sm2919301wmf.35.2020.11.17.03.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 03:08:08 -0800 (PST)
Date:   Tue, 17 Nov 2020 11:08:07 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@linux.ie>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 02/30] include: drm: drm_atomic: Artificially use 'crtc'
 to avoid 'not used' warning
Message-ID: <20201117110807.GG1869941@dell>
References: <20201112190039.2785914-1-lee.jones@linaro.org>
 <20201112190039.2785914-3-lee.jones@linaro.org>
 <20201112202516.GA3340631@ravnborg.org>
 <20201113204959.GW401619@phenom.ffwll.local>
 <CAF2Aj3j6+fEFS66qg-a-0Z1XtNQ7EAEnu4ECZ9gLiH7buH=PLw@mail.gmail.com>
 <CAKMK7uEQwFLj+D4LfdQNfb+cQZCH34HZU7oJh8r=mjozuKmZGQ@mail.gmail.com>
 <CAF2Aj3jRFM95R7VaV_4Chi3Tr3ja31EjdVTeHeDkUWETweqCGA@mail.gmail.com>
 <20201117100509.GJ401619@phenom.ffwll.local>
 <20201117103404.GF1869941@dell>
 <20201117104311.GK401619@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201117104311.GK401619@phenom.ffwll.local>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Nov 2020, Daniel Vetter wrote:

> On Tue, Nov 17, 2020 at 10:34:04AM +0000, Lee Jones wrote:
> > Daniel,
> > 
> > For some reason, you're not appearing in the recipents list when I
> > reply to all.  You're not in the Mail-Followup-To header.  Any idea
> > why this might be?
> 
> No idea either, could be my mutt not setting the reply headers like it
> should. I'm generally confused with how email works ...

Yes, email is a mystery!

> > Anyway, please see below:
> > 
> > On Tue, 17 Nov 2020, Daniel Vetter wrote:
> > > On Fri, Nov 13, 2020 at 10:01:57PM +0000, Lee Jones wrote:
> > > > On Fri, 13 Nov 2020, 21:31 Daniel Vetter, <daniel@ffwll.ch> wrote:
> > > > 
> > > > > On Fri, Nov 13, 2020 at 9:53 PM Lee Jones <lee.jones@linaro.org> wrote:
> > > > > >
> > > > > >
> > > > > >
> > > > > > On Fri, 13 Nov 2020, 20:50 Daniel Vetter, <daniel@ffwll.ch> wrote:
> > > > > >>
> > > > > >> On Thu, Nov 12, 2020 at 09:25:16PM +0100, Sam Ravnborg wrote:
> > > > > >> > Hi Lee,
> > > > > >> >
> > > > > >> > On Thu, Nov 12, 2020 at 07:00:11PM +0000, Lee Jones wrote:
> > > > > >> > > The precedent has already been set by other macros in the same file.
> > > > > >> > >
> > > > > >> > > Fixes the following W=1 kernel build warning(s):
> > > > > >> > >
> > > > > >> > >  drivers/gpu/drm/vkms/vkms_drv.c:55:19: warning: variable ‘crtc’
> > > > > set but not used [-Wunused-but-set-variable]
> > > > > >> > >  55 | struct drm_crtc *crtc;
> > > > > >> > >  | ^~~~
> > > > > >> > >
> > > > > >> > > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > > > > >> > > Cc: Maxime Ripard <mripard@kernel.org>
> > > > > >> > > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > > > > >> > > Cc: David Airlie <airlied@linux.ie>
> > > > > >> > > Cc: Daniel Vetter <daniel@ffwll.ch>
> > > > > >> > > Cc: Rob Clark <robdclark@gmail.com>
> > > > > >> > > Cc: dri-devel@lists.freedesktop.org
> > > > > >> > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > > > >> >
> > > > > >> > Also applied to drm-misc-next.
> > > > > >> > This was the last patch from this batch I will process.
> > > > > >> > The others are left for the maintainers to pick up.
> > > > > >>
> > > > > >> btw for patches that maintainers don't pick up, the usual process is
> > > > > that
> > > > > >> we give them 2 weeks, then just mass apply. Now you're producing a lot
> > > > > of
> > > > > >> patches, too much for me to keep track, so please just ping me with a
> > > > > >> resend for those that expired and I'll go through and pick them all up.
> > > > > >
> > > > > >
> > > > > > That's great Daniel. Thanks for your support.
> > > > > >
> > > > > > I can do one better than that.
> > > > > >
> > > > > > Would a pull-request suit you?
> > > > >
> > > > > We have a few trees going on, and your patches are landing through all
> > > > > kinds of them. So this might be more coordination pain. If you can
> > > > > exclude patches for the separately and usually fairly well maintained
> > > > > drivers out of the pull it should work (drm/amd, drm/radeon, drm/i915,
> > > > > drm/nouveau, drm/msm and drm/omapdrm probably the usual ones).
> > > > >
> > > > > Or you just send the next pile and we'll see.
> > > > >
> > > > > Also I guess I can't really interest you in commit rights so this
> > > > > patch bombs get off my back again? :-)
> > > > >
> > > > 
> > > > What does that mean? Merge my own patches?
> > > > 
> > > > Not sure how that works with your group maintenance setup.
> > > > 
> > > > Is it just a `git push`?
> > > 
> > > It's a bunch of scripting and setup, might not be worth it for just one
> > > of. Plus we still take pull requests from submaintainers so it's all just
> > > if you feel like it. Some docs if you're curious:
> > > 
> > > https://drm.pages.freedesktop.org/maintainer-tools/getting-started.html
> > 
> > As *fun* as that looks, I think I'll give it a miss, thanks. :)
> > 
> > So for the final merge of the non-Radeon set [0] to date (Alex just
> > pulled in all of the outstanding Radeon patches), we have a few
> > options:
> > 
> >  1. Take them directly from the most recent set [0]
> >  2. I can rebase and resubmit again in a few days
> >  3. I can submit a PR
> > 
> > Whatever works for you.
> > 
> > [0] "[PATCH v2 00/42] Rid W=1 warnings from GPU (non-Radeon)"
> 
> I planned to go through that today and apply it all. Wanted to ping a few
> maintainers first whether they pick anything up, but aside from Alex
> they're non-committal so I think I just vacuum them all up so it's done.

Okay, perfect.  Thanks a bunch.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
