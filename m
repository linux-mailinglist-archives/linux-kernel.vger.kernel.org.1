Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77D9F2F3FCF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394702AbhALWhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 17:37:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727275AbhALWhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 17:37:01 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E16C06179F
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 14:36:21 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id j20so57909otq.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 14:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JH6nC/aQbcpyo6ULVNL3R8Xru8k45Hsh678wX6MDpbI=;
        b=odQVvnMywsKmZe4RO4YkEwdlrZ7SKYCFZnkZS7oa+Eecz4XyPI3YkyNjMycSr2+LW5
         udt9bFxdoFg9ver3PZuYP5QWQgIj+Qr81YLMzOREFAF4RtlB3KZ4QMCklJW0zeNwHXTm
         tWvd/zD0rYOHQMOip+ORHhfNwz1qDUufzb3cAKFbAIpWF3fOSBySWtPK9XP7/dxG8REH
         td0jpCgmlcuk9pik/AupKqcBeOdquI2rD1XDwoC040B2DGkPA/OwgpYVCy/hPy62v6rv
         FEkfO7pikqMjCJ3rciVudYG0555YiEi/SZ+E1MOMvTrPnxByllFiSQkPrktaOGvpEi2p
         VOeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JH6nC/aQbcpyo6ULVNL3R8Xru8k45Hsh678wX6MDpbI=;
        b=U2/30pTcWQGdKe6/V7rAgSuex+Cg4eHPX4ZpTCN7Uy3Dhatu6qcEB37RUTyM67fPlA
         /vmANivqsGcUY59CJFFb0bDTojK/aaIDb+Th5ZKkQdrke+MBSACCXl+URPwaOOhdyU+J
         CEOjZoBmPKyGqapr9275COz5liS5v8h68LbbIq86L0drAZQqTcPee2SrvS2WAaPyHxsv
         gJ9DGZ6WgFbTTMXCgJ2MO7oB3bAaM9Vyqr9krSlLgVqbCuZAWUZexZjTirOr1vJt6QQF
         Jdl9+ea+RuSEOX0mXvwuwe75s8BmlYCTyqTgp9kaNilhz6BrcAHWILvt/ywlH6Tab+w1
         iGwg==
X-Gm-Message-State: AOAM531fLI2+mwaOaNtuTv3vxw1iDOXLF4WyVBhh9vrL7UfzWQ/dZ5Ir
        Z72EKmrknT8L/E5Hfv5iPsJ2ZUFjWO4y6umUmck=
X-Google-Smtp-Source: ABdhPJy+L5fq9ydJShYnxd48nzP1VDPvTey1uCesomK6RA/QTwnsJyiep/1hi8IWeptBdOF7YOWjI0joxbWKWd2MVX0=
X-Received: by 2002:a05:6830:1b7b:: with SMTP id d27mr1144198ote.132.1610490980649;
 Tue, 12 Jan 2021 14:36:20 -0800 (PST)
MIME-Version: 1.0
References: <20210111191926.3688443-1-lee.jones@linaro.org> <20210111191926.3688443-34-lee.jones@linaro.org>
In-Reply-To: <20210111191926.3688443-34-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 12 Jan 2021 17:36:08 -0500
Message-ID: <CADnq5_Nj+VOTTxxq+CkHXjv73MscUD+E+avKSgqEjOcH1dnuYA@mail.gmail.com>
Subject: Re: [PATCH 33/40] drm/amd/display/dc/dce110/dce110_resource: Make
 local functions invoked by reference static
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Leo Li <sunpeng.li@amd.com>, Anthony Koo <Anthony.Koo@amd.com>,
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
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_resource.c:262:15=
: warning: initialized field overwritten [-Woverride-init]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_resource.c:266:2:=
 note: in expansion of macro =E2=80=98stream_enc_regs=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_resource.c:262:15=
