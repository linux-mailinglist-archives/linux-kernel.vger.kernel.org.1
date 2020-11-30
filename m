Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 316E12C931A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 00:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730485AbgK3Xu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 18:50:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728746AbgK3Xu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 18:50:26 -0500
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7AB1C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 15:49:40 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id j15so16218976oih.4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 15:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HVZpTooF7hAtPwsEvgiChs4HEIlbYXKCaLTRuLtMB0w=;
        b=YkpR5fvtyhyxQxiRUSsBpwKjuQD9vU3HM+RfKxKJiBAGdh2jKzikuQTpAstLZ9q6Bx
         AfE+Xua8bra4CC10XBMQudcPV1mmkb7/hhl4M8e33gSpxfGU9MMwZ1HSUhFwr5Lsi9DA
         9GhtPDypLip3UjCGlAddlSE5L9AIYWrw9+HeUXMCv1J3Twe6zEeXd5cYOKgEYCdnrTeH
         jQ1ms5f+Jjpp2NyWVukgMLne7tUbBJ+z5T76Sk8haPe+QKsujnqhPDh2DznhsFO06cks
         aASsGLPJlD+fvj7g5+ReQmNArico3hF8yL+BwlM/gSY1YgQ78b8PDZc4MPRzzxcrH3zG
         va1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HVZpTooF7hAtPwsEvgiChs4HEIlbYXKCaLTRuLtMB0w=;
        b=tYLQTUtT+XCn4bmBZgGBxK5UUk2zm++M8+WLC1YRD7KVZFD3DoeX41TGRA0o/jaxw2
         wiwAwPnCxLi1ATutc/L97goo02PEtRddmq6RNk99OoZzmNX+GzO6E0m9whuwnagRYofA
         utp/pYJQ/ZnbIixsXCse2cOePZxaBvFo9y0vbdEDmnk/k1I6TRSrcbAnA+2cQR7ORMHH
         Cb5Rb6rlAx8L/upljOqhXUzSYjSuDXmk3L1CrsSlD60xziVrhDzEJdDEa5zbWgG71JSr
         Q+jaJL/hH1Xw5c69L8BMZZPW2BJjcNZKO8qEUJlv3uXmq06TB32RQQa7sCarOkuvZISE
         ktMg==
X-Gm-Message-State: AOAM531EZoeOb5SvZTpM2DPABEhJckDtvJmRo/0nYJRBzRR6RElGQqoP
        b4IvBn/BBwJsac9EOKO4zkNX/bWmgWin+oii6Iw=
X-Google-Smtp-Source: ABdhPJwAO1GxAG9CVK9t8sjPiPUjqedeNAQKVvLbUnEKoRxuFqbXXsHngAhH4rTSW1ZpCpuyvktDRcxRxcJXF+EOYV0=
X-Received: by 2002:aca:4f53:: with SMTP id d80mr7952oib.120.1606780180022;
 Mon, 30 Nov 2020 15:49:40 -0800 (PST)
