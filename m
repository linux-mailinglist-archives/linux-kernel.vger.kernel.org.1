Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79CC52F3FF2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438392AbhALWkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 17:40:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733073AbhALWkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 17:40:13 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D26CC0617A6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 14:38:58 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id j12so53157ota.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 14:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=k7FOmog0Ke+ybsAr0FrFIFA/znvyirSmZnfHvzxQdT4=;
        b=lI3oEmUhnNVCXgzH2uTiEnhUKxLOiuAV3XVXVlE/8XDdttWK/0tp+tI33ygLDT0KU4
         CBy6o8+4t5F2Wh5Ac2WeVLho4FGipFw44iA817xIkPHqYwyrdXRJidgqPLa3mnmYHDtJ
         dIJ4llO8qfdAJSuz07J4IBIyLpIuGzlBliqRTuTaYGV2ad0hXYAGr3WkG2q1/g4Tiv2t
         rqXMw6Wlq/u9A8QjTPnDk1XJ9JgU8KT1PZ9QcYyf+rKM09VKrHxINbHpDFnB8GMLe3d9
         l4DWpsJAFFrz8kaTIehptXnFu3BbKRoK72WLeVeEu2HW9eO9E3+qZ7l/ezrNpdmZjpcs
         XxDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=k7FOmog0Ke+ybsAr0FrFIFA/znvyirSmZnfHvzxQdT4=;
        b=jjJGUadf6zJHLUZwRbwNk3SJYdz+XIoSUq61HzWc+6BbGcBkQ0ofVyXlsdTgiyhf4J
         v0BK97hxGf8zxyfevKo6Nnyn3I1tPMzGxJ9/p4zK9ef/dvB2uq+v+k+yv8UP68rNX1CQ
         aAVoePA3IwN37xH3KsD+CrKKEWBTa/LrzShg7s0hakONJTvUSugLZEuHgvom1UExcY4b
         bmakk5uugkjBBneZUlem2xaAz5+zpX4oZ+ytfXQBXLIr3nckPEf2hQrdoBxwqIXJ+UWW
         FiqQQJYsYWJ5PLJzZ/g6/Q1nXmNTdd6WHPEtsjg8j5WGupKrSNO16PESlxoyVE0iEAEr
         r2cw==
X-Gm-Message-State: AOAM530du30yHNU86ltLNYsJoLiw7NzsgUZGNvSoP/wcnNgrkdY/d0nE
        eNoWyXmRe3xcfli6eE7cs6YvtHB1Y722cCgghsc=
X-Google-Smtp-Source: ABdhPJwY6U7u++qjBJGMhgM9mEIb5GGxy+dMHyL8By0nf57T8v1LyM8CZw1bPhauC1YBsrwneZRamXQR0p70pwccDyM=
X-Received: by 2002:a9d:75d4:: with SMTP id c20mr1059926otl.311.1610491137508;
 Tue, 12 Jan 2021 14:38:57 -0800 (PST)
