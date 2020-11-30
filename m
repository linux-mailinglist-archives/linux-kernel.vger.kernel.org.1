Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 036432C92F8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 00:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388812AbgK3Xpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 18:45:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388050AbgK3Xpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 18:45:45 -0500
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60585C0613D2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 15:45:05 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id w15so16165486oie.13
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 15:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/lyaYGV02AY7zFNEbhGP5/Ng0ywG3eDIwUtsDfqupic=;
        b=iGoI7oCQ7OuV+LUmK6RWknf4IkWkIrRTSZGIAeD3Zf5YUfOZn8iNi0B4EF3LyQyeVP
         NW1fJ6TSay1IddyfndLaU5Eof3Hl9hc5kmdVjisSqVYmGBChKu4HTici2FaLjoZy0IVo
         ZX/GW8K4J4K2l7ZMJiuXDPcZ+dZFpQsihdsMGUdFjSk+NG7heX6099IcZkTpTfu3A0hi
         cElQ407uKS6aqH0CxJETPgjvTBh2mCATmSOhvG5lc7bR65kg2ybL8gQ6RtFEQTeh9DhP
         LkKkN8z9OF7R43sQ9sk8WCWyzR2SrgqIwBPiwgCWfX7KwhQmGLlMpAKtjQSD0gouOMM0
         ithw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/lyaYGV02AY7zFNEbhGP5/Ng0ywG3eDIwUtsDfqupic=;
        b=I5DVA3+G28/Yk/geJR7GEKe2EykWUWAymF0oIeeEOYpLWKHvyWA5MVNIsmYyr1AjuM
         eq4lZTZ7Uf/AAhGJprfXSf7qiGsuPH64mbCkEkllXqNJJ2kdFCZQZbViGUBcP08vL111
         Yc25NDkSd/YuCRgqt7D6kOQBni0+lx6OUs/34XpeewpR5omca5+BxO9PuPhdEHxk3jSg
         PvBzeOZYBsHyIJqAVJu12aDVX704rtfeTd3BaW5P7zUmbBeu4TFCEeDqA1tg84BG10l6
         WLBLTaX2Q4T9Kz2G1xuZro3+vKdwlJa0quwOKEfQo8rdCsMKMKsy8MIVCbAgo+mGI/RV
         veHw==
X-Gm-Message-State: AOAM533iIvIIvf/nOZ+9ZSj0qrzleY3DVphY4GglLiLFDj2TVfjGN1tM
        SVZuZN3hGuGFxYSjlXkEbtfcXlmy10jXYVWAjzE=
X-Google-Smtp-Source: ABdhPJy3AkAOZ1BefVySkHZuT39m+O3MRbLY3QUbUYPTZj4ScbPjJPigzQgQP63AZaAuXllS0nZGBmiDAeBy5TPzG0I=
X-Received: by 2002:aca:f50e:: with SMTP id t14mr174065oih.123.1606779904734;
 Mon, 30 Nov 2020 15:45:04 -0800 (PST)
MIME-Version: 1.0
References: <20201126134240.3214176-1-lee.jones@linaro.org> <20201126134240.3214176-22-lee.jones@linaro.org>
In-Reply-To: <20201126134240.3214176-22-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 30 Nov 2020 18:44:53 -0500
Message-ID: <CADnq5_PkLAL7N=9C57j_nRdUa8VwhPUxBoUsGPfw2Q0T=TzqeQ@mail.gmail.com>
Subject: Re: [PATCH 21/40] drm/amd/pm/powerplay/hwmgr/smu7_hwmgr: Fix a whole
 bunch of historical function doc issues
