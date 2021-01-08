Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B160F2EF9EC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 22:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729420AbhAHVII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 16:08:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729349AbhAHVIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 16:08:07 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53B14C061574
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 13:07:27 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id s75so12901818oih.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 13:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Pcr4Tdvxc8bDQEjz7KUOR4L9kv90/P1v7PgP00kdfaM=;
        b=BnC4iPd0jnVFxunJsHGzISYmry9eUi/Ih0S4OS5xA6tAhcCgNxhxL2FBTScCEbZivj
         ezVDaKwHrzkyT6JOOkkXTcpDVgd8lGyQc4TcC9yFv6ZI3RCGdZgozMegrxAIRl33ub1I
         3ZqxI50CDbmICj/FwX0d3GVeNm9lgUCAu+DLPfgcT7LWA/VzEgTkG/biENrzx7pXqLBv
         Vww8HweJinbROeDY3AUBQKEo4nZpVqFOgwSFy9qcqesWRHjz033DFptGDg/dWbJW3boG
         5YoOsuoKsbMUqddt6My8qcbinXXUhEnyrFS1NjZUFXMZkDPM1tnDSUz1N59WSfcApQBC
         +eQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Pcr4Tdvxc8bDQEjz7KUOR4L9kv90/P1v7PgP00kdfaM=;
        b=NWGxoNxn/G1xhdcNGXrWFuMe72QWuYVQ+QMVli9HwwyJO6/gFCksR00D/pl92i88bu
         QoVGMLBjGIR5nNIZzqYXKOOAdS56zJ+Ddtm9sgxvGyrqXFzdC6KTnCqC5ScyDeAnJ0rO
         n1fyDui4Yh0k6sLjRUm7jvJgVj9XOrg+ZGn0p99ET2mnJpGz8BhHyBQyRFGktfGk/uU7
         vsjFQ3hDgu3DcyI2rogK8M63zsgnvTnTz87mdvvg7r6DNfz98zoYv86sMeaDGNyQjtpV
         K/MIH3AMb5tOxqBal9aD7sNPNMc2wrrIbHEdJU9mRMgThWtTUfRSUJtOBgcK4bR7f7ve
         0/Bw==
X-Gm-Message-State: AOAM532viUm5cGsv0iOy7tpJOU9w0W35A0kY4H8OTHMUOQFz8MAPzLqb
        SRJugndkN0aX/bdvglxhL+NXN4bZ2m1NA/IhvGw=
X-Google-Smtp-Source: ABdhPJxrSdeOuaVjOtCGANRq8MeS+tK/Fe/2NYSYId6ZgxhFadUmADwANBNROTRVJcjXq6iy5M8R94Zav+YSQSBPgSA=
X-Received: by 2002:a54:4083:: with SMTP id i3mr3473144oii.120.1610140046621;
 Fri, 08 Jan 2021 13:07:26 -0800 (PST)
MIME-Version: 1.0
References: <20210108201457.3078600-1-lee.jones@linaro.org> <20210108201457.3078600-22-lee.jones@linaro.org>
In-Reply-To: <20210108201457.3078600-22-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 8 Jan 2021 16:07:15 -0500
Message-ID: <CADnq5_MO9YN--+TZsYM6j12LhBO4JjbiNhUQULBZY2YOBGzV3g@mail.gmail.com>
Subject: Re: [PATCH 21/40] drm/amd/display/dc/calcs/dce_calcs: Remove unused
 variables 'v_filter_init_mode' and 'sclk_lvl'
To:     Lee Jones <lee.jones@linaro.org>,
        Harry Wentland <hwentlan@amd.com>,
        "Leo (Sunpeng) Li" <Sunpeng.Li@amd.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
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

@Harry Wentland
, @Leo (Sunpeng) Li I think this file is generated from a script or
something.  Wanted to get your take on how to properly integrate a
change like this.

Alex


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
