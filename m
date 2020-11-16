Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 592AC2B5339
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 21:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729945AbgKPUvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 15:51:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728639AbgKPUvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 15:51:23 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412D3C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:51:23 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id c17so20271598wrc.11
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Qs4skqLiNs1YGNTaNHs4+J+kILEtikJu7Z6PW9pHXL0=;
        b=M5uXhBMOsd621ueGmN9QqlJVWGt54ytFnAfTz5h9898EVgRiS8CtI9VQly7fRJoLqm
         HM6doMbFRhSbvRaF2bYqBm9iR7AivFctH5oTE5Y1ZI7XSFpPzQbZCCH7RbpHLZCkaQvJ
         Ckku+jjqFt4e9tiCQt1YO761Vm1LzwuVd1VP6bQjKF6NZsz1Lgyq1W9G5cul1xMVvt/q
         d2YzQY2YuyCCtOrQTw35V0HsQMPQkiUvzkPrp3V4R+22YvZLCzJaQOgAo3yoFONhNyA7
         DOveIEEBn/TG4oOPJg043MNPc3VJZOCe42yC0PC54dCKKvtKKy8wn8kLA849EM4VC8jb
         F5Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Qs4skqLiNs1YGNTaNHs4+J+kILEtikJu7Z6PW9pHXL0=;
        b=DvuqS+FswzzCRQyChhnAaEEvavNJoGXuFi8MxOJgppU6TCnadrjGScrgJVm6i6DLg8
         IGH0t/P0PaA7WpUuLcDHP3Mt5OIb9+3vDrdAtDw13mmJ1szKr2ni5L8LzDb/MrjEC5s5
         480CjRyodyPqngw8U10L+2qD5coGPyhcNARDNq+1hrQ8j47kewyvlNG1tqoYtcHyJKvc
         4PYK6ozIE6ALHNHtjyFGRD4it851xZ+LO0/G65OyZ8nyLNdEb7RNWoBYfBmewuH43+Fb
         qiDOrzIGdsgY6SqwiJIpE2vD6QPRl50UN0r+ocp25dSGE8oIHu0t2UpFOPsL5DfwGwJP
         5kkw==
X-Gm-Message-State: AOAM533rN+WtaOhrKFVbYotTrZrfY3/Nn9X3nWVROfa7fMX78cN0pKes
        Jb8THWXAt2B59jSdmpluUkVo9yK4iw9uzrjAI68=
X-Google-Smtp-Source: ABdhPJwb5tfPQcxAXgzsITx4XZUTsruBpQ3yy8t7sXvrXpQ2TsYsUKQMhZbknS5nZgr6BrsbqtJsP52X3CiLoO25nRk=
X-Received: by 2002:a5d:6992:: with SMTP id g18mr21179751wru.362.1605559882073;
 Mon, 16 Nov 2020 12:51:22 -0800 (PST)
MIME-Version: 1.0
References: <20201116174112.1833368-1-lee.jones@linaro.org> <20201116174112.1833368-2-lee.jones@linaro.org>
In-Reply-To: <20201116174112.1833368-2-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 16 Nov 2020 15:51:11 -0500
Message-ID: <CADnq5_Pf4oiEPBGvQZXVaoiFOjyrM8HcL9MXCe5xD5pOubd1jw@mail.gmail.com>
Subject: Re: [PATCH 01/42] drm/amd/amdgpu/atombios_encoders: Remove set but
 unused variable 'backlight_level'
To:     Lee Jones <lee.jones@linaro.org>
Cc:     David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 12:41 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Also removing the call to amdgpu_atombios_encoder_get_backlight_level_fro=
m_reg()
> since, according to Alex Deucher, "We call it again below indirectly".
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/atombios_encoders.c: In function =E2=80=98amd=
gpu_atombios_encoder_init_backlight=E2=80=99:
>  drivers/gpu/drm/amd/amdgpu/atombios_encoders.c:174:5: warning: variable =
=E2=80=98backlight_level=E2=80=99 set but not used [-Wunused-but-set-variab=
le]
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Luben Tuikov <luben.tuikov@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/atombios_encoders.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c b/drivers/gpu=
/drm/amd/amdgpu/atombios_encoders.c
> index fa817ebff9804..6134ed9640279 100644
> --- a/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
> +++ b/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
> @@ -171,7 +171,6 @@ void amdgpu_atombios_encoder_init_backlight(struct am=
dgpu_encoder *amdgpu_encode
>         struct backlight_properties props;
>         struct amdgpu_backlight_privdata *pdata;
>         struct amdgpu_encoder_atom_dig *dig;
> -       u8 backlight_level;
>         char bl_name[16];
>
>         /* Mac laptops with multiple GPUs use the gmux driver for backlig=
ht
> @@ -207,8 +206,6 @@ void amdgpu_atombios_encoder_init_backlight(struct am=
dgpu_encoder *amdgpu_encode
>
>         pdata->encoder =3D amdgpu_encoder;
>
> -       backlight_level =3D amdgpu_atombios_encoder_get_backlight_level_f=
rom_reg(adev);
> -
>         dig =3D amdgpu_encoder->enc_priv;
>         dig->bl_dev =3D bd;
>
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
