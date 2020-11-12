Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8A452B107B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 22:31:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbgKLVb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 16:31:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726337AbgKLVb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 16:31:28 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDABBC0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 13:31:27 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id p22so6483014wmg.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 13:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ltphK80Dwi9gQznPlQlyN4YpIhHPKbIf2gVpfnE2HcI=;
        b=bP2LN9S5Pf4fuiSRQsCYX6czzue5yO3/VjUACYDpYHgUjxZ2oc98jY4tEnXQoZ2wEj
         vKZPnSQvLj+0Yf3+H1gZXB4Bo2rnIuELOo63ZH2Q7GmQPEQr/zi9je2CfCZLi/X8t1+b
         7iuXWehIyHKJFRlcE/ytv37gU2FE+hvHwB5HrRgTHkZl7dV1A9ltfUuoQmxjjWQxgQ7R
         /S3LaNmgn00CZyzq7cjtSQAnM41w9YMdKuf8taxDagQ6+9aXPqTo7IQcd4g+mw5O0cmQ
         Iw6EC86a5CxJOjBN/UWei8jXz/I+FPnVG6/5atgP3yfqLTNNiiTyzWMa8ku04AlsH9jM
         tsXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ltphK80Dwi9gQznPlQlyN4YpIhHPKbIf2gVpfnE2HcI=;
        b=emNt3IB4IzEW7Gj9aDhmTP9wCDKYE2duA3GxttDOobNUdOD0Kb3PY2BMPAUz92B0gE
         MHUJD3CSECiXL4H9nfcvs1iuICkeo65H9UzOjkAhCLLQDlovxTdinRUw2S7JavUPI/WU
         EtQZLnbGmcriOMqVhwl+3g0t65VNCun0xh7sxt2jmrALVzYXAFZZ+Phv6SeVYOUElqeD
         fIGAjl9MoI93GPu7+UzEShdZiT8RDne0uw8+i9oBeIesrdUlwwvrE9VekijcYD9K8/N2
         pQ6M+YFYEXsOVykZB4ZiEhd3yLOTL/iEflCZUJve9R5J1rCq4xLIygeVU+FZ2odRCWCG
         3kvA==
X-Gm-Message-State: AOAM5308Y4GDUk1HIxa4QmZUPtXsTRw+K5vc6zXb+4PTJ3VftfNjskNF
        5MtlY2UZUnBbAHaO37uAJ6IHka+92WNOd/DPsrE=
X-Google-Smtp-Source: ABdhPJzNfSfPYEKiCAFmNOttrty7rS8ZUMbff9aAkk048MYkpiyrQPEMs+yLfPkVxyaMDwdY2bNSoTmplM4XMWDQEeM=
X-Received: by 2002:a05:600c:2319:: with SMTP id 25mr1700761wmo.102.1605216686520;
 Thu, 12 Nov 2020 13:31:26 -0800 (PST)
MIME-Version: 1.0
References: <20201112190039.2785914-1-lee.jones@linaro.org> <20201112190039.2785914-30-lee.jones@linaro.org>
In-Reply-To: <20201112190039.2785914-30-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 12 Nov 2020 16:31:15 -0500
Message-ID: <CADnq5_MjzzRhu0zwOeefjGP_mJ2tfTVvK1O5x55dE03kRxDa3Q@mail.gmail.com>
Subject: Re: [PATCH 29/30] drm/amd/amdgpu/atombios_encoders: Remove set but
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

On Thu, Nov 12, 2020 at 2:01 PM Lee Jones <lee.jones@linaro.org> wrote:
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
> ---
>  drivers/gpu/drm/amd/amdgpu/atombios_encoders.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c b/drivers/gpu=
/drm/amd/amdgpu/atombios_encoders.c
> index fa817ebff9804..af87505ad7d57 100644
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
> @@ -207,7 +206,7 @@ void amdgpu_atombios_encoder_init_backlight(struct am=
dgpu_encoder *amdgpu_encode
>
>         pdata->encoder =3D amdgpu_encoder;
>
> -       backlight_level =3D amdgpu_atombios_encoder_get_backlight_level_f=
rom_reg(adev);
> +       amdgpu_atombios_encoder_get_backlight_level_from_reg(adev);

We can drop this function call altogether.  We call it again below indirect=
ly.

Alex

>
>         dig =3D amdgpu_encoder->enc_priv;
>         dig->bl_dev =3D bd;
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