MIME-Version: 1.0
References: <20201126134240.3214176-1-lee.jones@linaro.org> <20201126134240.3214176-25-lee.jones@linaro.org>
In-Reply-To: <20201126134240.3214176-25-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 30 Nov 2020 18:49:28 -0500
Message-ID: <CADnq5_PZxwvJ5GNGc1U6cwWP0RPniu3G5fZtKZa5Yvks45A10A@mail.gmail.com>
Subject: Re: [PATCH 24/40] drm/amd/pm/powerplay/hwmgr/vega10_thermal: Fix a
 bunch of dated function doc formatting
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
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega10_thermal.c:128: w=
arning: Function parameter or member 'hwmgr' not described in 'vega10_fan_c=
trl_set_static_mode'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega10_thermal.c:128: w=
arning: Function parameter or member 'mode' not described in 'vega10_fan_ct=
rl_set_static_mode'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega10_thermal.c:157: w=
arning: Function parameter or member 'hwmgr' not described in 'vega10_fan_c=
trl_set_default_mode'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega10_thermal.c:176: w=
arning: Cannot understand  * @fn vega10_enable_fan_control_feature
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega10_thermal.c:252: w=
arning: Function parameter or member 'hwmgr' not described in 'vega10_fan_c=
trl_set_fan_speed_percent'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega10_thermal.c:252: w=
arning: Function parameter or member 'speed' not described in 'vega10_fan_c=
trl_set_fan_speed_percent'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega10_thermal.c:290: w=
arning: Function parameter or member 'hwmgr' not described in 'vega10_fan_c=
trl_reset_fan_speed_to_default'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega10_thermal.c:307: w=
arning: Function parameter or member 'hwmgr' not described in 'vega10_fan_c=
trl_set_fan_speed_rpm'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega10_thermal.c:307: w=
arning: Function parameter or member 'speed' not described in 'vega10_fan_c=
trl_set_fan_speed_rpm'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega10_thermal.c:339: w=
arning: Function parameter or member 'hwmgr' not described in 'vega10_therm=
al_get_temperature'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega10_thermal.c:365: w=
arning: Function parameter or member 'hwmgr' not described in 'vega10_therm=
al_set_temperature_range'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega10_thermal.c:365: w=
arning: Function parameter or member 'range' not described in 'vega10_therm=
al_set_temperature_range'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega10_thermal.c:414: w=
arning: Function parameter or member 'hwmgr' not described in 'vega10_therm=
al_initialize'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega10_thermal.c:437: w=
arning: Function parameter or member 'hwmgr' not described in 'vega10_therm=
al_enable_alert'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega10_thermal.c:468: w=
arning: Function parameter or member 'hwmgr' not described in 'vega10_therm=
al_disable_alert'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega10_thermal.c:496: w=
arning: Function parameter or member 'hwmgr' not described in 'vega10_therm=
al_stop_thermal_controller'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega10_thermal.c:515: w=
arning: Function parameter or member 'hwmgr' not described in 'vega10_therm=
al_setup_fan_table'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega10_thermal.c:618: w=
arning: Function parameter or member 'hwmgr' not described in 'vega10_therm=
al_start_smc_fan_control'
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
>  .../amd/pm/powerplay/hwmgr/vega10_thermal.c   | 131 ++++++++----------
>  1 file changed, 61 insertions(+), 70 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c b/dr=
ivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c
> index 952cd3d7240e3..9b46b27bd30c4 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c
> @@ -118,12 +118,12 @@ int vega10_fan_ctrl_get_fan_speed_rpm(struct pp_hwm=
gr *hwmgr, uint32_t *speed)
>  }
>
>  /**
> -* Set Fan Speed Control to static mode,
> -* so that the user can decide what speed to use.
> -* @param    hwmgr  the address of the powerplay hardware manager.
> -*           mode the fan control mode, 0 default, 1 by percent, 5, by RP=
M
> -* @exception Should always succeed.
> -*/
> + * vega10_fan_ctrl_set_static_mode - Set Fan Speed Control to static mod=
e,
> + * so that the user can decide what speed to use.
> + * @hwmgr:  the address of the powerplay hardware manager.
> + * @mode: the fan control mode, 0 default, 1 by percent, 5, by RPM
> + * Exception: Should always succeed.
> + */
>  int vega10_fan_ctrl_set_static_mode(struct pp_hwmgr *hwmgr, uint32_t mod=
e)
>  {
>         struct amdgpu_device *adev =3D hwmgr->adev;
> @@ -149,10 +149,10 @@ int vega10_fan_ctrl_set_static_mode(struct pp_hwmgr=
 *hwmgr, uint32_t mode)
>  }
>
>  /**
> -* Reset Fan Speed Control to default mode.
> -* @param    hwmgr  the address of the powerplay hardware manager.
> -* @exception Should always succeed.
> -*/
> + * vega10_fan_ctrl_set_default_mode - Reset Fan Speed Control to default=
 mode.
