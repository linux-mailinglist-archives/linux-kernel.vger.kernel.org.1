Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E59E72F3FF4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438403AbhALWka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 17:40:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbhALWk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 17:40:29 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765AFC061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 14:39:48 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id j12so55032ota.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 14:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SWaxzi3lp+qE9IJuiVjRhwoZaYuVtvJe4fHIGi7TqG0=;
        b=NzeXgI0wZfh+/jzfQvt4poZAOTFE+uWcQnTllRxwRI3QOMoMCZGHKzIQNFW/kRuNt+
         wPF+J3NKnB/6sa8tapH8YYRUosmF7XjI/m4A+xHwDChKYEmPRauRecwBsI6hyR+Ql+/I
         8rT9I8sUJ5NzfmR/T7xCI5Fb+CUVbk5EXsIWs9nhOm1zI8HimYxm6ik5x+YksibZKYhN
         tPynEsP4l3rssj4S6EYftgxjq4BDpI44N2asISYz/CE/vN2oWZgtID7rwVIXJhwLz5jf
         5wBjDlgGQLndTJMviYKtDYeS6O/ShjG5/iqZbEFugUNe6FfI49Gkv0T6qasd5HrIVe3q
         kntw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SWaxzi3lp+qE9IJuiVjRhwoZaYuVtvJe4fHIGi7TqG0=;
        b=o4rN2SEXyq7bXVxzfxPqwtAcaNT0lf491aAEhDc1U9NdBA+8/jWwD4+3vRQHvLTGbx
         z5fXatOWfRlzt1iaP/qkGEe96UcjiWk2PipJWLHAKiAa74XJYcGaRCwwotpE3MsmUQ6l
         OmC1vVuiRLI57KfZgMA+0ZdRLO1Q+/5Nf7DhcjX8ny5HxbEabmeyjKFgpKBkwwLvEHnO
         MaeQrugianX8JZ/Py5zZmhVzaRX5ZO0vRsP3a/YtFO/hD+MkNQJJN7GrRiuCfUuKorPy
         Ae9PINVzqSX1QdXSoZQw6bwKaXYvALowWLL7V/vfOFLtq2G3eyr4/TZf4HURNoRRJ7n9
         Xqxw==
X-Gm-Message-State: AOAM532uVC7mcIQ4IWiQj7x59P+mQ9wxZxf6sT5Hgouv/eurzgXe0iCV
        uoVHCuI/GyiPIPhgzuVvf+Z5UmcAewyD2mFnfT0=
X-Google-Smtp-Source: ABdhPJzM5I9XxSCCwp1Aa4EFADYNBtEG5agAQ2+3cqxQxY8lUdS2VzqqlNDvBV2tO936LFhT3UvnXTz6q+d81rgX4Ao=
X-Received: by 2002:a9d:2ac2:: with SMTP id e60mr1074881otb.23.1610491187926;
 Tue, 12 Jan 2021 14:39:47 -0800 (PST)
