Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 322722C2C92
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 17:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390273AbgKXQQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 11:16:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390095AbgKXQQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 11:16:08 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7622CC0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 08:16:08 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id l1so22871408wrb.9
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 08:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6u3X2EJumnPSVBJDMd67m/oxJY0N46da9Q4A0CHDe4c=;
        b=GoV+dO27QW2/4gv0cmXmmMNWMAcgCho4b8g3F3I8TEaqEQAWE6XvvOVw28ShJXay9b
         cctjltNE6yU/bV5WYUfCfy2qy50Dgn1qT/GxiaSYaWa5pxu98JePq7vgXUN53lGradzB
         1wAP0KYZsCK7//8V5/6lp3bimhzFnV9A5GDIYydjFVcaei8gWKT8cif3nNMe3tiXDHqq
         UeQ2LQMrssZkAcrkkVhYvaPLIEj6BMtTxQfECyeS/MBW/PSuY2PRPy9H2XLIZ1xP6Ew9
         xwhATPGnztcovclO7HvAZKPG5PgZth3WoiuJAL/jsTU0wuRbpDrZdBdGLIf3ovuay/4I
         rtNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6u3X2EJumnPSVBJDMd67m/oxJY0N46da9Q4A0CHDe4c=;
        b=bdAuzhuxCfv2s3OT7CD6mr+mmfHlxbgrPxD6vzfHyfk0P1Sm1JqJUyfK9UhGeundH+
         t3/RiuyGHHQDGf53elfpyCqy4d1Ovs83YBsONknMrvyQ6vG3x/lsuaOLblfTyr4hP34t
         X1NgCkVrGVRbUFr/t1mzdIHpWDX7Yx3LN9sC7AfY2H9HC98WEnJ50XW3g1sfomiZjDlV
         ek23K9il2ilxSfByCtrgCkHgYb1F8viJFwagg3WAxyhhQ48eLkt7jluXsPFxwaDts3hm
         kgjpdc0viOFz/a0SsHo8HG2a4aGIGmIma+RXC74Efe6eJ5ZBpR9JTTmFvcZuecDTmfRJ
         J6yA==
X-Gm-Message-State: AOAM530e8LfECQxi/X5JjidQgBfj66ttkBdp8+GeHbPLtj2mgNvIxD/m
        4yp3GtZxhrhpapKdUVCXB1kuhHcr37R2ikTQtiM=
X-Google-Smtp-Source: ABdhPJwMVElpfSmNpkqDl6RZr9Iq+NMuM32RVXSSv19l9Z5MpoEmkMzM2eVrMZq66oPV4PL4XC8vSkBuzPWvpdZWvEU=
X-Received: by 2002:adf:8028:: with SMTP id 37mr6158027wrk.111.1606234567277;
 Tue, 24 Nov 2020 08:16:07 -0800 (PST)
MIME-Version: 1.0
References: <20201123111919.233376-1-lee.jones@linaro.org> <20201123111919.233376-30-lee.jones@linaro.org>
In-Reply-To: <20201123111919.233376-30-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 24 Nov 2020 11:15:56 -0500
Message-ID: <CADnq5_NAD7-NzLDsLNhZ_PxrujiSXcVyj1uo=h--c2p9sRjXxg@mail.gmail.com>
Subject: Re: [PATCH 29/40] drm/amd/include/vangogh_ip_offset: Mark top-level
 IP_BASE as __maybe_unused
To:     Lee Jones <lee.jones@linaro.org>
Cc:     David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Huang Rui <ray.huang@amd.com>,
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
>  In file included from drivers/gpu/drm/amd/amdgpu/vangogh_reg_init.c:28:
>  drivers/gpu/drm/amd/amdgpu/../include/vangogh_ip_offset.h:210:29: warnin=
g: =E2=80=98USB_BASE=E2=80=99 defined but not used [-Wunused-const-variable=
=3D]
>  210 | static const struct IP_BASE USB_BASE =3D { { { { 0x0242A800, 0x05B=
00000, 0, 0, 0, 0 } },
>  | ^~~~~~~~
>  drivers/gpu/drm/amd/amdgpu/../include/vangogh_ip_offset.h:202:29: warnin=
g: =E2=80=98UMC_BASE=E2=80=99 defined but not used [-Wunused-const-variable=
=3D]
>  202 | static const struct IP_BASE UMC_BASE =3D { { { { 0x00014000, 0x024=
25800, 0, 0, 0, 0 } },
>  | ^~~~~~~~
>  drivers/gpu/drm/amd/amdgpu/../include/vangogh_ip_offset.h:178:29: warnin=
g: =E2=80=98PCIE0_BASE=E2=80=99 defined but not used [-Wunused-const-variab=
le=3D]
>  178 | static const struct IP_BASE PCIE0_BASE =3D { { { { 0x00000000, 0x0=
0000014, 0x00000D20, 0x00010400, 0x0241B000, 0x04040000 } },
>  | ^~~~~~~~~~
>  drivers/gpu/drm/amd/amdgpu/../include/vangogh_ip_offset.h:154:29: warnin=
g: =E2=80=98MP2_BASE=E2=80=99 defined but not used [-Wunused-const-variable=
=3D]
>  154 | static const struct IP_BASE MP2_BASE =3D { { { { 0x00016400, 0x024=
00800, 0x00F40000, 0x00F80000, 0x00FC0000, 0 } },
>  | ^~~~~~~~
>
> NB: Snipped lots of these
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Huang Rui <ray.huang@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/include/vangogh_ip_offset.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/include/vangogh_ip_offset.h b/drivers/gp=
u/drm/amd/include/vangogh_ip_offset.h
> index 2875574b060e6..691073ed780ec 100644
> --- a/drivers/gpu/drm/amd/include/vangogh_ip_offset.h
> +++ b/drivers/gpu/drm/amd/include/vangogh_ip_offset.h
> @@ -36,7 +36,7 @@ struct IP_BASE_INSTANCE
>  struct IP_BASE
>  {
>      struct IP_BASE_INSTANCE instance[MAX_INSTANCE];
> -};
> +} __maybe_unused;
>
>
>  static const struct IP_BASE ACP_BASE =3D { { { { 0x02403800, 0x00480000,=
 0, 0, 0, 0 } },
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
