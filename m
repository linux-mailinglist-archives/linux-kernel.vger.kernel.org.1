Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE372AE48D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 01:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731955AbgKKAEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 19:04:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730254AbgKKAED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 19:04:03 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39660C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 16:04:03 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id h62so224022wme.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 16:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rNl9gNKZYZT246LX4GtxHccG2jhMqzr9fQn7LRfzp9A=;
        b=mDg1LEsF9L8Q+Y64fd0woALGzY7ke9f5XWKGDEnDBwz1f06dkzSRE6rasYzWdM3aE9
         wq1kP5Mhril+nExoYVnhi/nw2z9fm44tFKWxAS1QjdtagopkAoCVpgdrnmbw+CmsnXKb
         JTSUS8ApJzzHPu5AWUyLGmABzCZneopM0dw8L1Q6955DXsY96O0xUALvMhLxjum/a5ha
         opaHNCZe6LEXhBmxZ6VkbzNiq2ilOvb5sNksuXZKRX5XrewdtV/DnjHJFXrZhbmk3czT
         3tBN9iJ7pHasz0Fq6/ba4GHH2MOO9psOX5e1k86VTT1ehTNs+vIiXyvE3EfPeeKr7Kt4
         BSog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rNl9gNKZYZT246LX4GtxHccG2jhMqzr9fQn7LRfzp9A=;
        b=X5OsOJUGqe9lUPiGTtqDYKZ2segvZoWIi+zDQ2vfr1e+aeeoV21bk2YWo5APWCTci/
         CQjgXIIafn3Z/H0mMI6JoC2MYr7hmTdIdXBloDHv7AaSYJLg2irQWpsjTp9Zb63vM9VS
         qWLhqM3MJqU9IrWEr51axAu565S7px2YCOXJ2P4QRr//g/wHahYbd1Kioh7nJ4NHAZ2x
         TXiK0J2HiOBaRRtQeDGtrKm5/ZbJI57+e+mZL1OOkkDsxsIpOzhccEZ5pnJpp4634nyk
         Ca7+O0xeX/BWtl4AMZ2X4tC1WVF0NKcZNYl+PB+ahj6tHm4QIqDSZEXYq/iTN+1Oonuc
         26iQ==
X-Gm-Message-State: AOAM531hTGOWWnjuPwGj2c7HLjOGf/g3gRyvmd1drxLfqZOk7hmnWXOJ
        xYNSjMy7b+xbzoK/zGUGcJU9gxA18W3w0rx+HI4=
X-Google-Smtp-Source: ABdhPJwpOTI1nN6UuRTxjd5/p73Uf6kM8+6ur8drWXqYDzSpM0mDXMEuqSEq2Eq2R9eZGkvRphtJ4uxHkTHNZ/PG/qM=
X-Received: by 2002:a1c:6302:: with SMTP id x2mr689378wmb.56.1605053041916;
 Tue, 10 Nov 2020 16:04:01 -0800 (PST)
MIME-Version: 1.0
References: <20201110193112.988999-1-lee.jones@linaro.org> <20201110193112.988999-28-lee.jones@linaro.org>
In-Reply-To: <20201110193112.988999-28-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 10 Nov 2020 19:03:50 -0500
Message-ID: <CADnq5_OrKhZnZKhBcQaDWwSyJhtv6pQJEd9Byx0ZEG_GW-uEWA@mail.gmail.com>
Subject: Re: [PATCH 27/30] drm/radeon/ni: Remove set but unused variable 'mc_shared_chmap'
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

On Tue, Nov 10, 2020 at 2:32 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/radeon/ni.c: In function =E2=80=98cayman_gpu_init=E2=80=
=99:
>  drivers/gpu/drm/radeon/ni.c:880:6: warning: variable =E2=80=98mc_shared_=
chmap=E2=80=99 set but not used [-Wunused-but-set-variable]
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
>  drivers/gpu/drm/radeon/ni.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/ni.c b/drivers/gpu/drm/radeon/ni.c
> index 12dd082069649..1c9030a4631b8 100644
> --- a/drivers/gpu/drm/radeon/ni.c
> +++ b/drivers/gpu/drm/radeon/ni.c
> @@ -877,7 +877,7 @@ int tn_get_temp(struct radeon_device *rdev)
>  static void cayman_gpu_init(struct radeon_device *rdev)
>  {
>         u32 gb_addr_config =3D 0;
> -       u32 mc_shared_chmap, mc_arb_ramcfg;
> +       u32 mc_arb_ramcfg;
>         u32 cgts_tcc_disable;
>         u32 sx_debug_1;
>         u32 smx_dc_ctl0;
> @@ -1002,7 +1002,7 @@ static void cayman_gpu_init(struct radeon_device *r=
dev)
>
>         evergreen_fix_pci_max_read_req_size(rdev);
>
> -       mc_shared_chmap =3D RREG32(MC_SHARED_CHMAP);
> +       RREG32(MC_SHARED_CHMAP);
>         mc_arb_ramcfg =3D RREG32(MC_ARB_RAMCFG);
>
>         tmp =3D (mc_arb_ramcfg & NOOFCOLS_MASK) >> NOOFCOLS_SHIFT;
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
