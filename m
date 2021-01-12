Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E93E2F3F64
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438203AbhALWQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 17:16:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436707AbhALWOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 17:14:51 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F96C061794
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 14:14:11 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id q205so4002546oig.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 14:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dUzHjSUJNwPOYe2P1SOY3ZnGPOkWoC76PQ0dv7QwL7Q=;
        b=TmKOQkDtlN2s867X3fJQaHMdBc/6iL5fV/QbW7EFO1gs4S8QzpfqGp2XU8LKIWhlcv
         /Gm7yOpxCdS2FxLeFLlJpTtqbVfFpiv69eo8p4aAcE5kjXRdwYIqdnCNINYlQfD+tXuc
         SIr+cUHULmbmXLHqCeDi6efl0aX8cJgOOpDTU6J1+3+kHrLrQKmgm06LFKxWPidMHeNv
         XSAWM9l5D2x7iFqvQpSz4Rt9TKMyfkawfHvEUXCdQRC/TKWOOx3Gc/3CTxUIoJnH3rCH
         1GC0GJu8dYKgTxPY2AtGSneHAalqnPtzpZAD5i9CSZc1BX8kv0v26uqkjn4mqYqTYEIU
         VG4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dUzHjSUJNwPOYe2P1SOY3ZnGPOkWoC76PQ0dv7QwL7Q=;
        b=MOJ+jTw+1MRUCp1pNtV0iNunXYMcHV0JL6IacOcMykkT0Z9PrW+D/r3R2cMICfejIt
         pWlvhrh0lriYw/by7Y/p5c7qRwVrdSyUPs4APTh23ehnoyQPoMpaHQt1gPs/9V0yhkVo
         pBvyxhv0Y3S39iVR2EDDfXlhOhoEfBq9B11bP8xuD8syYWnhWongY1ravo+LckrroYxL
         TW8bXwVFSVxB2N3oYzPHrD971SguCZEX1vn6WB6WMGS5D7JEE8I93Y3ymSlgOsy2lmP2
         afWqoX40cESNPd80HBxwTVWbQC3HP6tzC4CfGy0et/MZt1qLilZ/RR9mea/lfB8hUs05
         hFoQ==
X-Gm-Message-State: AOAM530e67/nbgE0LSLhH9oF00TQhfiU8eCoADS1t8gza0QnM1Hc0DxT
        yRB5iH4MsR4YrNug65qF08xzWuPfqSb/lhljhRY=
X-Google-Smtp-Source: ABdhPJyIPgB57dA666S4SRW6OSiMM5d32ZB9ymXUjcm/3oP+7Iv4gD5k5//P1Onz6OMlHc4lr2qC5AX326vzfhwk1eM=
X-Received: by 2002:aca:4f97:: with SMTP id d145mr783979oib.123.1610489650371;
 Tue, 12 Jan 2021 14:14:10 -0800 (PST)
MIME-Version: 1.0
References: <20210111191926.3688443-1-lee.jones@linaro.org> <20210111191926.3688443-16-lee.jones@linaro.org>
In-Reply-To: <20210111191926.3688443-16-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 12 Jan 2021 17:13:58 -0500
Message-ID: <CADnq5_MAazDVYS3ajUAKFdbbivADuu1Tq7GqynAAzuAFakKOaQ@mail.gmail.com>
Subject: Re: [PATCH 15/40] drm/amd/display/dc/dce120/dce120_resource:
 Staticify local functions
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
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_resource.c:426:32=
: warning: no previous prototype for =E2=80=98dce120_opp_create=E2=80=99 [-=
Wmissing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_resource.c:440:17=
: warning: no previous prototype for =E2=80=98dce120_aux_engine_create=E2=
=80=99 [-Wmissing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_resource.c:478:20=
: warning: no previous prototype for =E2=80=98dce120_i2c_hw_create=E2=80=99=
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
>  drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c b/dr=
ivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
> index f1e3d2888eacc..c65e4d125c8e2 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
> @@ -423,7 +423,7 @@ static const struct dce110_clk_src_mask cs_mask =3D {
>                 CS_COMMON_MASK_SH_LIST_DCE_112(_MASK)
>  };
>
> -struct output_pixel_processor *dce120_opp_create(
> +static struct output_pixel_processor *dce120_opp_create(
>         struct dc_context *ctx,
>         uint32_t inst)
>  {
> @@ -437,7 +437,7 @@ struct output_pixel_processor *dce120_opp_create(
>                              ctx, inst, &opp_regs[inst], &opp_shift, &opp=
_mask);
>         return &opp->base;
>  }
> -struct dce_aux *dce120_aux_engine_create(
> +static struct dce_aux *dce120_aux_engine_create(
>         struct dc_context *ctx,
>         uint32_t inst)
>  {
> @@ -475,7 +475,7 @@ static const struct dce_i2c_mask i2c_masks =3D {
>                 I2C_COMMON_MASK_SH_LIST_DCE110(_MASK)
>  };
>
> -struct dce_i2c_hw *dce120_i2c_hw_create(
> +static struct dce_i2c_hw *dce120_i2c_hw_create(
>         struct dc_context *ctx,
>         uint32_t inst)
>  {
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
