Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 146002B525A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 21:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732232AbgKPUUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 15:20:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbgKPUUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 15:20:00 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C587C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:20:00 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id m125so531074wmm.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iA5dlnSoNb3uY2ZyJuel3kYTh8E9e4NCsI1Von4rwMA=;
        b=g41vqogoXVnc/TjsoLfo5fHFZhbeZK7HACsF3AfFKsJ9umJ3ct8PGWivO4xuO6wNPO
         zhwL4+7pt5q4Z1JiznJZLMcgRlrJqpdwlITdb9RivVST3miOGPzSDkXS/SacL/JUh4LO
         ntSsFBya6HbQnpSmFmLtfNmpv/vtQDiDeX6wqLBqEdeJvOQnDzEGEmmEypnBrJc6GBSN
         qjDAzNrmL1+6hDtg3GOogiV8G9aklnOyeEQs0cE+cLgCu4AI/QjXSbaxK0CS+VQlmmqA
         SB1pXeTuOzUsy4SiVCt1G8p1JkkJNKi4evckukDZYyC73rZLsdFMcr7JOrHIigcKZbcx
         wnIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iA5dlnSoNb3uY2ZyJuel3kYTh8E9e4NCsI1Von4rwMA=;
        b=XWq0XB8x+mKrGRO6MrKMX/yYbosFGRDILwjwpJlGVRIGiZFmD6z53I7syXjVdz94xs
         MK4JNl2Yblkiq21Qs5pWID6+g3R/1aRT+dIpUB79UMMWwNni2IViYaglzLEu8zz2aQzq
         /XWgjxpIv3w00Zd6Zuhw7bgJK9Z+P9CeHwJ1w9A4zF1q0fMqIeZU4+M8ACnGoHMf4BEd
         PZfBgtpjCAIM7bX573mtshh+UvCD5FRX1JJiwv63SA3eBLtqcijYurVqCdcjJJvaDpVH
         1qCPPk+g6WSZREyC5xDU0f11yXi+RpXph4yExoN+NQQnVB/Q5piElur2szfuPdxXl/ON
         Y8eQ==
X-Gm-Message-State: AOAM531uvWL7xzIo5CRiKmVX7vvDaZrI2cpjsFqzJqqxpHFFzg4xHuT9
        Qf3NAP+NIzgAzIIYE2RApPbSL7xdLYI+E5sgMbbjbQCg
X-Google-Smtp-Source: ABdhPJxiy17mMdsqlfud+cq+tyycu+S0dU0362+y4CzP+m/8yq9B8aFtwH5zXLft48CsTrr7c8sPpzq/iu49bQ1PCSw=
X-Received: by 2002:a7b:c157:: with SMTP id z23mr644263wmi.70.1605557999351;
 Mon, 16 Nov 2020 12:19:59 -0800 (PST)
MIME-Version: 1.0
References: <20201116173700.1830487-1-lee.jones@linaro.org> <20201116173700.1830487-27-lee.jones@linaro.org>
In-Reply-To: <20201116173700.1830487-27-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 16 Nov 2020 15:19:48 -0500
Message-ID: <CADnq5_PaEEgG69pni8+z3CfpX2d1AOkPB3m4OXuAZ+EnU3sFXw@mail.gmail.com>
Subject: Re: [PATCH 26/43] drm/radeon/radeon_atombios: Move
 'radeon_add_atom_encoder()'s prototype to shared header
To:     Lee Jones <lee.jones@linaro.org>
Cc:     David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 12:38 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/radeon/atombios_encoders.c:2721:1: warning: no previous =
prototype for =E2=80=98radeon_add_atom_encoder=E2=80=99 [-Wmissing-prototyp=
es]
>  2721 | radeon_add_atom_encoder(struct drm_device *dev,
>  | ^~~~~~~~~~~~~~~~~~~~~~~
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/radeon/radeon_atombios.c | 4 ----
>  drivers/gpu/drm/radeon/radeon_atombios.h | 4 ++++
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_atombios.c b/drivers/gpu/drm/r=
adeon/radeon_atombios.c
> index cc80651b25773..be96d9b64e43b 100644
> --- a/drivers/gpu/drm/radeon/radeon_atombios.c
> +++ b/drivers/gpu/drm/radeon/radeon_atombios.c
> @@ -37,10 +37,6 @@
>  #include "radeon_atombios.h"
>  #include "radeon_legacy_encoders.h"
>
> -extern void
> -radeon_add_atom_encoder(struct drm_device *dev, uint32_t encoder_enum,
> -                       uint32_t supported_device, u16 caps);
> -
>  union atom_supported_devices {
>         struct _ATOM_SUPPORTED_DEVICES_INFO info;
>         struct _ATOM_SUPPORTED_DEVICES_INFO_2 info_2;
> diff --git a/drivers/gpu/drm/radeon/radeon_atombios.h b/drivers/gpu/drm/r=
adeon/radeon_atombios.h
> index b7c76920feb7d..a895a7002c3d3 100644
> --- a/drivers/gpu/drm/radeon/radeon_atombios.h
> +++ b/drivers/gpu/drm/radeon/radeon_atombios.h
> @@ -28,10 +28,14 @@
>  #ifndef __RADEON_ATOMBIOS_H__
>  #define __RADEON_ATOMBIOS_H__
>
> +struct drm_device;
>  struct drm_display_mode;
>  struct radeon_device;
>
>  bool radeon_atom_get_tv_timings(struct radeon_device *rdev, int index,
>                                 struct drm_display_mode *mode);
> +void radeon_add_atom_encoder(struct drm_device *dev, uint32_t encoder_en=
um,
> +                            uint32_t supported_device, u16 caps);
> +
>
>  #endif                         /* __RADEON_ATOMBIOS_H__ */
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
