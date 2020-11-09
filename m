Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95B292AC5A2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 20:59:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729903AbgKIT7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 14:59:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbgKIT7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 14:59:08 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FEB2C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 11:59:08 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id s13so666228wmh.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 11:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=14OC4JcK9p+yIXX4SORAUM7zivyh5xqxdOufNEz6M6o=;
        b=enWdTmaL0/5ShiXjmaRXpp5I4jfjvIZEYipmD4aq+kcaOekEyY/EQZORHxn77q9DTZ
         X5r8HnshVqSDrg24caSebdRdC/6Sds/4dRPR46x3DLCozLBYyx0oH1vy4prKF5acMkqO
         MuCfqJVQ+D9RY8zvY0XlhPL7wXmrtZjHxidkvvVJvVQz5y5iflxgUMM04n3ZquiKSzUb
         z1YngyLm7Ox9Kohnl6gSiihR7R2jsCudKg+TtB5cmTpaRAG0naSFoCyuA77eM+YTqKls
         xbpK7y7EDl13d7A1l6uwg9VyannLIOPPeXEFwnt7XmGMFJcxOAuMAibgakPcjds4Cuub
         cOcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=14OC4JcK9p+yIXX4SORAUM7zivyh5xqxdOufNEz6M6o=;
        b=JSqH0dYSNMT4UeC4pOZTf0WUcQkjnUlzPrnLduoK/madbT3nAWXwcQ3Qjojs+Wn88/
         1FBvd3+k1pyFaTd6EMMPAqbv203W6MjOHYD1s8n6OZyKVly4f4XUKje5s4fhgqBpQo9O
         BwYzCdZrtui7uZIDzQDb4j37aASyUiRGn50aakBDhrev9BfZJh/r/0Vg8nIyaZk97Wdy
         pFCQjb+v3YwuI3xpmHq07he+n+LwVYacaOs/fTlqD3ALYmsQQyjC2Pvt7FO06grsQwjG
         0PyX6xU8eXzxc25y2VNSg3sJVpsParee0wTaSKlPnYuedT2lnTvp9LWg8vZhz1lxugVK
         jW9g==
X-Gm-Message-State: AOAM532WS7zyv+rAYEZd6wKHc0epJUhSF68Y1EJYzqzoRa8H5NIwCUjB
        U5EC/jwZPFjGpOG/fTNlToZjdW/AUAj5hsEw9Ck=
X-Google-Smtp-Source: ABdhPJws3o7OfVZ+oNbDTTg8cd86AVCkFJEO6C0KOIeja4MGvFOLHSzv/QaD1ghugsfnkGA39cZsY4t79w/sUTFqo7I=
X-Received: by 2002:a1c:80cb:: with SMTP id b194mr832399wmd.73.1604951947040;
 Mon, 09 Nov 2020 11:59:07 -0800 (PST)
