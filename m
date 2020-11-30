Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA8432C9360
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 00:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730595AbgK3XyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 18:54:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730448AbgK3XyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 18:54:04 -0500
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFBBFC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 15:53:23 -0800 (PST)
Received: by mail-oo1-xc41.google.com with SMTP id l10so3106840oom.6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 15:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NHHcPwGriN5gHC4uSv5ls7SmKd9BGTWdDkFbwUWhYHQ=;
        b=KMbj3ZpzPjtCxxrCy1rf2XAqnoS5tGfvloqMyxIZu7d/bO3nCrEpXaPPqoP1cSyxmF
         Due2qTxk9wpZKPXPQOlNJ7/S4+gdp1TWyYNeAjHg3VZfiebFC1AXNtSe0GgD6aaHw1yv
         Go0Dd5Db0geF3H9E8LzyI5AKHGoLzKmOv5XcejNR29JsDo4/7tleJ7NzNgnNlKIPIkOs
         rKfq9JjmMc8s6KRJzxluDFkJZNukYL44S/r484klPg3g4qCqcmWOjiz4BxfQv0Iwwjku
         9SAonQ34OCzSVrMoMmfeYkAr3WJCVUvV52wobbYw8dWX77Qr8MRabqYSVdKR8YJFptEy
         bvNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NHHcPwGriN5gHC4uSv5ls7SmKd9BGTWdDkFbwUWhYHQ=;
        b=P6ZUdSholpNaeYdz99sxdlr+D45oyDX+Mnapf+qctWTfIV4hsDVGHnqM5zM469A0bK
         eSaYaSDjRTW0vawkPLNhsnYmjRehh437TX7tjL87Q9n1GUP37BEGeJ3qU3k5xuKM8Ea/
         UjBbtXN7IPbiFulSPjUHTtSCtaeIumfIbR1mdFa3xjbr3tzVfnuHgv8rtFdxkGGd4kg+
         iNqRNosuIj6QJF9OQN32Fy9M2bvtOKH1EJ7pJOaoSIpKswuCx4194jfGEyF3U/kSHpo1
         W5k720QVomYRSiUnO+R/0+bhVNIXh8o+j2o+H1Bmhr1JM1zLr+ejlYUY8ac3I8HZjTMH
         g7ng==
X-Gm-Message-State: AOAM5311XG3cV1MPHIWbng3CXJU0HQIZ8KbFlf0TqUuOcidzPvqOUyrS
        ohxPZEmbpvpzXUVKgXsT7wd8kUu173AqsjiwEk4=
X-Google-Smtp-Source: ABdhPJxBO01WNQ9ZTWgBQkpP9dCnXQzmSPjr5/phSUeAOmUvsKbi/eQ+8nhS2f9yaLFpkSwKV6g5l8M1fbgcVSU01Wk=
X-Received: by 2002:a4a:e0ce:: with SMTP id e14mr60877oot.72.1606780403439;
 Mon, 30 Nov 2020 15:53:23 -0800 (PST)
