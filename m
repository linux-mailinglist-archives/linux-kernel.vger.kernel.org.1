Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55D79285C6A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 12:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbgJGKGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 06:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727908AbgJGKGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 06:06:45 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5BB5C061755
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 03:06:45 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id f10so1663559otb.6
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 03:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FXyl0UgurwxyLuUIkQMCFeSWyFvGgXaLaSwzkPaBkpk=;
        b=R9tD3DdCMSZDZ5WwC/5gIKKZndNXWY6OZjNWoxwCaCIa3UbGwGd4/OR5cFtRIV+Hf4
         G47QhxXTI/FiaUusw2qLpB5eQAKol2Yo2E/Xn9o9NDt+7+zpeB1c9SrSq8Ad4I0G3wDg
         8Lekzp2kNtZlRHFaqOYDIsP385qmpf6cMsfqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FXyl0UgurwxyLuUIkQMCFeSWyFvGgXaLaSwzkPaBkpk=;
        b=Fri4DB2vWAhcdr1Z1goPGKtGrN0UuDbdCZwHWPFjMUnQXF2PWvXtFWaZlhLdgQkKAU
         1tIthC1TjpfstiiKzGo3bw1zfnj4biG0PtZnPSTixtNYrMbQ2mQ2xpfvCMP/SXfpSMBb
         v0LLeTEwm/678vYuu1WvX2GmgSUNvzzhnWD3Ta9oJmqMtc/tRQCXGLg5v1R89dTtsXM2
         rVAubcGQrFd/d4wueAYc4HtUb6dveocYRiL71GLteiha01uJZwBZvfj+a7JeXwRYmZig
         4D+hbiTEvCmwc5rO5pRRvSVwpSzlQnwaaN1S46js/oK5d6LC12pUcB/Ead95djeuwiZY
         8YgA==
X-Gm-Message-State: AOAM533UmjBPhhxN3ZQSa+QB8cEUc2qWX0gplbKxY8mb6SGGku7Lp0Eg
        /EgnoMcuzpArCfA+9oE0QLotNR//zHPHbyy3qXqHVg==
X-Google-Smtp-Source: ABdhPJyTcsoFNvuCh/cejrXxOixaiBBuesPOk0gqUkmdbG5dVwok3f70fWkkCBRI3SLyoPEuoAzRGQ9NuOx+3m2aKn8=
X-Received: by 2002:a05:6830:1e56:: with SMTP id e22mr1314124otj.303.1602065205130;
 Wed, 07 Oct 2020 03:06:45 -0700 (PDT)
MIME-Version: 1.0
References: <20201007092725.13300-1-matteo.franchin@arm.com>
In-Reply-To: <20201007092725.13300-1-matteo.franchin@arm.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 7 Oct 2020 12:06:34 +0200
Message-ID: <CAKMK7uHZs7uKMbbQhn43-u7Y3_KANA6tU25jnOZkzj3h_7dmgg@mail.gmail.com>
Subject: Re: [PATCH] drm/fourcc: Add AXBXGXRX106106106106 format
To:     Matteo Franchin <matteo.franchin@arm.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Dave Airlie <airlied@linux.ie>,
        Brian Starkey <brian.starkey@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 7, 2020 at 11:29 AM Matteo Franchin <matteo.franchin@arm.com> wrote:
>
> Add ABGR format with 10-bit components packed in 64-bit per pixel.
> This format can be used to handle
> VK_FORMAT_R10X6G10X6B10X6A10X6_UNORM_4PACK16 on little-endian
> architectures.
>
> Signed-off-by: Matteo Franchin <matteo.franchin@arm.com>

So is this essentially 16 bit, with the lowest 6 bits in each channel
ignored? What exactly is this used for where the full 16bit format
doesn't work?
-Daniel

> ---
>  drivers/gpu/drm/drm_fourcc.c  | 1 +
>  include/uapi/drm/drm_fourcc.h | 7 +++++++
>  2 files changed, 8 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/drm_fourcc.c
> index 722c7ebe4e88..bba03fcb016d 100644
> --- a/drivers/gpu/drm/drm_fourcc.c
> +++ b/drivers/gpu/drm/drm_fourcc.c
> @@ -202,6 +202,7 @@ const struct drm_format_info *__drm_format_info(u32 format)
>                 { .format = DRM_FORMAT_XBGR16161616F,   .depth = 0,  .num_planes = 1, .cpp = { 8, 0, 0 }, .hsub = 1, .vsub = 1 },
>                 { .format = DRM_FORMAT_ARGB16161616F,   .depth = 0,  .num_planes = 1, .cpp = { 8, 0, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
>                 { .format = DRM_FORMAT_ABGR16161616F,   .depth = 0,  .num_planes = 1, .cpp = { 8, 0, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
> +               { .format = DRM_FORMAT_AXBXGXRX106106106106,    .depth = 0,  .num_planes = 1, .cpp = { 8, 0, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
>                 { .format = DRM_FORMAT_RGB888_A8,       .depth = 32, .num_planes = 2, .cpp = { 3, 1, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
>                 { .format = DRM_FORMAT_BGR888_A8,       .depth = 32, .num_planes = 2, .cpp = { 3, 1, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
>                 { .format = DRM_FORMAT_XRGB8888_A8,     .depth = 32, .num_planes = 2, .cpp = { 4, 1, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
> diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
> index 82f327801267..76eedba52b77 100644
> --- a/include/uapi/drm/drm_fourcc.h
> +++ b/include/uapi/drm/drm_fourcc.h
> @@ -155,6 +155,13 @@ extern "C" {
>  #define DRM_FORMAT_ARGB16161616F fourcc_code('A', 'R', '4', 'H') /* [63:0] A:R:G:B 16:16:16:16 little endian */
>  #define DRM_FORMAT_ABGR16161616F fourcc_code('A', 'B', '4', 'H') /* [63:0] A:B:G:R 16:16:16:16 little endian */
>
> +/*
> + * RGBA format with 10-bit components packed in 64-bit per pixel, with 6 bits
> + * of unused padding per component:
> + * [63:0] A:x:B:x:G:x:R:x 10:6:10:6:10:6:10:6 little endian
> + */
> +#define DRM_FORMAT_AXBXGXRX106106106106 fourcc_code('A', 'B', '1', '0')
> +
>  /* packed YCbCr */
>  #define DRM_FORMAT_YUYV                fourcc_code('Y', 'U', 'Y', 'V') /* [31:0] Cr0:Y1:Cb0:Y0 8:8:8:8 little endian */
>  #define DRM_FORMAT_YVYU                fourcc_code('Y', 'V', 'Y', 'U') /* [31:0] Cb0:Y1:Cr0:Y0 8:8:8:8 little endian */
> --
> 2.17.1
>


-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