> + * @hwmgr:  the address of the powerplay hardware manager.
> + * Exception: Should always succeed.
> + */
>  int vega10_fan_ctrl_set_default_mode(struct pp_hwmgr *hwmgr)
>  {
>         struct amdgpu_device *adev =3D hwmgr->adev;
> @@ -173,11 +173,10 @@ int vega10_fan_ctrl_set_default_mode(struct pp_hwmg=
r *hwmgr)
>  }
>
>  /**
> - * @fn vega10_enable_fan_control_feature
> - * @brief Enables the SMC Fan Control Feature.
> + * vega10_enable_fan_control_feature - Enables the SMC Fan Control Featu=
re.
>   *
> - * @param    hwmgr - the address of the powerplay hardware manager.
> - * @return   0 on success. -1 otherwise.
> + * @hwmgr: the address of the powerplay hardware manager.
> + * Return:   0 on success. -1 otherwise.
>   */
>  static int vega10_enable_fan_control_feature(struct pp_hwmgr *hwmgr)
>  {
> @@ -242,11 +241,11 @@ int vega10_fan_ctrl_stop_smc_fan_control(struct pp_=
hwmgr *hwmgr)
>  }
>
>  /**
> -* Set Fan Speed in percent.
> -* @param    hwmgr  the address of the powerplay hardware manager.
> -* @param    speed is the percentage value (0% - 100%) to be set.
> -* @exception Fails is the 100% setting appears to be 0.
> -*/
> + * vega10_fan_ctrl_set_fan_speed_percent - Set Fan Speed in percent.
> + * @hwmgr:  the address of the powerplay hardware manager.
> + * @speed: is the percentage value (0% - 100%) to be set.
> + * Exception: Fails is the 100% setting appears to be 0.
> + */
>  int vega10_fan_ctrl_set_fan_speed_percent(struct pp_hwmgr *hwmgr,
>                 uint32_t speed)
>  {
> @@ -282,10 +281,10 @@ int vega10_fan_ctrl_set_fan_speed_percent(struct pp=
_hwmgr *hwmgr,
>  }
>
>  /**
> -* Reset Fan Speed to default.
> -* @param    hwmgr  the address of the powerplay hardware manager.
> -* @exception Always succeeds.
> -*/
> + * vega10_fan_ctrl_reset_fan_speed_to_default - Reset Fan Speed to defau=
lt.
> + * @hwmgr:  the address of the powerplay hardware manager.
> + * Exception: Always succeeds.
> + */
>  int vega10_fan_ctrl_reset_fan_speed_to_default(struct pp_hwmgr *hwmgr)
>  {
>         if (hwmgr->thermal_controller.fanInfo.bNoFan)
> @@ -298,11 +297,11 @@ int vega10_fan_ctrl_reset_fan_speed_to_default(stru=
ct pp_hwmgr *hwmgr)
>  }
>
>  /**
> -* Set Fan Speed in RPM.
> -* @param    hwmgr  the address of the powerplay hardware manager.
> -* @param    speed is the percentage value (min - max) to be set.
> -* @exception Fails is the speed not lie between min and max.
> -*/
> + * vega10_fan_ctrl_set_fan_speed_rpm - Set Fan Speed in RPM.
> + * @hwmgr:  the address of the powerplay hardware manager.
> + * @speed: is the percentage value (min - max) to be set.
> + * Exception: Fails is the speed not lie between min and max.
> + */
>  int vega10_fan_ctrl_set_fan_speed_rpm(struct pp_hwmgr *hwmgr, uint32_t s=
peed)
>  {
>         struct amdgpu_device *adev =3D hwmgr->adev;
> @@ -331,10 +330,10 @@ int vega10_fan_ctrl_set_fan_speed_rpm(struct pp_hwm=
gr *hwmgr, uint32_t speed)
>  }
>
>  /**
> -* Reads the remote temperature from the SIslands thermal controller.
> -*
> -* @param    hwmgr The address of the hardware manager.
> -*/
> + * vega10_thermal_get_temperature - Reads the remote temperature from th=
e SIslands thermal controller.
> + *
> + * @hwmgr: The address of the hardware manager.
> + */
>  int vega10_thermal_get_temperature(struct pp_hwmgr *hwmgr)
>  {
>         struct amdgpu_device *adev =3D hwmgr->adev;
> @@ -353,13 +352,13 @@ int vega10_thermal_get_temperature(struct pp_hwmgr =
*hwmgr)
>  }
>
>  /**
> -* Set the requested temperature range for high and low alert signals
> -*
> -* @param    hwmgr The address of the hardware manager.
> -* @param    range Temperature range to be programmed for
> -*           high and low alert signals
> -* @exception PP_Result_BadInput if the input data is not valid.
> -*/
> + * vega10_thermal_set_temperature_range - Set the requested temperature =
range for high and low alert signals
> + *
> + * @hwmgr: The address of the hardware manager.
> + * @range: Temperature range to be programmed for
> + *           high and low alert signals
> + * Exception: PP_Result_BadInput if the input data is not valid.
> + */
>  static int vega10_thermal_set_temperature_range(struct pp_hwmgr *hwmgr,
>                 struct PP_TemperatureRange *range)
>  {
> @@ -406,10 +405,10 @@ static int vega10_thermal_set_temperature_range(str=
uct pp_hwmgr *hwmgr,
>  }
>
>  /**
> -* Programs thermal controller one-time setting registers
> -*
> -* @param    hwmgr The address of the hardware manager.
> -*/
> + * vega10_thermal_initialize - Programs thermal controller one-time sett=
ing registers
> + *
> + * @hwmgr: The address of the hardware manager.
> + */
>  static int vega10_thermal_initialize(struct pp_hwmgr *hwmgr)
>  {
>         struct amdgpu_device *adev =3D hwmgr->adev;
> @@ -429,10 +428,10 @@ static int vega10_thermal_initialize(struct pp_hwmg=
r *hwmgr)
>  }
>
>  /**
> -* Enable thermal alerts on the RV770 thermal controller.
> -*
> -* @param    hwmgr The address of the hardware manager.
> -*/
> + * vega10_thermal_enable_alert - Enable thermal alerts on the RV770 ther=
mal controller.
> + *
> + * @hwmgr: The address of the hardware manager.
> + */
>  static int vega10_thermal_enable_alert(struct pp_hwmgr *hwmgr)
>  {
>         struct amdgpu_device *adev =3D hwmgr->adev;
> @@ -461,9 +460,9 @@ static int vega10_thermal_enable_alert(struct pp_hwmg=
r *hwmgr)
>  }
>
>  /**
> -* Disable thermal alerts on the RV770 thermal controller.
> -* @param    hwmgr The address of the hardware manager.
> -*/
> + * vega10_thermal_disable_alert - Disable thermal alerts on the RV770 th=
ermal controller.
> + * @hwmgr: The address of the hardware manager.
> + */
>  int vega10_thermal_disable_alert(struct pp_hwmgr *hwmgr)
>  {
>         struct amdgpu_device *adev =3D hwmgr->adev;
> @@ -488,10 +487,10 @@ int vega10_thermal_disable_alert(struct pp_hwmgr *h=
wmgr)
>  }
>
>  /**
> -* Uninitialize the thermal controller.
> -* Currently just disables alerts.
> -* @param    hwmgr The address of the hardware manager.
> -*/
> + * vega10_thermal_stop_thermal_controller - Uninitialize the thermal con=
troller.
> + * Currently just disables alerts.
> + * @hwmgr: The address of the hardware manager.
> + */
>  int vega10_thermal_stop_thermal_controller(struct pp_hwmgr *hwmgr)
>  {
>         int result =3D vega10_thermal_disable_alert(hwmgr);
> @@ -503,14 +502,10 @@ int vega10_thermal_stop_thermal_controller(struct p=
p_hwmgr *hwmgr)
>  }
>
>  /**
> -* Set up the fan table to control the fan using the SMC.
> -* @param    hwmgr  the address of the powerplay hardware manager.
> -* @param    pInput the pointer to input data
> -* @param    pOutput the pointer to output data
> -* @param    pStorage the pointer to temporary storage
> -* @param    Result the last failure code
> -* @return   result from set temperature range routine
> -*/
> + * vega10_thermal_setup_fan_table - Set up the fan table to control the =
fan using the SMC.
> + * @hwmgr:  the address of the powerplay hardware manager.
> + * Return:   result from set temperature range routine
> + */
>  static int vega10_thermal_setup_fan_table(struct pp_hwmgr *hwmgr)
>  {
>         int ret;
> @@ -606,14 +601,10 @@ int vega10_enable_mgpu_fan_boost(struct pp_hwmgr *h=
wmgr)
>  }
>
>  /**
> -* Start the fan control on the SMC.
> -* @param    hwmgr  the address of the powerplay hardware manager.
> -* @param    pInput the pointer to input data
> -* @param    pOutput the pointer to output data
> -* @param    pStorage the pointer to temporary storage
> -* @param    Result the last failure code
> -* @return   result from set temperature range routine
> -*/
> + * vega10_thermal_start_smc_fan_control - Start the fan control on the S=
MC.
> + * @hwmgr:  the address of the powerplay hardware manager.
> + * Return:   result from set temperature range routine
> + */
>  static int vega10_thermal_start_smc_fan_control(struct pp_hwmgr *hwmgr)
>  {
>  /* If the fantable setup has failed we could have disabled
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
