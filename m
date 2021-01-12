Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 381F02F3F87
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:46:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731328AbhALW0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 17:26:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727115AbhALW0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 17:26:05 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99DBC061786
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 14:25:24 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id j20so31304otq.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 14:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=u5Z73Bwrtvuv00OwqjkhofIO6vR29+6B907CCy8chGc=;
        b=grFBgfk0d4RYqdlhuOst/N4ygfe6EevSqDd011aGO0bVSvMaE1S5liBqClIA0LJgko
         CJlDZ6o/gw/MbOtuJzbG2xMD/t1dUnrPkWhVMYrDWa77h8B+XT+kMDepe1GgzDhRwS/l
         61DZG8r9p8aWaJWzgziYSLqTEAndvrf5t4tOsFxYLWJPn2vum4jYHlhimffK8sPFAAaQ
         wMR5BZPjahXVbNbXfmpSW8CO9Z7uNErj6tANwQTNOrBLUxPS7s3xE4VZl46/yD+l/PcV
         E7EXqVafA8UXUHNO9/hI7qP5f8uqc0jPEZmjTyCz9wjXABWEx/mLsj/6Yeq5fnCx31av
         JIIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=u5Z73Bwrtvuv00OwqjkhofIO6vR29+6B907CCy8chGc=;
        b=sp6xzAbnebBZupU8XQZVlzVxSRuWXTRDAbED9EPslgcMysfz3cLJvj92jc1TUj5ywd
         33sXO0gFOAY3RPSE2au+Xija3gg+0w9NkHH9WeAZEkMT/n4XD315okm9OaV9Xdskw5Tk
         IyZE967zxV1eIeuWx9NufhUFMEgpo9oT2cv5/nAM0H8KiOhhLfssglAYtGoKJIRSb1Jn
         jV7aQWsniFBmBGWGyNAhNmecWiLI/9cS4hRb/zq8Arhbe09ucnw2ElfYC5RRjG24K2PQ
         4PaGK3HB/6ggDmq7rhzDEOX7dstlRtn6FSMRPgVQp/ffqpvQHOWwhPHuGWJNRQaJTs8S
         9nug==
X-Gm-Message-State: AOAM532wRTxooM1QIXdSUx/vJMfSNMQMg1EXs1cMfag64WK3igg7s5vh
        nWVb8r5GPkPALgpRwGtRVl3gYFFB3l+vdgoZOWk6VkAW
X-Google-Smtp-Source: ABdhPJyImsRhgeNAV60sP9TZwurwHaIa7kl0k4HlojcXZlJRAW6Jb25X2zez5eFPLI/P+wgGI2pTv3XiVflcpPNEhcg=
X-Received: by 2002:a9d:75d4:: with SMTP id c20mr1034868otl.311.1610490321431;
 Tue, 12 Jan 2021 14:25:21 -0800 (PST)
