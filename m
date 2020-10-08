Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E56FA2879CC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 18:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730767AbgJHQO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 12:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728356AbgJHQO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 12:14:58 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD32CC061755
        for <linux-kernel@vger.kernel.org>; Thu,  8 Oct 2020 09:14:57 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id j2so7254176wrx.7
        for <linux-kernel@vger.kernel.org>; Thu, 08 Oct 2020 09:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=zXsct4aKUk5X9x91oDjSC7XjSSOkkDL4HLgLLcBeuwk=;
        b=ZOE66C1eXbIHfFLdjfwJbbm0fEF4D4SI45c0DVg/6dGD0B0R3EM3tEToOdAs7Jugnf
         3TTNgwpiWetXKWTn1RxwJFrgPIbWxNmQODK9aFEP0j+JneESDiSh2AN2hEAPXvg5wWzd
         i0z8G/ou/4LiLSYy904rlvvuqHiinMyYNT7XQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=zXsct4aKUk5X9x91oDjSC7XjSSOkkDL4HLgLLcBeuwk=;
        b=YPolFqJ7xUzL4Bwv7U8NcP9r/JTeATzwOmX8vfHERiGUtZrYmyp75HcKvXxCL2/843
         //4tx5Y0GK99aks2rVowvlhp53WeTy64eB4eS2gpv+bNXOgU8xjrUQYV8s+CItaZCWPc
         HDJ+xVrlnnNPkaQIAl2TOHjnLQ3qszYOyIGgy1lHhBbIIPICC8pb3JyLQwZmVGlZxGOy
         YcSpGrnXN/Ss81oqsIUHDn1ytdk+r4G4H4eTYCh8KRLHSXeL1nZrLz8L6ZCObROdFMZY
         H91VDOaCn1CLLCVZMckdd1IQdanDxO+N4M8SkXJ43nzTshANkSwrJ8LPTTq+RyRIdN8n
         NQmg==
X-Gm-Message-State: AOAM533+WgQBj06eK8Pfb1EJ4xUsdC3VJaSgc6Nwho24PSHjD6B2SEl5
        7N1HiTAm36IuHkHp+f48JvabDg==
X-Google-Smtp-Source: ABdhPJyvR2Wn8XzkW+mXGG92a58Zke6WRoDiWZI9CSZaD8/g3MWjYLRUK8RxxoqKy41YVhWvv7PJUQ==
X-Received: by 2002:a05:6000:1084:: with SMTP id y4mr9700595wrw.138.1602173696347;
        Thu, 08 Oct 2020 09:14:56 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id f14sm8609336wrt.53.2020.10.08.09.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 09:14:55 -0700 (PDT)
Date:   Thu, 8 Oct 2020 18:14:53 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Matteo Franchin <matteo.franchin@arm.com>
Cc:     dri-devel@lists.freedesktop.org, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, airlied@linux.ie,
        daniel@ffwll.ch, brian.starkey@arm.com, liviu.dudau@arm.com,
        linux-kernel@vger.kernel.org, nd@arm.com
Subject: Re: [PATCH v2] drm/fourcc: Add AXBXGXRX106106106106 format
Message-ID: <20201008161453.GI438822@phenom.ffwll.local>
Mail-Followup-To: Matteo Franchin <matteo.franchin@arm.com>,
        dri-devel@lists.freedesktop.org, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, airlied@linux.ie,
        brian.starkey@arm.com, liviu.dudau@arm.com,
        linux-kernel@vger.kernel.org, nd@arm.com
References: <20201008143350.5306-1-matteo.franchin@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201008143350.5306-1-matteo.franchin@arm.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 08, 2020 at 03:33:50PM +0100, Matteo Franchin wrote:
> Add ABGR format with 10-bit components packed in 64-bit per pixel.
> This format can be used to handle
> VK_FORMAT_R10X6G10X6B10X6A10X6_UNORM_4PACK16 on little-endian
> architectures.
> 
> Signed-off-by: Matteo Franchin <matteo.franchin@arm.com>

Ok so 0xff and 0xfb for a true 16bit format have a slight difference,
whereas for this truncated format they're both max brightness. So yeah
there's a difference and I guess we need to add this.

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  drivers/gpu/drm/drm_fourcc.c  | 1 +
>  include/uapi/drm/drm_fourcc.h | 6 ++++++
>  2 files changed, 7 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/drm_fourcc.c
> index 722c7ebe4e88..03262472059c 100644
> --- a/drivers/gpu/drm/drm_fourcc.c
> +++ b/drivers/gpu/drm/drm_fourcc.c
> @@ -202,6 +202,7 @@ const struct drm_format_info *__drm_format_info(u32 format)
>  		{ .format = DRM_FORMAT_XBGR16161616F,	.depth = 0,  .num_planes = 1, .cpp = { 8, 0, 0 }, .hsub = 1, .vsub = 1 },
>  		{ .format = DRM_FORMAT_ARGB16161616F,	.depth = 0,  .num_planes = 1, .cpp = { 8, 0, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
>  		{ .format = DRM_FORMAT_ABGR16161616F,	.depth = 0,  .num_planes = 1, .cpp = { 8, 0, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
> +		{ .format = DRM_FORMAT_AXBXGXRX106106106106, .depth = 0, .num_planes = 1, .cpp = { 8, 0, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
>  		{ .format = DRM_FORMAT_RGB888_A8,	.depth = 32, .num_planes = 2, .cpp = { 3, 1, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
>  		{ .format = DRM_FORMAT_BGR888_A8,	.depth = 32, .num_planes = 2, .cpp = { 3, 1, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
>  		{ .format = DRM_FORMAT_XRGB8888_A8,	.depth = 32, .num_planes = 2, .cpp = { 4, 1, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
> diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
> index 82f327801267..9374d9558493 100644
> --- a/include/uapi/drm/drm_fourcc.h
> +++ b/include/uapi/drm/drm_fourcc.h
> @@ -155,6 +155,12 @@ extern "C" {
>  #define DRM_FORMAT_ARGB16161616F fourcc_code('A', 'R', '4', 'H') /* [63:0] A:R:G:B 16:16:16:16 little endian */
>  #define DRM_FORMAT_ABGR16161616F fourcc_code('A', 'B', '4', 'H') /* [63:0] A:B:G:R 16:16:16:16 little endian */
>  
> +/*
> + * RGBA format with 10-bit components packed in 64-bit per pixel, with 6 bits
> + * of unused padding per component:
> + */
> +#define DRM_FORMAT_AXBXGXRX106106106106 fourcc_code('A', 'B', '1', '0') /* [63:0] A:x:B:x:G:x:R:x 10:6:10:6:10:6:10:6 little endian */
> +
>  /* packed YCbCr */
>  #define DRM_FORMAT_YUYV		fourcc_code('Y', 'U', 'Y', 'V') /* [31:0] Cr0:Y1:Cb0:Y0 8:8:8:8 little endian */
>  #define DRM_FORMAT_YVYU		fourcc_code('Y', 'V', 'Y', 'U') /* [31:0] Cb0:Y1:Cr0:Y0 8:8:8:8 little endian */
> -- 
> 2.17.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
