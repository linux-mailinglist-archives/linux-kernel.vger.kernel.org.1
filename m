Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE9012B5297
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 21:31:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732765AbgKPUax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 15:30:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbgKPUax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 15:30:53 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A667C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:30:53 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id c17so20215277wrc.11
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2vtxLDeQFs22DLyz4HgL3Y6rVX8yzKCeFH63VG1kJnc=;
        b=YzHDmQhV8IZiKFs6HLlQL8HK1f8pwDImAv/xJixGC7lWR5Ui7Xkoihb90HJGbgNsjS
         eWosCBL8OIlMkFxXoJTj4wBwcgZaaPEufYhrDJh3jmlKxyapfsXIrUBXXp0LfemceYGZ
         vFhCCFyZQoXRjbLFt9qPt86H24/9Wbo5vU7i45qQkXjGBRwH9gMCVykRg4XzeAR3KATB
         0RpcxCxWoynHfETu2lbIZvKdGXvBLkSckPrKY12qJ52OvRFz67jofRDdgDPAgWrJiiwA
         hq7YTvfGlmVGHE7cizkOnEUL7j5iohoyHK/Jlx28wYwhqQ8PSrrNTqaty2gg6+sgRFLJ
         glQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2vtxLDeQFs22DLyz4HgL3Y6rVX8yzKCeFH63VG1kJnc=;
        b=TDj8J9xb89wJm2tbUthZW0rtZnjtDaqz3gQbEjbNU+hv8ZjS9xKt7sJBRQ/Faf7zmL
         zL7hAzChlEMofOEYrFtwnBhIpeSKjDp8VXKy/kH5UVMmK4nTNmJLssbuCNe5MUBgMlFo
         Io+PkClwnBru1hk0PZMOj5em4wHke46pXQBvT56dCy5ONIeiqPK64S5xE49CGAHRn4WX
         gLQZvvl/zyPKAyDicBIw/kpBic/AgbTvPPFM1HSSR3VTuLSQOcJPBtu1D6oFx37bkkNs
         QrJAQoDpWUYI99FvJ7ld0g4oGbzaIg4mLBmwK9LJcIF1fGU+UC/3ynrYZgZbe8E1Fblz
         9nkg==
X-Gm-Message-State: AOAM533t8bDIRqiJhaXhz0b8KIYgmFJ55yCCYvMCobJQuZtr3XCh9P3K
        YPjbm8CB6i2QmvBdidQna9QhlRjDUypup8bluGaB+pZ3
X-Google-Smtp-Source: ABdhPJzQyzKmwaeo9m1q1UQzRHFx4HER8YWwaP5gI+EXp+WUZYn7yh1oE0lHLgQFNd6FEJqrM9KCD9oQQE9vEthKYNE=
X-Received: by 2002:adf:9144:: with SMTP id j62mr4584626wrj.419.1605558651987;
 Mon, 16 Nov 2020 12:30:51 -0800 (PST)
MIME-Version: 1.0
References: <20201116173700.1830487-1-lee.jones@linaro.org> <20201116173700.1830487-35-lee.jones@linaro.org>
In-Reply-To: <20201116173700.1830487-35-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 16 Nov 2020 15:30:41 -0500
Message-ID: <CADnq5_NEKQas7TZBiUrVHzJJ+0GrJD2AK+YbaDqArE50=ng7uA@mail.gmail.com>
Subject: Re: [PATCH 34/43] drm/radeon/evergreen: Move 'si_get_csb_*()'s
 prototypes to shared header
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

On Mon, Nov 16, 2020 at 12:37 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/radeon/si.c:5678:5: warning: no previous prototype for =
=E2=80=98si_get_csb_size=E2=80=99 [-Wmissing-prototypes]
>  5678 | u32 si_get_csb_size(struct radeon_device *rdev)
>  | ^~~~~~~~~~~~~~~
>  drivers/gpu/drm/radeon/si.c:5710:6: warning: no previous prototype for =
=E2=80=98si_get_csb_buffer=E2=80=99 [-Wmissing-prototypes]
>  5710 | void si_get_csb_buffer(struct radeon_device *rdev, volatile u32 *=
buffer)
>  | ^~~~~~~~~~~~~~~~~
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
>  drivers/gpu/drm/radeon/evergreen.c | 3 +--
>  drivers/gpu/drm/radeon/si.h        | 2 ++
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/evergreen.c b/drivers/gpu/drm/radeon/=
evergreen.c
> index 8fb0b8c3db5b5..4575e448e59df 100644
> --- a/drivers/gpu/drm/radeon/evergreen.c
> +++ b/drivers/gpu/drm/radeon/evergreen.c
> @@ -41,6 +41,7 @@
>  #include "radeon_asic.h"
>  #include "radeon_audio.h"
>  #include "radeon_ucode.h"
> +#include "si.h"
>
>  #define DC_HPDx_CONTROL(x)        (DC_HPD1_CONTROL     + (x * 0xc))
>  #define DC_HPDx_INT_CONTROL(x)    (DC_HPD1_INT_CONTROL + (x * 0xc))
> @@ -218,8 +219,6 @@ void evergreen_pcie_gen2_enable(struct radeon_device =
*rdev);
>  void evergreen_program_aspm(struct radeon_device *rdev);
>  void cik_init_cp_pg_table(struct radeon_device *rdev);
>
> -extern u32 si_get_csb_size(struct radeon_device *rdev);
> -extern void si_get_csb_buffer(struct radeon_device *rdev, volatile u32 *=
buffer);
>  extern u32 cik_get_csb_size(struct radeon_device *rdev);
>  extern void cik_get_csb_buffer(struct radeon_device *rdev, volatile u32 =
*buffer);
>
> diff --git a/drivers/gpu/drm/radeon/si.h b/drivers/gpu/drm/radeon/si.h
> index f483a64d17050..310c58376f927 100644
> --- a/drivers/gpu/drm/radeon/si.h
> +++ b/drivers/gpu/drm/radeon/si.h
> @@ -32,5 +32,7 @@ u32 si_gpu_check_soft_reset(struct radeon_device *rdev)=
;
>  void si_vram_gtt_location(struct radeon_device *rdev, struct radeon_mc *=
mc);
>  void si_rlc_reset(struct radeon_device *rdev);
>  void si_init_uvd_internal_cg(struct radeon_device *rdev);
> +u32 si_get_csb_size(struct radeon_device *rdev);
> +void si_get_csb_buffer(struct radeon_device *rdev, volatile u32 *buffer)=
;
>
>  #endif                         /* __SI_H__ */
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
