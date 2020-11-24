Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C16EA2C2C83
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 17:15:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390226AbgKXQOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 11:14:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389424AbgKXQOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 11:14:05 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043C4C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 08:14:05 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id 10so2893625wml.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 08:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8rBvHUrzCCm9gVWrU3I91+G5vSuJBwgXqyyisSK9ieo=;
        b=l6Lu+RcjXtavu4WmmL4nvGSMU4O10Lw8NUXO7J9V4wy3PuzN3MjeK+AHvjZGff1cJg
         Q5jBUmLOaoqfWCgcQi3TvtNb2ie+Vj75VjHOEoaaMT6ShtTx55XAVII0gn38CUUsVpRU
         MVFBP5+wkoiDND3/oTWXgfg9bahD8HYmooJTA83IzieEGcm/CkKDggkv3ISb3EWQ2uZa
         YY/EpeqHAcbaAcFv5hdK9teyXjRgIsICEaw49GJyUN5pD9YL5EXLxHX/5PRDfAHPdiS2
         JniwIlhIy/LNS0DcinQelv0hdz7zSN45Slj69MhAVP88A4t7W7gRcRYkC9NvXcJyNqkQ
         kqhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8rBvHUrzCCm9gVWrU3I91+G5vSuJBwgXqyyisSK9ieo=;
        b=QezL6K/VHKSwFrKNWxkLj/SbOhFvynPZIcx+nrSupHMsop+VdeZK2qTvjIGo6mSR8/
         oQ27sjSVOFd/AvVAIANr2N+MwAt/US3iXPEddM9fjDWwZEpwPn3UoQ9IaQTq/Md6bhES
         WRvNVt4EuUXliS2qsIVG59YH7USTj2d6PfbxDeNv2ka7v/htLfeOolJTQ0IFxyYGlUC7
         aBQ1ccZpwpagsjjd2APTlEzFkwXO/KBOuwGpmtM0dDYH1YxQ6MaOgk+HOkRvwxxAMQWb
         QHQNHxy0tzuS2bOKc05AqKNP1foNklgMzJrpj/T2N+Df+bwuqpHvYzSATWH3sdCcWVAB
         NMew==
X-Gm-Message-State: AOAM531Ruf63CKWjyKfMC6RzG8FarLNIWTWENY6goPrl7RrWCHXPvCzx
        xbA3Kndf7+7nQq+1nbfTx6a7QsqrOMasz6tNRoY=
X-Google-Smtp-Source: ABdhPJz0NioSPJlepfSlftukQu1yVMNbUcj2AKbQONE/GCi452Qv8YPxbyRcMRRCtBBkFWafFLNIucH0pvFJguWYECY=
X-Received: by 2002:a7b:c015:: with SMTP id c21mr5292166wmb.79.1606234443764;
 Tue, 24 Nov 2020 08:14:03 -0800 (PST)
MIME-Version: 1.0
References: <20201123111919.233376-1-lee.jones@linaro.org> <20201123111919.233376-27-lee.jones@linaro.org>
In-Reply-To: <20201123111919.233376-27-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 24 Nov 2020 11:13:52 -0500
Message-ID: <CADnq5_NNhyyDvbp5oULdEVwa8bAKqkFGrvujmmyZT7S088GfCg@mail.gmail.com>
Subject: Re: [PATCH 26/40] drm/amd/include/navi14_ip_offset: Mark top-level
 IP_BASE as __maybe_unused
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

On Mon, Nov 23, 2020 at 6:20 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  In file included from drivers/gpu/drm/amd/amdgpu/navi14_reg_init.c:27:
>  drivers/gpu/drm/amd/amdgpu/../include/navi14_ip_offset.h:179:29: warning=
: =E2=80=98USB0_BASE=E2=80=99 defined but not used [-Wunused-const-variable=
=3D]
>  179 | static const struct IP_BASE USB0_BASE =3D{ { { { 0x0242A800, 0x05B=
00000, 0, 0, 0 } },
>  | ^~~~~~~~~
>  drivers/gpu/drm/amd/amdgpu/../include/navi14_ip_offset.h:172:29: warning=
: =E2=80=98UMC_BASE=E2=80=99 defined but not used [-Wunused-const-variable=
=3D]
>  172 | static const struct IP_BASE UMC_BASE =3D{ { { { 0x00014000, 0x0242=
5800, 0, 0, 0 } },
>  | ^~~~~~~~
>  drivers/gpu/drm/amd/amdgpu/../include/navi14_ip_offset.h:151:29: warning=
: =E2=80=98SDMA_BASE=E2=80=99 defined but not used [-Wunused-const-variable=
=3D]
>  151 | static const struct IP_BASE SDMA_BASE =3D{ { { { 0x00001260, 0x000=
0A000, 0x02402C00, 0, 0 } },
>  | ^~~~~~~~~
>
> NB: Snipped a few of these
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
>  drivers/gpu/drm/amd/include/navi14_ip_offset.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/include/navi14_ip_offset.h b/drivers/gpu=
/drm/amd/include/navi14_ip_offset.h
> index ecdd9eabe0dc8..c39ef651adc6f 100644
> --- a/drivers/gpu/drm/amd/include/navi14_ip_offset.h
> +++ b/drivers/gpu/drm/amd/include/navi14_ip_offset.h
> @@ -33,7 +33,7 @@ struct IP_BASE_INSTANCE
>  struct IP_BASE
>  {
>      struct IP_BASE_INSTANCE instance[MAX_INSTANCE];
> -};
> +} __maybe_unused;
>
>
>  static const struct IP_BASE ATHUB_BASE =3D{ { { { 0x00000C00, 0x02408C00=
, 0, 0, 0 } },
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
