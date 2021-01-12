Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD4992F3FBC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405074AbhALWdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 17:33:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726475AbhALWdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 17:33:35 -0500
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C3AC061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 14:32:55 -0800 (PST)
Received: by mail-oo1-xc2a.google.com with SMTP id q6so26810ooo.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 14:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=d6RWIlOsuqJ/TIlP0QjP2tJnm5LowJ9Amebw00PcgQU=;
        b=Ywoe/yE6yhtOg3qXDxfkx59u01f48X3yOxfas5ZzA5ca4V5vCKroAWarMdmpvfQZxw
         CSTPO+c9G2LMI2Dtlu58/cZIoe1mNzBdJ4C8sr30wdlkip3x5E9Pr8uCP0jNiqHfzkQR
         Tj8RxiQN+iRDloI+ylSHJI0ZndhWTw4NgAQJqofd8iOmi2Whg+yVciMXn1zicqTvdo3I
         LJYQXN5qwo37QUl3dTF6DjDVddsQxI0i2EgqqQZFl2n31nbLrrN6RNeNdoHBSmQUn3j4
         otCgdzEUE0PTuN1Wz954BXh7rETBHZUmQs5nHmhojjJpYq4I/gkaU0u2AO6KJhstOtZC
         5CUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=d6RWIlOsuqJ/TIlP0QjP2tJnm5LowJ9Amebw00PcgQU=;
        b=ZL/tdBVmd8iAOatvUedB2Yoyf7UQmc1DgH4uzSZY/GKx3u94lQ0CxGwBE8Z6rkcSlk
         3lzDCI6NUSCN2beRQPj6G2sfPUw8MnAfYn53xD//r1r+J2Riaqeg8/hThyw0jqEGeqNK
         PijGfaXpP6SY7EtjVemKJXI2EDP03fygFDHrQZDSI3HxY5s/XX+APXgFkz76EnTOy/sC
         qgjrUlkpJwjfC7tf+E8x2uNaAhM0eXR9FkkrTxO7pisE0CxvveIk+qBdjZmD2WqA6Gy7
         5lmZjzRl9Gk5o32gzZHmRHUJw8khO1xYVoUnz63d4OUQpo8ZohwVVNwlEqU1cz44aS0Y
         oJqw==
X-Gm-Message-State: AOAM531XqtQVfUfVEwbvXCx+YaPxlc+9ZBRmiEidLJ7rmZrwJiP01xQ0
        pg32rEQVMhFG8d0l3UT5Ver1WuyWlt20lsUtzYc=
X-Google-Smtp-Source: ABdhPJyd0OcPPEjXW5gJ5zgyvbByVfmAy4OAwvodY5Ls1Oztu/0LjanK+ZslyjpTSJkx3YtVo5mzvGzUJa1/nwD5TZs=
X-Received: by 2002:a4a:a2c5:: with SMTP id r5mr798229ool.72.1610490774723;
 Tue, 12 Jan 2021 14:32:54 -0800 (PST)
