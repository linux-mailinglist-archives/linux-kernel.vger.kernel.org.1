Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B71F2C928C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 00:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388674AbgK3Xas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 18:30:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388590AbgK3Xar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 18:30:47 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 696AEC0613D2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 15:30:07 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id t18so4629555otk.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 15:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+uMOErT0cr65Ou3LFaf1alFJAddt+nc1yJ4P5ZkXSgw=;
        b=LMadV/9nvicO3vvuQxDXRrBC3owXn1KVMb0n/9FSUeUSXXxAFqgyrzU+op51wl1Vdi
         tuiuZrBC3sYtPAjhwQfYRmBxmfa+KjeI8DzNShbDtwD4Lh1Y9GtYXCX/3CQShqsMikpQ
         XyW0OvZjiPIo15Vjcwbh/xvdxlVarywtmfqN93pwMwUdq9eJO+I85tdt6yMUYcyI8mUi
         ezti7BgLs+TNquwGZblzt4NR6ryiipnvp8Q+2KnYDFOUN8ZoVvRjrCh5v8R2SWQW4zxz
         NczWkjyxN6sd7jx9Ub/1lp12yiX6NfpBDETw3Dlp4ac/Qv3v3hTV+uyhc5OBwf3m2Lp5
         d+sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+uMOErT0cr65Ou3LFaf1alFJAddt+nc1yJ4P5ZkXSgw=;
        b=q6Vf5EdL3Tr/GFJQaUUK5ycU3fnIg85tFnaorDuHenPf6v8v+BWHdsGCzfAZY0uRml
         /ejbWQyRpNH73MAXns5cISXv6kjtFErJeMa3zZDs5LkrF2/FWtRDccU6GIPIQ/GASKET
         8oEYclzjUk+h6KvPds4YJSvHLpGcxWKsXvQlnsu9TS26foBgakve7hdba7ugb4aw6HLF
         b7lLKM/kUoVpRjrwYPc3g1ROW68tf3ORcuDOUwF8rMeY9SzXaJRryP6NHvbcfc9XAf5z
         PIRBF5Xm4NfGAfR+xfFFjWSKDTURrVUZZYsjJC+wvqU2JrT30YeLMkMkFVir/jg+VXXx
         VTcg==
X-Gm-Message-State: AOAM533/nmaU2K3fag4H3eFYBXDR/tmaB6Spdc+qMrxPRpYgsRKPQK7B
        jimOUXV/WyBom8Ylyzf4wPls1RHCWWJP81rNCaY=
X-Google-Smtp-Source: ABdhPJw5LXpVxlLKZYxswd9WOJd3cPpw3dpLYTRdEcrta+gSNUaFyxsqW4utb6G0ceYh4Wue0dZAs4TwjozVvV3CW54=
X-Received: by 2002:a9d:4713:: with SMTP id a19mr19386387otf.132.1606779006892;
 Mon, 30 Nov 2020 15:30:06 -0800 (PST)
MIME-Version: 1.0
References: <20201126134240.3214176-1-lee.jones@linaro.org> <20201126134240.3214176-11-lee.jones@linaro.org>
In-Reply-To: <20201126134240.3214176-11-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 30 Nov 2020 18:29:55 -0500
Message-ID: <CADnq5_Mt7gT6cYkvJLiZRr73p_C06qhJH7iCAnYyZ6pP8yYGvw@mail.gmail.com>
Subject: Re: [PATCH 10/40] drm/amd/pm/inc/pp_thermal: Mark 'SMU7Thermal{WithDelay}Policy'
 as __maybe_unused
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
> They are used by some source files which include pp_thermal.h, but not al=
l.
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/../pm/inc/pp_thermal.h:28:41: warning: =E2=80=
=98SMU7ThermalWithDelayPolicy=E2=80=99 defined but not used [-Wunused-const=
-variable=3D]
>  drivers/gpu/drm/amd/amdgpu/../pm/inc/pp_thermal.h:28:41: warning: =E2=80=
=98SMU7ThermalWithDelayPolicy=E2=80=99 defined but not used [-Wunused-const=
-variable=3D]
>  drivers/gpu/drm/amd/amdgpu/../pm/inc/pp_thermal.h:34:41: warning: =E2=80=
=98SMU7ThermalPolicy=E2=80=99 defined but not used [-Wunused-const-variable=
=3D]
>  drivers/gpu/drm/amd/amdgpu/../pm/inc/pp_thermal.h:34:41: warning: =E2=80=
=98SMU7ThermalPolicy=E2=80=99 defined but not used [-Wunused-const-variable=
=3D]
>  drivers/gpu/drm/amd/amdgpu/../pm/inc/pp_thermal.h:34:41: warning: =E2=80=
=98SMU7ThermalPolicy=E2=80=99 defined but not used [-Wunused-const-variable=
=3D]
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Evan Quan <evan.quan@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied.  Thanks!

Alex


> ---
>  drivers/gpu/drm/amd/pm/inc/pp_thermal.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/inc/pp_thermal.h b/drivers/gpu/drm/am=
d/pm/inc/pp_thermal.h
> index 3e30768f9e1cc..f7c41185097e4 100644
> --- a/drivers/gpu/drm/amd/pm/inc/pp_thermal.h
> +++ b/drivers/gpu/drm/amd/pm/inc/pp_thermal.h
> @@ -25,13 +25,13 @@
>
>  #include "power_state.h"
>
> -static const struct PP_TemperatureRange SMU7ThermalWithDelayPolicy[] =3D
> +static const struct PP_TemperatureRange __maybe_unused SMU7ThermalWithDe=
layPolicy[] =3D
>  {
>         {-273150,  99000, 99000, -273150, 99000, 99000, -273150, 99000, 9=
9000},
>         { 120000, 120000, 120000, 120000, 120000, 120000, 120000, 120000,=
 120000},
>  };
>
> -static const struct PP_TemperatureRange SMU7ThermalPolicy[] =3D
> +static const struct PP_TemperatureRange __maybe_unused SMU7ThermalPolicy=
[] =3D
>  {
>         {-273150,  99000, 99000, -273150, 99000, 99000, -273150, 99000, 9=
9000},
>         { 120000, 120000, 120000, 120000, 120000, 120000, 120000, 120000,=
 120000},
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
