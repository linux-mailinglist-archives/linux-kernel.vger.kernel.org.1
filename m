Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 201D52FB8BF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 15:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405785AbhASNmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 08:42:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394318AbhASNhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 08:37:04 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C41C061573
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 05:36:09 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id i63so16489284wma.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 05:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=BKE9rDCIZOyErbmD+LY8/lgohFsufzeQzYye47k5eNU=;
        b=egv6CMm37ZE+aKLxMF65Ny/Cl+fogEW2LevhAiKiW/O889Pk6EHklNv2bNIYmFVsIB
         Ne/OSh7TUc/Lyk+6ebECYQxfFVVAsBsej2T/Mwa6/nCntzuaSw/ESTi+dqxzx+kxoFes
         moh5mGe1CceubqiTlWtQSFUO4b1ZWz0th5PfI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=BKE9rDCIZOyErbmD+LY8/lgohFsufzeQzYye47k5eNU=;
        b=HOzxRlPK87O3P23Ko5u9h1aMGKuThzQdCw3JQ7+O7SiXywGl8cVjMlH1A2hRL/GpCd
         vlgcIN71NjYI0yniEBOq/5I3bMJQvUUkGH76yl/Ow6xWeZ1b7S5EgUYs4upxbQ6VSKHC
         S2wtXJ3Q4CD4nA0dLcNOXwZjf/TmarFN9vnENa5g0CvF4ZTc35lDnsFvohiwpi7lAKVe
         T3LKdGHSaztio+GHSCjrL5DRvy+pgxCvs9G2T4bI6ZpLKkFcaCAOdnToNZFHFda0qHTw
         6zExIe6BadY1gjT9Q5zgun8a9Ky3DB0QuXVpGcSFpR/FLZhkQUkSOFwlrASKOHpNQJyA
         D/Tg==
X-Gm-Message-State: AOAM532i0KgpaH5UcHAXse0D4H3uTMLLLeFGkt13xZ4mkJbqR3mxKS2E
        UACo39p2eEmFKqRogdBrwdig9w==
X-Google-Smtp-Source: ABdhPJyxDhcjnIHo3Tv3lCkHjxbnmQ7vqX17dXcXNooyWX343UJoOqqngbbVLYY4daSVAO/uCH3Ayw==
X-Received: by 2002:a1c:7c06:: with SMTP id x6mr4124710wmc.67.1611063368009;
        Tue, 19 Jan 2021 05:36:08 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id m12sm4581831wmc.10.2021.01.19.05.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 05:36:07 -0800 (PST)
Date:   Tue, 19 Jan 2021 14:36:05 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Pan Bian <bianpan2016@163.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sean Paul <seanpaul@chromium.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] drm/atomic: put state on error path
Message-ID: <YAbgRbyeN2QUWKJr@phenom.ffwll.local>
Mail-Followup-To: Pan Bian <bianpan2016@163.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>, Sean Paul <seanpaul@chromium.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20210119121127.84127-1-bianpan2016@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210119121127.84127-1-bianpan2016@163.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 19, 2021 at 04:11:27AM -0800, Pan Bian wrote:
> Put the state before returning error code.
> 
> Fixes: 44596b8c4750 ("drm/atomic: Unify conflicting encoder handling.")
> 
> Signed-off-by: Pan Bian <bianpan2016@163.com>

Nice catch, patch merged to drm-misc-fixes with cc: stable.
-Daniel

> ---
>  drivers/gpu/drm/drm_atomic_helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
> index ba1507036f26..4a8cbec832bc 100644
> --- a/drivers/gpu/drm/drm_atomic_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_helper.c
> @@ -3021,7 +3021,7 @@ int drm_atomic_helper_set_config(struct drm_mode_set *set,
>  
>  	ret = handle_conflicting_encoders(state, true);
>  	if (ret)
> -		return ret;
> +		goto fail;
>  
>  	ret = drm_atomic_commit(state);
>  
> -- 
> 2.17.1
> 
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
