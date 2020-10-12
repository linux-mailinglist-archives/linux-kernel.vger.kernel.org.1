Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDE4028BAFB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 16:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729890AbgJLOkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 10:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728800AbgJLOkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 10:40:22 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12446C0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 07:40:22 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id k18so17778169wmj.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 07:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=Sgxu8pwzEMgUUbjWBDrQW3ILYSpl7WdZp96R0DhO5Mc=;
        b=XI3dCFkFiN+2pFpXGzPmSIRwuJuDv/y/2G9Cj9dJ5EghRoEEVwApSzVYeCtJxffgn5
         skL+vGIevqPHDkBJSkAmpM2A1fHP5B8RcTb8FrQ1CweEk8h/tiOQmT7bbDlKQbpo7hXP
         ndmRWBk0diEt7ZiV4Hc+RQVD5RBiDSm7v5vA0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=Sgxu8pwzEMgUUbjWBDrQW3ILYSpl7WdZp96R0DhO5Mc=;
        b=jsJNjPETmcaJg6JH7+ibuHzkFCYQy7CSFlK7iA74+hAB/E/em16s0h0aEYz4PrtJ7Z
         hd5Wx3VTj2JLmOXdTpMlTGbcuUSccH1lY1gOF3ygmMJwZ1GYFvcgsv+niaeVmXge1QAf
         6CkdyfZKLyKSBfBl2adwqFATH4LgzCgefu/LynFQse9YzV0waB7uf+VkmgLg8BNG408+
         qLzj+hF3dCyark3GbcZHIHXd7h8c+UD/VPzzNfQydT4J8qlUUGDtr3730ERDosw21kDn
         UqVJNynQwU/hy971plRV/2/oqvHQ/4JLdwvZrfSUVAOHjqrKJKs0t5HIsMehYmRma52T
         91lA==
X-Gm-Message-State: AOAM5305YpZpe2W8bOSJF3ED3ZL423EOYsy5S5VhdOy25nEvawBVjTqG
        A5Rh5CD4DDcumgXEQP1wRU4tn+4ee8BqGSTw
X-Google-Smtp-Source: ABdhPJxtuGldLayKaoOLNdhPXiIp8BIJ4bsOKgdiv6Dh9nEH8u2gHnOAjBdyITgyL7C1levJe7WYXg==
X-Received: by 2002:a1c:8056:: with SMTP id b83mr11077306wmd.124.1602513620761;
        Mon, 12 Oct 2020 07:40:20 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id v4sm23467980wmg.35.2020.10.12.07.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 07:40:20 -0700 (PDT)
Date:   Mon, 12 Oct 2020 16:40:18 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@chromium.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <freedreno@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 22/22] drm/msm: Don't implicit-sync if only a single
 ring
Message-ID: <20201012144018.GB438822@phenom.ffwll.local>
Mail-Followup-To: Rob Clark <robdclark@gmail.com>,
        dri-devel@lists.freedesktop.org, Rob Clark <robdclark@chromium.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" <linux-arm-msm@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" <freedreno@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20201012020958.229288-1-robdclark@gmail.com>
 <20201012020958.229288-23-robdclark@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201012020958.229288-23-robdclark@gmail.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 11, 2020 at 07:09:49PM -0700, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> Any cross-device sync use-cases *must* use explicit sync.  And if there
> is only a single ring (no-preemption), everything is FIFO order and
> there is no need to implicit-sync.
> 
> Mesa should probably just always use MSM_SUBMIT_NO_IMPLICIT, as behavior
> is undefined when fences are not used to synchronize buffer usage across
> contexts (which is the only case where multiple different priority rings
> could come into play).

Uh does this mean msm is broken on dri2/3 and wayland? Or I'm I just
confused by your commit message?

Since for these protocols we do expect implicit sync accross processes to
work. Even across devices (and nvidia have actually provided quite a bunch
of patches to make this work in i915 - ttm based drivers get this right,
plus dumb scanout drivers using the right helpers also get this all
right).
-Daniel

> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/gpu/drm/msm/msm_gem_submit.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
> index 3151a0ca8904..c69803ea53c8 100644
> --- a/drivers/gpu/drm/msm/msm_gem_submit.c
> +++ b/drivers/gpu/drm/msm/msm_gem_submit.c
> @@ -277,7 +277,7 @@ static int submit_lock_objects(struct msm_gem_submit *submit)
>  	return ret;
>  }
>  
> -static int submit_fence_sync(struct msm_gem_submit *submit, bool no_implicit)
> +static int submit_fence_sync(struct msm_gem_submit *submit, bool implicit_sync)
>  {
>  	int i, ret = 0;
>  
> @@ -297,7 +297,7 @@ static int submit_fence_sync(struct msm_gem_submit *submit, bool no_implicit)
>  				return ret;
>  		}
>  
> -		if (no_implicit)
> +		if (!implicit_sync)
>  			continue;
>  
>  		ret = msm_gem_sync_object(&msm_obj->base, submit->ring->fctx,
> @@ -768,7 +768,8 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
>  	if (ret)
>  		goto out;
>  
> -	ret = submit_fence_sync(submit, !!(args->flags & MSM_SUBMIT_NO_IMPLICIT));
> +	ret = submit_fence_sync(submit, (gpu->nr_rings > 1) &&
> +			!(args->flags & MSM_SUBMIT_NO_IMPLICIT));
>  	if (ret)
>  		goto out;
>  
> -- 
> 2.26.2
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
