Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22E962F3EA9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394475AbhALWLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 17:11:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391550AbhALWLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 17:11:02 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA7C6C061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 14:10:21 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id d8so3855552otq.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 14:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GXj1P17rD6kgJbSAgIyS/gPquD3jJy8joQuFnGQzY1c=;
        b=KNUgfacTVH3Mj+m0ddK60SJje5rtE7VPtcwX2HCdlAwnAMtkYxQZBbzqj/e3UTTIft
         058rmy4aybjGO0JrJD+fhQ/lePMCIcB+yR9ONz64naYguQCr3KkYrJKSy6rJJXXcxgkT
         L3rqzHgs1tO2NH5iKR9gZWhcGqLCUm4uonSTuxUDFWcq86nGsqFuE3zuKYKQMQC0I5I3
         xdtjhVR+kuBRM263SO8HqU080IhBnNO3IQ02hVuDriPj1rOwPHsRrKfsNTGIiYb0t/8D
         0lKWcmUULse3K8WjKiCPRCa/z0Gvw4I17VCpnJU4At7PKHzFFv0EoDC0FddtcRcc3Leo
         OtLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GXj1P17rD6kgJbSAgIyS/gPquD3jJy8joQuFnGQzY1c=;
        b=aDTg4E5pJMMzDBZ9T1efgcW2VlGcCUCa3nAv7fSjdml+FPjuvzhM0JVnntvZk1pOx+
         FGARd28yebAfp7ig4cHPrkBPljG5feQg3uoKZMoN3fRWNiBwIQpObw/Rz5oheogQ+iNu
         lz3qMTYbHEp52jrbYSou63mixVCU1ShGoVv75YYybmiQSYuN+DeSLij2azyKY+ix6YMj
         flZ45iQK53a2RKtR4iGB2tqO7V6jN1e1H0Bt0fxD9nHBw20piqrFG51hx6kEOKAWkiBT
         vmH+ponKPJhDx5b3FqmtSDGjj3SlAdIcYSTVpPpHmtQs2IDUKbjb0ch02hfYlcLW2yW2
         sBMg==
X-Gm-Message-State: AOAM532ldHcX2D5E5OHg/XUWP9IjwxJAsUB6v3RxDdIYaQPkmuw7dHmx
        lqDtAUYE+mAxDQLep2H3r705mUxVh39wKLtTw6s=
X-Google-Smtp-Source: ABdhPJyJRuRX2/tsQKV/rCfMskCzttmv8FMZ2UoRumVUYWFAZf02JFx2b91koPrwnxYjGH4Ee20x1tRGH11FudB86u4=
X-Received: by 2002:a9d:2ac2:: with SMTP id e60mr1017583otb.23.1610489421373;
 Tue, 12 Jan 2021 14:10:21 -0800 (PST)