MIME-Version: 1.0
References: <20210111191926.3688443-1-lee.jones@linaro.org> <20210111191926.3688443-24-lee.jones@linaro.org>
In-Reply-To: <20210111191926.3688443-24-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 12 Jan 2021 17:25:09 -0500
Message-ID: <CADnq5_N-KzxznD6Kq3ko_AN6LG_QFRQMwhz82-Rh8A6qnR-7Qw@mail.gmail.com>
Subject: Re: [PATCH 23/40] drm/amd/display/dc/dce110/dce110_mem_input_v: Make
 local functions static
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
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_mem_input_v.c:471=
:6: warning: no previous prototype for =E2=80=98dce_mem_input_v_is_surface_=
pending=E2=80=99 [-Wmissing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_mem_input_v.c:486=
:6: warning: no previous prototype for =E2=80=98dce_mem_input_v_program_sur=
face_flip_and_addr=E2=80=99 [-Wmissing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_mem_input_v.c:563=
:6: warning: no previous prototype for =E2=80=98dce_mem_input_v_program_pte=
_vm=E2=80=99 [-Wmissing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_mem_input_v.c:636=
:6: warning: no previous prototype for =E2=80=98dce_mem_input_v_program_sur=
face_config=E2=80=99 [-Wmissing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_mem_input_v.c:922=
:6: warning: no previous prototype for =E2=80=98dce_mem_input_v_program_dis=
play_marks=E2=80=99 [-Wmissing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_mem_input_v.c:945=
:6: warning: no previous prototype for =E2=80=98dce_mem_input_program_chrom=
a_display_marks=E2=80=99 [-Wmissing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_mem_input_v.c:966=
:6: warning: no previous prototype for =E2=80=98dce110_allocate_mem_input_v=
=E2=80=99 [-Wmissing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_mem_input_v.c:100=
8:6: warning: no previous prototype for =E2=80=98dce110_free_mem_input_v=E2=
=80=99 [-Wmissing-prototypes]
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
>  .../amd/display/dc/dce110/dce110_mem_input_v.c   | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_mem_input_v.c b=
/drivers/gpu/drm/amd/display/dc/dce110/dce110_mem_input_v.c
> index d54172d88f5f3..19b1976139b69 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_mem_input_v.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_mem_input_v.c
> @@ -468,7 +468,7 @@ static void program_pixel_format(
>         }
>  }
>
> -bool dce_mem_input_v_is_surface_pending(struct mem_input *mem_input)
> +static bool dce_mem_input_v_is_surface_pending(struct mem_input *mem_inp=
ut)
>  {
>         struct dce_mem_input *mem_input110 =3D TO_DCE_MEM_INPUT(mem_input=
);
>         uint32_t value;
> @@ -483,7 +483,7 @@ bool dce_mem_input_v_is_surface_pending(struct mem_in=
put *mem_input)
>         return false;
>  }
>
> -bool dce_mem_input_v_program_surface_flip_and_addr(
> +static bool dce_mem_input_v_program_surface_flip_and_addr(
>         struct mem_input *mem_input,
>         const struct dc_plane_address *address,
>         bool flip_immediate)
> @@ -560,7 +560,7 @@ static const unsigned int *get_dvmm_hw_setting(
>         }
>  }
>
> -void dce_mem_input_v_program_pte_vm(
> +static void dce_mem_input_v_program_pte_vm(
>                 struct mem_input *mem_input,
>                 enum surface_pixel_format format,
>                 union dc_tiling_info *tiling_info,
> @@ -633,7 +633,7 @@ void dce_mem_input_v_program_pte_vm(
>         dm_write_reg(mem_input110->base.ctx, mmUNP_DVMM_PTE_ARB_CONTROL_C=
, value);
>  }
>
> -void dce_mem_input_v_program_surface_config(
> +static void dce_mem_input_v_program_surface_config(
>         struct mem_input *mem_input,
>         enum surface_pixel_format format,
>         union dc_tiling_info *tiling_info,
> @@ -919,7 +919,7 @@ static void program_nbp_watermark_c(
>                         marks);
>  }
>
> -void dce_mem_input_v_program_display_marks(
> +static void dce_mem_input_v_program_display_marks(
>         struct mem_input *mem_input,
>         struct dce_watermarks nbp,
>         struct dce_watermarks stutter,
> @@ -942,7 +942,7 @@ void dce_mem_input_v_program_display_marks(
>
>  }
>
> -void dce_mem_input_program_chroma_display_marks(
> +static void dce_mem_input_program_chroma_display_marks(
>         struct mem_input *mem_input,
>         struct dce_watermarks nbp,
>         struct dce_watermarks stutter,
> @@ -963,7 +963,7 @@ void dce_mem_input_program_chroma_display_marks(
>                 stutter);
>  }
>
> -void dce110_allocate_mem_input_v(
> +static void dce110_allocate_mem_input_v(
>         struct mem_input *mi,
>         uint32_t h_total,/* for current stream */
>         uint32_t v_total,/* for current stream */
> @@ -1005,7 +1005,7 @@ void dce110_allocate_mem_input_v(
>
>  }
>
> -void dce110_free_mem_input_v(
> +static void dce110_free_mem_input_v(
>         struct mem_input *mi,
>         uint32_t total_stream_num)
>  {
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
