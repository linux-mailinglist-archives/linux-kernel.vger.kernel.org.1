Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E85B2F3FC6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:46:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394673AbhALWgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 17:36:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727074AbhALWgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 17:36:05 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA95C061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 14:35:25 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id x13so40070oto.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 14:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RBVtaHdcQr8AlNJUiFJGPz+6ofz2SELMI2v9FhPS71Y=;
        b=aOvWUfVqqcCVbTNyxyI42GpQ0qD41QueTQ+Zjs7OV6xW3pUqQ60xMpGe7wWwXe0ukd
         rVXjtQ9CTJVP+hzzpSd+2tyZUi4ZqGSe/qTbwnCQZ50OaaiMI30XCZihRQiCuQ3ulj4o
         nA3gEH/WBcAbTN6IUL/kh3TIW3Z35NHMDxBlVhWwT3c0RHSGcLEoBtZJZ/s9ZEpj0E4q
         lS3Yd0eX+Yktoi1sJ8vaDAb1lM/ml3tzrioetWkf7kKzvhiixqHlm5M5t0WHMPm8kSvS
         /3lS5f0seacmisWtNnKkIkvSRLeNujXWU4i3jXn6tCSf7Ev95GS175262wffpd2u36NR
         P9MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RBVtaHdcQr8AlNJUiFJGPz+6ofz2SELMI2v9FhPS71Y=;
        b=f7dVArKWBxQQCCVZmXf0pol1ZAS97qHQdXtxHy3ZmADA7WVNnQw182oDGpZp8gKnyd
         Sa9HqijNO4AlhYxGsjKbWzKzsm9ltNFWnpUuQSJ4PLvYmg6BhhxQvcv4422ot4ctTRYF
         xzy7LR+7VUp6FG+WMxJqG+9q5qT48t9sGdG3OoCJfRoPu10pSxxU+Cg4gHnfWPoa1TKT
         mqdZ+f8YdCgDqkyCiptEuLt/owpsDea0/eyzhFplDZwQhScnab3QzzZ70BCcFq32GCXj
         O1J3g360Tc6F/VRMuz4yD62Xxr47fGQwi7rV4+Q+CRyfaY5zlziGAKfubHKtTc87w1Bi
         bdzg==
X-Gm-Message-State: AOAM532OkSpC12Stg9t5Mu47h3ZQp219AVkMU/hoqJkZdwXUXVQh6EwL
        /PXorHbRlNStYWsHcBwyAHIaViAAQZGacjFXe/s=
X-Google-Smtp-Source: ABdhPJwOOYQXa5VbHnm4NhWJrmQCo0xFcnNhV2fUlKNJ/bkrcwYw2hZXIz8eC2XoXb6l9LQv6PVvMA21pUm9XeVHXMk=
X-Received: by 2002:a05:6830:1b7b:: with SMTP id d27mr1142211ote.132.1610490924728;
 Tue, 12 Jan 2021 14:35:24 -0800 (PST)
MIME-Version: 1.0
References: <20210111191926.3688443-1-lee.jones@linaro.org> <20210111191926.3688443-33-lee.jones@linaro.org>
In-Reply-To: <20210111191926.3688443-33-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 12 Jan 2021 17:35:13 -0500
Message-ID: <CADnq5_Ps+XGD+b7vo7hPC_nV5a3o9mbyA+i-=EgG2=deknEzXw@mail.gmail.com>
Subject: Re: [PATCH 32/40] drm/amd/display/dc/dce110/Makefile: Ignore
 -Woverride-init warning
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

On Mon, Jan 11, 2021 at 2:20 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dc=
e110_resource.c:66:
>  drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dce/dce_11_0_sh_mask.h:59=
36:51: warning: initialized field overwritten [-Woverride-init]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_stream_encoder.h:116:16=
: note: in expansion of macro =E2=80=98DIG_FE_CNTL__DIG_STEREOSYNC_SELECT__=
SHIFT=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_stream_encoder.h:306:2:=
 note: in expansion of macro =E2=80=98SE_SF=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_resource.c:272:3:=
 note: in expansion of macro =E2=80=98SE_COMMON_MASK_SH_LIST_DCE110=E2=80=
=99
>  drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dce/dce_11_0_sh_mask.h:59=
36:51: note: (near initialization for =E2=80=98se_shift.DIG_STEREOSYNC_SELE=
CT=E2=80=99)
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_stream_encoder.h:116:16=
: note: in expansion of macro =E2=80=98DIG_FE_CNTL__DIG_STEREOSYNC_SELECT__=
SHIFT=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_stream_encoder.h:306:2:=
 note: in expansion of macro =E2=80=98SE_SF=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_resource.c:272:3:=
 note: in expansion of macro =E2=80=98SE_COMMON_MASK_SH_LIST_DCE110=E2=80=
=99
>  drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dce/dce_11_0_sh_mask.h:59=
38:52: warning: initialized field overwritten [-Woverride-init]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_stream_encoder.h:116:16=
: note: in expansion of macro =E2=80=98DIG_FE_CNTL__DIG_STEREOSYNC_GATE_EN_=
_SHIFT=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_stream_encoder.h:307:2:=
 note: in expansion of macro =E2=80=98SE_SF=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_resource.c:272:3:=
 note: in expansion of macro =E2=80=98SE_COMMON_MASK_SH_LIST_DCE110=E2=80=
=99
>  drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dce/dce_11_0_sh_mask.h:59=
38:52: note: (near initialization for =E2=80=98se_shift.DIG_STEREOSYNC_GATE=
_EN=E2=80=99)
>
>  NB: Snipped for brevity
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
>  drivers/gpu/drm/amd/display/dc/dce110/Makefile | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce110/Makefile b/drivers/gpu=
/drm/amd/display/dc/dce110/Makefile
> index d564c0eb8b045..84ab48df0c261 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce110/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dce110/Makefile
> @@ -23,6 +23,8 @@
>  # Makefile for the 'controller' sub-component of DAL.
>  # It provides the control and status of HW CRTC block.
>
> +CFLAGS_$(AMDDALPATH)/dc/dce110/dce110_resource.o =3D $(call cc-disable-w=
arning, override-init)
> +
>  DCE110 =3D dce110_timing_generator.o \
>  dce110_compressor.o dce110_hw_sequencer.o dce110_resource.o \
>  dce110_opp_regamma_v.o dce110_opp_csc_v.o dce110_timing_generator_v.o \
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
