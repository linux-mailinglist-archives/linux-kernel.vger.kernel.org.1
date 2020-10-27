Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2619629A977
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 11:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410423AbgJ0KW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 06:22:58 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:32978 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410017AbgJ0KW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 06:22:58 -0400
Received: by mail-wr1-f68.google.com with SMTP id b8so1276869wrn.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 03:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=kWfU0dsyfTV6Wn29xNZN4rB2izI9mNIuZ5x5HbFggb0=;
        b=TfOGSAIo690wcW1CPshgXsDVYR5lDSaWjS8jI2wLXZffUxp7+0vANRr2T3ro0ATwGe
         ttyqu6UNKdahyR70yZRCX2JEiCTn1X9YbHmksiOxYyA06n98V9UmrYRhyfVxiA8N1vBz
         4zhY6iT9jp/nTy9vfeFVzZMkdmw8S18gzJboU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=kWfU0dsyfTV6Wn29xNZN4rB2izI9mNIuZ5x5HbFggb0=;
        b=At6x20QqeXSlFl/J1NXzEdYSsBzwxvIrTk/phxrFW5G/CLdOPTAGDhpaq7PAsvZet8
         8itj3S5LYWxebfSA6x0+Kt8DlZoZ/dPGsRe4yU2Obg9WJAVVfjM/KR3DSrUD4gyY0Kta
         hiOl51gKLqTFx5EDF2gAWC8J3Olt/JEyQLC2P4VIN7Gk5DIbzMvED+p3Dv375bSuXl6j
         Di6xPEiJe8o31kYbz05Dlje2G6XhlmHJRVDXvx3ksTcNqIOA2XZE0Z7YWdL1VcnVd5Pn
         NbwkRWPFcH1OE/ac9zTD+LJ4vSOeXeFbG5EDdZZyR0ZZXp9NJ/nHFB3/cNIU7jFpcotG
         j31g==
X-Gm-Message-State: AOAM533mVrLNrjoDxWkP33R29CITXuBeq3g03+i0CNHUbaxPxawWfQiF
        f6xz9tSOCkAMuibkRALbKFEHlg==
X-Google-Smtp-Source: ABdhPJydcxVBv/ADPzNa2jJ5qOWXsDx1BNtlSbm3Tn+0CBzU5+ltuST+K2UUh6w1jxJ+OjkENwSVng==
X-Received: by 2002:a5d:4e48:: with SMTP id r8mr1880774wrt.141.1603794176106;
        Tue, 27 Oct 2020 03:22:56 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id h3sm1403110wrw.78.2020.10.27.03.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 03:22:55 -0700 (PDT)
Date:   Tue, 27 Oct 2020 11:22:53 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 31/32] drm: drm_print.h: fix kernel-doc markups
Message-ID: <20201027102253.GK401619@phenom.ffwll.local>
Mail-Followup-To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <cover.1603791716.git.mchehab+huawei@kernel.org>
 <5b76c5625709aaaa3abee98faa620b9f3d27ff85.1603791716.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b76c5625709aaaa3abee98faa620b9f3d27ff85.1603791716.git.mchehab+huawei@kernel.org>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 10:51:35AM +0100, Mauro Carvalho Chehab wrote:
> A kernel-doc markup should start with the identifier on its
> first line.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

I've merged all the drm patches, excluding the amdgpu ones, to
drm-misc-fixes. Should land in -rc2.

Thanks for doing these patches.
-Daniel

> ---
>  include/drm/drm_print.h | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
> index 1c9417430d08..f32d179e139d 100644
> --- a/include/drm/drm_print.h
> +++ b/include/drm/drm_print.h
> @@ -338,7 +338,7 @@ void drm_dev_dbg(const struct device *dev, enum drm_debug_category category,
>  		 const char *format, ...);
>  
>  /**
> - * Error output.
> + * DRM_DEV_ERROR() - Error output.
>   *
>   * @dev: device pointer
>   * @fmt: printf() like format string.
> @@ -347,10 +347,12 @@ void drm_dev_dbg(const struct device *dev, enum drm_debug_category category,
>  	drm_dev_printk(dev, KERN_ERR, "*ERROR* " fmt, ##__VA_ARGS__)
>  
>  /**
> - * Rate limited error output.  Like DRM_ERROR() but won't flood the log.
> + * DRM_DEV_ERROR_RATELIMITED() - Rate limited error output.
>   *
>   * @dev: device pointer
>   * @fmt: printf() like format string.
> + *
> + * Like DRM_ERROR() but won't flood the log.
>   */
>  #define DRM_DEV_ERROR_RATELIMITED(dev, fmt, ...)			\
>  ({									\
> @@ -375,15 +377,27 @@ void drm_dev_dbg(const struct device *dev, enum drm_debug_category category,
>  })
>  
>  /**
> - * Debug output.
> + * DRM_DEV_DEBUG() - Debug output for generic drm code
>   *
>   * @dev: device pointer
>   * @fmt: printf() like format string.
>   */
>  #define DRM_DEV_DEBUG(dev, fmt, ...)					\
>  	drm_dev_dbg(dev, DRM_UT_CORE, fmt, ##__VA_ARGS__)
> +/**
> + * DRM_DEV_DEBUG_DRIVER() - Debug output for vendor specific part of the driver
> + *
> + * @dev: device pointer
> + * @fmt: printf() like format string.
> + */
>  #define DRM_DEV_DEBUG_DRIVER(dev, fmt, ...)				\
>  	drm_dev_dbg(dev, DRM_UT_DRIVER,	fmt, ##__VA_ARGS__)
> +/**
> + * DRM_DEV_DEBUG_KMS() - Debug output for modesetting code
> + *
> + * @dev: device pointer
> + * @fmt: printf() like format string.
> + */
>  #define DRM_DEV_DEBUG_KMS(dev, fmt, ...)				\
>  	drm_dev_dbg(dev, DRM_UT_KMS, fmt, ##__VA_ARGS__)
>  
> -- 
> 2.26.2
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