MIME-Version: 1.0
References: <20210111191926.3688443-1-lee.jones@linaro.org> <20210111191926.3688443-12-lee.jones@linaro.org>
In-Reply-To: <20210111191926.3688443-12-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 12 Jan 2021 17:10:10 -0500
Message-ID: <CADnq5_Oa7D4ohU-gk2WW1YqM3DkjPWtTa6Tn-4YE-gZ9XjZKvg@mail.gmail.com>
Subject: Re: [PATCH 11/40] drm/amd/display/dc/dce120/dce120_timing_generator:
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
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_timing_generator.=
c:101:6: warning: no previous prototype for =E2=80=98dce120_timing_generato=
r_validate_timing=E2=80=99 [-Wmissing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_timing_generator.=
c:128:6: warning: no previous prototype for =E2=80=98dce120_tg_validate_tim=
ing=E2=80=99 [-Wmissing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_timing_generator.=
c:136:6: warning: no previous prototype for =E2=80=98dce120_timing_generato=
r_enable_crtc=E2=80=99 [-Wmissing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_timing_generator.=
c:156:6: warning: no previous prototype for =E2=80=98dce120_timing_generato=
r_set_early_control=E2=80=99 [-Wmissing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_timing_generator.=
c:169:10: warning: no previous prototype for =E2=80=98dce120_timing_generat=
or_get_vblank_counter=E2=80=99 [-Wmissing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_timing_generator.=
c:184:6: warning: no previous prototype for =E2=80=98dce120_timing_generato=
r_get_crtc_position=E2=80=99 [-Wmissing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_timing_generator.=
c:210:6: warning: no previous prototype for =E2=80=98dce120_timing_generato=
r_wait_for_vblank=E2=80=99 [-Wmissing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_timing_generator.=
c:232:6: warning: no previous prototype for =E2=80=98dce120_timing_generato=
r_wait_for_vactive=E2=80=99 [-Wmissing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_timing_generator.=
c:245:6: warning: no previous prototype for =E2=80=98dce120_timing_generato=
r_setup_global_swap_lock=E2=80=99 [-Wmissing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_timing_generator.=
c:282:6: warning: no previous prototype for =E2=80=98dce120_timing_generato=
r_tear_down_global_swap_lock=E2=80=99 [-Wmissing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_timing_generator.=
c:303:6: warning: no previous prototype for =E2=80=98dce120_timing_generato=
r_enable_reset_trigger=E2=80=99 [-Wmissing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_timing_generator.=
c:350:6: warning: no previous prototype for =E2=80=98dce120_timing_generato=
r_disable_reset_trigger=E2=80=99 [-Wmissing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_timing_generator.=
c:370:6: warning: no previous prototype for =E2=80=98dce120_timing_generato=
r_did_triggered_reset_occur=E2=80=99 [-Wmissing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_timing_generator.=
c:387:6: warning: no previous prototype for =E2=80=98dce120_timing_generato=
r_disable_vga=E2=80=99 [-Wmissing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_timing_generator.=
c:428:6: warning: no previous prototype for =E2=80=98dce120_timing_generato=
r_program_blanking=E2=80=99 [-Wmissing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_timing_generator.=
c:488:6: warning: no previous prototype for =E2=80=98dce120_timing_generato=
r_program_blank_color=E2=80=99 [-Wmissing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_timing_generator.=
c:501:6: warning: no previous prototype for =E2=80=98dce120_timing_generato=
r_set_overscan_color_black=E2=80=99 [-Wmissing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_timing_generator.=
c:543:6: warning: no previous prototype for =E2=80=98dce120_timing_generato=
r_set_drr=E2=80=99 [-Wmissing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_timing_generator.=
c:602:6: warning: no previous prototype for =E2=80=98dce120_timing_generato=
r_get_position=E2=80=99 [-Wmissing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_timing_generator.=
c:635:6: warning: no previous prototype for =E2=80=98dce120_timing_generato=
r_get_crtc_scanoutpos=E2=80=99 [-Wmissing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_timing_generator.=
c:664:6: warning: no previous prototype for =E2=80=98dce120_timing_generato=
r_enable_advanced_request=E2=80=99 [-Wmissing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_timing_generator.=
c:702:6: warning: no previous prototype for =E2=80=98dce120_tg_program_blan=
k_color=E2=80=99 [-Wmissing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_timing_generator.=
c:725:6: warning: no previous prototype for =E2=80=98dce120_tg_set_overscan=
_color=E2=80=99 [-Wmissing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_timing_generator.=
c:752:6: warning: no previous prototype for =E2=80=98dce120_tg_is_blanked=
=E2=80=99 [-Wmissing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_timing_generator.=
c:773:6: warning: no previous prototype for =E2=80=98dce120_tg_set_blank=E2=
=80=99 [-Wmissing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_timing_generator.=
c:792:6: warning: no previous prototype for =E2=80=98dce120_tg_wait_for_sta=
te=E2=80=99 [-Wmissing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_timing_generator.=
c:809:6: warning: no previous prototype for =E2=80=98dce120_tg_set_colors=
=E2=80=99 [-Wmissing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_timing_generator.=
c:836:6: warning: no previous prototype for =E2=80=98dce120_timing_generato=
r_set_test_pattern=E2=80=99 [-Wmissing-prototypes]
>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Aric Cyr <aric.cyr@amd.com>
> Cc: Anthony Koo <Anthony.Koo@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied.  Thanks!

Alex

> ---
>  .../dc/dce120/dce120_timing_generator.c       | 56 +++++++++----------
>  1 file changed, 28 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce120/dce120_timing_generato=
r.c b/drivers/gpu/drm/amd/display/dc/dce120/dce120_timing_generator.c
> index 915fbb8e8168c..ebc7d61e8bf36 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce120/dce120_timing_generator.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce120/dce120_timing_generator.c
> @@ -98,7 +98,7 @@ static bool dce120_timing_generator_is_in_vertical_blan=
k(
>
>
>  /* determine if given timing can be supported by TG */
> -bool dce120_timing_generator_validate_timing(
> +static bool dce120_timing_generator_validate_timing(
>         struct timing_generator *tg,
>         const struct dc_crtc_timing *timing,
>         enum signal_type signal)
> @@ -125,7 +125,7 @@ bool dce120_timing_generator_validate_timing(
>         return true;
>  }
>
> -bool dce120_tg_validate_timing(struct timing_generator *tg,
> +static bool dce120_tg_validate_timing(struct timing_generator *tg,
>         const struct dc_crtc_timing *timing)
>  {
>         return dce120_timing_generator_validate_timing(tg, timing, SIGNAL=
_TYPE_NONE);
> @@ -133,7 +133,7 @@ bool dce120_tg_validate_timing(struct timing_generato=
r *tg,
>
>  /******** HW programming ************/
>  /* Disable/Enable Timing Generator */
> -bool dce120_timing_generator_enable_crtc(struct timing_generator *tg)
> +static bool dce120_timing_generator_enable_crtc(struct timing_generator =
*tg)
>  {
>         enum bp_result result;
>         struct dce110_timing_generator *tg110 =3D DCE110TG_FROM_TG(tg);
> @@ -153,7 +153,7 @@ bool dce120_timing_generator_enable_crtc(struct timin=
g_generator *tg)
>         return result =3D=3D BP_RESULT_OK;
>  }
>
> -void dce120_timing_generator_set_early_control(
> +static void dce120_timing_generator_set_early_control(
>                 struct timing_generator *tg,
>                 uint32_t early_cntl)
>  {
> @@ -166,7 +166,7 @@ void dce120_timing_generator_set_early_control(
>  /**************** TG current status ******************/
>
>  /* return the current frame counter. Used by Linux kernel DRM */
> -uint32_t dce120_timing_generator_get_vblank_counter(
> +static uint32_t dce120_timing_generator_get_vblank_counter(
>                 struct timing_generator *tg)
>  {
>         struct dce110_timing_generator *tg110 =3D DCE110TG_FROM_TG(tg);
> @@ -181,7 +181,7 @@ uint32_t dce120_timing_generator_get_vblank_counter(
>  }
>
>  /* Get current H and V position */
> -void dce120_timing_generator_get_crtc_position(
> +static void dce120_timing_generator_get_crtc_position(
>         struct timing_generator *tg,
>         struct crtc_position *position)
>  {
> @@ -207,7 +207,7 @@ void dce120_timing_generator_get_crtc_position(
>  }
>
>  /* wait until TG is in beginning of vertical blank region */
> -void dce120_timing_generator_wait_for_vblank(struct timing_generator *tg=
)
> +static void dce120_timing_generator_wait_for_vblank(struct timing_genera=
tor *tg)
>  {
>         /* We want to catch beginning of VBlank here, so if the first try=
 are
>          * in VBlank, we might be very close to Active, in this case wait=
 for
> @@ -229,7 +229,7 @@ void dce120_timing_generator_wait_for_vblank(struct t=
iming_generator *tg)
>  }
>
>  /* wait until TG is in beginning of active region */
> -void dce120_timing_generator_wait_for_vactive(struct timing_generator *t=
g)
> +static void dce120_timing_generator_wait_for_vactive(struct timing_gener=
ator *tg)
>  {
>         while (dce120_timing_generator_is_in_vertical_blank(tg)) {
>                 if (!tg->funcs->is_counter_moving(tg)) {
> @@ -242,7 +242,7 @@ void dce120_timing_generator_wait_for_vactive(struct =
timing_generator *tg)
>  /*********** Timing Generator Synchronization routines ****/
>
>  /* Setups Global Swap Lock group, TimingServer or TimingClient*/
> -void dce120_timing_generator_setup_global_swap_lock(
> +static void dce120_timing_generator_setup_global_swap_lock(
>         struct timing_generator *tg,
>         const struct dcp_gsl_params *gsl_params)
>  {
> @@ -279,7 +279,7 @@ void dce120_timing_generator_setup_global_swap_lock(
>  }
>
>  /* Clear all the register writes done by setup_global_swap_lock */
> -void dce120_timing_generator_tear_down_global_swap_lock(
> +static void dce120_timing_generator_tear_down_global_swap_lock(
>         struct timing_generator *tg)
>  {
>         struct dce110_timing_generator *tg110 =3D DCE110TG_FROM_TG(tg);
> @@ -300,7 +300,7 @@ void dce120_timing_generator_tear_down_global_swap_lo=
ck(
>  }
>
>  /* Reset slave controllers on master VSync */
> -void dce120_timing_generator_enable_reset_trigger(
> +static void dce120_timing_generator_enable_reset_trigger(
>         struct timing_generator *tg,
>         int source)
>  {
> @@ -347,7 +347,7 @@ void dce120_timing_generator_enable_reset_trigger(
>  }
>
>  /* disabling trigger-reset */
> -void dce120_timing_generator_disable_reset_trigger(
> +static void dce120_timing_generator_disable_reset_trigger(
>         struct timing_generator *tg)
>  {
>         struct dce110_timing_generator *tg110 =3D DCE110TG_FROM_TG(tg);
> @@ -367,7 +367,7 @@ void dce120_timing_generator_disable_reset_trigger(
>  }
>
>  /* Checks whether CRTC triggered reset occurred */
> -bool dce120_timing_generator_did_triggered_reset_occur(
> +static bool dce120_timing_generator_did_triggered_reset_occur(
>         struct timing_generator *tg)
>  {
>         struct dce110_timing_generator *tg110 =3D DCE110TG_FROM_TG(tg);
> @@ -384,7 +384,7 @@ bool dce120_timing_generator_did_triggered_reset_occu=
r(
>
>  /******** Stuff to move to other virtual HW objects *****************/
>  /* Move to enable accelerated mode */
> -void dce120_timing_generator_disable_vga(struct timing_generator *tg)
> +static void dce120_timing_generator_disable_vga(struct timing_generator =
*tg)
>  {
>         uint32_t offset =3D 0;
>         uint32_t value =3D 0;
> @@ -425,7 +425,7 @@ void dce120_timing_generator_disable_vga(struct timin=
g_generator *tg)
>  }
>  /* TODO: Should we move it to transform */
>  /* Fully program CRTC timing in timing generator */
> -void dce120_timing_generator_program_blanking(
> +static void dce120_timing_generator_program_blanking(
>         struct timing_generator *tg,
>         const struct dc_crtc_timing *timing)
>  {
> @@ -485,7 +485,7 @@ void dce120_timing_generator_program_blanking(
>
>  /* TODO: Should we move it to opp? */
>  /* Combine with below and move YUV/RGB color conversion to SW layer */
> -void dce120_timing_generator_program_blank_color(
> +static void dce120_timing_generator_program_blank_color(
>         struct timing_generator *tg,
>         const struct tg_color *black_color)
>  {
> @@ -498,7 +498,7 @@ void dce120_timing_generator_program_blank_color(
>                 CRTC_BLACK_COLOR_R_CR, black_color->color_r_cr);
>  }
>  /* Combine with above and move YUV/RGB color conversion to SW layer */
> -void dce120_timing_generator_set_overscan_color_black(
> +static void dce120_timing_generator_set_overscan_color_black(
>         struct timing_generator *tg,
>         const struct tg_color *color)
>  {
> @@ -540,7 +540,7 @@ void dce120_timing_generator_set_overscan_color_black=
(
>          */
>  }
>
> -void dce120_timing_generator_set_drr(
> +static void dce120_timing_generator_set_drr(
>         struct timing_generator *tg,
>         const struct drr_params *params)
>  {
> @@ -599,7 +599,7 @@ void dce120_timing_generator_set_drr(
>   *  @param [out] position
>   ***********************************************************************=
******
>   */
> -void dce120_timing_generator_get_position(struct timing_generator *tg,
> +static void dce120_timing_generator_get_position(struct timing_generator=
 *tg,
>         struct crtc_position *position)
>  {
>         uint32_t value;
> @@ -632,7 +632,7 @@ void dce120_timing_generator_get_position(struct timi=
ng_generator *tg,
>  }
>
>
> -void dce120_timing_generator_get_crtc_scanoutpos(
> +static void dce120_timing_generator_get_crtc_scanoutpos(
>         struct timing_generator *tg,
>         uint32_t *v_blank_start,
>         uint32_t *v_blank_end,
> @@ -661,7 +661,7 @@ void dce120_timing_generator_get_crtc_scanoutpos(
>         *v_position =3D position.vertical_count;
>  }
>
> -void dce120_timing_generator_enable_advanced_request(
> +static void dce120_timing_generator_enable_advanced_request(
>         struct timing_generator *tg,
>         bool enable,
>         const struct dc_crtc_timing *timing)
> @@ -699,7 +699,7 @@ void dce120_timing_generator_enable_advanced_request(
>                         value);
>  }
>
> -void dce120_tg_program_blank_color(struct timing_generator *tg,
> +static void dce120_tg_program_blank_color(struct timing_generator *tg,
>         const struct tg_color *black_color)
>  {
>         struct dce110_timing_generator *tg110 =3D DCE110TG_FROM_TG(tg);
> @@ -722,7 +722,7 @@ void dce120_tg_program_blank_color(struct timing_gene=
rator *tg,
>                 value);
>  }
>
> -void dce120_tg_set_overscan_color(struct timing_generator *tg,
> +static void dce120_tg_set_overscan_color(struct timing_generator *tg,
>         const struct tg_color *overscan_color)
>  {
>         struct dce110_timing_generator *tg110 =3D DCE110TG_FROM_TG(tg);
> @@ -749,7 +749,7 @@ static void dce120_tg_program_timing(struct timing_ge=
nerator *tg,
>                 dce120_timing_generator_program_blanking(tg, timing);
>  }
>
> -bool dce120_tg_is_blanked(struct timing_generator *tg)
> +static bool dce120_tg_is_blanked(struct timing_generator *tg)
>  {
>         struct dce110_timing_generator *tg110 =3D DCE110TG_FROM_TG(tg);
>         uint32_t value =3D dm_read_reg_soc15(
> @@ -770,7 +770,7 @@ bool dce120_tg_is_blanked(struct timing_generator *tg=
)
>         return false;
>  }
>
> -void dce120_tg_set_blank(struct timing_generator *tg,
> +static void dce120_tg_set_blank(struct timing_generator *tg,
>                 bool enable_blanking)
>  {
>         struct dce110_timing_generator *tg110 =3D DCE110TG_FROM_TG(tg);
> @@ -789,7 +789,7 @@ void dce120_tg_set_blank(struct timing_generator *tg,
>  bool dce120_tg_validate_timing(struct timing_generator *tg,
>         const struct dc_crtc_timing *timing);
>
> -void dce120_tg_wait_for_state(struct timing_generator *tg,
> +static void dce120_tg_wait_for_state(struct timing_generator *tg,
>         enum crtc_state state)
>  {
>         switch (state) {
> @@ -806,7 +806,7 @@ void dce120_tg_wait_for_state(struct timing_generator=
 *tg,
>         }
>  }
>
> -void dce120_tg_set_colors(struct timing_generator *tg,
> +static void dce120_tg_set_colors(struct timing_generator *tg,
>         const struct tg_color *blank_color,
>         const struct tg_color *overscan_color)
>  {
> @@ -833,7 +833,7 @@ static void dce120_timing_generator_set_static_screen=
_control(
>                         CRTC_STATIC_SCREEN_FRAME_COUNT, num_frames);
>  }
>
> -void dce120_timing_generator_set_test_pattern(
> +static void dce120_timing_generator_set_test_pattern(
>         struct timing_generator *tg,
>         /* TODO: replace 'controller_dp_test_pattern' by 'test_pattern_mo=
de'
>          * because this is not DP-specific (which is probably somewhere i=
n DP
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