: note: (near initialization for =E2=80=98stream_enc_regs[0].TMDS_CNTL=E2=
=80=99)
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_resource.c:266:2:=
 note: in expansion of macro =E2=80=98stream_enc_regs=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_resource.c:262:15=
: warning: initialized field overwritten [-Woverride-init]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_resource.c:267:2:=
 note: in expansion of macro =E2=80=98stream_enc_regs=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_resource.c:262:15=
: note: (near initialization for =E2=80=98stream_enc_regs[1].TMDS_CNTL=E2=
=80=99)
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_resource.c:267:2:=
 note: in expansion of macro =E2=80=98stream_enc_regs=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_resource.c:262:15=
: warning: initialized field overwritten [-Woverride-init]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_resource.c:268:2:=
 note: in expansion of macro =E2=80=98stream_enc_regs=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_resource.c:262:15=
: note: (near initialization for =E2=80=98stream_enc_regs[2].TMDS_CNTL=E2=
=80=99)
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_resource.c:268:2:=
 note: in expansion of macro =E2=80=98stream_enc_regs=E2=80=99
>  In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dc=
e110_resource.c:66:
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_resource.c:272:3:=
 note: in expansion of macro =E2=80=98SE_COMMON_MASK_SH_LIST_DCE110=E2=80=
=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_resource.c:272:3:=
 note: in expansion of macro =E2=80=98SE_COMMON_MASK_SH_LIST_DCE110=E2=80=
=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_resource.c:272:3:=
 note: in expansion of macro =E2=80=98SE_COMMON_MASK_SH_LIST_DCE110=E2=80=
=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_resource.c:272:3:=
 note: in expansion of macro =E2=80=98SE_COMMON_MASK_SH_LIST_DCE110=E2=80=
=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_resource.c:276:3:=
 note: in expansion of macro =E2=80=98SE_COMMON_MASK_SH_LIST_DCE110=E2=80=
=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_resource.c:276:3:=
 note: in expansion of macro =E2=80=98SE_COMMON_MASK_SH_LIST_DCE110=E2=80=
=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_resource.c:276:3:=
 note: in expansion of macro =E2=80=98SE_COMMON_MASK_SH_LIST_DCE110=E2=80=
=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_resource.c:276:3:=
 note: in expansion of macro =E2=80=98SE_COMMON_MASK_SH_LIST_DCE110=E2=80=
=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_resource.c:553:3:=
 note: in expansion of macro =E2=80=98HWSEQ_DCE11_MASK_SH_LIST=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_resource.c:553:3:=
 note: in expansion of macro =E2=80=98HWSEQ_DCE11_MASK_SH_LIST=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_resource.c:553:3:=
 note: in expansion of macro =E2=80=98HWSEQ_DCE11_MASK_SH_LIST=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_resource.c:553:3:=
 note: in expansion of macro =E2=80=98HWSEQ_DCE11_MASK_SH_LIST=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_resource.c:557:3:=
 note: in expansion of macro =E2=80=98HWSEQ_DCE11_MASK_SH_LIST=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_resource.c:557:3:=
 note: in expansion of macro =E2=80=98HWSEQ_DCE11_MASK_SH_LIST=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_resource.c:557:3:=
 note: in expansion of macro =E2=80=98HWSEQ_DCE11_MASK_SH_LIST=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_resource.c:557:3:=
 note: in expansion of macro =E2=80=98HWSEQ_DCE11_MASK_SH_LIST=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_resource.c:594:3:=
 note: in expansion of macro =E2=80=98MI_DCE11_MASK_SH_LIST=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_resource.c:594:3:=
 note: in expansion of macro =E2=80=98MI_DCE11_MASK_SH_LIST=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_resource.c:599:3:=
 note: in expansion of macro =E2=80=98MI_DCE11_MASK_SH_LIST=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_resource.c:599:3:=
 note: in expansion of macro =E2=80=98MI_DCE11_MASK_SH_LIST=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_resource.c:718:17=
