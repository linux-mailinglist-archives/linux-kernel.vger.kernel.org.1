Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A33C2C9306
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 00:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388929AbgK3XtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 18:49:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387812AbgK3XtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 18:49:24 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 393C2C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 15:48:44 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id f12so13092350oto.10
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 15:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Bvx4pDZYPZCX35U6zzpbnRRIPOhC5pWiW3E6ZxD7RDY=;
        b=UwotRxxrPX+AGZSWfkvG8kxchkTqSitxI6nLOWtbkWJY7avlFm0otLZq+4xKyEUhhp
         j+b8yP8TGjvnX1lCOrDNk6I+Kx46txWsyGJX2AVrZKZpw79XBejXmtbO1G/+J8dvuIEN
         TBWBOMEQ9g25u4lqLzX93iT06rfK+nyMzbTq5m2x87A5EWOOf3z4UOQBfEwGncacKeKO
         2dG33PDZAPL6FyP6/SSItIURcZdSuYzOAQIA1vHBEWv8MhpOZYHCdmme9ayZu3T1Po6F
         SU7YEmV9XZL8iyOsqTLQMz5oJA7SVIh9u8Bav0awF2PUpCHYORBI8Jb/eq9iKH92U0R+
         +jvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Bvx4pDZYPZCX35U6zzpbnRRIPOhC5pWiW3E6ZxD7RDY=;
        b=df0errvnsRfEzhMCmwIeWcWA93+8hD7ylUOqOT9JgTXZFL5YQuyT/VkDuQYwjJVzeD
         8zAo1Rja9H3ec/lAVYQHUEJOzTZTK9VSUxtuNhVz/rPL/z231O0Kvz/4m07dIZYXuXkv
         AwPVsGM7I/YnRLpvumoZomdGZGYH0jWwYbJ9gzbp+29U/S23KJjQFDoLFr9JlETbiGaO
         WB5/cvAhM5+WiNZPXHQdGqherJanywxaCKd1JTWTCitmSfWfOFXV0Wmu9o9xLGbE/VxO
         QXuGh59wkt1T9Cww1nWf3aXJfND66cFLJ6bX3/jG2c6iB3/uDxrKntkFaQplR0SYeWlm
         M8PQ==
X-Gm-Message-State: AOAM533Z36V00EvkLVm7JinxbqoL/le7xWamIbk+sTJv2O5RccvXV+AU
        +4RNvcRP59ENMFfRDNpk1rkbBXItZi9Ug2U84OQ=
X-Google-Smtp-Source: ABdhPJzATgPrGRALIprWKWIxtDYmAhs46x3EiJWWjVM700ERSWFSdZdQzozhcDfBY9aN5ClJ8dOa14IvAxw7QliM2aA=
X-Received: by 2002:a9d:5388:: with SMTP id w8mr19001971otg.311.1606780123649;
 Mon, 30 Nov 2020 15:48:43 -0800 (PST)
MIME-Version: 1.0
References: <20201126134240.3214176-1-lee.jones@linaro.org> <20201126134240.3214176-24-lee.jones@linaro.org>
In-Reply-To: <20201126134240.3214176-24-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 30 Nov 2020 18:48:32 -0500
Message-ID: <CADnq5_PGWbuJcEtJ-eCJE40jjpfaAToma7OH6qd51C1VBqfXvA@mail.gmail.com>
Subject: Re: [PATCH 23/40] drm/amd/pm/powerplay/hwmgr/smu7_thermal: Repair
 formatting in a bunch of function docs
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
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_thermal.c:112: war=
ning: Function parameter or member 'hwmgr' not described in 'smu7_fan_ctrl_=
set_static_mode'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_thermal.c:112: war=
ning: Function parameter or member 'mode' not described in 'smu7_fan_ctrl_s=
et_static_mode'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_thermal.c:137: war=
ning: Function parameter or member 'hwmgr' not described in 'smu7_fan_ctrl_=
set_default_mode'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_thermal.c:209: war=
ning: Function parameter or member 'hwmgr' not described in 'smu7_fan_ctrl_=
set_fan_speed_percent'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_thermal.c:209: war=
ning: Function parameter or member 'speed' not described in 'smu7_fan_ctrl_=
set_fan_speed_percent'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_thermal.c:245: war=
ning: Function parameter or member 'hwmgr' not described in 'smu7_fan_ctrl_=
reset_fan_speed_to_default'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_thermal.c:268: war=
ning: Function parameter or member 'hwmgr' not described in 'smu7_fan_ctrl_=
set_fan_speed_rpm'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_thermal.c:268: war=
ning: Function parameter or member 'speed' not described in 'smu7_fan_ctrl_=
set_fan_speed_rpm'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_thermal.c:299: war=
ning: Function parameter or member 'hwmgr' not described in 'smu7_thermal_g=
et_temperature'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_thermal.c:325: war=
ning: Function parameter or member 'hwmgr' not described in 'smu7_thermal_s=
et_temperature_range'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_thermal.c:325: war=
ning: Function parameter or member 'low_temp' not described in 'smu7_therma=
l_set_temperature_range'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_thermal.c:325: war=
ning: Function parameter or member 'high_temp' not described in 'smu7_therm=
al_set_temperature_range'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_thermal.c:358: war=
ning: Function parameter or member 'hwmgr' not described in 'smu7_thermal_i=
nitialize'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_thermal.c:377: war=
ning: Function parameter or member 'hwmgr' not described in 'smu7_thermal_e=
nable_alert'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_thermal.c:395: war=
ning: Function parameter or member 'hwmgr' not described in 'smu7_thermal_d=
isable_alert'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_thermal.c:414: war=
ning: Function parameter or member 'hwmgr' not described in 'smu7_thermal_s=
top_thermal_controller'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_thermal.c:433: war=
ning: Function parameter or member 'hwmgr' not described in 'smu7_thermal_s=
tart_smc_fan_control'
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
>  .../drm/amd/pm/powerplay/hwmgr/smu7_thermal.c | 103 +++++++++---------
>  1 file changed, 50 insertions(+), 53 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.c b/driv=
ers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.c
> index e3d9d969d86ac..0d38d4206848a 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.c
> @@ -103,11 +103,11 @@ int smu7_fan_ctrl_get_fan_speed_rpm(struct pp_hwmgr=
 *hwmgr, uint32_t *speed)