MIME-Version: 1.0
References: <20201126134240.3214176-1-lee.jones@linaro.org> <20201126134240.3214176-30-lee.jones@linaro.org>
In-Reply-To: <20201126134240.3214176-30-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 30 Nov 2020 18:53:11 -0500
Message-ID: <CADnq5_Od260OHDBTfOh+7n9Lb8At0uF96=aYB1ZPsFDu=ddCtg@mail.gmail.com>
Subject: Re: [PATCH 29/40] drm/amd/pm/powerplay/hwmgr/vega20_thermal: Fix some
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
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega20_thermal.c:217: w=
arning: Function parameter or member 'hwmgr' not described in 'vega20_therm=
al_get_temperature'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega20_thermal.c:242: w=
arning: Function parameter or member 'hwmgr' not described in 'vega20_therm=
al_set_temperature_range'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega20_thermal.c:242: w=
arning: Function parameter or member 'range' not described in 'vega20_therm=
al_set_temperature_range'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega20_thermal.c:278: w=
arning: Function parameter or member 'hwmgr' not described in 'vega20_therm=
al_enable_alert'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega20_thermal.c:296: w=
arning: Function parameter or member 'hwmgr' not described in 'vega20_therm=
al_disable_alert'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega20_thermal.c:310: w=
arning: Function parameter or member 'hwmgr' not described in 'vega20_therm=
al_stop_thermal_controller'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega20_thermal.c:326: w=
arning: Function parameter or member 'hwmgr' not described in 'vega20_therm=
al_setup_fan_table'
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
>  .../amd/pm/powerplay/hwmgr/vega20_thermal.c   | 54 +++++++++----------
>  1 file changed, 24 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_thermal.c b/dr=
ivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_thermal.c
> index 364162ddaa9c6..269dd7e95a445 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_thermal.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_thermal.c
> @@ -209,10 +209,10 @@ int vega20_fan_ctrl_set_fan_speed_rpm(struct pp_hwm=
gr *hwmgr, uint32_t speed)
>  }
>
>  /**
> -* Reads the remote temperature from the SIslands thermal controller.
> -*
> -* @param    hwmgr The address of the hardware manager.
> -*/
> + * vega20_thermal_get_temperature - Reads the remote temperature from th=
e SIslands thermal controller.
> + *
> + * @hwmgr: The address of the hardware manager.
> + */
>  int vega20_thermal_get_temperature(struct pp_hwmgr *hwmgr)
>  {
>         struct amdgpu_device *adev =3D hwmgr->adev;
> @@ -230,13 +230,12 @@ int vega20_thermal_get_temperature(struct pp_hwmgr =
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
> + * vega20_thermal_set_temperature_range - Set the requested temperature =
range for high and low alert signals
> + *
> + * @hwmgr: The address of the hardware manager.
> + * @range: Temperature range to be programmed for high and low alert sig=
nals
> + * Exception: PP_Result_BadInput if the input data is not valid.
> + */
>  static int vega20_thermal_set_temperature_range(struct pp_hwmgr *hwmgr,
>                 struct PP_TemperatureRange *range)
>  {
> @@ -270,10 +269,10 @@ static int vega20_thermal_set_temperature_range(str=
uct pp_hwmgr *hwmgr,
>  }
>
>  /**
> -* Enable thermal alerts on the RV770 thermal controller.
> -*
> -* @param    hwmgr The address of the hardware manager.
> -*/
> + * vega20_thermal_enable_alert - Enable thermal alerts on the RV770 ther=
mal controller.
> + *
> + * @hwmgr: The address of the hardware manager.
> + */
>  static int vega20_thermal_enable_alert(struct pp_hwmgr *hwmgr)
>  {
>         struct amdgpu_device *adev =3D hwmgr->adev;
> @@ -289,9 +288,9 @@ static int vega20_thermal_enable_alert(struct pp_hwmg=
r *hwmgr)
>  }
>
>  /**
> -* Disable thermal alerts on the RV770 thermal controller.
> -* @param    hwmgr The address of the hardware manager.
> -*/
> + * vega20_thermal_disable_alert - Disable thermal alerts on the RV770 th=
ermal controller.
> + * @hwmgr: The address of the hardware manager.
> + */
>  int vega20_thermal_disable_alert(struct pp_hwmgr *hwmgr)
>  {
>         struct amdgpu_device *adev =3D hwmgr->adev;
> @@ -302,10 +301,10 @@ int vega20_thermal_disable_alert(struct pp_hwmgr *h=
wmgr)
>  }
>
>  /**
> -* Uninitialize the thermal controller.
> -* Currently just disables alerts.
> -* @param    hwmgr The address of the hardware manager.
> -*/
> + * vega20_thermal_stop_thermal_controller - Uninitialize the thermal con=
troller.
> + * Currently just disables alerts.
> + * @hwmgr: The address of the hardware manager.
> + */
>  int vega20_thermal_stop_thermal_controller(struct pp_hwmgr *hwmgr)
>  {
>         int result =3D vega20_thermal_disable_alert(hwmgr);
> @@ -314,14 +313,9 @@ int vega20_thermal_stop_thermal_controller(struct pp=
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
> + * vega20_thermal_setup_fan_table - Set up the fan table to control the =
fan using the SMC.
> + * @hwmgr:  the address of the powerplay hardware manager.
> + */
>  static int vega20_thermal_setup_fan_table(struct pp_hwmgr *hwmgr)
>  {
>         int ret;
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
