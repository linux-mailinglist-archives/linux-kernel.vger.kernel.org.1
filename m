Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDEC126DA8A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 13:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgIQLml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 07:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbgIQLjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 07:39:44 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73CDAC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 04:39:39 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id t10so1712222wrv.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 04:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=KdFRPp8G7Pc9SANwQvVH7RQh6a6fZvMww6ZKYFFkVQY=;
        b=lHcbmlaLVlPUVyyMuL4iwsSq8Ccq7spAK6UKimuI1yegpPn0s1GjfbR9AkCnZiGdM0
         599RO5gGKhOGacOuqHDQ/uAW+XC6uEtHQBLSU7t3oYlP+IeIL73Gg/B5d9CxX0APH/02
         DlzcwyiEEJWV/ZvC3Dp3Z8aDR+JhWdb/p0egI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=KdFRPp8G7Pc9SANwQvVH7RQh6a6fZvMww6ZKYFFkVQY=;
        b=Nwpy2mnpagYzV1yASGl6vFuN0M97De451pHWm9e9e6kdKmrkCBZWaYq+KM7hwXT4j5
         5l655qPze7dJsq76zFx+TLEYMnaGAO9X3t6u1QgqeoZUNXheGi3kZS2kzRHSy8LT6V2D
         cXijzikBS/+xrP7BgriMwDeVt3SRZ3Ciqn1TRmgTD2XEaIeWJRHi+4TOGjKGwDXToyCm
         2OK+5FgJzQVSXvVCpVgJxulR30PXuOipzsI8KtB0gJCSYagMQr3Z66lPQmUgUWTKd30H
         bKzUwfeT8wfyfv7OJ02GSGqyjiqQI2AIEN4zc9ZK5SvJ9aOQHFUcC1HVO/dEiF7Z3UyZ
         jNwg==
X-Gm-Message-State: AOAM531I611w11l65o0gIoM/acULA5hgTeV9o9R6yxgawwZtW0hrcFKx
        j1h4VmuZoJ35Td3LvLVcz7pnomjiJmeIJtUT
X-Google-Smtp-Source: ABdhPJyaII+8Is2mvRxKGZmyejd6O40gRKrgf+kBPOVDl57wSAqMifjNZaFkSV15TYfCxkEYc6WMIw==
X-Received: by 2002:a5d:40c4:: with SMTP id b4mr28769336wrq.151.1600342778142;
        Thu, 17 Sep 2020 04:39:38 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id m13sm36802384wrr.74.2020.09.17.04.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 04:39:37 -0700 (PDT)
Date:   Thu, 17 Sep 2020 13:39:35 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Wang Qing <wangqing@vivo.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: fix spelling error in comments
Message-ID: <20200917113935.GU438822@phenom.ffwll.local>
Mail-Followup-To: Wang Qing <wangqing@vivo.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <1600308275-32094-1-git-send-email-wangqing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1600308275-32094-1-git-send-email-wangqing@vivo.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 10:04:32AM +0800, Wang Qing wrote:
> Change the comment typo: "manger" -> "manager".
> 
> Signed-off-by: Wang Qing <wangqing@vivo.com>

Pushed to drm-misc-next, thanks for your patch.
-Daniel

> ---
>  include/drm/drm_mm.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/drm/drm_mm.h b/include/drm/drm_mm.h
> index a01bc6f..9b4292f
> --- a/include/drm/drm_mm.h
> +++ b/include/drm/drm_mm.h
> @@ -338,7 +338,7 @@ static inline u64 drm_mm_hole_node_end(const struct drm_mm_node *hole_node)
>  
>  /**
>   * drm_mm_nodes - list of nodes under the drm_mm range manager
> - * @mm: the struct drm_mm range manger
> + * @mm: the struct drm_mm range manager
>   *
>   * As the drm_mm range manager hides its node_list deep with its
>   * structure, extracting it looks painful and repetitive. This is
> -- 
> 2.7.4
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
