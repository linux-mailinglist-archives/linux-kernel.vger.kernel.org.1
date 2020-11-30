Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66A5F2C926A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 00:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730958AbgK3XVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 18:21:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbgK3XVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 18:21:01 -0500
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4749FC0613D2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 15:20:21 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id y74so16124686oia.11
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 15:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CDfNpqMXGhqvJenF6xYXnI7EWSyYaGSCmDynR3Cbu1A=;
        b=LhlCbBDhK3DAxmiqeCyyY5IVJIGP0Bgg3vzynN9O8fQwGcJiU4Om38fo3Ki4cBkJ4P
         0B+wfPdrsMY/wIvbCvTw5qeBiToL9IWKJUjb4RHY5vj6kTB1r7sizNxkUQMU13YqNjkd
         rq8OLY6ijTWXEqohFEAA6eaGmDW94FG0adiw5Efue1dmnQrNX0uRNqPvns5t6wkhEx2d
         oyHOOnCsfS25XVrPa5aMPrS5PajomWF+6Nxbgagk7p44MCIcwtiILcRqAu8PKnlT3vS+
         OqKtNl3CDa4emDev0dUxaG2zq6o8kYIi6H7OSFB/7HZWQKitTfs28wFQw/VYmxIsvArk
         4xrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CDfNpqMXGhqvJenF6xYXnI7EWSyYaGSCmDynR3Cbu1A=;
        b=mIAqLGIXPyNHkgxjUHwXdk1QjkgnjLMJqrgJw/LGA8QLZRSwkzO7l8dOlm6OjqcveH
         cfRP/tzPh2P4LQ1W/MQNKjluhSBQn16rJkU8moIuJ/1/0fykUS6yUjFJKrP+HCb3pfq8
         ix2rAzAzOqgBAL8YWieLMSy3RJh4EcgWUwSM/SbVR1AYtnocXvx1H1aoW37C54XtUCD8
         BsDh45vkd0AQB9qxYJuTqQjh/wgX1Yh7u/PzZm/SbGaiRhO8oYNxzcQsW+aqyfBXtGt1
         7wGZrf87a5hbEaovyS4VHIcwbg9u1Z0DjCrT6Wd+8B2xROdQh6Ger6LW3dAnBxjfrqBA
         Zr+Q==
X-Gm-Message-State: AOAM532SeCgctLSOEYIgmDCWSXXWIE7Oxiy3bQLs8QX8/+kvadpqck+y
        E869yjIKgxHH/sScFFAWj6QALu+LjWtTH3g+Ric=
X-Google-Smtp-Source: ABdhPJwSo/dWUELdsWgMGbX4aJtaagoeCjTtBZXc+5tM3qYJTvO1sBgLcRM+L7bhdL+h7GGkoH8X7bCQI9WCANH4i5k=
X-Received: by 2002:aca:f50e:: with SMTP id t14mr106519oih.123.1606778420693;
 Mon, 30 Nov 2020 15:20:20 -0800 (PST)
MIME-Version: 1.0
References: <20201126134240.3214176-1-lee.jones@linaro.org> <20201126134240.3214176-9-lee.jones@linaro.org>
In-Reply-To: <20201126134240.3214176-9-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 30 Nov 2020 18:20:09 -0500
Message-ID: <CADnq5_MCqEad1qme4Z4-Cw-ScCweQr3_r8Ph3LCz65mpr+9=bg@mail.gmail.com>
Subject: Re: [PATCH 08/40] drm/amd/pm/powerplay/hwmgr/hardwaremanager: Remove
 unused 'phm_set_*()' functions
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
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/hardwaremanager.c:518:5=
: warning: no previous prototype for =E2=80=98phm_set_min_deep_sleep_dcefcl=
k=E2=80=99 [-Wmissing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/hardwaremanager.c:528:5=
: warning: no previous prototype for =E2=80=98phm_set_hard_min_dcefclk_by_f=
req=E2=80=99 [-Wmissing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/hardwaremanager.c:538:5=
: warning: no previous prototype for =E2=80=98phm_set_hard_min_fclk_by_freq=
=E2=80=99 [-Wmissing-prototypes]
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
>  .../amd/pm/powerplay/hwmgr/hardwaremanager.c  | 31 -------------------
>  1 file changed, 31 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hardwaremanager.c b/d=
rivers/gpu/drm/amd/pm/powerplay/hwmgr/hardwaremanager.c
> index 1f9b9facdf1f4..45dde3e74b578 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hardwaremanager.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hardwaremanager.c
> @@ -514,34 +514,3 @@ int phm_set_active_display_count(struct pp_hwmgr *hw=
mgr, uint32_t count)
>
>         return hwmgr->hwmgr_func->set_active_display_count(hwmgr, count);
>  }
> -
> -int phm_set_min_deep_sleep_dcefclk(struct pp_hwmgr *hwmgr, uint32_t cloc=
k)
> -{
> -       PHM_FUNC_CHECK(hwmgr);
> -
> -       if (!hwmgr->hwmgr_func->set_min_deep_sleep_dcefclk)
> -               return -EINVAL;
> -
> -       return hwmgr->hwmgr_func->set_min_deep_sleep_dcefclk(hwmgr, clock=
);
> -}
> -
> -int phm_set_hard_min_dcefclk_by_freq(struct pp_hwmgr *hwmgr, uint32_t cl=
ock)
> -{
> -       PHM_FUNC_CHECK(hwmgr);
> -
> -       if (!hwmgr->hwmgr_func->set_hard_min_dcefclk_by_freq)
> -               return -EINVAL;
> -
> -       return hwmgr->hwmgr_func->set_hard_min_dcefclk_by_freq(hwmgr, clo=
ck);
> -}
> -
> -int phm_set_hard_min_fclk_by_freq(struct pp_hwmgr *hwmgr, uint32_t clock=
)
> -{
> -       PHM_FUNC_CHECK(hwmgr);
> -
> -       if (!hwmgr->hwmgr_func->set_hard_min_fclk_by_freq)
> -               return -EINVAL;
> -
> -       return hwmgr->hwmgr_func->set_hard_min_fclk_by_freq(hwmgr, clock)=
;
> -}
> -
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
