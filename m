Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64B7D2B52A1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 21:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732777AbgKPUcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 15:32:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbgKPUcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 15:32:45 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01FBFC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:32:45 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id p22so572082wmg.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tvjObB+QSH10nKAdT+mgUH1fEbKyTz7cFdjI3x4Mh38=;
        b=Z5rUMDq107kdOxeQ9oudvz6w92/u0jvTalftxFkTkOsX816vk7IC2nuwkVym9s16+B
         dISyj0lbJh21VRYzOvLjCrCYYvF+wxxwZcgPbmmOeJZRTW41SWJH7KQuwlaL7PSTwDQb
         jorjF3om74hVfAJt6Ud7dwcLybESn7zNkHOmZgY72b8VJCMmxl5j9BhxUoBXxExelPG6
         8zTDwed30dtPgfJd3PKo4k4rMUmDOyTjJR9CP+CxG7eGG2t6i4Zyx1pDZAgqTurjTPG3
         dJR4XSOtxdmrRlhmDZ1IlKPwCRCHvoBG+s46Nl7pC8ZD4INGVmvqs4mBI4HsXoZ5KG7H
         ylrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tvjObB+QSH10nKAdT+mgUH1fEbKyTz7cFdjI3x4Mh38=;
        b=GpPBNAU/VQOzw28/kNzplcTqz7ZsCofVuOtezPyRa0ErAdSGT+FBTwi21QmubUH3LG
         /4vQqWKsFotMpK3NbdvZAfH/EE20+Y14ANdTq3ZSUFl6curbUwapoPgb/iN/AzMT/lpW
         n2mRZk2L8yn985YwLp4p4C+GT7llW4jlxRQpFtlDPg9AExHHYFl0dseVow4MZe4T/p/5
         WAj25zOm3x1tYo0I/eeKSPIw5OStDKu8aFVkEvD1IxRiBpH6Zj0z3EWV0ttgtSashZor
         qr4MxBd3GEdFF4zy8MkCJUm0RJeDn8J4tQYOs0isFuligZAW08kiMZqUJ8p7nQ3/VlZp
         lEJA==
X-Gm-Message-State: AOAM532AzIQL08jmR/MWyh757SFyJYrJo3fNC12bzexZGiFOZ06tUTdL
        Jkd9ZrxbccEc1QUd7NtbzW/JBG5rsYAY4H76918=
X-Google-Smtp-Source: ABdhPJx91wm13SHnc9OKeMbG/rgExYVLjFNtsfjpB43JlyH7VsoFOOOVdSDQnex+m4quboH/8kdpgJGkqg94FGU2JQQ=
X-Received: by 2002:a1c:1c3:: with SMTP id 186mr665693wmb.39.1605558763784;
 Mon, 16 Nov 2020 12:32:43 -0800 (PST)
MIME-Version: 1.0
References: <20201116173700.1830487-1-lee.jones@linaro.org> <20201116173700.1830487-37-lee.jones@linaro.org>
In-Reply-To: <20201116173700.1830487-37-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 16 Nov 2020 15:32:32 -0500
Message-ID: <CADnq5_PyE+j1YaDX5FBU4cbUqvGt63GsSXW_RvQZXD0Y_6HFiw@mail.gmail.com>
Subject: Re: [PATCH 36/43] drm/radeon/evergreen: Move 'cik_*()'s prototypes to
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
>  drivers/gpu/drm/radeon/cik.c:6413:6: warning: no previous prototype for =
=E2=80=98cik_init_cp_pg_table=E2=80=99 [-Wmissing-prototypes]
>  6413 | void cik_init_cp_pg_table(struct radeon_device *rdev)
>  | ^~~~~~~~~~~~~~~~~~~~
>  drivers/gpu/drm/radeon/cik.c:6670:5: warning: no previous prototype for =
=E2=80=98cik_get_csb_size=E2=80=99 [-Wmissing-prototypes]
>  6670 | u32 cik_get_csb_size(struct radeon_device *rdev)
>  | ^~~~~~~~~~~~~~~~
>  drivers/gpu/drm/radeon/cik.c:6702:6: warning: no previous prototype for =
=E2=80=98cik_get_csb_buffer=E2=80=99 [-Wmissing-prototypes]
>  6702 | void cik_get_csb_buffer(struct radeon_device *rdev, volatile u32 =
*buffer)
>  | ^~~~~~~~~~~~~~~~~~
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
>  drivers/gpu/drm/radeon/cik.h       | 3 +++
>  drivers/gpu/drm/radeon/evergreen.c | 5 +----
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/cik.h b/drivers/gpu/drm/radeon/cik.h
> index 6630b9da9e7aa..420207d19de52 100644
> --- a/drivers/gpu/drm/radeon/cik.h
> +++ b/drivers/gpu/drm/radeon/cik.h
> @@ -30,5 +30,8 @@ void cik_exit_rlc_safe_mode(struct radeon_device *rdev)=
;
>  int ci_mc_load_microcode(struct radeon_device *rdev);
>  void cik_update_cg(struct radeon_device *rdev, u32 block, bool enable);
>  u32 cik_gpu_check_soft_reset(struct radeon_device *rdev);
> +void cik_init_cp_pg_table(struct radeon_device *rdev);
> +u32 cik_get_csb_size(struct radeon_device *rdev);
> +void cik_get_csb_buffer(struct radeon_device *rdev, volatile u32 *buffer=
);
>
>  #endif                         /* __CIK_H__ */
> diff --git a/drivers/gpu/drm/radeon/evergreen.c b/drivers/gpu/drm/radeon/=
evergreen.c
> index 4575e448e59df..8e9e88bf1f43d 100644
> --- a/drivers/gpu/drm/radeon/evergreen.c
> +++ b/drivers/gpu/drm/radeon/evergreen.c
> @@ -31,6 +31,7 @@
>
>  #include "atom.h"
>  #include "avivod.h"
> +#include "cik.h"
>  #include "ni.h"
>  #include "rv770.h"
>  #include "evergreen.h"
> @@ -217,10 +218,6 @@ static void evergreen_gpu_init(struct radeon_device =
*rdev);
>  void evergreen_fini(struct radeon_device *rdev);
>  void evergreen_pcie_gen2_enable(struct radeon_device *rdev);
>  void evergreen_program_aspm(struct radeon_device *rdev);
> -void cik_init_cp_pg_table(struct radeon_device *rdev);
> -
> -extern u32 cik_get_csb_size(struct radeon_device *rdev);
> -extern void cik_get_csb_buffer(struct radeon_device *rdev, volatile u32 =
*buffer);
>
>  static const u32 evergreen_golden_registers[] =3D
>  {
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
