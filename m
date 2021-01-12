Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A12432F3FAF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394634AbhALWbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 17:31:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728225AbhALWah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 17:30:37 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064EBC061795
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 14:29:57 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id i6so58637otr.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 14:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zqgSs5YA1N4P5qw6TX1amzxNau3S2NsbER/l85K2hbo=;
        b=IHsnhu+DCbXPmU/M9sbJ18QTjFnMV9YXipbUdi1/RnHwOE55hDIuyoApG+XCI6t7y6
         AyxkRqCULNSRNqIlIjFxbfAY7O6ErrR9G7MCEneFNPIsPJ419DF5ZIXB9rKupQhG3749
         tc7oAOeX+F5rSibwBPh02stpcALEeLdMW2tPvZJY6ItmIRzkFdB/mOxPt7hpQQ3KNlKp
         PIwk1kZU+c++amsrEh/kCpfxYT1ykTzuZ/C+cWUIz53PwgcLGRJRex+q+2QZ6vKFN9Qn
         u8PD+epq8iOWogGfKxB/s8DajRnzFFNK3uzNhoRLxaUanWXTk9cgVzHepHXLq7N7WU/N
         1Mhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zqgSs5YA1N4P5qw6TX1amzxNau3S2NsbER/l85K2hbo=;
        b=P5Y911djO8TKLw4GwqewaJGxAfi+bkaaDVS5i1ec7Mpjzs0rVofBP9rYpsQIS1dI+8
         CIup0GT9MSpnwMCv+slbKX0xtjkd2kbEO3DgTtvtKpzPSJDbwr1KMNhXAkxAsmzPHyVW
         79XGOGE5DW0/e1ylkKC4j/UVHmPcCYevukc7zmTonBnT6fAoRPPSo1hrHVdUCmed8eZz
         2JPC/4opdE7u1dak4EILRL4K0Up8uDejJcDhszcx+hiJJipn71nu7pmGnzCmIJyYKjUN
         vARnq/nKE+8zO8S3uKdaKz4vEeVMcjRdyxl3+gGg7XORFkPXtDTtVfcIBFlrsPWDJ0rF
         RSdw==
X-Gm-Message-State: AOAM531UDThir5yMLwNE4Wh/SN+y5G+xi0/JT9iPBSTQ1FQRr2twcXJ7
        AJo4jdaKwb4+AzKrwND1nz04Ogz6Yhg5WtWBLeChPa0g
X-Google-Smtp-Source: ABdhPJxncpEJztvvar/ck9ystEIB4WhkWvcJRUv+mtBzsU6p56GdYF0ipSWizZC5y+ToIbb1ZnS5LUpN3ga7szu8erk=
X-Received: by 2002:a9d:75d4:: with SMTP id c20mr1042650otl.311.1610490596442;
 Tue, 12 Jan 2021 14:29:56 -0800 (PST)
MIME-Version: 1.0
References: <20210111191926.3688443-1-lee.jones@linaro.org> <20210111191926.3688443-27-lee.jones@linaro.org>
In-Reply-To: <20210111191926.3688443-27-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 12 Jan 2021 17:29:43 -0500
Message-ID: <CADnq5_OqT44rxMaaLQatKDs79G-v4D-yshuDwTZqHWh7pF0XcQ@mail.gmail.com>
Subject: Re: [PATCH 26/40] drm/amd/display/dc/dce110/dce110_timing_generator:
 Demote kernel-doc abuses to standard function headers
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
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_timing_generator.=
c:79: warning: Cannot understand  *****************************************=
************************************
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_timing_generator.=
c:124: warning: Function parameter or member 'tg' not described in 'dce110_=
timing_generator_enable_crtc'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_timing_generator.=
c:179: warning: Cannot understand  ****************************************=
*************************************
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_timing_generator.=
c:233: warning: Function parameter or member 'tg' not described in 'dce110_=
timing_generator_disable_crtc'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_timing_generator.=
c:258: warning: Function parameter or member 'tg' not described in 'program=
_horz_count_by_2'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_timing_generator.=
c:258: warning: Function parameter or member 'timing' not described in 'pro=
gram_horz_count_by_2'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_timing_generator.=
c:284: warning: Function parameter or member 'tg' not described in 'dce110_=
timing_generator_program_timing_generator'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_timing_generator.=
c:284: warning: Function parameter or member 'dc_crtc_timing' not described=
 in 'dce110_timing_generator_program_timing_generator'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_timing_generator.=
