Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8C1A2F3FB3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394651AbhALWbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 17:31:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394647AbhALWbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 17:31:32 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1BC1C061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 14:30:52 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id j12so34454ota.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 14:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dF0yJHbbjBb5erCUCeH3GN84OQvrBthurVO49Uciku8=;
        b=guZqN+mctqBHsmD4I1QYDAt214jwEM9rS8OLOeLW+xtLapW6NBfmy6T6Qmer5EXYX5
         bFU5yxZlS/4SQGnqmm+FYm/toyJAHTqC29K4CBVguL7xxAiV1g2zPhwKR3YDCK6N9fp2
         rKqtJKywncWwhmwG5qEb8a3O5NnGn7iF4+5PXzfzosPAVNRB14v38jmsRBWPLLizQGWx
         U/Xl4Xcwc9ySRHWeO3tSyHdy/jk7JpYEns3iU9kn3d8Nd/r7v4S7L3sDjSy9+58NasJq
         75II5u4p71BsRc0gZKoNzz4AHnbwpvcSYbo9zyURaWmTK5329nKuzDkgA+b4Km5Rh+HA
         2G2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dF0yJHbbjBb5erCUCeH3GN84OQvrBthurVO49Uciku8=;
        b=fblM1sXyY7Y5buLQGbNqWCvmkcR3c4OyTAmNJ1NK9etxWAAwFedLSx+xp9bOQHAE1s
         5rOggLVFt0ZbTGMea1/w2/sPQZQi8HDhEY2eyrlQG3QkIcj0kYTUXZuijUzo5xJMzIIQ
         jaqZYJLkczOUYb8JhXdpJc9/hYrbAX7az4EozKNu0q7PF9oLedh2YczumaogUe1GaOhJ
         7qPAnFXpmE73fqwxngy0QorieCGQDquV1sPc9PfcVuacTBjGpIloRuq2Xc2cLgYKLW48
         je+B8uXlIpjAQg/FqeRzOTv6c+ucP9u5cdf6IvlzAUFzIVoW2iqHEEy4shssRuH+l8TL
         Rpgg==
X-Gm-Message-State: AOAM5310DVmD0RbEOh0I8ypjL53oeCpl3c7n+16b5qItk+Rkj4+X0Sbc
        Hg34RwIyQ2u5tCHw6q0VCV0ngnmaMVU9vvuuZB4=
X-Google-Smtp-Source: ABdhPJxzlQ64G4f7mRpozXG0VzDdJ19+FRvpX5WO0g/YmLDMV9Q/xGD8xgDV5U8nKOQwoq2ri/50wVVgpdH0Y6gwfaA=
X-Received: by 2002:a9d:75d4:: with SMTP id c20mr1044535otl.311.1610490651899;
 Tue, 12 Jan 2021 14:30:51 -0800 (PST)
MIME-Version: 1.0
References: <20210111191926.3688443-1-lee.jones@linaro.org> <20210111191926.3688443-28-lee.jones@linaro.org>
In-Reply-To: <20210111191926.3688443-28-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 12 Jan 2021 17:30:40 -0500
Message-ID: <CADnq5_Pk++N2Ary324cEAdUFvFS0QF4VO7DumuiD9rYmF2Jyzg@mail.gmail.com>
Subject: Re: [PATCH 27/40] drm/amd/display/dc/dce110/dce110_compressor: Strip
 out unused function 'controller_id_to_index'
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

On Mon, Jan 11, 2021 at 2:20 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_compressor.c:429:=
14: warning: no previous prototype for =E2=80=98controller_id_to_index=E2=
=80=99 [-Wmissing-prototypes]
>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied. Thanks!

Alex


> ---
>  .../amd/display/dc/dce110/dce110_compressor.c | 25 -------------------
>  1 file changed, 25 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_compressor.c b/=
drivers/gpu/drm/amd/display/dc/dce110/dce110_compressor.c
> index 18b0a69b0b1e8..44564a4742b52 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_compressor.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_compressor.c
> @@ -425,31 +425,6 @@ void get_max_support_fbc_buffersize(unsigned int *ma=
x_x, unsigned int *max_y)
>          */
>  }
>
> -
> -unsigned int controller_id_to_index(enum controller_id controller_id)
> -{
> -       unsigned int index =3D 0;
> -
> -       switch (controller_id) {
> -       case CONTROLLER_ID_D0:
> -               index =3D 0;
> -               break;
> -       case CONTROLLER_ID_D1:
> -               index =3D 1;
> -               break;
> -       case CONTROLLER_ID_D2:
> -               index =3D 2;
> -               break;
> -       case CONTROLLER_ID_D3:
> -               index =3D 3;
> -               break;
> -       default:
> -               break;
> -       }
> -       return index;
> -}
> -
> -
>  static const struct compressor_funcs dce110_compressor_funcs =3D {
>         .power_up_fbc =3D dce110_compressor_power_up_fbc,
>         .enable_fbc =3D dce110_compressor_enable_fbc,
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
