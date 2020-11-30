Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 727702C922B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 00:12:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731142AbgK3XKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 18:10:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730406AbgK3XKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 18:10:00 -0500
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A753FC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 15:09:20 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id f12so13008541oto.10
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 15:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=J/JA2QHuMpYftB+Osd3l6b/sOo2jHBKPSU8ic35WqME=;
        b=nOPRVaN2A1Le1NwZHS3q6mYRIhcuB7foKxQN64YeNJn/uuBx+RG1P6JclOCG+oy8ko
         pvpNgIfCshDjKK4kooB7p2oIYcytgpwmg9zut0uWDNyPs38wXK0M8p3XbNtWlM86VrYb
         ADl3XIIMGbPHST15YX8aRdqbIoC7i11VKjQHJMRNqLy+8zXvIbiNWoACkqbdp7XaJr+D
         A5I4ipaXHMUEI5EfUpWafL8vgzvBd3YY54S4/WX9TF/0cyZkRKTncu6JZPTp/zm93WnN
         Bz+sucYWuLVcZj4dGBsoSxFiNlUgM1jfxiG69rS6N9i9/4MOxHoaV3j44s7yZhWbi+zB
         2nkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=J/JA2QHuMpYftB+Osd3l6b/sOo2jHBKPSU8ic35WqME=;
        b=TqaYRkT+SKazpxV3jB75MQV9MdDjvVS6m/HaRzeh47fO2N7ig07gjeeNxgLS6EoFgT
         cnUkk5wrOtU9m0RD5rJvt7eA/yeBDskR+jbi78I5kdGQStiHggEj6de+9PAVrmvOV26o
         xdQa2UpmY4bkOb2mvR+Rgr1saSTKMLcx9/YuO0VlBC2h3FWbZRgzXU11raVL0nzfepsr
         tulAnV9QwpR51+zs51KZOO5dIE0vYAdjaeNOkwUX57flNxNEV5TDZ2/DyzSFDbo6wMta
         7B7dJ8coHIFQkyByRH6w/Kn9caPj/08UHSQ18M7La8FTz3oJO4BmsDNcarcVKElAldY3
         yNKw==
X-Gm-Message-State: AOAM531goMUor1cTzb7+socpnTEUj5DSxDu+1uBmrpXcMwAZb8Jfbxsn
        EmWhsRDWW/JT0G5WpEyIyvjrY0nTHA5Kan4IGreHxMEJ
X-Google-Smtp-Source: ABdhPJxCSXUMPP0ZI97R0IC/K40/cxIU5+ZMkCy3yWJIZXmdRE+bjla5Nxc+Y2fG7e73MWuOH4H9h70bydvMKNOy2MI=
X-Received: by 2002:a9d:4713:: with SMTP id a19mr19320659otf.132.1606777760122;
 Mon, 30 Nov 2020 15:09:20 -0800 (PST)
MIME-Version: 1.0
References: <20201126134240.3214176-1-lee.jones@linaro.org> <20201126134240.3214176-2-lee.jones@linaro.org>
In-Reply-To: <20201126134240.3214176-2-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 30 Nov 2020 18:09:08 -0500
Message-ID: <CADnq5_P56t2WVe2akpysWfQ=6SbxacoS_d41GtehgJGws2vpUg@mail.gmail.com>
Subject: Re: [PATCH 01/40] drm/amd/pm/powerplay/smumgr/tonga_smumgr: Remove
 set but unused variable 'res'
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

On Thu, Nov 26, 2020 at 8:42 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/tonga_smumgr.c: In fun=
ction =E2=80=98tonga_thermal_setup_fan_table=E2=80=99:
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/tonga_smumgr.c:2469:6:=
 warning: variable =E2=80=98res=E2=80=99 set but not used [-Wunused-but-set=
-variable]
>
> Cc: Evan Quan <evan.quan@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/gpu/drm/amd/pm/powerplay/smumgr/tonga_smumgr.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/tonga_smumgr.c b/dri=
vers/gpu/drm/amd/pm/powerplay/smumgr/tonga_smumgr.c
> index 4bfadb49521bc..c28f3e1299701 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/tonga_smumgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/tonga_smumgr.c
> @@ -2466,7 +2466,6 @@ static int tonga_thermal_setup_fan_table(struct pp_=
hwmgr *hwmgr)
>         uint32_t t_diff1, t_diff2, pwm_diff1, pwm_diff2;
>         uint16_t fdo_min, slope1, slope2;
>         uint32_t reference_clock;
> -       int res;
>         uint64_t tmp64;
>
>         if (!phm_cap_enabled(hwmgr->platform_descriptor.platformCaps,
> @@ -2539,11 +2538,9 @@ static int tonga_thermal_setup_fan_table(struct pp=
_hwmgr *hwmgr)
>
>         fan_table.FanControl_GL_Flag =3D 1;
>
> -       res =3D smu7_copy_bytes_to_smc(hwmgr,
> -                                       smu_data->smu7_data.fan_table_sta=
rt,
> -                                       (uint8_t *)&fan_table,
> -                                       (uint32_t)sizeof(fan_table),
> -                                       SMC_RAM_END);
> +       smu7_copy_bytes_to_smc(hwmgr, smu_data->smu7_data.fan_table_start=
,
> +                              (uint8_t *)&fan_table,
> +                              (uint32_t)sizeof(fan_table), SMC_RAM_END);
>

We should probably return the error here rather than dropping it.
I'll send out a patch.

Thanks,

Alex


>         return 0;
>  }
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