To:     Lee Jones <lee.jones@linaro.org>
Cc:     David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Evan Quan <evan.quan@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 26, 2020 at 8:43 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_hwmgr.c:202: warni=
ng: Function parameter or member 'hwmgr' not described in 'smu7_get_mc_micr=
ocode_version'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_hwmgr.c:242: warni=
ng: Function parameter or member 'hwmgr' not described in 'smu7_enable_smc_=
voltage_controller'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_hwmgr.c:263: warni=
ng: Function parameter or member 'hwmgr' not described in 'smu7_voltage_con=
trol'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_hwmgr.c:277: warni=
ng: Function parameter or member 'hwmgr' not described in 'smu7_enable_volt=
age_control'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_hwmgr.c:315: warni=
ng: Function parameter or member 'hwmgr' not described in 'smu7_construct_v=
oltage_tables'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_hwmgr.c:428: warni=
ng: Function parameter or member 'hwmgr' not described in 'smu7_program_sta=
tic_screen_threshold_parameters'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_hwmgr.c:450: warni=
ng: Function parameter or member 'hwmgr' not described in 'smu7_enable_disp=
lay_gap'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_hwmgr.c:474: warni=
ng: Function parameter or member 'hwmgr' not described in 'smu7_program_vot=
ing_clients'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_hwmgr.c:570: warni=
ng: Function parameter or member 'hwmgr' not described in 'smu7_initial_swi=
tch_from_arbf0_to_f1'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_hwmgr.c:1926: warn=
ing: Function parameter or member 'hwmgr' not described in 'smu7_get_evv_vo=
ltages'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_hwmgr.c:2028: warn=
ing: Function parameter or member 'hwmgr' not described in 'smu7_patch_ppt_=
v1_with_vdd_leakage'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_hwmgr.c:2028: warn=
ing: Function parameter or member 'voltage' not described in 'smu7_patch_pp=
t_v1_with_vdd_leakage'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_hwmgr.c:2028: warn=
ing: Function parameter or member 'leakage_table' not described in 'smu7_pa=
tch_ppt_v1_with_vdd_leakage'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_hwmgr.c:2056: warn=
ing: Function parameter or member 'hwmgr' not described in 'smu7_patch_look=
up_table_with_leakage'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_hwmgr.c:2056: warn=
ing: Function parameter or member 'lookup_table' not described in 'smu7_pat=
ch_lookup_table_with_leakage'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_hwmgr.c:2056: warn=
ing: Function parameter or member 'leakage_table' not described in 'smu7_pa=
tch_lookup_table_with_leakage'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_hwmgr.c:2511: warn=
ing: Function parameter or member 'hwmgr' not described in 'smu7_patch_ppt_=
v0_with_vdd_leakage'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_hwmgr.c:2511: warn=
ing: Function parameter or member 'voltage' not described in 'smu7_patch_pp=
t_v0_with_vdd_leakage'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_hwmgr.c:2511: warn=
ing: Function parameter or member 'leakage_table' not described in 'smu7_pa=
tch_ppt_v0_with_vdd_leakage'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_hwmgr.c:4449: warn=
ing: Function parameter or member 'hwmgr' not described in 'smu7_program_di=
splay_gap'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_hwmgr.c:4508: warn=
ing: Function parameter or member 'hwmgr' not described in 'smu7_set_max_fa=
n_rpm_output'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_hwmgr.c:4508: warn=
ing: Function parameter or member 'us_max_fan_rpm' not described in 'smu7_s=
et_max_fan_rpm_output'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_hwmgr.c:4707: warn=
ing: Function parameter or member 'hwmgr' not described in 'smu7_get_memory=
_type'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_hwmgr.c:4723: warn=
ing: Function parameter or member 'hwmgr' not described in 'smu7_enable_acp=
i_power_management'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_hwmgr.c:4737: warn=
ing: Function parameter or member 'hwmgr' not described in 'smu7_init_power=
_gate_state'
>
> Cc: Evan Quan <evan.quan@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied.  Thanks!

Alex