>  }
>
>  /**
> -* Set Fan Speed Control to static mode, so that the user can decide what=
 speed to use.
> -* @param    hwmgr  the address of the powerplay hardware manager.
> -*           mode    the fan control mode, 0 default, 1 by percent, 5, by=
 RPM
> -* @exception Should always succeed.
> -*/
> + * smu7_fan_ctrl_set_static_mode - Set Fan Speed Control to static mode,=
 so that the user can decide what speed to use.
> + * @hwmgr:  the address of the powerplay hardware manager.
> + * @mode:   the fan control mode, 0 default, 1 by percent, 5, by RPM
> + * Exception: Should always succeed.
> + */
>  int smu7_fan_ctrl_set_static_mode(struct pp_hwmgr *hwmgr, uint32_t mode)
>  {
>         if (hwmgr->fan_ctrl_is_in_default_mode) {
> @@ -130,8 +130,8 @@ int smu7_fan_ctrl_set_static_mode(struct pp_hwmgr *hw=
mgr, uint32_t mode)
>
>  /**
>  * Reset Fan Speed Control to default mode.
> -* @param    hwmgr  the address of the powerplay hardware manager.
> -* @exception Should always succeed.
> +* @hwmgr:  the address of the powerplay hardware manager.
> +* Exception: Should always succeed.
>  */
>  int smu7_fan_ctrl_set_default_mode(struct pp_hwmgr *hwmgr)
>  {
> @@ -199,11 +199,11 @@ int smu7_fan_ctrl_stop_smc_fan_control(struct pp_hw=
mgr *hwmgr)
>  }
>
>  /**
> -* Set Fan Speed in percent.
> -* @param    hwmgr  the address of the powerplay hardware manager.
> -* @param    speed is the percentage value (0% - 100%) to be set.
> -* @exception Fails is the 100% setting appears to be 0.
> -*/
> + * smu7_fan_ctrl_set_fan_speed_percent - Set Fan Speed in percent.
> + * @hwmgr: the address of the powerplay hardware manager.
> + * @speed: is the percentage value (0% - 100%) to be set.
> + * Exception: Fails is the 100% setting appears to be 0.
> + */
>  int smu7_fan_ctrl_set_fan_speed_percent(struct pp_hwmgr *hwmgr,
>                 uint32_t speed)
>  {
> @@ -237,9 +237,9 @@ int smu7_fan_ctrl_set_fan_speed_percent(struct pp_hwm=
gr *hwmgr,
>  }
>
>  /**
> -* Reset Fan Speed to default.
> -* @param    hwmgr  the address of the powerplay hardware manager.
> -* @exception Always succeeds.
> +* smu7_fan_ctrl_reset_fan_speed_to_default - Reset Fan Speed to default.
> +* @hwmgr:  the address of the powerplay hardware manager.
> +* Exception: Always succeeds.
>  */
>  int smu7_fan_ctrl_reset_fan_speed_to_default(struct pp_hwmgr *hwmgr)
>  {
> @@ -259,11 +259,11 @@ int smu7_fan_ctrl_reset_fan_speed_to_default(struct=
 pp_hwmgr *hwmgr)
>  }
>
>  /**
> -* Set Fan Speed in RPM.
> -* @param    hwmgr  the address of the powerplay hardware manager.
> -* @param    speed is the percentage value (min - max) to be set.
> -* @exception Fails is the speed not lie between min and max.
> -*/
> + * smu7_fan_ctrl_set_fan_speed_rpm - Set Fan Speed in RPM.
> + * @hwmgr: the address of the powerplay hardware manager.
> + * @speed: is the percentage value (min - max) to be set.
> + * Exception: Fails is the speed not lie between min and max.
> + */
>  int smu7_fan_ctrl_set_fan_speed_rpm(struct pp_hwmgr *hwmgr, uint32_t spe=
ed)
>  {
>         uint32_t tach_period;
> @@ -291,10 +291,10 @@ int smu7_fan_ctrl_set_fan_speed_rpm(struct pp_hwmgr=
 *hwmgr, uint32_t speed)
>  }
>
>  /**
> -* Reads the remote temperature from the SIslands thermal controller.
> -*
> -* @param    hwmgr The address of the hardware manager.
> -*/
> + * smu7_thermal_get_temperature - Reads the remote temperature from the =
SIslands thermal controller.
> + *
> + * @hwmgr: The address of the hardware manager.
> + */
>  int smu7_thermal_get_temperature(struct pp_hwmgr *hwmgr)
>  {
>         int temp;
> @@ -314,12 +314,13 @@ int smu7_thermal_get_temperature(struct pp_hwmgr *h=
wmgr)
>  }
>
>  /**
> -* Set the requested temperature range for high and low alert signals
> -*
> -* @param    hwmgr The address of the hardware manager.
> -* @param    range Temperature range to be programmed for high and low al=
ert signals
> -* @exception PP_Result_BadInput if the input data is not valid.
> -*/
> + * smu7_thermal_set_temperature_range - Set the requested temperature ra=
nge for high and low alert signals
> + *
> + * @hwmgr: The address of the hardware manager.
> + * @low_temp: Temperature to be programmed for high alert signals
> + * @high_temp: Temperature to be programmed for low alert signals
> + * Exception: PP_Result_BadInput if the input data is not valid.
> + */
>  static int smu7_thermal_set_temperature_range(struct pp_hwmgr *hwmgr,
>                 int low_temp, int high_temp)
>  {
> @@ -350,10 +351,10 @@ static int smu7_thermal_set_temperature_range(struc=
t pp_hwmgr *hwmgr,
>  }
>
>  /**
> -* Programs thermal controller one-time setting registers
> -*
> -* @param    hwmgr The address of the hardware manager.
> -*/
> + * smu7_thermal_initialize - Programs thermal controller one-time settin=
g registers
> + *
> + * @hwmgr: The address of the hardware manager.
> + */
>  static int smu7_thermal_initialize(struct pp_hwmgr *hwmgr)
>  {
>         if (hwmgr->thermal_controller.fanInfo.ucTachometerPulsesPerRevolu=
tion)
> @@ -369,10 +370,10 @@ static int smu7_thermal_initialize(struct pp_hwmgr =
*hwmgr)
>  }
>
>  /**
> -* Enable thermal alerts on the RV770 thermal controller.
> -*
> -* @param    hwmgr The address of the hardware manager.
> -*/
> + * smu7_thermal_enable_alert - Enable thermal alerts on the RV770 therma=
l controller.
> + *
> + * @hwmgr: The address of the hardware manager.
> + */
>  static void smu7_thermal_enable_alert(struct pp_hwmgr *hwmgr)
>  {
>         uint32_t alert;
> @@ -388,9 +389,9 @@ static void smu7_thermal_enable_alert(struct pp_hwmgr=
 *hwmgr)
>  }
>
>  /**
> -* Disable thermal alerts on the RV770 thermal controller.
> -* @param    hwmgr The address of the hardware manager.
> -*/
> + * smu7_thermal_disable_alert - Disable thermal alerts on the RV770 ther=
mal controller.
> + * @hwmgr: The address of the hardware manager.
> + */
>  int smu7_thermal_disable_alert(struct pp_hwmgr *hwmgr)
>  {
>         uint32_t alert;
> @@ -406,10 +407,10 @@ int smu7_thermal_disable_alert(struct pp_hwmgr *hwm=
gr)
>  }
>
>  /**
> -* Uninitialize the thermal controller.
> -* Currently just disables alerts.
> -* @param    hwmgr The address of the hardware manager.
> -*/
> + * smu7_thermal_stop_thermal_controller - Uninitialize the thermal contr=
oller.
> + * Currently just disables alerts.
> + * @hwmgr: The address of the hardware manager.
> + */
>  int smu7_thermal_stop_thermal_controller(struct pp_hwmgr *hwmgr)
>  {
>         int result =3D smu7_thermal_disable_alert(hwmgr);
> @@ -421,14 +422,10 @@ int smu7_thermal_stop_thermal_controller(struct pp_=
hwmgr *hwmgr)
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
> + * smu7_thermal_start_smc_fan_control - Start the fan control on the SMC=
.
> + * @hwmgr:  the address of the powerplay hardware manager.
> + * Return:   result from set temperature range routine
> + */
>  static int smu7_thermal_start_smc_fan_control(struct pp_hwmgr *hwmgr)
>  {
>  /* If the fantable setup has failed we could have disabled
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
