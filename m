Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC14B2EFA6A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 22:27:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbhAHVZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 16:25:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbhAHVZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 16:25:30 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD40C061574
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 13:24:49 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id q25so12900758oij.10
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 13:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=auD7mbSMX/XpHUok2f7h/lpQb4MboPYfCPmFvkXVnf0=;
        b=e5eWhLc6AKzo+0/H5kiPOp8zABjRQimjDbdTgufmBkHLoYKpOZWtnS+/XZKIdwBBsM
         L1ebh1nosR7hviVAn5L47/g2R8UUnf0R5+PpNkERBfvD4EwD2+vjw2Ty5bUKMJ75viF8
         NrXhPG+R7oo4epfnscKqKypjUGSdMHatpqmXa2N4GxP5urZWtsDEexrigFhOGZzd4FSk
         r2rr/rpPk8FLf2FSuXLfrLEA8yso6yxeTCMWUP99xX576i0E3DOgfHoCsItwaDb8RUUz
         K06kMlVXPYuNhuPRVcPRn/uJ2yEDKGuP5QQDywgC/sL/pRD4lUBK41KOwVOgD8TsbMfg
         ueYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=auD7mbSMX/XpHUok2f7h/lpQb4MboPYfCPmFvkXVnf0=;
        b=RPiAxutMHYnBkuv0/7LZoFY0Tj6WpNDpa5tvB3xXjlI0fBQ/dWgwnMSsPzsZBoh9RH
         1aVAL9C7QZdLApaa91XbBvZvhp5AFRdR11GNT+4b9N2IJlm0pySlZkAjE9zn2/iTLZDs
         Tvjj/pVNeSkbMGEXh/Df4h1wcMGm+K4j0K7nT5pUerE1xC9Xj7Zsavz9gYJfmXTEi1No
         inoUxNMAN8HxmazcrmLf+RE0KWBNS8Z7xWdTDJTyxThNKrebj5hP47jwEaxuiopWupU8
         8bHQarXZ/yq2KhsJ4UD5V2G0JqmDr6dPwZ9nC0nhVcPELO1AG5N8HKE7Ozxd/BBm5dNk
         BnSw==
X-Gm-Message-State: AOAM531HF9EqeKLXPmP0F2V/ZDCIwtrsFwa0UGoFg8KTWO84psylwrdV
        clnPe+cvFBQYEy+LedaaOnki7TJ5ckCcKlymQaUzUAnp
X-Google-Smtp-Source: ABdhPJyaS/QWrXyCB59tCxKopFR4J1F5TFDQyUTG+B8t/fvPSX9e8d78847ZnKfyBF0J22jUSwXCMQnKv0x4062FbV0=
X-Received: by 2002:aca:6202:: with SMTP id w2mr3387318oib.5.1610141089341;
 Fri, 08 Jan 2021 13:24:49 -0800 (PST)
MIME-Version: 1.0
References: <20210108201457.3078600-1-lee.jones@linaro.org> <20210108201457.3078600-38-lee.jones@linaro.org>
In-Reply-To: <20210108201457.3078600-38-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 8 Jan 2021 16:24:38 -0500
Message-ID: <CADnq5_NHZ6V9R3P22vWNBmWtn0Xz840K-r8kxV-1dv=0UPSECQ@mail.gmail.com>
Subject: Re: [PATCH 37/40] drm/amd/display/dc/dce/dce_i2c_sw: Make a bunch of
 local functions static
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

On Fri, Jan 8, 2021 at 3:16 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_i2c_sw.c:342:6: warning=
: no previous prototype for =E2=80=98dce_i2c_sw_engine_set_speed=E2=80=99 [=
-Wmissing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_i2c_sw.c:356:6: warning=
: no previous prototype for =E2=80=98dce_i2c_sw_engine_acquire_engine=E2=80=
=99 [-Wmissing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_i2c_sw.c:400:6: warning=
: no previous prototype for =E2=80=98dce_i2c_sw_engine_submit_channel_reque=
st=E2=80=99 [-Wmissing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_i2c_sw.c:443:6: warning=
: no previous prototype for =E2=80=98dce_i2c_sw_engine_submit_payload=E2=80=
=99 [-Wmissing-prototypes]
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
>  drivers/gpu/drm/amd/display/dc/dce/dce_i2c_sw.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_sw.c b/drivers/gp=
u/drm/amd/display/dc/dce/dce_i2c_sw.c
> index 87d8428df6c46..6846afd83701b 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_sw.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_sw.c
> @@ -339,7 +339,7 @@ static bool start_sync_sw(
>         return false;
>  }
>
> -void dce_i2c_sw_engine_set_speed(
> +static void dce_i2c_sw_engine_set_speed(
>         struct dce_i2c_sw *engine,
>         uint32_t speed)
>  {
> @@ -353,7 +353,7 @@ void dce_i2c_sw_engine_set_speed(
>                 engine->clock_delay =3D 12;
>  }
>
> -bool dce_i2c_sw_engine_acquire_engine(
> +static bool dce_i2c_sw_engine_acquire_engine(
>         struct dce_i2c_sw *engine,
>         struct ddc *ddc)
>  {
> @@ -397,7 +397,7 @@ bool dce_i2c_engine_acquire_sw(
>
>
>
> -void dce_i2c_sw_engine_submit_channel_request(
> +static void dce_i2c_sw_engine_submit_channel_request(
>         struct dce_i2c_sw *engine,
>         struct i2c_request_transaction_data *req)
>  {
> @@ -440,7 +440,8 @@ void dce_i2c_sw_engine_submit_channel_request(
>                 I2C_CHANNEL_OPERATION_SUCCEEDED :
>                 I2C_CHANNEL_OPERATION_FAILED;
>  }
> -bool dce_i2c_sw_engine_submit_payload(
> +
> +static bool dce_i2c_sw_engine_submit_payload(
>         struct dce_i2c_sw *engine,
>         struct i2c_payload *payload,
>         bool middle_of_transaction)
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
