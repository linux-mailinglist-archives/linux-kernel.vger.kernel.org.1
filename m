Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 029922F3F8F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391679AbhALW1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 17:27:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731556AbhALW1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 17:27:40 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED57BC061786
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 14:26:59 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id x13so19553oto.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 14:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=trCTWdvjHMkvPDEDmT3pUIVTBrdeeOfcyXQgZDcVJx4=;
        b=muS1YPhlz4qgL7ceLFn6pIbbjGWGMgOZza+OnaaW7VlWYR3J2M2OjcCZo3pIV+yafO
         Vf6+DMKqkoS9l84JDL2Yq6/BjkJsySedrz2NXMqRl3eSpop5oU8CLmPzCvyjNvGK+NtE
         Oiw1/e7+KvH9IIYv6as3G6b6zYkXRs0J+PmQ/gpQfXMQLW0Fmz9D0vy4RlebIjHOPnfE
         4hVTAczfzJ7/FStB42OlahmmaPC9AK/b6BPpOVOLy25Yt2VBSwWQfJRFTOSA8OI8Dz1t
         rt+EE1JtqwD1bvCSfcjHw0v1SAuokEG52nhSxuCIj/X0lwdhNcGUQgfhGTAAGwxqc+u/
         6EOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=trCTWdvjHMkvPDEDmT3pUIVTBrdeeOfcyXQgZDcVJx4=;
        b=AnIFaU9GlLJeZKrBKn5RT5USzdYgfi/VunbgOk14WyXKVeQGNLPTqdWWAWlHJVFreH
         oHJSJQiCkqZnZ/RCHwbWKcdRQ2VWgGjLH0U9q8l4Kja1dnDswjbwS3WUpbnfjCqzIfhb
         /8uKtBOMeqQbN4qOj1IAx3Z/PtJ10QVvhrT1mJcHvZOIA0oGTiWb+0EIPWqOJAcJQqbJ
         d+4LAf5FM2zN5GI4zvPbdPJwHIMR+IFipWUNKq4jHF1hrW3d+h4RxkJvP4g/YynA5dj9
         epIwWyNwTjwnS+V5hKOtFNDytP3XdteecBlWIBgFKjWQ37sKNfCQUBudGeyArDpnZYM6
         4pMQ==
X-Gm-Message-State: AOAM5330ZsSezB0hUpOhsUPy0Bf1ci8dXeLfcuRrurZlpFtmqygkRMID
        2RRgQJwMHuA1AiIyE80UnJYhqQpaFCAlP3UP86U=
X-Google-Smtp-Source: ABdhPJwLdnpdw0ja1Ltjtm14wSKYzVapg2AKCaNpZpS7lOKMqBsG7IHq4Nher6CTSy1VnNs1FVkIKuBYnjRMgAjviFI=
X-Received: by 2002:a9d:2ac2:: with SMTP id e60mr1051458otb.23.1610490419441;
 Tue, 12 Jan 2021 14:26:59 -0800 (PST)
MIME-Version: 1.0
References: <20210111191926.3688443-1-lee.jones@linaro.org> <20210111191926.3688443-26-lee.jones@linaro.org>
In-Reply-To: <20210111191926.3688443-26-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 12 Jan 2021 17:26:47 -0500
Message-ID: <CADnq5_MDnYtb_zxUQfqgbDKvzHuPRdBPDj=BRBGPPme_6aa30A@mail.gmail.com>
Subject: Re: [PATCH 25/40] drm/amd/display/dc/dce120/dce120_timing_generator:
 Remove unused function 'dce120_timing_generator_get_position'
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
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_timing_generator.=
c:602:13: warning: =E2=80=98dce120_timing_generator_get_position=E2=80=99 d=
efined but not used [-Wunused-function]
>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied.  Thanks!

Alex

> ---
>  .../dc/dce120/dce120_timing_generator.c       | 43 -------------------
>  1 file changed, 43 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce120/dce120_timing_generato=
r.c b/drivers/gpu/drm/amd/display/dc/dce120/dce120_timing_generator.c
> index d02ecb983c9cd..b57c466124e76 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce120/dce120_timing_generator.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce120/dce120_timing_generator.c
> @@ -589,49 +589,6 @@ static void dce120_timing_generator_set_drr(
>         }
>  }
>
> -/*
> - ***********************************************************************=
******
> - *  Function: dce120_timing_generator_get_position
> - *
> - *  @brief
> - *     Returns CRTC vertical/horizontal counters
> - *
> - *  @param [out] position
> - ***********************************************************************=
******
> - */
> -static void dce120_timing_generator_get_position(struct timing_generator=
 *tg,
> -       struct crtc_position *position)
> -{
> -       uint32_t value;
> -       struct dce110_timing_generator *tg110 =3D DCE110TG_FROM_TG(tg);
> -
> -       value =3D dm_read_reg_soc15(
> -                       tg->ctx,
> -                       mmCRTC0_CRTC_STATUS_POSITION,
> -                       tg110->offsets.crtc);
> -
> -       position->horizontal_count =3D get_reg_field_value(
> -                       value,
> -                       CRTC0_CRTC_STATUS_POSITION,
> -                       CRTC_HORZ_COUNT);
> -
> -       position->vertical_count =3D get_reg_field_value(
> -                       value,
> -                       CRTC0_CRTC_STATUS_POSITION,
> -                       CRTC_VERT_COUNT);
> -
> -       value =3D dm_read_reg_soc15(
> -                       tg->ctx,
> -                       mmCRTC0_CRTC_NOM_VERT_POSITION,
> -                       tg110->offsets.crtc);
> -
> -       position->nominal_vcount =3D get_reg_field_value(
> -                       value,
> -                       CRTC0_CRTC_NOM_VERT_POSITION,
> -                       CRTC_VERT_COUNT_NOM);
> -}
> -
> -
>  static void dce120_timing_generator_get_crtc_scanoutpos(
>         struct timing_generator *tg,
>         uint32_t *v_blank_start,
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
