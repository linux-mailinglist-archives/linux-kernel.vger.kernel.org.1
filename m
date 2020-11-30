Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0662C91DF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 00:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388926AbgK3XAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 18:00:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388109AbgK3XAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 18:00:34 -0500
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1284CC0613D2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 14:59:54 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id p126so5056384oif.7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 14:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=k+dbsDk0Oc0svCZNoINarBhbwsNQCNzrJCy0UzhKJ2U=;
        b=jU80lPUmgMBiZbtn5YYCQWnBhyeiMUPfXlAFdEJfLfs//Xmn+UlLptEHVgPlgLbIdj
         t48doM8eGwuwyKYqhA79YyEonl4YXKIFRQF6rNTUxZIkrel3TG5K75AGbpr7/PaJu3x0
         xwJS7zT9bszVpl9sv+KxcudNiGDW1RisH1CyvNOiNxe6XFXoCH2OI5qVbCJTRAHU2IeM
         EmOpxaOmQhUk3+lUGXRh5KA+EWBYOF60RbNRozDiBM23JYscCgfMhv7cxCyfF0vAsgVl
         yJaL+yjrO25vhDtJNqdi2Ok+PbALGayx5utuRer+/lNs/vATDVs5NJfIZ3ChMVMkmCTg
         g0Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=k+dbsDk0Oc0svCZNoINarBhbwsNQCNzrJCy0UzhKJ2U=;
        b=Daxbcv8cCtN9ScViKLueZA8BBjGs+Dr5+Ic+pt6CAxJVQXL712x1tNzaU2Q9YENnVr
         iBUluXMIJcKP+F5pgDwesNWSIOd3lJPvAV+KHVdn0bIdB1DfPCNTaja+JFHKU1SqTfwt
         hI91M4isaOICFpZN5oljNTJwMuJ1AE3Jg5G2O+OfVX2IeCNfMslab4pYoiKDmcJgslmc
         tr9YUgsdHNupX0kMvfrreay/sswvQkI0QZRTjHPf8FLZmI1MrLu/mQtd4RhQAIvCNAjF
         qaPoU1jMUjoRq/P6dUofvYbGjWVbdqVHeZcJh1HTKbT0MnmE1w8zE3t5x/gG1A5WAn9H
         Np5g==
X-Gm-Message-State: AOAM531UUM8QbwTAAEVg5STcOOP0Q9PaAjYUtDyycrpdztKcbudxXqB+
        FMZA+jEvI35ek+OHTdmScsaxO1qaz9ZfDfd49TokqiBS
X-Google-Smtp-Source: ABdhPJz5yXnb6dYRUf/M4cilyKszP6fQrBYdqs9uhYKVOv0GI5qHljJuuc9EaeFJRT2LbGV5izvmz+pCCKK95yFUamY=
X-Received: by 2002:aca:4f53:: with SMTP id d80mr54520oib.120.1606777193523;
 Mon, 30 Nov 2020 14:59:53 -0800 (PST)
MIME-Version: 1.0
References: <20201124193824.1118741-1-lee.jones@linaro.org> <20201124193824.1118741-37-lee.jones@linaro.org>
In-Reply-To: <20201124193824.1118741-37-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 30 Nov 2020 17:59:42 -0500
Message-ID: <CADnq5_OWFTtQ_V+UxtfeqpPER1ZuZSkkbD+6zO5Fa5t1GkUsvw@mail.gmail.com>
Subject: Re: [PATCH 36/40] drm/amd/pm/inc/smu_v11_0: Mark 'smu11_thermal_policy'
 as __maybe_unused
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

On Tue, Nov 24, 2020 at 2:45 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> It's used in some, but not all source files which include 'smu_v11_0.h'.
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  In file included from drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/smu_v=
11_0.c:36:
>  drivers/gpu/drm/amd/amdgpu/../pm/inc/smu_v11_0.h:61:43: warning: =E2=80=
=98smu11_thermal_policy=E2=80=99 defined but not used [-Wunused-const-varia=
ble=3D]
>  61 | static const struct smu_temperature_range smu11_thermal_policy[] =
=3D
>  | ^~~~~~~~~~~~~~~~~~~~
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
>  drivers/gpu/drm/amd/pm/inc/smu_v11_0.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd=
/pm/inc/smu_v11_0.h
> index eff396c7a281f..9742a02e7b16b 100644
> --- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
> +++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
> @@ -58,7 +58,8 @@
>  #define CTF_OFFSET_HOTSPOT             5
>  #define CTF_OFFSET_MEM                 5
>
> -static const struct smu_temperature_range smu11_thermal_policy[] =3D
> +static const
> +struct smu_temperature_range __maybe_unused smu11_thermal_policy[] =3D
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