: warning: no previous prototype for =E2=80=98dce110_aux_engine_create=E2=
=80=99 [-Wmissing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_resource.c:756:20=
: warning: no previous prototype for =E2=80=98dce110_i2c_hw_create=E2=80=99=
 [-Wmissing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_resource.c:771:22=
: warning: no previous prototype for =E2=80=98dce110_clock_source_create=E2=
=80=99 [-Wmissing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_resource.c:795:6:=
 warning: no previous prototype for =E2=80=98dce110_clock_source_destroy=E2=
=80=99 [-Wmissing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_resource.c:1037:1=
6: warning: no previous prototype for =E2=80=98dce110_validate_plane=E2=80=
=99 [-Wmissing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_resource.c:1092:1=
6: warning: no previous prototype for =E2=80=98dce110_validate_global=E2=80=
=99 [-Wmissing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_resource.c:1336:2=
9: warning: no previous prototype for =E2=80=98dce110_resource_cap=E2=80=99=
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
>  .../drm/amd/display/dc/dce110/dce110_resource.c  | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c b/dr=
ivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
> index af208f9bd03be..73a924ed2b71e 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
> @@ -715,7 +715,7 @@ static struct output_pixel_processor *dce110_opp_crea=
te(
>         return &opp->base;
>  }
>
> -struct dce_aux *dce110_aux_engine_create(
> +static struct dce_aux *dce110_aux_engine_create(
>         struct dc_context *ctx,
>         uint32_t inst)
>  {
> @@ -753,7 +753,7 @@ static const struct dce_i2c_mask i2c_masks =3D {
>                 I2C_COMMON_MASK_SH_LIST_DCE110(_MASK)
>  };
>
> -struct dce_i2c_hw *dce110_i2c_hw_create(
> +static struct dce_i2c_hw *dce110_i2c_hw_create(
>         struct dc_context *ctx,
>         uint32_t inst)
>  {
> @@ -768,7 +768,7 @@ struct dce_i2c_hw *dce110_i2c_hw_create(
>
>         return dce_i2c_hw;
>  }
> -struct clock_source *dce110_clock_source_create(
> +static struct clock_source *dce110_clock_source_create(
>         struct dc_context *ctx,
>         struct dc_bios *bios,
>         enum clock_source_id id,
> @@ -792,7 +792,7 @@ struct clock_source *dce110_clock_source_create(
>         return NULL;
>  }
>
> -void dce110_clock_source_destroy(struct clock_source **clk_src)
> +static void dce110_clock_source_destroy(struct clock_source **clk_src)
>  {
>         struct dce110_clk_src *dce110_clk_src;
>
> @@ -1034,8 +1034,8 @@ static bool dce110_validate_bandwidth(
>         return result;
>  }
>
> -enum dc_status dce110_validate_plane(const struct dc_plane_state *plane_=
state,
> -                                    struct dc_caps *caps)
> +static enum dc_status dce110_validate_plane(const struct dc_plane_state =
*plane_state,
> +                                           struct dc_caps *caps)
>  {
>         if (((plane_state->dst_rect.width * 2) < plane_state->src_rect.wi=
dth) ||
>             ((plane_state->dst_rect.height * 2) < plane_state->src_rect.h=
eight))
> @@ -1089,7 +1089,7 @@ static bool dce110_validate_surface_sets(
>         return true;
>  }
>
> -enum dc_status dce110_validate_global(
> +static enum dc_status dce110_validate_global(
>                 struct dc *dc,
>                 struct dc_state *context)
>  {
> @@ -1333,7 +1333,7 @@ static void bw_calcs_data_update_from_pplib(struct =
dc *dc)
>                 1000);
>  }
>
> -const struct resource_caps *dce110_resource_cap(
> +static const struct resource_caps *dce110_resource_cap(
>         struct hw_asic_id *asic_id)
>  {
>         if (ASIC_REV_IS_STONEY(asic_id->hw_internal_rev))
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
