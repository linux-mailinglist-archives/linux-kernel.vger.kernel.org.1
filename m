Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D24512AE3A9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 23:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732391AbgKJWuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 17:50:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731981AbgKJWuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 17:50:16 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19F0C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:50:15 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id w24so4858043wmi.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BddpXWM57oMSeuVH0GiCGkmNr8YUMWASKDEXAi/F4Ik=;
        b=L5zynW/A8fxFU6d77a5ySvH/zy/gQQ03BiPxTKVFS0BkRGdTjlZU1ny3qgCTVODHrk
         Tc3pEvR9O+kugkYPplUoNDeeefZR3hPV4lcG4Jwx8o1akwlC7c6oIWH+bZptJcecyu1l
         Fjq8w3jC8ModVcuglp4i103Ic56YXgcHSZAMzV5arGidxapkUSYBeCRGICkB1Xgf0B+b
         J1CN5MXVwquoolNXwAhW8Cbx+3vLwXnchxkai6yYY0W2cb+MgfBbUhzgKNhs+0+sK6c/
         6Fs2P/PGRXjUZCR5IbJzw9L3QgtUQxmTg5KHsRMKthXM548Wv16tUUc1TUBw28NLaQbP
         k22g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BddpXWM57oMSeuVH0GiCGkmNr8YUMWASKDEXAi/F4Ik=;
        b=jyaqPEVcxxDh1pyemqi6A7eKtaqQ6Udr8Gc8KowlEcDioAL/z8f16uWEviPCR9OlVi
         A4d64EOEpmeswWlMaFQe+FFSPUupZB/2tv3ttuHp69MTdCPXoxis8UYNYHOHU2NCXlao
         xQ5TA+UtAHXiXjLl0oqVSx2eIOB+srPE/shDE9tqRD2k+kaa2kfAbJ2UHhZ7TK4hh5N6
         YaPrfKtG2KeKt5S/iFr8iZn5JJ2E41XDlml+8X0jSFpc51+4okMATxts/h4pHhxAA1pv
         HGvc37/kAMj8aYHpQt/r3YS5bu7OC9Y1rYXtgncnT4W3+O+S7kf6LvGB9YC3pK0uxLWB
         GMzQ==
X-Gm-Message-State: AOAM53046WI98SoYTsUjWf2nfKVMZstHrHPO0c2Urf4tZhbMaFkEOQ7n
        pvLsHsxzEL2pZVsJBOSs95k+DJg5oWNUxx7JAeY=
X-Google-Smtp-Source: ABdhPJxo+X4jxV+bBVFzVi6yl51daBDZgI3j6cR4TkxJYsINm8BjEk0lHQgnEei9W0LNO6y946QRic5xwYgIBRaf4gs=
X-Received: by 2002:a1c:80cb:: with SMTP id b194mr368273wmd.73.1605048614642;
 Tue, 10 Nov 2020 14:50:14 -0800 (PST)
MIME-Version: 1.0
References: <20201110193112.988999-1-lee.jones@linaro.org> <20201110193112.988999-3-lee.jones@linaro.org>
In-Reply-To: <20201110193112.988999-3-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 10 Nov 2020 17:50:03 -0500
Message-ID: <CADnq5_MOF00Fy0yALwrb+G77+Bxfa27Bzg5M6SEPzgqzJP=cnA@mail.gmail.com>
Subject: Re: [PATCH 02/30] drm/radeon/evergreen: Remove set but unused
 variable 'mc_shared_chmap'
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

On Tue, Nov 10, 2020 at 2:31 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/radeon/evergreen.c: In function =E2=80=98evergreen_gpu_i=
nit=E2=80=99:
>  drivers/gpu/drm/radeon/evergreen.c:3135:6: warning: variable =E2=80=98mc=
_shared_chmap=E2=80=99 set but not used [-Wunused-but-set-variable]
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
>  drivers/gpu/drm/radeon/evergreen.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/evergreen.c b/drivers/gpu/drm/radeon/=
evergreen.c
> index c9a9a87959f9e..efb19c445e48f 100644
> --- a/drivers/gpu/drm/radeon/evergreen.c
> +++ b/drivers/gpu/drm/radeon/evergreen.c
> @@ -3135,7 +3135,7 @@ static int evergreen_cp_resume(struct radeon_device=
 *rdev)
>  static void evergreen_gpu_init(struct radeon_device *rdev)
>  {
>         u32 gb_addr_config;
> -       u32 mc_shared_chmap, mc_arb_ramcfg;
> +       u32 mc_arb_ramcfg;
>         u32 sx_debug_1;
>         u32 smx_dc_ctl0;
>         u32 sq_config;
> @@ -3399,7 +3399,7 @@ static void evergreen_gpu_init(struct radeon_device=
 *rdev)
>
>         evergreen_fix_pci_max_read_req_size(rdev);
>
> -       mc_shared_chmap =3D RREG32(MC_SHARED_CHMAP);
> +       RREG32(MC_SHARED_CHMAP);
>         if ((rdev->family =3D=3D CHIP_PALM) ||
>             (rdev->family =3D=3D CHIP_SUMO) ||
>             (rdev->family =3D=3D CHIP_SUMO2))
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
