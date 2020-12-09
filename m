Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4F22D37ED
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 01:45:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729907AbgLIApA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 19:45:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbgLIAo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 19:44:59 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7152DC061794
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 16:44:19 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id g25so29849wmh.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 16:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=WBbHO055TDdHkxOg7jOYFdPzCq3mNcsnhSnfew3Y1EY=;
        b=gkn9GnyQglKnUhjGGYCXIKsVi5wfV6l/qEI1a2+K2hvW+PzEBba0WRfUqG5WqleEHH
         rYvJAfFHvVA1vSFpUDhC9St39gWYoj9oFpMSVof8etKlbdIgrXP/Fe/VJAoTRe1NW53r
         oINMGfzdvTBk2+JPfj2iGvrr651ssjNGtsJy4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=WBbHO055TDdHkxOg7jOYFdPzCq3mNcsnhSnfew3Y1EY=;
        b=kCFKGyQvQMJgrIQFqrkMQxnkYW98U1rE7GFmikf7ACMuKl8rACQMsiXNtNEpuWOPc+
         EGBCXJ1K1oJs5pJoWRx4FVOMbFA4MQ7CdipTg7XtwW1GJLCf2SAq+YfEnEFgQtmUGADr
         eiB7GJRrdqaKbPe5+d97XsssJoLTG1xC7ktySy4vKuCqW36cGKY4LfBzTyi2gkz8I3bv
         SLH6ihwIpg58BpzhggZglA7TH0pby/FFIcZMaahoiqQtk9TnNzSQknoUIAmIiRMv9w9M
         oZ1Vw78ljCX5cJWLSBUTYMFCa1n60RAAscU3uNnXGbUba0JUt/w1+PRPv0kEXJMcX4qD
         WJcQ==
X-Gm-Message-State: AOAM533pMvHoEQe9rXZA3IeuovfurUCakefi5nJgmMnCuYEeGZKn3KY9
        rq0wh5QVdl/jtN+Qbs4MpXZOZYmvfA5JxQ==
X-Google-Smtp-Source: ABdhPJxLmZZZDr4AskPctoFwXO0CXDkm7krmiIzueb/sJB51n47BczDttWqZl8WpkJ2EVS9oYPgS8A==
X-Received: by 2002:a7b:c308:: with SMTP id k8mr44691wmj.76.1607474658253;
        Tue, 08 Dec 2020 16:44:18 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id 138sm37368wma.41.2020.12.08.16.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 16:44:17 -0800 (PST)
Date:   Wed, 9 Dec 2020 01:44:15 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Liu Ying <victor.liu@nxp.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, p.zabel@pengutronix.de,
        airlied@linux.ie, daniel@ffwll.ch, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, robh+dt@kernel.org,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, laurentiu.palcu@oss.nxp.com
Subject: Re: [PATCH v3 4/6] drm/atomic: Avoid unused-but-set-variable warning
 on for_each_old_plane_in_state
Message-ID: <20201209004415.GM401619@phenom.ffwll.local>
Mail-Followup-To: Liu Ying <victor.liu@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, p.zabel@pengutronix.de,
        airlied@linux.ie, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        robh+dt@kernel.org, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de,
        laurentiu.palcu@oss.nxp.com
References: <1607311260-13983-1-git-send-email-victor.liu@nxp.com>
 <1607311260-13983-5-git-send-email-victor.liu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1607311260-13983-5-git-send-email-victor.liu@nxp.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 07, 2020 at 11:20:58AM +0800, Liu Ying wrote:
> Artifically use 'plane' and 'old_plane_state' to avoid 'not used' warning.
> The precedent has already been set by other macros in the same file.
> 
> Signed-off-by: Liu Ying <victor.liu@nxp.com>

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

I'm assuming someone will push this to drm-misc or some other tree. Should
probably land sooner than later.
-Daniel

> ---
> v2->v3:
> * Add a missing blank line.
> 
> v1->v2:
> * No change.
> 
>  include/drm/drm_atomic.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
> index 54e051a..2e087d7 100644
> --- a/include/drm/drm_atomic.h
> +++ b/include/drm/drm_atomic.h
> @@ -888,7 +888,10 @@ void drm_state_dump(struct drm_device *dev, struct drm_printer *p);
>  	     (__i)++)							\
>  		for_each_if ((__state)->planes[__i].ptr &&		\
>  			     ((plane) = (__state)->planes[__i].ptr,	\
> -			      (old_plane_state) = (__state)->planes[__i].old_state, 1))
> +			      (void)(plane) /* Only to avoid unused-but-set-variable warning */, \
> +			      (old_plane_state) = (__state)->planes[__i].old_state, \
> +			      (void)(old_plane_state) /* Only to avoid unused-but-set-variable warning */, 1))
> +
>  /**
>   * for_each_new_plane_in_state - iterate over all planes in an atomic update
>   * @__state: &struct drm_atomic_state pointer
> -- 
> 2.7.4
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
