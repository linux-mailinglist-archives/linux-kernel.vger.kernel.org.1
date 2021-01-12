Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 979CF2F2A6A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 09:58:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389001AbhALI5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 03:57:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732350AbhALI5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 03:57:25 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F66C061786
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 00:56:44 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id y17so1563033wrr.10
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 00:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=gg3b4S3+NvBTyr0GUYFPJqJgJwEUKIraiC/Q4OrzhDU=;
        b=kV8jbVHGZ83kAA2ockVKP3nZ5skWlkzOniECMv+Rr/OaHN1qkfgvADTHs23Z849hPg
         cfxkiQwka5IjJInacK/GqMNA1rjVXxZhD5+JfCl8dSj1nLGSd6U9wAqRMJjtA6dgfOa+
         b/jSWh3tzjAmeno4fLk642Ita4/dgb+Vy3bTg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=gg3b4S3+NvBTyr0GUYFPJqJgJwEUKIraiC/Q4OrzhDU=;
        b=O0kqnNlchHJ9ZBOjIUxdmt8Zbmm/htFecLDgPSZAV/EQi/s06wthPNIhCmaPNgWIMH
         0BIrTxiAI9Z0qWXn13YCTWiITaNwKBHUrPwFq8+ABrxH0R2JDQFellSHXAtXG8wkKB6B
         p8VLGmF9oiCl46tlorNCef7CrQoT6fx1wWY/V2xp2iKAryP8vOR43IWMb9wd0H1lhOox
         CpAWBp4invlG6eqOaYBeI1ojm8R/3UzCLS4vyfEoDP39OXlpvN/Ck1WCNzBaMOcsdu/X
         lRuxDVMoRfdCeZOg1BBDB4+HQFOK/n+7iohppVRN4S7FKoQa+mUPpDV0Y1/SvlpEucgL
         2N+w==
X-Gm-Message-State: AOAM532cskPxHf/XVIwsILpS6GuB+eT8B6MopBbm6DC9N10iYK0gKesz
        KJ2jt7bruZLpZUGyJq+JuE5id4xQDNNiQPLk
X-Google-Smtp-Source: ABdhPJz94xA5LyGQws93JRw6mmTqO9rvy26w4v3WTl1SAD+5pg6u83ZfeyEgolrvXRuDnKy0SDb+Qw==
X-Received: by 2002:adf:e60f:: with SMTP id p15mr3112146wrm.60.1610441803328;
        Tue, 12 Jan 2021 00:56:43 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id o23sm4068104wro.57.2021.01.12.00.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 00:56:42 -0800 (PST)
Date:   Tue, 12 Jan 2021 09:56:40 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Zhaoge Zhang <zhangzhaoge@loongson.cn>
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: Fix macro name DRM_MODE_PROP_OBJECT in code comment
Message-ID: <X/1kSJ/y+5BIotd4@phenom.ffwll.local>
Mail-Followup-To: Zhaoge Zhang <zhangzhaoge@loongson.cn>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <1610416479-32736-1-git-send-email-zhangzhaoge@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1610416479-32736-1-git-send-email-zhangzhaoge@loongson.cn>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 09:54:39AM +0800, Zhaoge Zhang wrote:
> Signed-off-by: Zhaoge Zhang <zhangzhaoge@loongson.cn>
> ---
>  include/drm/drm_property.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/drm/drm_property.h b/include/drm/drm_property.h
> index 4a0a80d..bbf5c1fd 100644
> --- a/include/drm/drm_property.h
> +++ b/include/drm/drm_property.h
> @@ -114,7 +114,7 @@ struct drm_property {
>  	 *     by the property. Bitmask properties are created using
>  	 *     drm_property_create_bitmask().
>  	 *
> -	 * DRM_MODE_PROB_OBJECT
> +	 * DRM_MODE_PROP_OBJECT

Nice catch, merged to drm-misc-next, thanks for your patch.
-Daniel

>  	 *     Object properties are used to link modeset objects. This is used
>  	 *     extensively in the atomic support to create the display pipeline,
>  	 *     by linking &drm_framebuffer to &drm_plane, &drm_plane to
> -- 
> 2.7.4
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
