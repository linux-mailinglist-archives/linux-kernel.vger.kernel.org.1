Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1933B2A2811
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 11:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728465AbgKBKRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 05:17:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728132AbgKBKRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 05:17:30 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A764C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 02:17:28 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id n15so13925000wrq.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 02:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=5hSoUnmWrkIiPJtBur2bCaJkJBa+PcbPE5F/qKNSDyM=;
        b=Hbm0iIk5gdB9MgZjt+GPwBb0j9HoSSFSxRO8xqvyR0S0gyQ7etZZtcEpWTliJjXs/2
         KSQtIHuyQsaw/f2JT6c0QlC/y1wfBo2jcXZlMHJ2nmkVYpwJNbIWZDlqzJKRtGS7Vk0b
         4BJtj8uREqzMd09CLR8t2fyiM03WK3SgGCZlY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=5hSoUnmWrkIiPJtBur2bCaJkJBa+PcbPE5F/qKNSDyM=;
        b=BMsSIIH8u5EMIEUwQ92xDq/N/7+N2nWh1kZ2qKLJt0TBcTOPU7mxTGxyTARPYt/uP7
         1TU7UxJ0KlCCayMzHi1dGO22q4xb8QA4svtUINWJfv0xnPH1sfiGHd+Jt+o746gfXll7
         fmwKFdlN8pp6S4NixVwI6BUnDM7FXFerqPEScudnUh6DZ0xLbX0WLGUym1H/pWe95L/+
         Rbys92jPBQEbuKI8UAYfo19TsIJmg4kt0L7kPdad52YYEE5eJvZ7JlumaubSoy3e4eH6
         qiJv1az90DVhB70EE53G65EkwkCsupP1PbLEfk6X2hr8Kn+kB6UVQRa7O0QWUsiIPWlS
         Bcug==
X-Gm-Message-State: AOAM532s6h2ArZtE66z89MorAd7NO6z+9llSn2B9ddQiXrFCGD07LHXs
        /QpFoRJz8swBnGeVFpszLBx9zQ==
X-Google-Smtp-Source: ABdhPJwQMZvHwWKFlVeyO1nurWVIUzcbyGEq6qVyO4SdeqmbiIAn6Kkm37lB4XaCkCNv1schQER+Ew==
X-Received: by 2002:adf:dd89:: with SMTP id x9mr19144821wrl.284.1604312247227;
        Mon, 02 Nov 2020 02:17:27 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id j13sm22285058wru.86.2020.11.02.02.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 02:17:26 -0800 (PST)
Date:   Mon, 2 Nov 2020 11:17:24 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Bernard Zhao <bernard@vivo.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        opensource.kernel@vivo.com
Subject: Re: [PATCH] gpu/drm: make crtc check before new_connector circle
Message-ID: <20201102101724.GO401619@phenom.ffwll.local>
Mail-Followup-To: Bernard Zhao <bernard@vivo.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
References: <20201102025851.3613-1-bernard@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102025851.3613-1-bernard@vivo.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 01, 2020 at 06:58:51PM -0800, Bernard Zhao wrote:
> In function prepare_signaling, crtc check (c==0) is not related
> with the next new_connector circle, maybe we can put the crtc
> check just after the crtc circle and before new_connector circle.
> This change is to make the code to run a bit first.

I'm a bit confused here with your explanation, I'm not understanding why
you do this change ... Can you pls elaborate? Maybe give an example or
something of the problem this patch solves, that often helps.

Thanks, Daniel

> 
> Signed-off-by: Bernard Zhao <bernard@vivo.com>
> ---
>  drivers/gpu/drm/drm_atomic_uapi.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
> index 25c269bc4681..566110996474 100644
> --- a/drivers/gpu/drm/drm_atomic_uapi.c
> +++ b/drivers/gpu/drm/drm_atomic_uapi.c
> @@ -1182,6 +1182,12 @@ static int prepare_signaling(struct drm_device *dev,
>  
>  		c++;
>  	}
> +	/*
> +	 * Having this flag means user mode pends on event which will never
> +	 * reach due to lack of at least one CRTC for signaling
> +	 */
> +	if (c == 0 && (arg->flags & DRM_MODE_PAGE_FLIP_EVENT))
> +		return -EINVAL;
>  
>  	for_each_new_connector_in_state(state, conn, conn_state, i) {
>  		struct drm_writeback_connector *wb_conn;
> @@ -1220,13 +1226,6 @@ static int prepare_signaling(struct drm_device *dev,
>  		conn_state->writeback_job->out_fence = fence;
>  	}
>  
> -	/*
> -	 * Having this flag means user mode pends on event which will never
> -	 * reach due to lack of at least one CRTC for signaling
> -	 */
> -	if (c == 0 && (arg->flags & DRM_MODE_PAGE_FLIP_EVENT))
> -		return -EINVAL;
> -
>  	return 0;
>  }
>  
> -- 
> 2.29.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
