Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 887A72C2C95
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 17:18:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390308AbgKXQRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 11:17:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390194AbgKXQRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 11:17:35 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB16C061A4D
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 08:17:35 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id s13so3434393wmh.4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 08:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LijZ/LqMszGs8xMM0dN6Uty/k0Afuzo1kPHaiKp50lc=;
        b=eaq71AqWyrm4yPjqqoTtDMMrJUD/KevYxQDuMMRci86JvXfpe109IVVg4XYRfQ989H
         8z+N2Z3l1wEbTolG3PvIdM8zCEjXNTYB4LN7dy+FW/kz8o4PrApSMxa+IQo+ht7GB/ul
         qwzLvczje0prXgOiFT0YrVDqnifD1NLbbkZzbQ+oh7jX6AKkQ2gpPTQ7xo0u5oHlQ2iQ
         A43GSBpnmZiGXuWpZghmalIj8kmrHMzVGMfIF18BbCRymF50MEjKHsNIgXCDbFR4GYKx
         TUZFDyiEMYdU67/R84i7RfwvbW/yFgKkrNGMOLEPhpjElJ8Lw6lzbK2q8TZmFAPHEiqX
         +tEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LijZ/LqMszGs8xMM0dN6Uty/k0Afuzo1kPHaiKp50lc=;
        b=o+WbGrWCDc7b35ML8N/rbLxUD8RwWxRQy2J7R5hHn79oH4zs8bJkczrg73rZKtAB4P
         1twc9cL2d8l83+k0D1XVp4UO5ayYDP/8wLMmDuRI1o7t/o3WWKqVVuACR1PsjlIH0u1S
         UpEB4AYXQ/MrBfUWRd1dUWeNKHJCPrkazjR4+YTqDUVPncJqbdoio+RaKXDjsRukgjyE
         t4YEsBfDQFL8tkAUF5joGhbgd+f8kGynhtp6A6dyX8PiXEkwuBHPtugvYeMolHmaKmM5
         V1c1zYJQshRIaDgQmIdKM7liqo+vX3Abqb95/M8PeZcpZNX4A595xXFRizaSx6BX5nzO
         XyvA==
X-Gm-Message-State: AOAM532/69ia0rVEkretDUJscGRghL+XT2bsr/2XL75SewNy7dinrbKw
        9z9pTkrLK13TeeAFJKYGf8wstaB3eXHv2rxTpvY=
X-Google-Smtp-Source: ABdhPJzNygOzaDXbLuiWRGlvfncBI8h76FaQ99ii/pEtG+p4yc6rqeX5YYUTQfCiUJ/jAsV9SGlQext02PglndiOHbI=
X-Received: by 2002:a1c:2dc8:: with SMTP id t191mr5227545wmt.73.1606234653994;
 Tue, 24 Nov 2020 08:17:33 -0800 (PST)
MIME-Version: 1.0
References: <20201123111919.233376-1-lee.jones@linaro.org> <20201123111919.233376-31-lee.jones@linaro.org>
In-Reply-To: <20201123111919.233376-31-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 24 Nov 2020 11:17:22 -0500
Message-ID: <CADnq5_PXFO704YgzzWHmMSJEp0g0LMKYYqBcCJ--yLZ72agDNg@mail.gmail.com>
Subject: Re: [PATCH 30/40] drm/amd/include/dimgrey_cavefish_ip_offset: Mark
 top-level IP_BASE as __maybe_unused
To:     Lee Jones <lee.jones@linaro.org>
Cc:     David Airlie <airlied@linux.ie>, Tao Zhou <tao.zhou1@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Jiansong Chen <Jiansong.Chen@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 23, 2020 at 6:20 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
> In file included from drivers/gpu/drm/amd/amdgpu/dimgrey_cavefish_reg_ini=
t.c:28:
> drivers/gpu/drm/amd/amdgpu/../include/dimgrey_cavefish_ip_offset.h:151:29=
: warning: =E2=80=98UMC_BASE=E2=80=99 defined but not used [-Wunused-const-=
variable=3D]
> 151 | static const struct IP_BASE UMC_BASE =3D { { { { 0x00014000, 0x0242=
5800, 0, 0, 0, 0 } },
> | ^~~~~~~~
> drivers/gpu/drm/amd/amdgpu/../include/dimgrey_cavefish_ip_offset.h:81:29:=
 warning: =E2=80=98FUSE_BASE=E2=80=99 defined but not used [-Wunused-const-=
variable=3D]
> 81 | static const struct IP_BASE FUSE_BASE =3D { { { { 0x00017400, 0x0240=
1400, 0, 0, 0, 0 } },
> | ^~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/../include/dimgrey_cavefish_ip_offset.h:74:29:=
 warning: =E2=80=98DPCS_BASE=E2=80=99 defined but not used [-Wunused-const-=
variable=3D]
> 74 | static const struct IP_BASE DPCS_BASE =3D { { { { 0x00000012, 0x0000=
00C0, 0x000034C0, 0x00009000, 0x02403C00, 0 } },
> | ^~~~~~~~~
>
> NB: Snipped lots of these
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Tao Zhou <tao.zhou1@amd.com>
> Cc: Hawking Zhang <Hawking.Zhang@amd.com>
> Cc: Jiansong Chen <Jiansong.Chen@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/include/dimgrey_cavefish_ip_offset.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/include/dimgrey_cavefish_ip_offset.h b/d=
rivers/gpu/drm/amd/include/dimgrey_cavefish_ip_offset.h
> index b41263de8a9b6..f84996a73de94 100644
> --- a/drivers/gpu/drm/amd/include/dimgrey_cavefish_ip_offset.h
> +++ b/drivers/gpu/drm/amd/include/dimgrey_cavefish_ip_offset.h
> @@ -33,7 +33,7 @@ struct IP_BASE_INSTANCE
>  struct IP_BASE
>  {
>      struct IP_BASE_INSTANCE instance[MAX_INSTANCE];
> -};
> +} __maybe_unused;
>
>
>  static const struct IP_BASE ATHUB_BASE =3D { { { { 0x00000C00, 0x02408C0=
0, 0, 0, 0, 0 } },
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
