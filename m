Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0146F2AE440
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 00:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732031AbgKJXmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 18:42:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726706AbgKJXmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 18:42:16 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7343AC0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 15:42:16 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id p1so321169wrf.12
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 15:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Rx4+AnDnGG2uOUuYvCD2kX/y5IPcI9grqVLoFPnDhZs=;
        b=aUc15+h6S0MbpN1QvMk3vVOBRorNBNoGdQU0AckwRRIZRe2lGbFnRVBWKIhb3LxBps
         2m1ewRtGhI0hPHPvt9FCXpAAAn78wP7EBmgdQlxfswzLZvUADu3q8SUrFa4BqrW3TC5T
         7PhMhwp+p84rcQpVHILNwqnVRkkJEpzzuCxuQl1HR71NzVa2CYGpSemDlzoZjj3bNoU9
         4qhaXE6c4+s9Sl/lrDsKS4gBZO2E7EKYhlRHGSQkIp/9nbLLYInRcO64Z48cHexhAHBo
         zKecVlHHXC6M1eXy1Ww9Ncz8Vs520PqtihkJsa8S8ePk//5IwTeTxBT/nEpKyN1RtRx5
         9iHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Rx4+AnDnGG2uOUuYvCD2kX/y5IPcI9grqVLoFPnDhZs=;
        b=h/xe3xAGsKa1gz9v7h09e30dRH3f4/Qf2t4AplkLhKZXvQc4yCSbMqFN8gBMWWSRoH
         KgXXaV8HPWwTXBsC3HszY1pNU0IKUNpSxAX1ijHgm2JiPTlYV2PAIQp2KX9ki3P3iHzI
         R8uD6K3RpIjdJU8SFBrZ3o1Drg6B1C9AUnrcvVGAQ4A++QFmlwY9VI76w+7qAaAOXLVK
         1TwWbT4fh18fLqP8UpxZOsg2DFjBB9g9KVbJeEuOIpy38+r5B0M5XDDGZRgMDRsNTYD/
         CanboFGQEXTLkeJirZinnQfBCJz6nPWoDWFugHcXf3sG5zfY4u5rPQpdYY6lb7mRM2X0
         iXxA==
X-Gm-Message-State: AOAM533JPF9vN1I3lnVS/CLlw/5doeLnqGeYi1QG+MWCGQB9xAj3av6h
        AkWiRnu2+Y0Q2/96ejhOFKeAyvYnf2EGAJJxD64=
X-Google-Smtp-Source: ABdhPJwjbq17rx2WoHZy+mm45mILPxwoMZE4g1kekeZ4ir+vZXwFa9KxgzHwN2TiC2o7hCUQrO5NkZGXiJFjcL2X1Sg=
X-Received: by 2002:adf:e8d0:: with SMTP id k16mr26256999wrn.362.1605051735175;
 Tue, 10 Nov 2020 15:42:15 -0800 (PST)
MIME-Version: 1.0
References: <20201110193112.988999-1-lee.jones@linaro.org> <20201110193112.988999-9-lee.jones@linaro.org>
In-Reply-To: <20201110193112.988999-9-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 10 Nov 2020 18:42:03 -0500
Message-ID: <CADnq5_Ndta5KgCr9X9StdFD_SvATX_=kV6NynxjEbbj+XvX57Q@mail.gmail.com>
Subject: Re: [PATCH 08/30] drm/radeon/ci_dpm: Remove set but unused variable 'dpm_event_src'
To:     Lee Jones <lee.jones@linaro.org>
Cc:     David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 2:31 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> And the piece of code that has never been executed.
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/radeon/ci_dpm.c: In function =E2=80=98ci_set_dpm_event_s=
ources=E2=80=99:
>  drivers/gpu/drm/radeon/ci_dpm.c:1369:28: warning: variable =E2=80=98dpm_=
event_src=E2=80=99 set but not used [-Wunused-but-set-variable]
>
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
>  drivers/gpu/drm/radeon/ci_dpm.c | 12 ------------
>  1 file changed, 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/ci_dpm.c b/drivers/gpu/drm/radeon/ci_=
dpm.c
> index 886e9959496fe..8324aca5fd006 100644
> --- a/drivers/gpu/drm/radeon/ci_dpm.c
> +++ b/drivers/gpu/drm/radeon/ci_dpm.c
> @@ -1366,7 +1366,6 @@ static void ci_set_dpm_event_sources(struct radeon_=
device *rdev, u32 sources)
>  {
>         struct ci_power_info *pi =3D ci_get_pi(rdev);
>         bool want_thermal_protection;
> -       enum radeon_dpm_event_src dpm_event_src;
>         u32 tmp;
>
>         switch (sources) {
> @@ -1376,28 +1375,17 @@ static void ci_set_dpm_event_sources(struct radeo=
n_device *rdev, u32 sources)
>                 break;
>         case (1 << RADEON_DPM_AUTO_THROTTLE_SRC_THERMAL):
>                 want_thermal_protection =3D true;
> -               dpm_event_src =3D RADEON_DPM_EVENT_SRC_DIGITAL;
>                 break;
>         case (1 << RADEON_DPM_AUTO_THROTTLE_SRC_EXTERNAL):
>                 want_thermal_protection =3D true;
> -               dpm_event_src =3D RADEON_DPM_EVENT_SRC_EXTERNAL;
>                 break;
>         case ((1 << RADEON_DPM_AUTO_THROTTLE_SRC_EXTERNAL) |
>               (1 << RADEON_DPM_AUTO_THROTTLE_SRC_THERMAL)):
>                 want_thermal_protection =3D true;
> -               dpm_event_src =3D RADEON_DPM_EVENT_SRC_DIGIAL_OR_EXTERNAL=
;
>                 break;
>         }
>
>         if (want_thermal_protection) {
> -#if 0
> -               /* XXX: need to figure out how to handle this properly */
> -               tmp =3D RREG32_SMC(CG_THERMAL_CTRL);
> -               tmp &=3D DPM_EVENT_SRC_MASK;
> -               tmp |=3D DPM_EVENT_SRC(dpm_event_src);
> -               WREG32_SMC(CG_THERMAL_CTRL, tmp);
> -#endif
> -
>                 tmp =3D RREG32_SMC(GENERAL_PWRMGT);
>                 if (pi->thermal_protection)
>                         tmp &=3D ~THERMAL_PROTECTION_DIS;
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
