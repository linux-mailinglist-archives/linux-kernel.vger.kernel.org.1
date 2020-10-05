Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77D47283E20
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 20:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727871AbgJESTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 14:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbgJESTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 14:19:04 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67671C0613A7
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 11:19:04 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id n61so9536617ota.10
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 11:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=In0H1HeRaahBqHRJG3WYCn/jPrfcT39VxygZWdrKz0U=;
        b=G9VnZHdzNM4pErmtEpJ1P06DEL/kfTfrDzrcMiS0K+PneP38wM4nkksUdHu+NCcAnW
         PVRbECL0+y0gPnfU9bYGb1SRyEpPt5657CnVeVTSzpK2xDkX7uaij8f6nYicopqm7U4/
         ZJe/HUFY5gn3zR59Rrrr6FYo2oi5CTo7poOTk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=In0H1HeRaahBqHRJG3WYCn/jPrfcT39VxygZWdrKz0U=;
        b=VIFLDAA9s3eRN/902B8wvDu+tqP3DsK7vvXyJO1zEgI3+Jk0zrpLnU7LDd+WKYnMAY
         0/51BGUG2LmZ0rE6a2YXXc5i/NtUeJ4SWEQWJUNRPV3UIZElWWYRT2cRODWTJ0DDyk9D
         AxIa1MMIJcOKn6cew6Om7ePuRiZoRu3xwlqRlMo3DGbMu6dySH5gUgV3QtCNA1QkY/WQ
         CTDWfdVsI8wVsHn0AhiOoAHHGT8RDLbS3T4W/R3y0IFWPDK4MunlMqHpzocgh/ofT1+z
         lFdnrW5TzwbkT/D+kLljjo7T/AR6Jb4ixhu7DRV8nSWbgoCQDSfTtlE/rl2a0fYc7ZVe
         5mhA==
X-Gm-Message-State: AOAM532O2D2eBd5Gba1KQhFFw5AclhNh/gL4r5uKJsCHcwctyGmWwmSs
        8yNN1oCSf+SigakgWYYtY/C5ek1QwRQyw0fTJQybrg==
X-Google-Smtp-Source: ABdhPJwb2udB+ti8/BSw9azKpCYNapb5vn8dmsFNQ+jSRevONoZR7A89yIg5NYGsYY62/1FIqsrs3xTq/GQw/OTXO8g=
X-Received: by 2002:a05:6830:1e56:: with SMTP id e22mr364384otj.303.1601921943802;
 Mon, 05 Oct 2020 11:19:03 -0700 (PDT)
MIME-Version: 1.0
References: <20201004192152.3298573-1-robdclark@gmail.com> <20201005092419.15608-1-hdanton@sina.com>
 <20201005140203.GS438822@phenom.ffwll.local> <CAF6AEGveqvvv9MfBMAr34y9664fPouGjwPrK=v9OLVXv4dHzxg@mail.gmail.com>
In-Reply-To: <CAF6AEGveqvvv9MfBMAr34y9664fPouGjwPrK=v9OLVXv4dHzxg@mail.gmail.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Mon, 5 Oct 2020 20:18:52 +0200
Message-ID: <CAKMK7uHH2imD+8pG-bN8kXcOjvkcta88LXFC2Yb8hw25-cLBeQ@mail.gmail.com>
Subject: Re: [PATCH 13/14] drm/msm: Drop struct_mutex in shrinker path
To:     Rob Clark <robdclark@gmail.com>
Cc:     Hillf Danton <hdanton@sina.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Rob Clark <robdclark@chromium.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 5, 2020 at 6:49 PM Rob Clark <robdclark@gmail.com> wrote:
>
> On Mon, Oct 5, 2020 at 7:02 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> >
> > On Mon, Oct 05, 2020 at 05:24:19PM +0800, Hillf Danton wrote:
> > >
> > > On Sun,  4 Oct 2020 12:21:45
> > > > From: Rob Clark <robdclark@chromium.org>
> > > >
> > > > Now that the inactive_list is protected by mm_lock, and everything
> > > > else on per-obj basis is protected by obj->lock, we no longer depend
> > > > on struct_mutex.
> > > >
> > > > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > > > ---
> > > >  drivers/gpu/drm/msm/msm_gem.c          |  1 -
> > > >  drivers/gpu/drm/msm/msm_gem_shrinker.c | 54 --------------------------
> > > >  2 files changed, 55 deletions(-)
> > > >
> > > [...]
> > >
> > > > @@ -71,13 +33,8 @@ msm_gem_shrinker_scan(struct shrinker *shrinker, struct shrink_control *sc)
> > > >  {
> > > >     struct msm_drm_private *priv =
> > > >             container_of(shrinker, struct msm_drm_private, shrinker);
> > > > -   struct drm_device *dev = priv->dev;
> > > >     struct msm_gem_object *msm_obj;
> > > >     unsigned long freed = 0;
> > > > -   bool unlock;
> > > > -
> > > > -   if (!msm_gem_shrinker_lock(dev, &unlock))
> > > > -           return SHRINK_STOP;
> > > >
> > > >     mutex_lock(&priv->mm_lock);
> > >
> > > Better if the change in behavior is documented that SHRINK_STOP will
> > > no longer be needed.
> >
> > btw I read through this and noticed you have your own obj lock, plus
> > mutex_lock_nested. I strongly recommend to just cut over to dma_resv_lock
> > for all object lock needs (soc drivers have been terrible with this
> > unfortuntaly), and in the shrinker just use dma_resv_trylock instead of
> > trying to play clever games outsmarting lockdep.
> >
> > I recently wrote an entire blog length rant on why I think
> > mutex_lock_nested is too dangerous to be useful:
> >
> > https://blog.ffwll.ch/2020/08/lockdep-false-positives.html
> >
> > Not anything about this here, just general comment. The problem extends to
> > shmem helpers and all that also having their own locks for everything.
>
> the shrinker lock class has existed for a while.. and is based on the
> idea that anything in the get-pages/vmap path cannot happen on a
> WONTNEED bo.. although perhaps there should be a few more 'if
> (WARN_ON(obj->madv != WILLNEED)) return -EBUSY'..

Yeah it works, but it's the kind of really clever stuff that
eventually bites again. For pretty much no benefit, if the lock is
held then you can assume someone else is using the object and you
won't be able to shrink it anyway. So trylock is enough.

> replacing obj->lock with dma_resv lock, might be a nice cleanup.. but
> I think it will be a bit churny..

Oh fully agreed, I tried to push the helpers a bit in that direction
for shmem/cma and gave up. Just something I think we should have in
mind. And in case your gpu ever becomes discrete ... yes the churn is
terrible :-/
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
