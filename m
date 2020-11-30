Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE40B2C92C9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 00:37:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389073AbgK3Xfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 18:35:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389063AbgK3Xft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 18:35:49 -0500
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A7FC0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 15:35:09 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id x16so388775oic.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 15:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SwJKAP9OtM5KbJNlEw3zjPIkLv4Kktv+7inoscp0z7U=;
        b=k4Wd78hT8inLJOYSLeOOPi34S0koKhrVKM3UpIBLhmfHbpfTr6Ah/if6wiLPmHFk1s
         B0vZW5YKwgAjhS8zsKfaWdMILFup/SuJfoZs36YLvo5xD3cOTbDzy0+pW133mCekJpcB
         7XEKeT6Z59EtNJ831McaGE/L3e4tpXTj2qEim1UrvMOXC/D6Cvj/U5S8Tb1ubL4LrKEi
         eVEeF0aGYqU/ntGqXr2Pm8iKBaYjBd5PUeu6ds8Q6wjqCRCKmXGj0ASaW/U9KOqgpb2a
         hhzD5KiojB70IV6OGEFddXVa/u01QHH5k9Ai5kg2E/OB+mgLkqaAqApOsIc7tJ/HJRNI
         68cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SwJKAP9OtM5KbJNlEw3zjPIkLv4Kktv+7inoscp0z7U=;
        b=PDdSUQv2VCHXZuci6+IoEKSxVMd9Zq1duCvVEEZaGM0qtB0zgr90+c+kXWkzrh9yxG
         aGvOumvveiSVN8Fsz6lDnXaYjdBKuA3S0W+qLF9AzsrspQtv/6EhxlJWExlZHbgRKo7S
         OL/Vy/SP6Yw6QzklwbFGd/Bet9I0loe2tRJiU3+yXEHfPN4f/UIbXj/u5TQyOiC7mFJx
         ylSa3iexrelBraJN22JNzxcYiDQIBWU1hCP3YUKQh3KERjvOCQ0RSvL9xH0k3WmncDLE
         D2MKm3+E39bQZM8Ev26jYdxYFDXt2dEaF26E2Amnm6S2YpCQyFhg7hemiOJi+Qk0V9rq
         bydQ==
X-Gm-Message-State: AOAM533X7CSN20xMVzUgDXLtcwuOPo3rJBJ6ssidkcZ4m3Wgpw1QRpOT
        F3vmXCROsRaJMDYPzEdSIUDiukB07/DFVc/Phac=
X-Google-Smtp-Source: ABdhPJyPtCgAjFf+HLll81ZRLEVbukcLKb7sy29t/zXUKK54Nn4INoceJ/2jc6YQJmbuW3xmmKc5PACrEOL9aJfv0tQ=
X-Received: by 2002:a54:4608:: with SMTP id p8mr165809oip.5.1606779309113;
 Mon, 30 Nov 2020 15:35:09 -0800 (PST)
MIME-Version: 1.0
References: <20201126134240.3214176-1-lee.jones@linaro.org> <20201126134240.3214176-15-lee.jones@linaro.org>
In-Reply-To: <20201126134240.3214176-15-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 30 Nov 2020 18:34:57 -0500
Message-ID: <CADnq5_OygrSpan8jzEazeETDpp1PryjS+pFjw+tUpXTnj-Z=Hw@mail.gmail.com>
Subject: Re: [PATCH 14/40] drm/amd/pm/powerplay/hwmgr/ppatomfwctrl: Demote
 kernel-doc formatting abuses
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
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/ppatomfwctrl.c:78: warn=
ing: Function parameter or member 'hwmgr' not described in 'pp_atomfwctrl_i=
s_voltage_controlled_by_gpio_v4'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/ppatomfwctrl.c:78: warn=
ing: Function parameter or member 'voltage_type' not described in 'pp_atomf=
wctrl_is_voltage_controlled_by_gpio_v4'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/ppatomfwctrl.c:78: warn=
ing: Function parameter or member 'voltage_mode' not described in 'pp_atomf=
wctrl_is_voltage_controlled_by_gpio_v4'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/ppatomfwctrl.c:211: war=
ning: Function parameter or member 'hwmgr' not described in 'pp_atomfwctrl_=
get_pp_assign_pin'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/ppatomfwctrl.c:211: war=
ning: Function parameter or member 'pin_id' not described in 'pp_atomfwctrl=
_get_pp_assign_pin'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/ppatomfwctrl.c:211: war=
ning: Function parameter or member 'gpio_pin_assignment' not described in '=
pp_atomfwctrl_get_pp_assign_pin'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/ppatomfwctrl.c:232: war=
ning: Function parameter or member 'hwmgr' not described in 'pp_atomfwctrl_=
enter_self_refresh'
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
>  .../drm/amd/pm/powerplay/hwmgr/ppatomfwctrl.c | 24 +++++++++----------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomfwctrl.c b/driv=
ers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomfwctrl.c
> index 615cf2c09e54e..a47a47238e2b9 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomfwctrl.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomfwctrl.c
> @@ -68,11 +68,11 @@ static struct atom_voltage_objects_info_v4_1 *pp_atom=
fwctrl_get_voltage_info_tab
>         return (struct atom_voltage_objects_info_v4_1 *)table_address;
>  }
>
> -/**
> -* Returns TRUE if the given voltage type is controlled by GPIO pins.
> -* voltage_type is one of SET_VOLTAGE_TYPE_ASIC_VDDC, SET_VOLTAGE_TYPE_AS=
IC_MVDDC, SET_VOLTAGE_TYPE_ASIC_MVDDQ.
> -* voltage_mode is one of ATOM_SET_VOLTAGE, ATOM_SET_VOLTAGE_PHASE
> -*/
> +/*
> + * Returns TRUE if the given voltage type is controlled by GPIO pins.
> + * voltage_type is one of SET_VOLTAGE_TYPE_ASIC_VDDC, SET_VOLTAGE_TYPE_A=
SIC_MVDDC, SET_VOLTAGE_TYPE_ASIC_MVDDQ.
> + * voltage_mode is one of ATOM_SET_VOLTAGE, ATOM_SET_VOLTAGE_PHASE
> + */
>  bool pp_atomfwctrl_is_voltage_controlled_by_gpio_v4(struct pp_hwmgr *hwm=
gr,
>                 uint8_t voltage_type, uint8_t voltage_mode)
>  {
> @@ -202,9 +202,9 @@ static bool pp_atomfwctrl_lookup_gpio_pin(
>         return false;
>  }
>
> -/**
> -* Returns TRUE if the given pin id find in lookup table.
> -*/
> +/*
> + * Returns TRUE if the given pin id find in lookup table.
> + */
>  bool pp_atomfwctrl_get_pp_assign_pin(struct pp_hwmgr *hwmgr,
>                 const uint32_t pin_id,
>                 struct pp_atomfwctrl_gpio_pin_assignment *gpio_pin_assign=
ment)
> @@ -224,10 +224,10 @@ bool pp_atomfwctrl_get_pp_assign_pin(struct pp_hwmg=
r *hwmgr,
>         return ret;
>  }
>
> -/**
> -* Enter to SelfRefresh mode.
> -* @param hwmgr
> -*/
> +/*
> + * Enter to SelfRefresh mode.
> + * @param hwmgr
> + */
>  int pp_atomfwctrl_enter_self_refresh(struct pp_hwmgr *hwmgr)
>  {
>         /* 0 - no action
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