MIME-Version: 1.0
References: <20210111191926.3688443-1-lee.jones@linaro.org> <20210111191926.3688443-38-lee.jones@linaro.org>
In-Reply-To: <20210111191926.3688443-38-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 12 Jan 2021 17:39:36 -0500
Message-ID: <CADnq5_O=6HukSMAkHK5Cot5URYphtqwEa+t-pL38o=LYHBZRVw@mail.gmail.com>
Subject: Re: [PATCH 37/40] drm/amd/display/dc/dce60/dce60_resource: Make local
 functions static
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Leo Li <sunpeng.li@amd.com>, Mauro Rossi <issor.oruam@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
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
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce60/dce60_resource.c:522:17: =
warning: no previous prototype for =E2=80=98dce60_aux_engine_create=E2=80=
=99 [-Wmissing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce60/dce60_resource.c:560:20: =
warning: no previous prototype for =E2=80=98dce60_i2c_hw_create=E2=80=99 [-=
Wmissing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce60/dce60_resource.c:576:20: =
warning: no previous prototype for =E2=80=98dce60_i2c_sw_create=E2=80=99 [-=
Wmissing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce60/dce60_resource.c:710:22: =
warning: no previous prototype for =E2=80=98dce60_link_encoder_create=E2=80=
=99 [-Wmissing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce60/dce60_resource.c:749:22: =
warning: no previous prototype for =E2=80=98dce60_clock_source_create=E2=80=
=99 [-Wmissing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce60/dce60_resource.c:773:6: w=
arning: no previous prototype for =E2=80=98dce60_clock_source_destroy=E2=80=
=99 [-Wmissing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce60/dce60_resource.c:863:6: w=
arning: no previous prototype for =E2=80=98dce60_validate_bandwidth=E2=80=
=99 [-Wmissing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce60/dce60_resource.c:908:16: =
warning: no previous prototype for =E2=80=98dce60_validate_global=E2=80=99 =
[-Wmissing-prototypes]
>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Mauro Rossi <issor.oruam@gmail.com>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied.  Thanks!

Alex

> ---
>  .../drm/amd/display/dc/dce60/dce60_resource.c    | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c b/driv=
ers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
> index e9dd78c484d6e..64f4a0da146bf 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
> @@ -519,7 +519,7 @@ static struct output_pixel_processor *dce60_opp_creat=
e(
>         return &opp->base;
>  }
>
> -struct dce_aux *dce60_aux_engine_create(
> +static struct dce_aux *dce60_aux_engine_create(
>         struct dc_context *ctx,
>         uint32_t inst)
>  {
> @@ -557,7 +557,7 @@ static const struct dce_i2c_mask i2c_masks =3D {
>                 I2C_COMMON_MASK_SH_LIST_DCE_COMMON_BASE(_MASK)
>  };
>
> -struct dce_i2c_hw *dce60_i2c_hw_create(
> +static struct dce_i2c_hw *dce60_i2c_hw_create(
>         struct dc_context *ctx,
>         uint32_t inst)
>  {
> @@ -573,7 +573,7 @@ struct dce_i2c_hw *dce60_i2c_hw_create(
>         return dce_i2c_hw;
>  }
>
> -struct dce_i2c_sw *dce60_i2c_sw_create(
> +static struct dce_i2c_sw *dce60_i2c_sw_create(
>         struct dc_context *ctx)
>  {
>         struct dce_i2c_sw *dce_i2c_sw =3D
> @@ -707,7 +707,7 @@ static const struct encoder_feature_support link_enc_=
feature =3D {
>                 .flags.bits.IS_TPS3_CAPABLE =3D true
>  };
>
> -struct link_encoder *dce60_link_encoder_create(
> +static struct link_encoder *dce60_link_encoder_create(
>         const struct encoder_init_data *enc_init_data)
>  {
>         struct dce110_link_encoder *enc110 =3D
> @@ -746,7 +746,7 @@ static struct panel_cntl *dce60_panel_cntl_create(con=
st struct panel_cntl_init_d
>         return &panel_cntl->base;
>  }
>
> -struct clock_source *dce60_clock_source_create(
> +static struct clock_source *dce60_clock_source_create(
>         struct dc_context *ctx,
>         struct dc_bios *bios,
>         enum clock_source_id id,
> @@ -770,7 +770,7 @@ struct clock_source *dce60_clock_source_create(
>         return NULL;
>  }
>
> -void dce60_clock_source_destroy(struct clock_source **clk_src)
> +static void dce60_clock_source_destroy(struct clock_source **clk_src)
>  {
>         kfree(TO_DCE110_CLK_SRC(*clk_src));
>         *clk_src =3D NULL;
> @@ -860,7 +860,7 @@ static void dce60_resource_destruct(struct dce110_res=
ource_pool *pool)
>         }
>  }
>
> -bool dce60_validate_bandwidth(
> +static bool dce60_validate_bandwidth(
>         struct dc *dc,
>         struct dc_state *context,
>         bool fast_validate)
> @@ -905,7 +905,7 @@ static bool dce60_validate_surface_sets(
>         return true;
>  }
>
> -enum dc_status dce60_validate_global(
> +static enum dc_status dce60_validate_global(
>                 struct dc *dc,
>                 struct dc_state *context)
>  {
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
