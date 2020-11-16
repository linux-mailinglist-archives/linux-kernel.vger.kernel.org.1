Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA7DB2B520B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 21:09:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731806AbgKPUJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 15:09:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbgKPUJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 15:09:19 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4FCC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:09:19 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id c17so20157844wrc.11
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pg6uaDKDYNPDperu96oj5Pj32go0EMzBskVqcWRUwJg=;
        b=ifKnE5TyrOtX4QVZ0FKpawewZ53nJLm99KV7Ro0ExwFgjQ5x79c0u1CqIJJ8xFuJv5
         gK+51TWymqdA37R1DqjBN1S3tZk+1+Z90z6oNROFp1oNx6jR1YMi9VuTNZa/xtiyDxeN
         HdBAbjtr/Qxp3BDby/S4LAHmxV6vQIsc7ElE0Oj874f9rGWi6JXNCjVnSqsGpdomUMgD
         PA8D/IrD1srimFCrsD+Ac7srzfvUGp3A+TzHlf3gu3bQ6f7H1Oh4XILkEGKgMEKZOe6W
         rjPkOtYUF09a0VFO1SJiKgXqNC7zhwS6b77vA6I8ER5XWzp//sagLgqK7Qqfaltc4SUl
         WMuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pg6uaDKDYNPDperu96oj5Pj32go0EMzBskVqcWRUwJg=;
        b=qD7AWjAjVjM1FyVbKyQC2ajxznoyiIORoLBKcLZBiRhuwH5XPs5K6pjPqchsNRC6zZ
         IYuFT9k1qHY1xqL6uUhsK8gqd9pc9S/fVvkTDMptCMwWFwip/eM2ywcqp0zeyCdNYw1M
         ox/da8WOd261BKCqfxt2eyZxye9GcvrQKdz5LJZQat2pl9nh7ePzjxj26VWtK66n6V/l
         0DuFbEHttz52j97C8JuISSSOaOdQSY16TcAMRuUm5iKSFTSa+gnPzXvviSYnuY8GIvU4
         q2s9P/LlTWLnb6AuTFD1gtxLuIyxz1I7RUWu2ldsacn/4YOpcTS9hLsANH/v5ESmksnb
         M2Dw==
X-Gm-Message-State: AOAM533VOXK3QmN8Au1Jo28e9JHANu2TkqHWVoxvNaHuEzlUspZvaypC
        vNvauCqYr+VkMjw7Kz4lmTjECPa2yC+EJoKYc+6YNjVx
X-Google-Smtp-Source: ABdhPJwT64UuAgjZK9kFkJMd/Zlx/HK9C7umlQpb+s00D/ZGhxNus/6SRixMlRH+h5U5RxW5C524zCzR6EoE2xknsnI=
X-Received: by 2002:adf:e551:: with SMTP id z17mr21548934wrm.374.1605557357973;
 Mon, 16 Nov 2020 12:09:17 -0800 (PST)
MIME-Version: 1.0
References: <20201116173700.1830487-1-lee.jones@linaro.org> <20201116173700.1830487-20-lee.jones@linaro.org>
In-Reply-To: <20201116173700.1830487-20-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 16 Nov 2020 15:09:07 -0500
Message-ID: <CADnq5_P3Otrk=UeG+G2T8p8NcwGWBrdQSgddhp9tJYi9A_SBXA@mail.gmail.com>
Subject: Re: [PATCH 19/43] drm/radeon/ni_dpm: Move 'ni_get_{pi, ps}()'s into
 shared header
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

On Mon, Nov 16, 2020 at 12:38 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/radeon/ni_dpm.c:727:23: warning: no previous prototype f=
or =E2=80=98ni_get_pi=E2=80=99 [-Wmissing-prototypes]
>  727 | struct ni_power_info *ni_get_pi(struct radeon_device *rdev)
>  | ^~~~~~~~~
>  drivers/gpu/drm/radeon/ni_dpm.c:734:15: warning: no previous prototype f=
or =E2=80=98ni_get_ps=E2=80=99 [-Wmissing-prototypes]
>  734 | struct ni_ps *ni_get_ps(struct radeon_ps *rps)
>  | ^~~~~~~~~
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
>  drivers/gpu/drm/radeon/ni_dpm.h | 3 +++
>  drivers/gpu/drm/radeon/si_dpm.c | 3 +--
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/ni_dpm.h b/drivers/gpu/drm/radeon/ni_=
dpm.h
> index 6bbee9180909e..74e3019369063 100644
> --- a/drivers/gpu/drm/radeon/ni_dpm.h
> +++ b/drivers/gpu/drm/radeon/ni_dpm.h
> @@ -247,4 +247,7 @@ void ni_set_uvd_clock_after_set_eng_clock(struct rade=
on_device *rdev,
>
>  bool ni_dpm_vblank_too_short(struct radeon_device *rdev);
>
> +struct ni_power_info *ni_get_pi(struct radeon_device *rdev);
> +struct ni_ps *ni_get_ps(struct radeon_ps *rps);
> +
>  #endif
> diff --git a/drivers/gpu/drm/radeon/si_dpm.c b/drivers/gpu/drm/radeon/si_=
dpm.c
> index a80a21447a76d..c68ab2fb1ac23 100644
> --- a/drivers/gpu/drm/radeon/si_dpm.c
> +++ b/drivers/gpu/drm/radeon/si_dpm.c
> @@ -30,6 +30,7 @@
>  #include "rv770.h"
>  #include "radeon.h"
>  #include "radeon_asic.h"
> +#include "ni_dpm.h"
>  #include "si_dpm.h"
>  #include "sid.h"
>
> @@ -1719,8 +1720,6 @@ static const struct si_powertune_data powertune_dat=
a_hainan =3D
>  };
>
>  struct evergreen_power_info *evergreen_get_pi(struct radeon_device *rdev=
);
> -struct ni_power_info *ni_get_pi(struct radeon_device *rdev);
> -struct ni_ps *ni_get_ps(struct radeon_ps *rps);
>
>  extern int si_mc_load_microcode(struct radeon_device *rdev);
>  extern void vce_v1_0_enable_mgcg(struct radeon_device *rdev, bool enable=
);
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
