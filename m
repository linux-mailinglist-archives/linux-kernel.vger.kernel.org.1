Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65BEE2C9362
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 00:55:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730668AbgK3XzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 18:55:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729600AbgK3XzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 18:55:02 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2779FC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 15:54:22 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id n12so13160851otk.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 15:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8TPXKJCWuw3SmK/LJVZlS1aNM+mO64u0DgLoqdZJPVQ=;
        b=RfXZVWzBBAlCW8JM4E1AbBuOW+HyToiN1uMWZVM7O9FoKRLZSlpM84972cl/ZIChy9
         XftvJBQCq6oiN30Xwe4L2NNLKSAqFGpiTNOpd4JZ5pj7QUC+H4BIL4RJlXNBNhGjitJP
         Ok8BjW737tR9LhZIZhWD3zzkpzdM3Lgelc364BbcH6xJeftOJROzXttBHfi9EKCSmPMT
         9J5dcBQFwyom7WWGnr46gzJpHeNU7GueV+gq/ai9Z23/uWK5dPbuJTrFGVtOt0wR5idx
         L4ZaFUH1NxvpkGtr1Q6r29hdrHZoNuceMJzrSAJJ5uI6lIp2gp27WPtwUwrMftOsq0xc
         e6Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8TPXKJCWuw3SmK/LJVZlS1aNM+mO64u0DgLoqdZJPVQ=;
        b=O5wDmS1MJMkXBR5VdxjfhBcidSRmwaw27IT5VfvUhKlNqMHKRkfbfmN9Cx7inRIwnz
         fCtMkRWR/975gN8kab4ICR6YdgJExh9ieSPpv5fg+O+quWZeRJklDA1hw+EtD4kT1daz
         MYdYjYb2hueRT532Cv+AKmQYmdImnn5EV20fco6IJWcO0zjelYKf0nIwIU5yB/8PCV66
         dvqbXx69mh01An1fFjnMKvw4cf+pzewNXpmY/9/O1ijRDicAi4xS2Ge+3otTFpntGT1t
         QzcLJvQFH56G/YVFU8iG1obqU2uWRf+ou0Zj8RDAx98RrJUYbzEIplm9yBZ8da8j2vTo
         Zt4g==
X-Gm-Message-State: AOAM533grT/VbsLNN7QKXZTf7TMCnZnK4NpPzJv7rjNKN4/qvW4A/wP+
        FfKiscPgBAQUAcT5rrk1+rCZiBb0qMhWJc3QmyQ=
X-Google-Smtp-Source: ABdhPJzxxjRuC2GOXnyYGLtk6xQTYs/jtuO9BJcS++ZhHW+8kSVhXG9zUxIcNMO7rSKEQ4ZaaMnQa/7WHzyBRvfu4AE=
X-Received: by 2002:a9d:5388:: with SMTP id w8mr19017264otg.311.1606780461610;
 Mon, 30 Nov 2020 15:54:21 -0800 (PST)
MIME-Version: 1.0
References: <20201126134240.3214176-1-lee.jones@linaro.org> <20201126134240.3214176-31-lee.jones@linaro.org>
In-Reply-To: <20201126134240.3214176-31-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 30 Nov 2020 18:54:10 -0500
Message-ID: <CADnq5_Nx-6-CpBEYS=vNtvABakARnQO4+0QP1EtcJCykLK+2nA@mail.gmail.com>
Subject: Re: [PATCH 30/40] drm/amd/pm/powerplay/hwmgr/vega12_thermal: Fix some
 outdated function documentation
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
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega12_thermal.c:63: wa=
rning: Cannot understand  * @fn vega12_enable_fan_control_feature
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega12_thermal.c:137: w=
arning: Function parameter or member 'hwmgr' not described in 'vega12_fan_c=
trl_reset_fan_speed_to_default'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega12_thermal.c:147: w=
arning: Function parameter or member 'hwmgr' not described in 'vega12_therm=
al_get_temperature'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega12_thermal.c:172: w=
arning: Function parameter or member 'hwmgr' not described in 'vega12_therm=
al_set_temperature_range'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega12_thermal.c:172: w=
arning: Function parameter or member 'range' not described in 'vega12_therm=
al_set_temperature_range'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega12_thermal.c:208: w=
arning: Function parameter or member 'hwmgr' not described in 'vega12_therm=
al_enable_alert'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega12_thermal.c:226: w=
arning: Function parameter or member 'hwmgr' not described in 'vega12_therm=
al_disable_alert'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega12_thermal.c:240: w=
arning: Function parameter or member 'hwmgr' not described in 'vega12_therm=
al_stop_thermal_controller'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega12_thermal.c:256: w=
arning: Function parameter or member 'hwmgr' not described in 'vega12_therm=
al_setup_fan_table'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega12_thermal.c:279: w=
arning: Function parameter or member 'hwmgr' not described in 'vega12_therm=
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
>  .../amd/pm/powerplay/hwmgr/vega12_thermal.c   | 82 ++++++++-----------
>  1 file changed, 36 insertions(+), 46 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_thermal.c b/dr=
ivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_thermal.c
> index 7ace439dcde7a..0dc16f25a463b 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_thermal.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_thermal.c
> @@ -60,11 +60,10 @@ int vega12_fan_ctrl_get_fan_speed_rpm(struct pp_hwmgr=
 *hwmgr, uint32_t *speed)