MIME-Version: 1.0
References: <20201106214949.2042120-1-lee.jones@linaro.org> <20201106214949.2042120-13-lee.jones@linaro.org>
In-Reply-To: <20201106214949.2042120-13-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 9 Nov 2020 14:58:55 -0500
Message-ID: <CADnq5_OF0ZY9KZ3gXs0Wdk24=VmwfzOoZgUBLVT1w6YK5Wyt7A@mail.gmail.com>
Subject: Re: [PATCH 12/19] drm/amd/display/dc/basics/fixpt31_32: Move
 variables to where they're used
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Leo Li <sunpeng.li@amd.com>, LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 6, 2020 at 4:50 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Also rid some unused ones.
>
> This patch solves 2000 warnings!
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dc_types.=
h:33,
>  from drivers/gpu/drm/amd/amdgpu/../display/dc/dm_services_types.h:30,
>  from drivers/gpu/drm/amd/amdgpu/../display/dc/dm_services.h:35,
>  from drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_helpers.c=
:35:
>  At top level:
>  drivers/gpu/drm/amd/amdgpu/../display/include/fixed31_32.h:76:32: warnin=
g: =E2=80=98dc_fixpt_ln2_div_2=E2=80=99 defined but not used [-Wunused-cons=
t-variable=3D]
>  76 | static const struct fixed31_32 dc_fixpt_ln2_div_2 =3D { 1488522236L=
L };
>  | ^~~~~~~~~~~~~~~~~~
>  drivers/gpu/drm/amd/amdgpu/../display/include/fixed31_32.h:75:32: warnin=
g: =E2=80=98dc_fixpt_ln2=E2=80=99 defined but not used [-Wunused-const-vari=
able=3D]
>  75 | static const struct fixed31_32 dc_fixpt_ln2 =3D { 2977044471LL };
>  | ^~~~~~~~~~~~
>  drivers/gpu/drm/amd/amdgpu/../display/include/fixed31_32.h:74:32: warnin=
g: =E2=80=98dc_fixpt_e=E2=80=99 defined but not used [-Wunused-const-variab=
le=3D]
>  74 | static const struct fixed31_32 dc_fixpt_e =3D { 11674931555LL };
>  | ^~~~~~~~~~
>  drivers/gpu/drm/amd/amdgpu/../display/include/fixed31_32.h:73:32: warnin=
g: =E2=80=98dc_fixpt_two_pi=E2=80=99 defined but not used [-Wunused-const-v=
ariable=3D]
>  73 | static const struct fixed31_32 dc_fixpt_two_pi =3D { 26986075409LL =
};
>  | ^~~~~~~~~~~~~~~
>  drivers/gpu/drm/amd/amdgpu/../display/include/fixed31_32.h:72:32: warnin=
g: =E2=80=98dc_fixpt_pi=E2=80=99 defined but not used [-Wunused-const-varia=
ble=3D]
>  72 | static const struct fixed31_32 dc_fixpt_pi =3D { 13493037705LL };
>  | ^~~~~~~~~~~
>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
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
>  drivers/gpu/drm/amd/display/dc/basics/fixpt31_32.c | 5 +++++
>  drivers/gpu/drm/amd/display/include/fixed31_32.h   | 6 ------
>  2 files changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/basics/fixpt31_32.c b/drivers=
/gpu/drm/amd/display/dc/basics/fixpt31_32.c
> index 1e9a2d3520684..59f37563704ad 100644
> --- a/drivers/gpu/drm/amd/display/dc/basics/fixpt31_32.c
> +++ b/drivers/gpu/drm/amd/display/dc/basics/fixpt31_32.c
> @@ -26,6 +26,11 @@
>  #include "dm_services.h"
>  #include "include/fixed31_32.h"
>
> +static const struct fixed31_32 dc_fixpt_pi =3D { 13493037705LL };
> +static const struct fixed31_32 dc_fixpt_two_pi =3D { 26986075409LL };
> +static const struct fixed31_32 dc_fixpt_ln2 =3D { 2977044471LL };
> +static const struct fixed31_32 dc_fixpt_ln2_div_2 =3D { 1488522236LL };
> +
>  static inline unsigned long long abs_i64(
>         long long arg)
>  {
> diff --git a/drivers/gpu/drm/amd/display/include/fixed31_32.h b/drivers/g=
pu/drm/amd/display/include/fixed31_32.h
> index 16df2a485dd0d..22053d7ea6ced 100644
> --- a/drivers/gpu/drm/amd/display/include/fixed31_32.h
> +++ b/drivers/gpu/drm/amd/display/include/fixed31_32.h
> @@ -69,12 +69,6 @@ static const struct fixed31_32 dc_fixpt_epsilon =3D { =
1LL };
>  static const struct fixed31_32 dc_fixpt_half =3D { 0x80000000LL };
>  static const struct fixed31_32 dc_fixpt_one =3D { 0x100000000LL };
>
> -static const struct fixed31_32 dc_fixpt_pi =3D { 13493037705LL };
> -static const struct fixed31_32 dc_fixpt_two_pi =3D { 26986075409LL };
> -static const struct fixed31_32 dc_fixpt_e =3D { 11674931555LL };
> -static const struct fixed31_32 dc_fixpt_ln2 =3D { 2977044471LL };
> -static const struct fixed31_32 dc_fixpt_ln2_div_2 =3D { 1488522236LL };
> -
>  /*
>   * @brief
>   * Initialization routines
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
