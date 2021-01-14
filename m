Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 640162F6662
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 17:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbhANQvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 11:51:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbhANQvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 11:51:13 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3202FC0613C1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 08:50:33 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id d8so5766228otq.6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 08:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=L+TgfptYtNVwPcoqIzpc+5x5pT5jGcrCtNNE8GbycVQ=;
        b=OU+ltv1/I1mq2l+2K0dxg49+eeRyGQPUoZIqH6PnpCygeJzSwYom/ikzMn/exSo+kG
         XGryLRYg/tmP2bElPqcqydE71+8acjxa8ClBmwzdjoTlltEbALf6+nILf6YUYQfBiHOu
         ewTMAhgmHUA9jAMuDXKdUWR2eh1u4g4vIa0+bnJlkhGfqEFQDba0JDXa8cnR4qumPQEU
         kzhG9d0F2tDVUdlfwMkqFFy+l/+xKw46w9D5Yqwtxdi5Epq42DOuv4HUIvrVq3VrOwgN
         k+RVxTcfgQrWqltPgBFuwsgm0B5dZtnRq+AB6iShCbYnYCUB9aNFaB/0FGLoXdNk3EOL
         pV9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=L+TgfptYtNVwPcoqIzpc+5x5pT5jGcrCtNNE8GbycVQ=;
        b=LaWSKB6sFi37H+nbXxh5vRujfJwsY//kRfezqArjFVg2Z61aef3+XFnEMHCeG8QN4t
         2Wj/9TAc+qWYzQ0IgKf40EbS8NkRZmxkTRX8MkFj8gcBC8zakhs0dQlfI79Nl6JhRb/7
         WDURNZh0jqWSHvXM7UeOnB7pn7kpZ4E9T3+GoJbxpxjXBjDpQb+SIPicfTeCONOgT8Sl
         luxeVh2+CF0b1oKP/Bu3mJQ3P5zmWvT3IhSXcIGn7ZC431HhlYF0nP8KjexntH1V5HOX
         ackilZxyDIzMLIJ3VdbywuWLvEdZax2OmQP5kLUPcAXuYd7Fn5JFn+GhDYTaQa48+Vdc
         /5fA==
X-Gm-Message-State: AOAM531UypoKISnftSXOiA5jrpEbzOCEqNabULMUGoGaBCTiSpksE7zl
        jOccLPMyPf/dZ6OUdhBjS29OovWT+SIc01AyueI=
X-Google-Smtp-Source: ABdhPJyDq5ns73KgHKa6b8H0X02mufxys2TirNlA/0Nqjtj6UrkIsOVk0kiLYwtG+xP1vqvJELUEAj5pmPN1zv3Moeg=
X-Received: by 2002:a05:6830:1b7b:: with SMTP id d27mr5391755ote.132.1610643032581;
 Thu, 14 Jan 2021 08:50:32 -0800 (PST)
MIME-Version: 1.0
References: <20210108201457.3078600-1-lee.jones@linaro.org> <20210108201457.3078600-22-lee.jones@linaro.org>
In-Reply-To: <20210108201457.3078600-22-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 14 Jan 2021 11:50:21 -0500
Message-ID: <CADnq5_MK8VqPiRzLFAn4a7U_-Ptq12bR6KYHdq4D0yzNjWPpQg@mail.gmail.com>
Subject: Re: [PATCH 21/40] drm/amd/display/dc/calcs/dce_calcs: Remove unused
 variables 'v_filter_init_mode' and 'sclk_lvl'
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

Applied.  Thanks!

Alex

On Fri, Jan 8, 2021 at 3:15 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dce_calcs.c: In function =
=E2=80=98calculate_bandwidth=E2=80=99:
>  drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dce_calcs.c:109:18: warni=
ng: variable =E2=80=98v_filter_init_mode=E2=80=99 set but not used [-Wunuse=
d-but-set-variable]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dce_calcs.c: In function =
=E2=80=98bw_calcs=E2=80=99:
>  drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dce_calcs.c:3031:21: warn=
ing: variable =E2=80=98sclk_lvl=E2=80=99 set but not used [-Wunused-but-set=
-variable]
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
> ---
>  drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c b/drivers/g=
pu/drm/amd/display/dc/calcs/dce_calcs.c
> index ef41b287cbe23..158d927c03e55 100644
> --- a/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
> +++ b/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
> @@ -106,7 +106,6 @@ static void calculate_bandwidth(
>         bool lpt_enabled;
>         enum bw_defines sclk_message;
>         enum bw_defines yclk_message;
> -       enum bw_defines v_filter_init_mode[maximum_number_of_surfaces];
>         enum bw_defines tiling_mode[maximum_number_of_surfaces];
>         enum bw_defines surface_type[maximum_number_of_surfaces];
>         enum bw_defines voltage;
> @@ -792,12 +791,8 @@ static void calculate_bandwidth(
>                                 data->v_filter_init[i] =3D bw_add(data->v=
_filter_init[i], bw_int_to_fixed(1));
>                         }
>                         if (data->stereo_mode[i] =3D=3D bw_def_top_bottom=
) {
> -                               v_filter_init_mode[i] =3D bw_def_manual;
>                                 data->v_filter_init[i] =3D bw_min2(data->=
v_filter_init[i], bw_int_to_fixed(4));
>                         }
> -                       else {
> -                               v_filter_init_mode[i] =3D bw_def_auto;
> -                       }
>                         if (data->stereo_mode[i] =3D=3D bw_def_top_bottom=
) {
>                                 data->num_lines_at_frame_start =3D bw_int=
_to_fixed(1);
>                         }
> @@ -3028,7 +3023,7 @@ bool bw_calcs(struct dc_context *ctx,
>                 calcs_output->all_displays_in_sync =3D false;
>
>         if (data->number_of_displays !=3D 0) {
> -               uint8_t yclk_lvl, sclk_lvl;
> +               uint8_t yclk_lvl;
>                 struct bw_fixed high_sclk =3D vbios->high_sclk;
>                 struct bw_fixed mid1_sclk =3D vbios->mid1_sclk;
>                 struct bw_fixed mid2_sclk =3D vbios->mid2_sclk;
> @@ -3049,7 +3044,6 @@ bool bw_calcs(struct dc_context *ctx,
>                 calculate_bandwidth(dceip, vbios, data);
>
>                 yclk_lvl =3D data->y_clk_level;
> -               sclk_lvl =3D data->sclk_level;
>
>                 calcs_output->nbp_state_change_enable =3D
>                         data->nbp_state_change_enable;
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