>  }
>
>  /**
> - * @fn vega12_enable_fan_control_feature
> - * @brief Enables the SMC Fan Control Feature.
> + * vega12_enable_fan_control_feature -Enables the SMC Fan Control Featur=
e.
>   *
> - * @param    hwmgr - the address of the powerplay hardware manager.
> - * @return   0 on success. -1 otherwise.
> + * @hwmgr: the address of the powerplay hardware manager.
> + * Return:   0 on success. -1 otherwise.
>   */
>  static int vega12_enable_fan_control_feature(struct pp_hwmgr *hwmgr)
>  {
> @@ -129,20 +128,20 @@ int vega12_fan_ctrl_stop_smc_fan_control(struct pp_=
hwmgr *hwmgr)
>  }
>
>  /**
> -* Reset Fan Speed to default.
> -* @param    hwmgr  the address of the powerplay hardware manager.
> -* @exception Always succeeds.
> -*/
> + * vega12_fan_ctrl_reset_fan_speed_to_default - Reset Fan Speed to defau=
lt.
> + * @hwmgr:  the address of the powerplay hardware manager.
> + * Exception Always succeeds.
> + */
>  int vega12_fan_ctrl_reset_fan_speed_to_default(struct pp_hwmgr *hwmgr)
>  {
>         return vega12_fan_ctrl_start_smc_fan_control(hwmgr);
>  }
>
>  /**
> -* Reads the remote temperature from the SIslands thermal controller.
> -*
> -* @param    hwmgr The address of the hardware manager.
> -*/
> + * vega12_thermal_get_temperature - Reads the remote temperature from th=
e SIslands thermal controller.
> + *
> + * @hwmgr: The address of the hardware manager.
> + */
>  int vega12_thermal_get_temperature(struct pp_hwmgr *hwmgr)
>  {
>         struct amdgpu_device *adev =3D hwmgr->adev;
> @@ -160,13 +159,13 @@ int vega12_thermal_get_temperature(struct pp_hwmgr =
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
> + * Set the requested temperature range for high and low alert signals
> + *
> + * @hwmgr: The address of the hardware manager.
> + * @range: Temperature range to be programmed for
> + *           high and low alert signals
> + * Exception: PP_Result_BadInput if the input data is not valid.
> + */
>  static int vega12_thermal_set_temperature_range(struct pp_hwmgr *hwmgr,
>                 struct PP_TemperatureRange *range)
>  {
> @@ -200,10 +199,10 @@ static int vega12_thermal_set_temperature_range(str=
uct pp_hwmgr *hwmgr,
>  }
>
>  /**
> -* Enable thermal alerts on the RV770 thermal controller.
> -*
> -* @param    hwmgr The address of the hardware manager.
> -*/
> + * vega12_thermal_enable_alert - Enable thermal alerts on the RV770 ther=
mal controller.
> + *
> + * @hwmgr: The address of the hardware manager.
> + */
>  static int vega12_thermal_enable_alert(struct pp_hwmgr *hwmgr)
>  {
>         struct amdgpu_device *adev =3D hwmgr->adev;
> @@ -219,9 +218,9 @@ static int vega12_thermal_enable_alert(struct pp_hwmg=
r *hwmgr)
>  }
>
>  /**
> -* Disable thermal alerts on the RV770 thermal controller.
> -* @param    hwmgr The address of the hardware manager.
> -*/
> + * vega12_thermal_disable_alert - Disable thermal alerts on the RV770 th=
ermal controller.
> + * @hwmgr: The address of the hardware manager.
> + */
>  int vega12_thermal_disable_alert(struct pp_hwmgr *hwmgr)
>  {
>         struct amdgpu_device *adev =3D hwmgr->adev;
> @@ -232,10 +231,10 @@ int vega12_thermal_disable_alert(struct pp_hwmgr *h=
wmgr)
>  }
>
>  /**
> -* Uninitialize the thermal controller.
> -* Currently just disables alerts.
> -* @param    hwmgr The address of the hardware manager.
> -*/
> + * vega12_thermal_stop_thermal_controller - Uninitialize the thermal con=
troller.
> + * Currently just disables alerts.
> + * @hwmgr: The address of the hardware manager.
> + */
>  int vega12_thermal_stop_thermal_controller(struct pp_hwmgr *hwmgr)
>  {
>         int result =3D vega12_thermal_disable_alert(hwmgr);
> @@ -244,14 +243,9 @@ int vega12_thermal_stop_thermal_controller(struct pp=
_hwmgr *hwmgr)
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
> + * vega12_thermal_setup_fan_table - Set up the fan table to control the =
fan using the SMC.
> + * @hwmgr:  the address of the powerplay hardware manager.
> + */
>  static int vega12_thermal_setup_fan_table(struct pp_hwmgr *hwmgr)
>  {
>         int ret;
> @@ -267,14 +261,10 @@ static int vega12_thermal_setup_fan_table(struct pp=
_hwmgr *hwmgr)
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
> + * vega12_thermal_start_smc_fan_control - Start the fan control on the S=
MC.
> + * @hwmgr:  the address of the powerplay hardware manager.
> + * Return:  result from set temperature range routine
> + */
>  static int vega12_thermal_start_smc_fan_control(struct pp_hwmgr *hwmgr)
>  {
>         /* If the fantable setup has failed we could have disabled
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
