Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2D72C924A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 00:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730746AbgK3XPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 18:15:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726737AbgK3XPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 18:15:06 -0500
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF731C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 15:14:25 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id w15so16086075oie.13
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 15:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fiqCo1/lI2q1mRSdvAPLuR7qN8UC6kpdlJNW9jLd1So=;
        b=D/a9sT7QnDRknAcb/kqsN0U4b8shUkIGmqCsSQqBos1WqsXEgHYeUKUGdxEtN69qSi
         sFj7Hv+Ll2zQJCmcJAIGfIeL9E2kBLEfkrdnZNc52OuWC7dQJcVQAOChniIeEEhCT9Ia
         MnZEUHrQ91aemrIQKi47ZFvbtnMqwkH6g+8pAV71pqO3wtS/8MUfoybkcCiRa84IxDbI
         ONPlgY/pyJ7It74yoTQzkMx96X1beweGtCyxkgQGeQjYY+dZtD6+njFquPAJh/qcGN81
         dHFY0nd5VCyuJoNICJMc9O3ffP5ukZT4FTDEZrmWLrBI8BLAOVxyQQ/grdSpQiWq7wX4
         Cu7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fiqCo1/lI2q1mRSdvAPLuR7qN8UC6kpdlJNW9jLd1So=;
        b=LC7TK65cQQOUnANJik5wOIqePk8zYaa0twfPXZmvGgeXcK+jEtNuZTmx7HF5bhfBy1
         slP3csLOOPTpBAT7LYciig35937z7pSel6t4zaY86YG7GSR7s8kc8JrOOQWX2W8yZkpE
         mONz7HbZdVV/2/WTizitVSH7oA/RhWZOerbqVk+7bdNpfzwGGw0V1xJhPXgfJiHUZtyh
         c1iBAOzRj2CeCONSYEiKIdzNA5yTneUs1CDe6kJEITZMEomFqpp3LIo6ouNjn5iXE9br
         cbbGaoSutJ32Lucl1gROET5qfNuCOZ68YcFf/tBWoqUYuQWnV6C9q0qLMLnNREqTae6P
         UBcQ==
X-Gm-Message-State: AOAM531Eji3wbEMs/o27qA0DmrTwS1FUCEHA+Oa/Ek4/+QqnfyUax54y
        D+ISymh/D7c9SnREAczZCv5VHLDSqIYf0TWOTO/8KGz+
X-Google-Smtp-Source: ABdhPJxEaLWXFtxL3ijIBaGXZ22vZflmOE1jRdmPndYRMxiIVD5eI+WbIfWWBpqaHZENtarBXBDtoIDzoitjeT6W6xc=
X-Received: by 2002:aca:4f53:: with SMTP id d80mr109224oib.120.1606778065481;
 Mon, 30 Nov 2020 15:14:25 -0800 (PST)
MIME-Version: 1.0
References: <20201126134240.3214176-1-lee.jones@linaro.org> <20201126134240.3214176-4-lee.jones@linaro.org>
In-Reply-To: <20201126134240.3214176-4-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 30 Nov 2020 18:14:14 -0500
Message-ID: <CADnq5_MQUuOWoKboqUEu-xazNF2MoCke5dLqRfzX_c6d=cavgA@mail.gmail.com>
Subject: Re: [PATCH 03/40] drm/amd/pm/powerplay/smumgr/ci_smumgr: Remove set
 but unused variable 'res'
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
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/ci_smumgr.c: In functi=
on =E2=80=98ci_thermal_setup_fan_table=E2=80=99:
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/ci_smumgr.c:2132:6: wa=
rning: variable =E2=80=98res=E2=80=99 set but not used [-Wunused-but-set-va=
riable]
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
>  drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c b/driver=
s/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c
> index 329bf4d44bbce..c1d869b4c7a42 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c
> @@ -2129,7 +2129,6 @@ static int ci_thermal_setup_fan_table(struct pp_hwm=
gr *hwmgr)
>         uint32_t t_diff1, t_diff2, pwm_diff1, pwm_diff2;
>         uint16_t fdo_min, slope1, slope2;
>         uint32_t reference_clock;
> -       int res;
>         uint64_t tmp64;
>
>         if (!phm_cap_enabled(hwmgr->platform_descriptor.platformCaps, PHM=
_PlatformCaps_MicrocodeFanControl))
> @@ -2191,7 +2190,7 @@ static int ci_thermal_setup_fan_table(struct pp_hwm=
gr *hwmgr)
>
>         fan_table.TempSrc =3D (uint8_t)PHM_READ_VFPF_INDIRECT_FIELD(hwmgr=
->device, CGS_IND_REG__SMC, CG_MULT_THERMAL_CTRL, TEMP_SEL);
>
> -       res =3D ci_copy_bytes_to_smc(hwmgr, ci_data->fan_table_start, (ui=
nt8_t *)&fan_table, (uint32_t)sizeof(fan_table), SMC_RAM_END);
> +       ci_copy_bytes_to_smc(hwmgr, ci_data->fan_table_start, (uint8_t *)=
&fan_table, (uint32_t)sizeof(fan_table), SMC_RAM_END);
>

Should probably just return the error here.  I'll fix it up.  Thanks!

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
