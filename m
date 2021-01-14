Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAB7E2F66C9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 18:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbhANRGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 12:06:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbhANRGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 12:06:49 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC3A2C061574
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:06:08 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id r9so5793135otk.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ssuwm5geZ6avPsQABGpir+jMcKxJQOkzJqc/fGTa4j0=;
        b=vGjwCEmiDqj01desICX/fCkLT7uffyYwfgLvgAZKFbZiIVtqeS+vfY4HOoClGo/fDs
         WCdeGo5kz15jut2PHHzt6riva9ddYbgprKSy98pCIf5V3cR1vdzM1jmcTCBzRuwRpFRn
         Z4ONbFKb/suIUvG8BiXj+RpKWtFH/mfNSsa9pUoxCqm0obH21c9HyRqHxHdQ69EwNc6n
         VC4vF2nKcX5OyoxaNhfTY0+rnBfIvj+fY6GbbxLOfuRh6QRLgwTI80gD/qjBHb0rLpFC
         NTULDoSO2GJbFNSg3rAwVeDYe0tnwg5xk56rN/Xz5CoB8ibkJNsDRFbmbIfZaMlZBVZk
         N9xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ssuwm5geZ6avPsQABGpir+jMcKxJQOkzJqc/fGTa4j0=;
        b=qMZgSmlGI0pifcqZ65ICCmS7+H+zAv8uJcscRkGo1lF87AI47bL2gOEUQyWOMn6kZZ
         VHNM/CrRUdS0Zhl5zJklunV6o1YCDwDv3G+C9cjf917wUulq3/ErGXzAEEJLbdaHbTQy
         AmzqnXnjPv18U6riu8ZSNiECflOeuZ6gjP5/66eGVlBoA0nge23K1XyDB8Vl/KpAFMrV
         DwDnpmksnhr7esNwrrmbU+BtHiSjqj3cMTGTwMqRt55KOlQeCFg1+OjFfHfCS+O32TwA
         T4xV4xfRDH7MJhKcIIGCslJ+vnsuJvAIxZYNN9miqyih6EYXera7C6O1yErJx0hyKAFN
         XgaA==
X-Gm-Message-State: AOAM531TuvoHjpST31TeRpQEqimv13R3y9kkL6ZRObp7Bc174WVhHMcn
        ab9Ku4qNCFZpnmpS9wlgWo/ToLshWZqZ3em4VWI=
X-Google-Smtp-Source: ABdhPJyb9XIR5l58CoU8oUzP0D7Jskp6KZ4We+iu6vQHk7LdiQd7dLVurjs2uHDUrD24xuURiOdG73ldLAMxUlxPnno=
X-Received: by 2002:a05:6830:1b7b:: with SMTP id d27mr5438999ote.132.1610643968152;
 Thu, 14 Jan 2021 09:06:08 -0800 (PST)
MIME-Version: 1.0
References: <20210113080752.1003793-1-lee.jones@linaro.org> <20210113080752.1003793-5-lee.jones@linaro.org>
In-Reply-To: <20210113080752.1003793-5-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 14 Jan 2021 12:05:56 -0500
Message-ID: <CADnq5_PzcLKd9rMZKaF83FKSEp0Y2tcHXHSJYV=qU+PsjXXbrA@mail.gmail.com>
Subject: Re: [PATCH 04/30] drm/amd/display/modules/power/power_helpers:
 Staticify local functions
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
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

On Wed, Jan 13, 2021 at 3:08 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c:281:=
6: warning: no previous prototype for =E2=80=98fill_iram_v_2=E2=80=99 [-Wmi=
ssing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c:455:=
6: warning: no previous prototype for =E2=80=98fill_iram_v_2_2=E2=80=99 [-W=
missing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c:601:=
6: warning: no previous prototype for =E2=80=98fill_iram_v_2_3=E2=80=99 [-W=
missing-prototypes]
>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied.  Thanks!

Alex


> ---
>  drivers/gpu/drm/amd/display/modules/power/power_helpers.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c b/=
drivers/gpu/drm/amd/display/modules/power/power_helpers.c
> index 4fd8bce95d843..3d4c66933f518 100644
> --- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
> +++ b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
> @@ -278,7 +278,7 @@ static void fill_backlight_transform_table_v_2_2(stru=
ct dmcu_iram_parameters par
>         }
>  }
>
> -void fill_iram_v_2(struct iram_table_v_2 *ram_table, struct dmcu_iram_pa=
rameters params)
> +static void fill_iram_v_2(struct iram_table_v_2 *ram_table, struct dmcu_=
iram_parameters params)
>  {
>         unsigned int set =3D params.set;
>
> @@ -452,7 +452,7 @@ void fill_iram_v_2(struct iram_table_v_2 *ram_table, =
struct dmcu_iram_parameters
>                         params, ram_table);
>  }
>
> -void fill_iram_v_2_2(struct iram_table_v_2_2 *ram_table, struct dmcu_ira=
m_parameters params)
> +static void fill_iram_v_2_2(struct iram_table_v_2_2 *ram_table, struct d=
mcu_iram_parameters params)
>  {
>         unsigned int set =3D params.set;
>
> @@ -598,7 +598,7 @@ void fill_iram_v_2_2(struct iram_table_v_2_2 *ram_tab=
le, struct dmcu_iram_parame
>                         params, ram_table, true);
>  }
>
> -void fill_iram_v_2_3(struct iram_table_v_2_2 *ram_table, struct dmcu_ira=
m_parameters params, bool big_endian)
> +static void fill_iram_v_2_3(struct iram_table_v_2_2 *ram_table, struct d=
mcu_iram_parameters params, bool big_endian)
>  {
>         unsigned int i, j;
>         unsigned int set =3D params.set;
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
