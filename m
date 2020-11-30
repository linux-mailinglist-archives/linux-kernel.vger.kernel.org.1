Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBD2E2C92E1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 00:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388889AbgK3Xl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 18:41:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387524AbgK3Xl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 18:41:28 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43CB6C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 15:40:48 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id n12so13132535otk.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 15:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WUKv34qtxSOJIcfls0yKx8KJWtFAnXOJgFSnubgtGqg=;
        b=IGNh/RJJ87DgGvzDZ1Ckv9pW5bIUwmR/4ZzR3Jb781Wpda4RInP2blSGgETAfALxlm
         Bk89O2QyQu66fPm8rLnMtDaxdOrZkZ1cTHxF0DDbvEvyBznHGrw0aLnEO65qjplfba32
         Txd/XWn8CmXRZCzAD9tNQrIa0rwDo/PkKblFfG6345rPBDbWUhjkhhOtsTYkdO2/1709
         fuEQgZMUVGxGDdcU8ZSMD2vn6OJ2QVMSewoqvQCQvsMGkIMC3ZGAlTRQmHVslk3qC/p6
         3qy9MHvfn8u5uh2s3qXLbcO/XdhN20+bAaWeo9gH1pmzTZjNQWu25EroDxu4V4tKuqqx
         p1cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WUKv34qtxSOJIcfls0yKx8KJWtFAnXOJgFSnubgtGqg=;
        b=G09f6WPSaXRfwsBmJLZF1B/hy7Lq7OUeRmw5Ti2IVP5U3rRMdl3ilzCKitMZa69xg/
         ePjwjmL5mMzqsug4cXvOXBjtB276y/vG8Od2oUmp1G7RKdDfkWZlMaUw7FIcRWkHLMeh
         G1unj7uu99HZi+Ms8mKy5nTt2C14y+kCnACqESC8FrYcJck/FhHA8k+pXaBfxGX4yLOi
         VBzktXcmKLW6MvQ/FnAphiqQVzwyfvABH1SdlYwX16aRd0uEn1rLsOg6AiHZ2CWrd9pi
         RobxJauPcQt1+u85nCGJ5dzj50GDkGOVoADjqBdzUGrHZGDeqC2wt2fvivU7wIJ4eOqI
         hqCA==
X-Gm-Message-State: AOAM533H/3htUQgFMWzEXu3DYxKRlrUbxZTVYYMN4LCIQJiTbQVtUBex
        bPLAvjku1I+X8cnK+0xEaVN78KxkYV77wdhPq3Y=
X-Google-Smtp-Source: ABdhPJz5o1Vtz5zo1fATxAk/iLOIZ24Rtnyz9pEVUG886RxDl7LNB4OdkvWj12oEP+1+SdP9VgFNeLlQ9YtMWoX4g0I=
X-Received: by 2002:a9d:5388:: with SMTP id w8mr18980735otg.311.1606779647728;
 Mon, 30 Nov 2020 15:40:47 -0800 (PST)
MIME-Version: 1.0
References: <20201126134240.3214176-1-lee.jones@linaro.org> <20201126134240.3214176-18-lee.jones@linaro.org>
In-Reply-To: <20201126134240.3214176-18-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 30 Nov 2020 18:40:36 -0500
Message-ID: <CADnq5_OJBza2OCgXKH=kG7-z6vdV_BHh=ZJLTVLRo4FSxit1yw@mail.gmail.com>
Subject: Re: [PATCH 17/40] drm/amd/pm/powerplay/hwmgr/hardwaremanager: Fix
 function header related formatting issues
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
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/hardwaremanager.c:232: =
warning: Function parameter or member 'hwmgr' not described in 'phm_start_t=
hermal_controller'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/hardwaremanager.c:383: =
warning: Function parameter or member 'hwmgr' not described in 'phm_get_clo=
ck_info'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/hardwaremanager.c:383: =
warning: Function parameter or member 'state' not described in 'phm_get_clo=
ck_info'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/hardwaremanager.c:383: =
warning: Function parameter or member 'pclock_info' not described in 'phm_g=
et_clock_info'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/hardwaremanager.c:383: =
warning: Function parameter or member 'designation' not described in 'phm_g=
et_clock_info'
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
>  .../amd/pm/powerplay/hwmgr/hardwaremanager.c  | 25 ++++++++++---------
>  1 file changed, 13 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hardwaremanager.c b/d=
rivers/gpu/drm/amd/pm/powerplay/hwmgr/hardwaremanager.c
> index 45dde3e74b578..25b5831a15cd2 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hardwaremanager.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hardwaremanager.c
> @@ -223,11 +223,11 @@ int phm_register_irq_handlers(struct pp_hwmgr *hwmg=
r)
>  }
>
>  /**
> -* Initializes the thermal controller subsystem.
> -*
> -* @param    pHwMgr  the address of the powerplay hardware manager.
> -* @exception PP_Result_Failed if any of the paramters is NULL, otherwise=
 the return value from the dispatcher.
> -*/
> + * phm_start_thermal_controller - Initializes the thermal controller sub=
system.
> + *
> + * @hwmgr:   the address of the powerplay hardware manager.
> + * Exception PP_Result_Failed if any of the paramters is NULL, otherwise=
 the return value from the dispatcher.
> + */
>  int phm_start_thermal_controller(struct pp_hwmgr *hwmgr)
>  {
>         int ret =3D 0;
> @@ -371,13 +371,14 @@ int phm_get_performance_level(struct pp_hwmgr *hwmg=
r, const struct pp_hw_power_s
>
>
>  /**
> -* Gets Clock Info.
> -*
> -* @param    pHwMgr  the address of the powerplay hardware manager.
> -* @param    pPowerState the address of the Power State structure.
> -* @param    pClockInfo the address of PP_ClockInfo structure where the r=
esult will be returned.
> -* @exception PP_Result_Failed if any of the paramters is NULL, otherwise=
 the return value from the back-end.
> -*/
> + * phm_get_clock_info
> + *
> + * @hwmgr:  the address of the powerplay hardware manager.
> + * @state: the address of the Power State structure.
> + * @pclock_info: the address of PP_ClockInfo structure where the result =
will be returned.
> + * @designation: PHM performance level designation
> + * Exception PP_Result_Failed if any of the paramters is NULL, otherwise=
 the return value from the back-end.
> + */
>  int phm_get_clock_info(struct pp_hwmgr *hwmgr, const struct pp_hw_power_=
state *state, struct pp_clock_info *pclock_info,
>                         PHM_PerformanceLevelDesignation designation)
>  {
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
