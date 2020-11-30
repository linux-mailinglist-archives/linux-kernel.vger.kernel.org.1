Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFB182C91DC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 00:01:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388920AbgK3W7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 17:59:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388913AbgK3W72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 17:59:28 -0500
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8512C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 14:58:36 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id x16so289715oic.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 14:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AFKS8AJu+Fj+MZmOUNhw1ND9mL6dIAAw6BtuS0oHe6E=;
        b=UaiIA6Sjv4FXSOCMWBm3hHKel0jzdCXcIJIacC1DYcQINH/Lyt0t33lU7IxE4CTk8j
         zIPqZznn5SqovEBZvr1IVYKAsoYiohNUEpRIrJpSmMJ46fOAw3u5NBnpzUKoEpr3jc/J
         WuDg0xU7X0njIN6IBWGcA/Rld47I7z5NhJ4w2Sd+voJmWv+XnCMOmJRICEJfWKshpn36
         tv+rds1+EWC8kd2QrQr93YQY1zJd1+fPwcEVV7KAZ/rE/GDFt9T+c5PUOkFihfzG1CFD
         10y0NfpIPIeQ3lWVTzQaQ2geFSZtSnhy7Vs+JhuK+Ij77U04W+qPvNFCfyKN9gEF/kkB
         bIjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AFKS8AJu+Fj+MZmOUNhw1ND9mL6dIAAw6BtuS0oHe6E=;
        b=pDvzzSIZmB+E75qr05o4Q6lwgxLsXLs0kKvSxnkwpewPmj8RH0G4NVfOpUx3uWLUMw
         svGvesN561QOsOs8HwqGsBWigKjc3XhiO647hqwlPGtfL6IRmG2d+tnOTH9EADWQenw6
         Hua+ZmGrCxxv7FP3TiLYGWaMmbIqfc82biy5ws20e/FXyt48j5Cs7J5GaNHNrprEOnd1
         yc2xJkQgFrqmqRKm170HVayvNZhRoU34yPxXkRZhlox8jEIzOi9t0UefohRFoMOTRPdt
         oYwrQNU9H8t8qceK0+BCKaKD/ihXK1oxJabSJWMFDOa4b4BqyVwriDBh6d/pwY9dGGli
         KAzQ==
X-Gm-Message-State: AOAM532h1oPj67lrk2NWq+1xrhMC2X6oNS6+2CtboBIBGWdTRVIpQ43V
        HcQIXSMf40UIxiNtc6hZJ0ZRHz75K8GbMLDDLdA=
X-Google-Smtp-Source: ABdhPJyNBowr50AMEKIoDeQpkyqZuKZ4limvURq/g3IpLqTRRmsU3Prk3PIRibfwhOfSYmywxOxWp9KDfcXUv9jdmV8=
X-Received: by 2002:aca:f50e:: with SMTP id t14mr29155oih.123.1606777116254;
 Mon, 30 Nov 2020 14:58:36 -0800 (PST)
MIME-Version: 1.0
References: <20201124193824.1118741-1-lee.jones@linaro.org> <20201124193824.1118741-36-lee.jones@linaro.org>
In-Reply-To: <20201124193824.1118741-36-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 30 Nov 2020 17:58:25 -0500
Message-ID: <CADnq5_OKkW3MvjAK4eziMPJyZ-D4vYT0VnCJk2BpX9szKY4edA@mail.gmail.com>
Subject: Re: [PATCH 35/40] drm/amd/pm/swsmu/smu11/vangogh_ppt: Make local
 function 'vangogh_set_default_dpm_tables()' static
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Xiaojian Du <Xiaojian.Du@amd.com>, David Airlie <airlied@linux.ie>,
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

On Tue, Nov 24, 2020 at 2:45 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/vangogh_ppt.c: At top level=
:
>  drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/vangogh_ppt.c:764:5: warnin=
g: no previous prototype for =E2=80=98vangogh_set_default_dpm_tables=E2=80=
=99 [-Wmissing-prototypes]
>  764 | int vangogh_set_default_dpm_tables(struct smu_context *smu)
>  | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Xiaojian Du <Xiaojian.Du@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

This code has changed a bit and I've just sent out a patch to handle
this slightly differently.  Thanks!

Alex


> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/g=
pu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> index 9a2f72f21ed86..05c32be3a7496 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> @@ -400,16 +400,13 @@ static int vangogh_get_current_activity_percent(str=
uct smu_context *smu,
>                                                enum amd_pp_sensors sensor=
,
>                                                uint32_t *value)
>  {
> -       int ret =3D 0;
> -
>         if (!value)
>                 return -EINVAL;
>
>         switch (sensor) {
>         case AMDGPU_PP_SENSOR_GPU_LOAD:
> -               ret =3D vangogh_get_smu_metrics_data(smu,
> -                                                 METRICS_AVERAGE_GFXACTI=
VITY,
> -                                                 value);
> +               vangogh_get_smu_metrics_data(smu, METRICS_AVERAGE_GFXACTI=
VITY,
> +                                            value);
>                 break;
>         default:
>                 dev_err(smu->adev->dev, "Invalid sensor for retrieving cl=
ock activity\n");
> @@ -761,7 +758,7 @@ static int vangogh_od_edit_dpm_table(struct smu_conte=
xt *smu, enum PP_OD_DPM_TAB
>         return ret;
>  }
>
> -int vangogh_set_default_dpm_tables(struct smu_context *smu)
> +static int vangogh_set_default_dpm_tables(struct smu_context *smu)
>  {
>         struct smu_table_context *smu_table =3D &smu->smu_table;
>
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
