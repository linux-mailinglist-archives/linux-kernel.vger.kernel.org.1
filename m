Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 970B02B5D1F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 11:45:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbgKQKnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 05:43:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbgKQKnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 05:43:16 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21641C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 02:43:15 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id w24so2770738wmi.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 02:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=osy6pxkQVPDItsXbD8uQObD8sxPqWcKJrKxDFuP2CRo=;
        b=VctitzbicJkaHcJN6Or9BIV+nqX+/ENaocC6P5PhNt3RYi3dOw61X5Zz0e0EYNPE8r
         ixlIbKm0Go1VVuhle/glLsfFcUcKThHlTZ77X8fgLA1KqFrhAlopKo/xZdtghZbex8vM
         An+gfGg+RqAICDtuPV/NLrb36j1eZMOmpU6Qk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=osy6pxkQVPDItsXbD8uQObD8sxPqWcKJrKxDFuP2CRo=;
        b=K27HawQCbIdH6RUEFX+vSbPtqGT5JOo1Do8KC2VTYc4JVlStqTGoPl+vP12fTLPCnR
         mgT/Afd4HrPLwtsF8ZUtc0y946+oheLJqcYMTRzsUalrotrWBtVMNOjUwfK/RY4nf2mT
         p61hNm2pePMpm/QENiAQS5SYQk6zlvsA4BkSfj+MyGaajl/Iq2HIJ4ZMvBT5A0av2yrn
         U+wFv/yHQgEOwewNmPaMNXVjj3fRWQglDOS6x9exIsKNsLmy+drHzmF2fQsHf6Mrg3Dm
         KowQeFCbCEeM4oMaL9FfTpXFcTMMYm5Qf1/a9RzogYTkYoEfJMkC33Ie6J844k0LoXxp
         0KtA==
X-Gm-Message-State: AOAM532lqSLDtstHkzKCCv/STpTWP1Gp/PNBJ759J4AB90PaHIAOfAky
        mRhxfVCNnqrTPzvDA33rtzXEEuijZyn/Eg==
X-Google-Smtp-Source: ABdhPJzEWHBluUkDhcVjqLuQrUUOs/GMyNmg/eBb8+6AUyBHVarVGItlkHrjVTcgOwf1/M/uumpZcA==
X-Received: by 2002:a1c:6043:: with SMTP id u64mr3521455wmb.166.1605609793857;
        Tue, 17 Nov 2020 02:43:13 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id w17sm2784038wru.82.2020.11.17.02.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 02:43:12 -0800 (PST)
Date:   Tue, 17 Nov 2020 11:43:11 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@linux.ie>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 02/30] include: drm: drm_atomic: Artificially use 'crtc'
 to avoid 'not used' warning
Message-ID: <20201117104311.GK401619@phenom.ffwll.local>
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
 <20201117100509.GJ401619@phenom.ffwll.local>
 <20201117103404.GF1869941@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201117103404.GF1869941@dell>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 10:34:04AM +0000, Lee Jones wrote:
> Daniel,
> 
> For some reason, you're not appearing in the recipents list when I
> reply to all.  You're not in the Mail-Followup-To header.  Any idea
> why this might be?

No idea either, could be my mutt not setting the reply headers like it
should. I'm generally confused with how email works ...
> 
> Anyway, please see below:
> 
> On Tue, 17 Nov 2020, Daniel Vetter wrote:
> > On Fri, Nov 13, 2020 at 10:01:57PM +0000, Lee Jones wrote:
> > > On Fri, 13 Nov 2020, 21:31 Daniel Vetter, <daniel@ffwll.ch> wrote:
> > > 
> > > > On Fri, Nov 13, 2020 at 9:53 PM Lee Jones <lee.jones@linaro.org> wrote:
> > > > >
> > > > >
> > > > >
> > > > > On Fri, 13 Nov 2020, 20:50 Daniel Vetter, <daniel@ffwll.ch> wrote:
> > > > >>
> > > > >> On Thu, Nov 12, 2020 at 09:25:16PM +0100, Sam Ravnborg wrote:
> > > > >> > Hi Lee,
> > > > >> >
> > > > >> > On Thu, Nov 12, 2020 at 07:00:11PM +0000, Lee Jones wrote:
> > > > >> > > The precedent has already been set by other macros in the same file.
> > > > >> > >
> > > > >> > > Fixes the following W=1 kernel build warning(s):
> > > > >> > >
> > > > >> > >  drivers/gpu/drm/vkms/vkms_drv.c:55:19: warning: variable ‘crtc’
> > > > set but not used [-Wunused-but-set-variable]
> > > > >> > >  55 | struct drm_crtc *crtc;
> > > > >> > >  | ^~~~
> > > > >> > >
> > > > >> > > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > > > >> > > Cc: Maxime Ripard <mripard@kernel.org>
> > > > >> > > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > > > >> > > Cc: David Airlie <airlied@linux.ie>
> > > > >> > > Cc: Daniel Vetter <daniel@ffwll.ch>
> > > > >> > > Cc: Rob Clark <robdclark@gmail.com>
> > > > >> > > Cc: dri-devel@lists.freedesktop.org
> > > > >> > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > > >> >
> > > > >> > Also applied to drm-misc-next.
> > > > >> > This was the last patch from this batch I will process.
> > > > >> > The others are left for the maintainers to pick up.
> > > > >>
> > > > >> btw for patches that maintainers don't pick up, the usual process is
> > > > that
> > > > >> we give them 2 weeks, then just mass apply. Now you're producing a lot
> > > > of
> > > > >> patches, too much for me to keep track, so please just ping me with a
> > > > >> resend for those that expired and I'll go through and pick them all up.
> > > > >
> > > > >
> > > > > That's great Daniel. Thanks for your support.
> > > > >
> > > > > I can do one better than that.
> > > > >
> > > > > Would a pull-request suit you?
> > > >
> > > > We have a few trees going on, and your patches are landing through all
> > > > kinds of them. So this might be more coordination pain. If you can
> > > > exclude patches for the separately and usually fairly well maintained
> > > > drivers out of the pull it should work (drm/amd, drm/radeon, drm/i915,
> > > > drm/nouveau, drm/msm and drm/omapdrm probably the usual ones).
> > > >
> > > > Or you just send the next pile and we'll see.
> > > >
> > > > Also I guess I can't really interest you in commit rights so this
> > > > patch bombs get off my back again? :-)
> > > >
> > > 
> > > What does that mean? Merge my own patches?
> > > 
> > > Not sure how that works with your group maintenance setup.
> > > 
> > > Is it just a `git push`?
> > 
> > It's a bunch of scripting and setup, might not be worth it for just one
> > of. Plus we still take pull requests from submaintainers so it's all just
> > if you feel like it. Some docs if you're curious:
> > 
> > https://drm.pages.freedesktop.org/maintainer-tools/getting-started.html
> 
> As *fun* as that looks, I think I'll give it a miss, thanks. :)
> 
> So for the final merge of the non-Radeon set [0] to date (Alex just
> pulled in all of the outstanding Radeon patches), we have a few
> options:
> 
>  1. Take them directly from the most recent set [0]
>  2. I can rebase and resubmit again in a few days
>  3. I can submit a PR
> 
> Whatever works for you.
> 
> [0] "[PATCH v2 00/42] Rid W=1 warnings from GPU (non-Radeon)"

I planned to go through that today and apply it all. Wanted to ping a few
maintainers first whether they pick anything up, but aside from Alex
they're non-committal so I think I just vacuum them all up so it's done.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
