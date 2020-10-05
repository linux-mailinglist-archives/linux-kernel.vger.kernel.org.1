Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76985283735
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 16:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbgJEOCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 10:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbgJEOCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 10:02:12 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4284CC0613A7
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 07:02:10 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id v12so8918381wmh.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 07:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=Kw0jH99mH65cgbBf0cAKvt7u45o+bI69PtoRz7plT9I=;
        b=LKbavLR8ZdTnQm7tlmWwgndIQwhen8v8O8x1psZ+HIE2wmAD24D+bXj5NwsJAvyS/R
         MQkiaMJ/+ob1zWMVtrd+sEWT6BKvZocdCnxbzPsmOqi3r39+dbuF1VEaGtZJZGoHTneV
         0F4uvulqQGo0uTF43vmMZxaBExbJ8UbT6Sb9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=Kw0jH99mH65cgbBf0cAKvt7u45o+bI69PtoRz7plT9I=;
        b=KyLnZGJjNucofJTkFFPX9rHlCMYExUlsGEq1mnNRL9FQDJX20LlKYWzO1g+xAtrUR7
         i6bolX1RtPKLqnbKTeEAWvkuUw2orjATTVTfQOVYh4Wkkra+LYMGrUmYt7vWJbluoTkv
         yIyaWrzPtEOw0mixXZGtT69p96rMrCnV4/myZFVQxY8qYH+qmAzd0OXaQKS/wbuo7zCc
         vGoBWhowk9KybaSClvqLI5OgqW+mlVO9AnDd4CpHy+X5WJgDR5anq66jRmOPoINMW92X
         48kMdlquw9CgX6FYi4LnrVRRmaIW07tIEv/3BnjJry2Ick/5uyKHImpi9LnHBPBKsDTz
         ktkg==
X-Gm-Message-State: AOAM533usaRnhQaSaalwIJDRCuEvmOiI9yC2gWQM2XI2C6Qu61pZVkl3
        jrIo/LE8sf4o1kNjlqxZipQquA==
X-Google-Smtp-Source: ABdhPJxaKvPpL0rwdLNrB+ck47hYngpJ9D4J1RqIbGrDU+BZnsh9AH/S/PSgGf1teantMnWe2hZn8w==
X-Received: by 2002:a1c:2905:: with SMTP id p5mr17734071wmp.187.1601906526822;
        Mon, 05 Oct 2020 07:02:06 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id t15sm78967wrp.20.2020.10.05.07.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 07:02:05 -0700 (PDT)
Date:   Mon, 5 Oct 2020 16:02:03 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/14] drm/msm: Drop struct_mutex in shrinker path
Message-ID: <20201005140203.GS438822@phenom.ffwll.local>
Mail-Followup-To: Hillf Danton <hdanton@sina.com>,
        Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20201004192152.3298573-1-robdclark@gmail.com>
 <20201005092419.15608-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201005092419.15608-1-hdanton@sina.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 05, 2020 at 05:24:19PM +0800, Hillf Danton wrote:
> 
> On Sun,  4 Oct 2020 12:21:45
> > From: Rob Clark <robdclark@chromium.org>
> > 
> > Now that the inactive_list is protected by mm_lock, and everything
> > else on per-obj basis is protected by obj->lock, we no longer depend
> > on struct_mutex.
> > 
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > ---
> >  drivers/gpu/drm/msm/msm_gem.c          |  1 -
> >  drivers/gpu/drm/msm/msm_gem_shrinker.c | 54 --------------------------
> >  2 files changed, 55 deletions(-)
> > 
> [...]
> 
> > @@ -71,13 +33,8 @@ msm_gem_shrinker_scan(struct shrinker *shrinker, struct shrink_control *sc)
> >  {
> >  	struct msm_drm_private *priv =
> >  		container_of(shrinker, struct msm_drm_private, shrinker);
> > -	struct drm_device *dev = priv->dev;
> >  	struct msm_gem_object *msm_obj;
> >  	unsigned long freed = 0;
> > -	bool unlock;
> > -
> > -	if (!msm_gem_shrinker_lock(dev, &unlock))
> > -		return SHRINK_STOP;
> >  
> >  	mutex_lock(&priv->mm_lock);
> 
> Better if the change in behavior is documented that SHRINK_STOP will
> no longer be needed.

btw I read through this and noticed you have your own obj lock, plus
mutex_lock_nested. I strongly recommend to just cut over to dma_resv_lock
for all object lock needs (soc drivers have been terrible with this
unfortuntaly), and in the shrinker just use dma_resv_trylock instead of
trying to play clever games outsmarting lockdep.

I recently wrote an entire blog length rant on why I think
mutex_lock_nested is too dangerous to be useful:

https://blog.ffwll.ch/2020/08/lockdep-false-positives.html

Not anything about this here, just general comment. The problem extends to
shmem helpers and all that also having their own locks for everything.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