MIME-Version: 1.0
References: <20210111191926.3688443-1-lee.jones@linaro.org> <20210111191926.3688443-37-lee.jones@linaro.org>
In-Reply-To: <20210111191926.3688443-37-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 12 Jan 2021 17:38:44 -0500
Message-ID: <CADnq5_MBbmhJPTb0k3FgOYugJiSmUDYREZwcKNYcn72bjLXuYA@mail.gmail.com>
Subject: Re: [PATCH 36/40] drm/amd/display/dc/dce100/dce100_resource: Make
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
>  In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dce100/dc=
e100_resource.c:54:
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce100/dce100_resource.c:614:22=
: warning: no previous prototype for =E2=80=98dce100_link_encoder_create=E2=
=80=99 [-Wmissing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce100/dce100_resource.c:653:32=
: warning: no previous prototype for =E2=80=98dce100_opp_create=E2=80=99 [-=
Wmissing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce100/dce100_resource.c:668:17=
: warning: no previous prototype for =E2=80=98dce100_aux_engine_create=E2=
=80=99 [-Wmissing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce100/dce100_resource.c:706:20=
: warning: no previous prototype for =E2=80=98dce100_i2c_hw_create=E2=80=99=
 [-Wmissing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce100/dce100_resource.c:721:22=
: warning: no previous prototype for =E2=80=98dce100_clock_source_create=E2=
=80=99 [-Wmissing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce100/dce100_resource.c:745:6:=
 warning: no previous prototype for =E2=80=98dce100_clock_source_destroy=E2=
=80=99 [-Wmissing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce100/dce100_resource.c:834:6:=
 warning: no previous prototype for =E2=80=98dce100_validate_bandwidth=E2=
=80=99 [-Wmissing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce100/dce100_resource.c:879:16=
: warning: no previous prototype for =E2=80=98dce100_validate_global=E2=80=
=99 [-Wmissing-prototypes]
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
>  .../drm/amd/display/dc/dce100/dce100_resource.c  | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c b/dr=
ivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c
> index f20ed05a5050d..648169086bcf8 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c
> @@ -611,7 +611,7 @@ static const struct encoder_feature_support link_enc_=
feature =3D {
>                 .flags.bits.IS_TPS3_CAPABLE =3D true
>  };
>
> -struct link_encoder *dce100_link_encoder_create(
> +static struct link_encoder *dce100_link_encoder_create(
>         const struct encoder_init_data *enc_init_data)
>  {
>         struct dce110_link_encoder *enc110 =3D
> @@ -650,7 +650,7 @@ static struct panel_cntl *dce100_panel_cntl_create(co=
nst struct panel_cntl_init_
>         return &panel_cntl->base;
>  }
>
> -struct output_pixel_processor *dce100_opp_create(
> +static struct output_pixel_processor *dce100_opp_create(
>         struct dc_context *ctx,
>         uint32_t inst)
>  {
> @@ -665,7 +665,7 @@ struct output_pixel_processor *dce100_opp_create(
>         return &opp->base;
>  }
>
> -struct dce_aux *dce100_aux_engine_create(
> +static struct dce_aux *dce100_aux_engine_create(
>         struct dc_context *ctx,
>         uint32_t inst)
>  {
> @@ -703,7 +703,7 @@ static const struct dce_i2c_mask i2c_masks =3D {
>                 I2C_COMMON_MASK_SH_LIST_DCE_COMMON_BASE(_MASK)
>  };
>
> -struct dce_i2c_hw *dce100_i2c_hw_create(
> +static struct dce_i2c_hw *dce100_i2c_hw_create(
>         struct dc_context *ctx,
>         uint32_t inst)
>  {
> @@ -718,7 +718,7 @@ struct dce_i2c_hw *dce100_i2c_hw_create(
>
>         return dce_i2c_hw;
>  }
> -struct clock_source *dce100_clock_source_create(
> +static struct clock_source *dce100_clock_source_create(
>         struct dc_context *ctx,
>         struct dc_bios *bios,
>         enum clock_source_id id,
> @@ -742,7 +742,7 @@ struct clock_source *dce100_clock_source_create(
>         return NULL;
>  }
>
> -void dce100_clock_source_destroy(struct clock_source **clk_src)
> +static void dce100_clock_source_destroy(struct clock_source **clk_src)
>  {
>         kfree(TO_DCE110_CLK_SRC(*clk_src));
>         *clk_src =3D NULL;
> @@ -831,7 +831,7 @@ static enum dc_status build_mapped_resource(
>         return DC_OK;
>  }
>
> -bool dce100_validate_bandwidth(
> +static bool dce100_validate_bandwidth(
>         struct dc  *dc,
>         struct dc_state *context,
>         bool fast_validate)
> @@ -876,7 +876,7 @@ static bool dce100_validate_surface_sets(
>         return true;
>  }
>
> -enum dc_status dce100_validate_global(
> +static enum dc_status dce100_validate_global(
>                 struct dc  *dc,
>                 struct dc_state *context)
>  {
> --
> 2.25.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