MIME-Version: 1.0
References: <20210111191926.3688443-1-lee.jones@linaro.org> <20210111191926.3688443-30-lee.jones@linaro.org>
In-Reply-To: <20210111191926.3688443-30-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 12 Jan 2021 17:32:43 -0500
Message-ID: <CADnq5_ONz+ncvkPkw1pKzWi81_RR-yX7+adGP7rvuUX=RM-LPA@mail.gmail.com>
Subject: Re: [PATCH 29/40] drm/amd/display/dc/dce112/dce112_resource: Make
 local functions and ones called by reference static
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Leo Li <sunpeng.li@amd.com>, Anthony Koo <Anthony.Koo@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 2:55 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dce112_resource.c:620:22=
: warning: no previous prototype for =E2=80=98dce112_link_encoder_create=E2=
=80=99 [-Wmissing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dce112_resource.c:674:32=
: warning: no previous prototype for =E2=80=98dce112_opp_create=E2=80=99 [-=
Wmissing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dce112_resource.c:689:17=
: warning: no previous prototype for =E2=80=98dce112_aux_engine_create=E2=
=80=99 [-Wmissing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dce112_resource.c:727:20=
: warning: no previous prototype for =E2=80=98dce112_i2c_hw_create=E2=80=99=
 [-Wmissing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dce112_resource.c:742:22=
: warning: no previous prototype for =E2=80=98dce112_clock_source_create=E2=
=80=99 [-Wmissing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dce112_resource.c:766:6:=
 warning: no previous prototype for =E2=80=98dce112_clock_source_destroy=E2=
=80=99 [-Wmissing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dce112_resource.c:1027:1=
6: warning: no previous prototype for =E2=80=98dce112_validate_global=E2=80=
=99 [-Wmissing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dce112_resource.c:1205:2=
9: warning: no previous prototype for =E2=80=98dce112_resource_cap=E2=80=99=
 [-Wmissing-prototypes]
>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Anthony Koo <Anthony.Koo@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied.  Thanks!

Alex

> ---
>  .../drm/amd/display/dc/dce112/dce112_resource.c  | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c b/dr=
ivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
> index f99b1c0845908..c68e576a21990 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
> @@ -617,7 +617,7 @@ static const struct encoder_feature_support link_enc_=
feature =3D {
>                 .flags.bits.IS_TPS4_CAPABLE =3D true
>  };
>
> -struct link_encoder *dce112_link_encoder_create(
> +static struct link_encoder *dce112_link_encoder_create(
>         const struct encoder_init_data *enc_init_data)
>  {
>         struct dce110_link_encoder *enc110 =3D
> @@ -671,7 +671,7 @@ static struct input_pixel_processor *dce112_ipp_creat=
e(
>         return &ipp->base;
>  }
>
> -struct output_pixel_processor *dce112_opp_create(
> +static struct output_pixel_processor *dce112_opp_create(
>         struct dc_context *ctx,
>         uint32_t inst)
>  {
> @@ -686,7 +686,7 @@ struct output_pixel_processor *dce112_opp_create(
>         return &opp->base;
>  }
>
> -struct dce_aux *dce112_aux_engine_create(
> +static struct dce_aux *dce112_aux_engine_create(
>         struct dc_context *ctx,
>         uint32_t inst)
>  {
> @@ -724,7 +724,7 @@ static const struct dce_i2c_mask i2c_masks =3D {
>                 I2C_COMMON_MASK_SH_LIST_DCE110(_MASK)
>  };
>
> -struct dce_i2c_hw *dce112_i2c_hw_create(
> +static struct dce_i2c_hw *dce112_i2c_hw_create(
>         struct dc_context *ctx,
>         uint32_t inst)
>  {
> @@ -739,7 +739,7 @@ struct dce_i2c_hw *dce112_i2c_hw_create(
>
>         return dce_i2c_hw;
>  }
> -struct clock_source *dce112_clock_source_create(
> +static struct clock_source *dce112_clock_source_create(
>         struct dc_context *ctx,
>         struct dc_bios *bios,
>         enum clock_source_id id,
> @@ -763,7 +763,7 @@ struct clock_source *dce112_clock_source_create(
>         return NULL;
>  }
>
> -void dce112_clock_source_destroy(struct clock_source **clk_src)
> +static void dce112_clock_source_destroy(struct clock_source **clk_src)
>  {
>         kfree(TO_DCE110_CLK_SRC(*clk_src));
>         *clk_src =3D NULL;
> @@ -1024,7 +1024,7 @@ enum dc_status dce112_add_stream_to_ctx(
>         return result;
>  }
>
> -enum dc_status dce112_validate_global(
> +static enum dc_status dce112_validate_global(
>                 struct dc *dc,
>                 struct dc_state *context)
>  {
> @@ -1202,7 +1202,7 @@ static void bw_calcs_data_update_from_pplib(struct =
dc *dc)
>         dm_pp_notify_wm_clock_changes(dc->ctx, &clk_ranges);
>  }
>
> -const struct resource_caps *dce112_resource_cap(
> +static const struct resource_caps *dce112_resource_cap(
>         struct hw_asic_id *asic_id)
>  {
>         if (ASIC_REV_IS_POLARIS11_M(asic_id->hw_internal_rev) ||
> --
> 2.25.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
