Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70F1E2C9393
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 01:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730866AbgLAADa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 19:03:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbgLAADa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 19:03:30 -0500
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EEF0C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 16:02:44 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id f16so13117065otl.11
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 16:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=K/9NUHkJty1ovLR+EfZmMVNsAinmnqg1MiYad0AFs6s=;
        b=RaRFmByruZ8FV7wlqHl1H8uwNDlL6Ks/8bAHzq5xOWJCD8e9ehAinGROIYEjswXxUc
         pkULXah4E7Ba0XEApCjgZvfna4bCtcajYclcDgPRE/bueGd+Etkta/zE5xBjMNHt1eMw
         nml5UvH9hDaOkaEXXJG4qTLIKLosZ3yMzd6cW8fTEc3FrDNtXytTuNPcSFgmuo4xpEIF
         S8IzjK+kIg6wZl/S2s94mZv+cV1mqL2d2Q4iwa/bN2hgmYOcurA/VV3uIqUnGCFODBC6
         uIFQGAVbxgMqYryN6/hukJzH8tdixBPNPLgPKVXWl9TKAhYr5OziYJRHuoAsKXOg32ZP
         zLVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=K/9NUHkJty1ovLR+EfZmMVNsAinmnqg1MiYad0AFs6s=;
        b=sKP+952K6qDFa0MRADHd1o1ZdI651I126yeTnD/HaOB5yaRMF5wX2azWOjkqwsA5B9
         XYfhf4I737joLlwXbBVTDAS7dtZku7G5+lXoE02JNQTzXLerXdsnIrlOVdT80Sv+lBd9
         9LXBpGE85e10j79k7MJ2Cxvm8dicPmMyrAwbte9JbnsQFXNpNVUUPgpypUS9Ymamj2tC
         EdAHzzSeL3IgZQlhJqvZFlEJs0sa0Iriw0vvAF/NKJtBghgtjWkKgOGwXhmQlLgt47wf
         Whvtk8mJ/RMz5auenBwK4nbMnx2dxI9BC4SyIsy9kN36OIQeJkVdjCOuFbUetT9iKKW8
         t83Q==
X-Gm-Message-State: AOAM532GILSFGsumGsXGVWUSNpNvGvCrpJWSObT6ssYwnCCJnejRtPde
        7NEwh2LGrvEeR+9EQpbFTRZAoZCnmmy6vCvTuDk=
X-Google-Smtp-Source: ABdhPJzsga2CJsXwChU5oXdvjGrHF1f1fA+NX9FOpgzTyse1D46AuR3fhdViOw3/ESWYgDPB6VE78BrXP4K3VJjON20=
X-Received: by 2002:a9d:5388:: with SMTP id w8mr19042743otg.311.1606780963550;
 Mon, 30 Nov 2020 16:02:43 -0800 (PST)
MIME-Version: 1.0
References: <20201126134240.3214176-1-lee.jones@linaro.org> <20201126134240.3214176-36-lee.jones@linaro.org>
In-Reply-To: <20201126134240.3214176-36-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 30 Nov 2020 19:02:31 -0500
Message-ID: <CADnq5_PXEFXCBfpGKWPCohe30GuV0O1fvyaX_CL1LoheWBti7Q@mail.gmail.com>
Subject: Re: [PATCH 35/40] drm/amd/display/amdgpu_dm/amdgpu_dm_color: Demote a
 misuse and fix another kernel-doc header
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Leo Li <sunpeng.li@amd.com>, LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 26, 2020 at 8:44 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_color.c:128: w=
arning: Function parameter or member 'lut' not described in '__drm_lut_to_d=
c_gamma'
>  drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_color.c:128: w=
arning: Function parameter or member 'gamma' not described in '__drm_lut_to=
_dc_gamma'
>  drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_color.c:128: w=
arning: Function parameter or member 'is_legacy' not described in '__drm_lu=
t_to_dc_gamma'
>  drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_color.c:426: w=
arning: Function parameter or member 'dc_plane_state' not described in 'amd=
gpu_dm_update_plane_color_mgmt'
>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
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
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/dr=
ivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> index 5df05f0d18bc9..157fe4efbb599 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> @@ -119,7 +119,7 @@ static bool __is_lut_linear(const struct drm_color_lu=
t *lut, uint32_t size)
>         return true;
>  }
>
> -/**
> +/*
>   * Convert the drm_color_lut to dc_gamma. The conversion depends on the =
size
>   * of the lut - whether or not it's legacy.
>   */
> @@ -413,7 +413,7 @@ int amdgpu_dm_update_crtc_color_mgmt(struct dm_crtc_s=
tate *crtc)
>  /**
>   * amdgpu_dm_update_plane_color_mgmt: Maps DRM color management to DC pl=
ane.
>   * @crtc: amdgpu_dm crtc state
> - * @ dc_plane_state: target DC surface
> + * @dc_plane_state: target DC surface
>   *
>   * Update the underlying dc_stream_state's input transfer function (ITF)=
 in
>   * preparation for hardware commit. The transfer function used depends o=
n
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