> ---
>  .../drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c   | 166 +++++++++---------
>  1 file changed, 83 insertions(+), 83 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/driver=
s/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> index 53111c6bbcc91..82676c086ce46 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> @@ -193,10 +193,10 @@ static const struct smu7_power_state *cast_const_ph=
w_smu7_power_state(
>  }
>
>  /**
> - * Find the MC microcode version and store it in the HwMgr struct
> + * smu7_get_mc_microcode_version - Find the MC microcode version and sto=
re it in the HwMgr struct
>   *
> - * @param    hwmgr  the address of the powerplay hardware manager.
> - * @return   always 0
> + * @hwmgr:  the address of the powerplay hardware manager.
> + * Return:   always 0
>   */
>  static int smu7_get_mc_microcode_version(struct pp_hwmgr *hwmgr)
>  {
> @@ -233,11 +233,11 @@ static int smu7_get_current_pcie_lane_number(struct=
 pp_hwmgr *hwmgr)
>  }
>
>  /**
> -* Enable voltage control
> -*
> -* @param    pHwMgr  the address of the powerplay hardware manager.
> -* @return   always PP_Result_OK
> -*/
> + * smu7_enable_smc_voltage_controller - Enable voltage control
> + *
> + * @hwmgr  the address of the powerplay hardware manager.
> + * Return:   always PP_Result_OK
> + */
>  static int smu7_enable_smc_voltage_controller(struct pp_hwmgr *hwmgr)
>  {
>         if (hwmgr->chip_id >=3D CHIP_POLARIS10 &&
> @@ -255,10 +255,10 @@ static int smu7_enable_smc_voltage_controller(struc=
t pp_hwmgr *hwmgr)
>  }
>
>  /**
> -* Checks if we want to support voltage control
> -*
> -* @param    hwmgr  the address of the powerplay hardware manager.
> -*/
> + * smu7_voltage_control - Checks if we want to support voltage control
> + *
> + * @hwmgr:  the address of the powerplay hardware manager.
> + */
>  static bool smu7_voltage_control(const struct pp_hwmgr *hwmgr)
>  {
>         const struct smu7_hwmgr *data =3D
> @@ -268,11 +268,11 @@ static bool smu7_voltage_control(const struct pp_hw=
mgr *hwmgr)
>  }
>
>  /**
> -* Enable voltage control
> -*
> -* @param    hwmgr  the address of the powerplay hardware manager.
> -* @return   always 0
> -*/
> + * smu7_enable_voltage_control - Enable voltage control
> + *
> + * @hwmgr:  the address of the powerplay hardware manager.
> + * Return:   always 0
> + */
>  static int smu7_enable_voltage_control(struct pp_hwmgr *hwmgr)
>  {
>         /* enable voltage control */
> @@ -306,11 +306,11 @@ static int phm_get_svi2_voltage_table_v0(pp_atomctr=
l_voltage_table *voltage_tabl
>
>
>  /**
> -* Create Voltage Tables.
> -*
> -* @param    hwmgr  the address of the powerplay hardware manager.
> -* @return   always 0
> -*/
> + * smu7_construct_voltage_tables - Create Voltage Tables.
> + *
> + * @hwmgr:  the address of the powerplay hardware manager.
> + * Return:   always 0
> + */
>  static int smu7_construct_voltage_tables(struct pp_hwmgr *hwmgr)
>  {
>         struct smu7_hwmgr *data =3D (struct smu7_hwmgr *)(hwmgr->backend)=
;
> @@ -418,11 +418,11 @@ static int smu7_construct_voltage_tables(struct pp_=
hwmgr *hwmgr)
>  }
>
>  /**
> -* Programs static screed detection parameters
> -*
> -* @param    hwmgr  the address of the powerplay hardware manager.
> -* @return   always 0
> -*/
> + * smu7_program_static_screen_threshold_parameters - Programs static scr=
eed detection parameters
> + *
> + * @hwmgr:  the address of the powerplay hardware manager.
> + * Return:   always 0
> + */
>  static int smu7_program_static_screen_threshold_parameters(
>                                                         struct pp_hwmgr *=
hwmgr)
>  {
> @@ -441,11 +441,11 @@ static int smu7_program_static_screen_threshold_par=
ameters(
>  }
>
>  /**
> -* Setup display gap for glitch free memory clock switching.
> -*
> -* @param    hwmgr  the address of the powerplay hardware manager.
> -* @return   always  0
> -*/
> + * smu7_enable_display_gap - Setup display gap for glitch free memory cl=
ock switching.
> + *
> + * @hwmgr:  the address of the powerplay hardware manager.
> + * Return:   always  0
> + */
>  static int smu7_enable_display_gap(struct pp_hwmgr *hwmgr)
>  {
>         uint32_t display_gap =3D
> @@ -465,11 +465,11 @@ static int smu7_enable_display_gap(struct pp_hwmgr =
*hwmgr)
>  }
>
>  /**
> -* Programs activity state transition voting clients
> -*
> -* @param    hwmgr  the address of the powerplay hardware manager.
> -* @return   always  0
> -*/
> + * smu7_program_voting_clients - Programs activity state transition voti=
ng clients
> + *
> + * @hwmgr:  the address of the powerplay hardware manager.
> + * Return:   always  0
> + */
>  static int smu7_program_voting_clients(struct pp_hwmgr *hwmgr)
>  {
>         struct smu7_hwmgr *data =3D (struct smu7_hwmgr *)(hwmgr->backend)=
;
> @@ -560,12 +560,12 @@ static int smu7_reset_to_default(struct pp_hwmgr *h=
wmgr)
>  }
>
>  /**
> -* Initial switch from ARB F0->F1
> -*
> -* @param    hwmgr  the address of the powerplay hardware manager.
> -* @return   always 0
> -* This function is to be called from the SetPowerState table.
> -*/
> + * smu7_initial_switch_from_arbf0_to_f1 - Initial switch from ARB F0->F1
> + *
> + * @hwmgr:  the address of the powerplay hardware manager.
> + * Return:   always 0
> + * This function is to be called from the SetPowerState table.
> + */
>  static int smu7_initial_switch_from_arbf0_to_f1(struct pp_hwmgr *hwmgr)
>  {
>         return smu7_copy_and_switch_arb_sets(hwmgr,
> @@ -1917,11 +1917,11 @@ static int smu7_calculate_ro_range(struct pp_hwmg=
r *hwmgr)
>  }
>
>  /**
> -* Get Leakage VDDC based on leakage ID.
> -*
> -* @param    hwmgr  the address of the powerplay hardware manager.
> -* @return   always 0
> -*/
> + * smu7_get_evv_voltages - Get Leakage VDDC based on leakage ID.
> + *
> + * @hwmgr:  the address of the powerplay hardware manager.
> + * Return:   always 0
> + */
>  static int smu7_get_evv_voltages(struct pp_hwmgr *hwmgr)
>  {
>         struct smu7_hwmgr *data =3D (struct smu7_hwmgr *)(hwmgr->backend)=
;
> @@ -2017,11 +2017,11 @@ static int smu7_get_evv_voltages(struct pp_hwmgr =
*hwmgr)
>  }
>
>  /**
> - * Change virtual leakage voltage to actual value.
> + * smu7_patch_ppt_v1_with_vdd_leakage - Change virtual leakage voltage t=
o actual value.
>   *
> - * @param     hwmgr  the address of the powerplay hardware manager.
> - * @param     pointer to changing voltage
> - * @param     pointer to leakage table
> + * @hwmgr:  the address of the powerplay hardware manager.
> + * @voltage: pointer to changing voltage
> + * @leakage_table: pointer to leakage table
>   */
>  static void smu7_patch_ppt_v1_with_vdd_leakage(struct pp_hwmgr *hwmgr,
>                 uint16_t *voltage, struct smu7_leakage_voltage *leakage_t=
able)
> @@ -2043,13 +2043,13 @@ static void smu7_patch_ppt_v1_with_vdd_leakage(st=
ruct pp_hwmgr *hwmgr,
>  }
>
>  /**
> -* Patch voltage lookup table by EVV leakages.
> -*
> -* @param     hwmgr  the address of the powerplay hardware manager.
> -* @param     pointer to voltage lookup table
> -* @param     pointer to leakage table
> -* @return     always 0
> -*/
> + * smu7_patch_lookup_table_with_leakage - Patch voltage lookup table by =
EVV leakages.
> + *
> + * @hwmgr:  the address of the powerplay hardware manager.
> + * @lookup_table: pointer to voltage lookup table
> + * @leakage_table: pointer to leakage table
> + * Return:     always 0
> + */
>  static int smu7_patch_lookup_table_with_leakage(struct pp_hwmgr *hwmgr,
>                 phm_ppt_v1_voltage_lookup_table *lookup_table,
>                 struct smu7_leakage_voltage *leakage_table)
> @@ -2500,11 +2500,11 @@ static int smu7_thermal_parameter_init(struct pp_=
hwmgr *hwmgr)
>  }
>
>  /**
> - * Change virtual leakage voltage to actual value.
> + * smu7_patch_ppt_v0_with_vdd_leakage - Change virtual leakage voltage t=
o actual value.
>   *
> - * @param     hwmgr  the address of the powerplay hardware manager.
> - * @param     pointer to changing voltage
> - * @param     pointer to leakage table
> + * @hwmgr:  the address of the powerplay hardware manager.
> + * @voltage: pointer to changing voltage
> + * @leakage_table: pointer to leakage table
>   */
>  static void smu7_patch_ppt_v0_with_vdd_leakage(struct pp_hwmgr *hwmgr,
>                 uint32_t *voltage, struct smu7_leakage_voltage *leakage_t=
able)
> @@ -4440,11 +4440,11 @@ smu7_notify_smc_display_config_after_ps_adjustmen=
t(struct pp_hwmgr *hwmgr)
>  }
>
>  /**
> -* Programs the display gap
> -*
> -* @param    hwmgr  the address of the powerplay hardware manager.
> -* @return   always OK
> -*/
> + * smu7_program_display_gap - Programs the display gap
> + *
> + * @hwmgr:  the address of the powerplay hardware manager.
> + * Return:   always OK
> + */
>  static int smu7_program_display_gap(struct pp_hwmgr *hwmgr)
>  {
>         struct smu7_hwmgr *data =3D (struct smu7_hwmgr *)(hwmgr->backend)=
;
> @@ -4498,12 +4498,12 @@ static int smu7_display_configuration_changed_tas=
k(struct pp_hwmgr *hwmgr)
>  }
>
>  /**
> -*  Set maximum target operating fan output RPM
> -*
> -* @param    hwmgr:  the address of the powerplay hardware manager.
> -* @param    usMaxFanRpm:  max operating fan RPM value.
> -* @return   The response that came from the SMC.
> -*/
> + * smu7_set_max_fan_rpm_output - Set maximum target operating fan output=
 RPM
> + *
> + * @hwmgr:  the address of the powerplay hardware manager.
> + * @usMaxFanRpm:  max operating fan RPM value.
> + * Return:   The response that came from the SMC.
> + */
>  static int smu7_set_max_fan_rpm_output(struct pp_hwmgr *hwmgr, uint16_t =
us_max_fan_rpm)
>  {
>         hwmgr->thermal_controller.
> @@ -4698,10 +4698,10 @@ static int smu7_read_clock_registers(struct pp_hw=
mgr *hwmgr)
>  }
>
>  /**
> - * Find out if memory is GDDR5.
> + * smu7_get_memory_type - Find out if memory is GDDR5.
>   *
> - * @param    hwmgr  the address of the powerplay hardware manager.
> - * @return   always 0
> + * @hwmgr:  the address of the powerplay hardware manager.
> + * Return:   always 0
>   */
>  static int smu7_get_memory_type(struct pp_hwmgr *hwmgr)
>  {
> @@ -4714,10 +4714,10 @@ static int smu7_get_memory_type(struct pp_hwmgr *=
hwmgr)
>  }
>
>  /**
> - * Enables Dynamic Power Management by SMC
> + * smu7_enable_acpi_power_management - Enables Dynamic Power Management =
by SMC
>   *
> - * @param    hwmgr  the address of the powerplay hardware manager.
> - * @return   always 0
> + * @hwmgr:  the address of the powerplay hardware manager.
> + * Return:   always 0
>   */
>  static int smu7_enable_acpi_power_management(struct pp_hwmgr *hwmgr)
>  {
> @@ -4728,10 +4728,10 @@ static int smu7_enable_acpi_power_management(stru=
ct pp_hwmgr *hwmgr)
>  }
>
>  /**
> - * Initialize PowerGating States for different engines
> + * smu7_init_power_gate_state - Initialize PowerGating States for differ=
ent engines
>   *
> - * @param    hwmgr  the address of the powerplay hardware manager.
> - * @return   always 0
> + * @hwmgr:  the address of the powerplay hardware manager.
> + * Return:   always 0
>   */
>  static int smu7_init_power_gate_state(struct pp_hwmgr *hwmgr)
>  {
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