c:356: warning: Cannot understand  ****************************************=
*************************************
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_timing_generator.=
c:525: warning: Cannot understand  ****************************************=
*************************************
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_timing_generator.=
c:561: warning: Cannot understand  ****************************************=
*************************************
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_timing_generator.=
c:1118: warning: Function parameter or member 'tg' not described in 'dce110=
_timing_generator_validate_timing'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_timing_generator.=
c:1118: warning: Function parameter or member 'timing' not described in 'dc=
e110_timing_generator_validate_timing'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_timing_generator.=
c:1118: warning: Function parameter or member 'signal' not described in 'dc=
e110_timing_generator_validate_timing'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_timing_generator.=
c:1174: warning: Function parameter or member 'tg' not described in 'dce110=
_timing_generator_wait_for_vblank'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_timing_generator.=
c:1198: warning: Function parameter or member 'tg' not described in 'dce110=
_timing_generator_wait_for_vactive'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_timing_generator.=
c:1208: warning: Cannot understand  ***************************************=
**************************************
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_timing_generator.=
c:1386: warning: Cannot understand  ***************************************=
**************************************
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_timing_generator.=
c:1768: warning: Cannot understand  ***************************************=
**************************************
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_timing_generator.=
c:1801: warning: Function parameter or member 'tg' not described in 'dce110=
_timing_generator_disable_vga'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_timing_generator.=
c:1851: warning: Function parameter or member 'tg' not described in 'dce110=
_timing_generator_set_overscan_color_black'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_timing_generator.=
c:1851: warning: Function parameter or member 'color' not described in 'dce=
110_timing_generator_set_overscan_color_black'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_timing_generator.=
c:1851: warning: Excess function parameter 'param' description in 'dce110_t=
iming_generator_set_overscan_color_black'
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
>  .../dc/dce110/dce110_timing_generator.c       | 71 +++++++++----------
>  1 file changed, 34 insertions(+), 37 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_timing_generato=
r.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_timing_generator.c
> index 9a6c411bb7fe6..d88a74559edd7 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_timing_generator.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_timing_generator.c
> @@ -75,7 +75,7 @@ static void dce110_timing_generator_apply_front_porch_w=
orkaround(
>         }
>  }
>
> -/**
> +/*
>   ***********************************************************************=
******
>   *  Function: is_in_vertical_blank
>   *
> @@ -116,7 +116,7 @@ void dce110_timing_generator_set_early_control(
>         dm_write_reg(tg->ctx, address, regval);
>  }
>
> -/**
> +/*
>   * Enable CRTC
>   * Enable CRTC - call ASIC Control Object to enable Timing generator.
>   */
> @@ -175,7 +175,7 @@ void dce110_timing_generator_program_blank_color(
>         dm_write_reg(tg->ctx, addr, value);
>  }
>
> -/**
> +/*
>   ***********************************************************************=
******
>   *  Function: disable_stereo
>   *
> @@ -226,7 +226,7 @@ static void disable_stereo(struct timing_generator *t=
g)
>  }
>  #endif
>
> -/**
> +/*
>   * disable_crtc - call ASIC Control Object to disable Timing generator.
>   */
>  bool dce110_timing_generator_disable_crtc(struct timing_generator *tg)
> @@ -247,11 +247,10 @@ bool dce110_timing_generator_disable_crtc(struct ti=
ming_generator *tg)
>         return result =3D=3D BP_RESULT_OK;
>  }
>
> -/**
> -* program_horz_count_by_2
> -* Programs DxCRTC_HORZ_COUNT_BY2_EN - 1 for DVI 30bpp mode, 0 otherwise
> -*
> -*/
> +/*
> + * program_horz_count_by_2
> + * Programs DxCRTC_HORZ_COUNT_BY2_EN - 1 for DVI 30bpp mode, 0 otherwise
> + */
>  static void program_horz_count_by_2(
>         struct timing_generator *tg,
>         const struct dc_crtc_timing *timing)
> @@ -273,7 +272,7 @@ static void program_horz_count_by_2(
>                         CRTC_REG(mmCRTC_COUNT_CONTROL), regval);
>  }
>
> -/**
> +/*
>   * program_timing_generator
>   * Program CRTC Timing Registers - DxCRTC_H_*, DxCRTC_V_*, Pixel repetit=
ion.
>   * Call ASIC Control Object to program Timings.
> @@ -352,7 +351,7 @@ bool dce110_timing_generator_program_timing_generator=
(
>         return result =3D=3D BP_RESULT_OK;
>  }
>
> -/**
> +/*
>   ***********************************************************************=
******
>   *  Function: set_drr
>   *
> @@ -521,7 +520,7 @@ uint32_t dce110_timing_generator_get_vblank_counter(s=
truct timing_generator *tg)
>         return field;
>  }
>
> -/**
> +/*
>   ***********************************************************************=
******
>   *  Function: dce110_timing_generator_get_position
>   *
> @@ -557,7 +556,7 @@ void dce110_timing_generator_get_position(struct timi=
ng_generator *tg,
>                         CRTC_VERT_COUNT_NOM);
>  }
>
> -/**
> +/*
>   ***********************************************************************=
******
>   *  Function: get_crtc_scanoutpos
>   *
> @@ -1106,11 +1105,11 @@ void dce110_timing_generator_set_test_pattern(
>         }
>  }
>
> -/**
> -* dce110_timing_generator_validate_timing
> -* The timing generators support a maximum display size of is 8192 x 8192=
 pixels,
> -* including both active display and blanking periods. Check H Total and =
V Total.
> -*/
> +/*
> + * dce110_timing_generator_validate_timing
> + * The timing generators support a maximum display size of is 8192 x 819=
2 pixels,
> + * including both active display and blanking periods. Check H Total and=
 V Total.
> + */
>  bool dce110_timing_generator_validate_timing(
>         struct timing_generator *tg,
>         const struct dc_crtc_timing *timing,
> @@ -1167,9 +1166,9 @@ bool dce110_timing_generator_validate_timing(
>         return true;
>  }
>
> -/**
> -* Wait till we are at the beginning of VBlank.
> -*/
> +/*
> + * Wait till we are at the beginning of VBlank.
> + */
>  void dce110_timing_generator_wait_for_vblank(struct timing_generator *tg=
)
>  {
>         /* We want to catch beginning of VBlank here, so if the first try=
 are
> @@ -1191,9 +1190,9 @@ void dce110_timing_generator_wait_for_vblank(struct=
 timing_generator *tg)
>         }
>  }
>
> -/**
> -* Wait till we are in VActive (anywhere in VActive)
> -*/
> +/*
> + * Wait till we are in VActive (anywhere in VActive)
> + */
>  void dce110_timing_generator_wait_for_vactive(struct timing_generator *t=
g)
>  {
>         while (dce110_timing_generator_is_in_vertical_blank(tg)) {
> @@ -1204,7 +1203,7 @@ void dce110_timing_generator_wait_for_vactive(struc=
t timing_generator *tg)
>         }
>  }
>
> -/**
> +/*
>   ***********************************************************************=
******
>   *  Function: dce110_timing_generator_setup_global_swap_lock
>   *
> @@ -1215,7 +1214,6 @@ void dce110_timing_generator_wait_for_vactive(struc=
t timing_generator *tg)
>   *  @param [in] gsl_params: setup data
>   ***********************************************************************=
******
>   */
> -
>  void dce110_timing_generator_setup_global_swap_lock(
>         struct timing_generator *tg,
>         const struct dcp_gsl_params *gsl_params)
> @@ -1382,7 +1380,7 @@ void dce110_timing_generator_tear_down_global_swap_=
lock(
>
>         dm_write_reg(tg->ctx, address, value);
>  }
> -/**
> +/*
>   ***********************************************************************=
******
>   *  Function: is_counter_moving
>   *
> @@ -1764,7 +1762,7 @@ void dce110_timing_generator_disable_reset_trigger(
>         dm_write_reg(tg->ctx, CRTC_REG(mmCRTC_TRIGB_CNTL), value);
>  }
>
> -/**
> +/*
>   ***********************************************************************=
******
>   *  @brief
>   *     Checks whether CRTC triggered reset occurred
> @@ -1791,7 +1789,7 @@ bool dce110_timing_generator_did_triggered_reset_oc=
cur(
>         return (force || vert_sync);
>  }
>
> -/**
> +/*
>   * dce110_timing_generator_disable_vga
>   * Turn OFF VGA Mode and Timing  - DxVGA_CONTROL
>   * VGA Mode and VGA Timing is used by VBIOS on CRT Monitors;
> @@ -1837,14 +1835,13 @@ void dce110_timing_generator_disable_vga(
>         dm_write_reg(tg->ctx, addr, value);
>  }
>
> -/**
> -* set_overscan_color_black
> -*
> -* @param :black_color is one of the color space
> -*    :this routine will set overscan black color according to the color =
space.
> -* @return none
> -*/
> -
> +/*
> + * set_overscan_color_black
> + *
> + * @param :black_color is one of the color space
> + *    :this routine will set overscan black color according to the color=
 space.
> + * @return none
> + */
>  void dce110_timing_generator_set_overscan_color_black(
>         struct timing_generator *tg,
>         const struct tg_color *color)
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
