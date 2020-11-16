Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD89A2B5328
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 21:47:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388586AbgKPUqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 15:46:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731170AbgKPUqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 15:46:37 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5437C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:46:36 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id k2so20329073wrx.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=n7206K9tbQjrW9WffRhlFU03h2XPHVa1EJsFslHQZc8=;
        b=V9P3O57JwSOXE4Z/U9mCTVsVxRev+UDzCjmh2+cmsy0VZx93J51SqMoOm+qkWXJ5by
         Ta6k32mrflPo/zvmGzOGyGemF+8mqpkYwXPFoEVPT32HPJ5Pe2AG/jKVnrtu80CunmlE
         Wysr8IuhYTkUWW54uorMR1E3kgN2l/D5GI4NBNCcK0/Fqc1sGhXqkAqa8MG/ZY0K5EKP
         J0AwQnsCIf7K/3LTDU/vfviHCNbxImjv6fepY24rTQdiAu23kspNjuejCJEiavfBZAvc
         t8aMbOvR1lWbTFqo47cLUEr1kdHWBPEiHg2wuGo2/CJmXQDvGuWLKMKqR2Dkm1uMIRVz
         /LnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=n7206K9tbQjrW9WffRhlFU03h2XPHVa1EJsFslHQZc8=;
        b=ZgoVyb1sbCdhLBg+8BS9RU2slghyho96OFeRjqqK+4akpC7SWPd13ZoyJqKSFj9Exb
         42ayynV7RBH6Z0Jvb1t6LsRdJCpZ6C+exT0Zn7aYlNCHHvFNK+Ph1Dkyq3+3KpFg8nQO
         LYKiZwB2Ih52P7b5ZlI35pOO86u7FjhljBl2uWBuk2tQptyh69ZOn995V6hkP/I0gqW+
         LDON7iz1FYlck2vqYMR+pXt0FuIyoz5UdG3wKR6rtAyd5etzHHhNL+ZljWnDf+aKCYOJ
         OdCkag1JjEdGq3/uenj8fr+IxplpjgppGKJO7FCr4D6DmSG9eiGkqwjgNagWadjHMPUB
         Eyjg==
X-Gm-Message-State: AOAM530GvS/GB6fFpQKbWy4IQogNLb9Flp1duHaWBIZZ/l7QWG2Lf5nm
        IfNLrmJVTGQun5LtPSntRD5rYMiFYsEfMG5Ldas=
X-Google-Smtp-Source: ABdhPJzBHUUYDmNrmFwgmzoxO2xlGZGD4FgVoxPR0v30R6cuqJYbuzlV+EyMqUJtGvEU0GUM+8xvcxtMPQVTDPk+sls=
X-Received: by 2002:adf:e551:: with SMTP id z17mr21691708wrm.374.1605559595551;
 Mon, 16 Nov 2020 12:46:35 -0800 (PST)
MIME-Version: 1.0
References: <20201116173700.1830487-1-lee.jones@linaro.org> <20201116173700.1830487-42-lee.jones@linaro.org>
In-Reply-To: <20201116173700.1830487-42-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 16 Nov 2020 15:46:24 -0500
Message-ID: <CADnq5_O6-AtbMtURHi+0mKgBv7W0PhRZKPNSi0qmEu_E-gj0rw@mail.gmail.com>
Subject: Re: [PATCH 41/43] drm/radeon/evergreen_cs: Move 'r600_dma_cs_next_reloc()'s
 prototype to shared header
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
>  drivers/gpu/drm/radeon/r600_cs.c:2343:5: warning: no previous prototype =
for =E2=80=98r600_dma_cs_next_reloc=E2=80=99 [-Wmissing-prototypes]
>  2343 | int r600_dma_cs_next_reloc(struct radeon_cs_parser *p,
>  | ^~~~~~~~~~~~~~~~~~~~~~
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
>  drivers/gpu/drm/radeon/evergreen_cs.c | 3 +--
>  drivers/gpu/drm/radeon/r600.h         | 4 ++++
>  drivers/gpu/drm/radeon/r600_cs.c      | 1 +
>  3 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/evergreen_cs.c b/drivers/gpu/drm/rade=
on/evergreen_cs.c
> index 53b75cf201958..0de79f3a7e3ff 100644
> --- a/drivers/gpu/drm/radeon/evergreen_cs.c
> +++ b/drivers/gpu/drm/radeon/evergreen_cs.c
> @@ -28,6 +28,7 @@
>
>  #include "radeon.h"
>  #include "radeon_asic.h"
> +#include "r600.h"
>  #include "evergreend.h"
>  #include "evergreen_reg_safe.h"
>  #include "cayman_reg_safe.h"
> @@ -37,8 +38,6 @@
>
>  #define REG_SAFE_BM_SIZE ARRAY_SIZE(evergreen_reg_safe_bm)
>
> -int r600_dma_cs_next_reloc(struct radeon_cs_parser *p,
> -                          struct radeon_bo_list **cs_reloc);
>  struct evergreen_cs_track {
>         u32                     group_size;
>         u32                     nbanks;
> diff --git a/drivers/gpu/drm/radeon/r600.h b/drivers/gpu/drm/radeon/r600.=
h
> index e66ef58706cd8..dbdff4568516b 100644
> --- a/drivers/gpu/drm/radeon/r600.h
> +++ b/drivers/gpu/drm/radeon/r600.h
> @@ -28,10 +28,14 @@
>  #ifndef __R600_H__
>  #define __R600_H__
>
> +struct radeon_bo_list;
> +struct radeon_cs_parser;
>  struct radeon_device;
>
>  u32 r600_gpu_check_soft_reset(struct radeon_device *rdev);
>  int r600_ih_ring_alloc(struct radeon_device *rdev);
>  void r600_ih_ring_fini(struct radeon_device *rdev);
>
> +int r600_dma_cs_next_reloc(struct radeon_cs_parser *p,
> +                          struct radeon_bo_list **cs_reloc);
>  #endif                         /* __R600_H__ */
> diff --git a/drivers/gpu/drm/radeon/r600_cs.c b/drivers/gpu/drm/radeon/r6=
00_cs.c
> index f20b619466816..dc68e538d5a97 100644
> --- a/drivers/gpu/drm/radeon/r600_cs.c
> +++ b/drivers/gpu/drm/radeon/r600_cs.c
> @@ -29,6 +29,7 @@
>
>  #include "radeon.h"
>  #include "radeon_asic.h"
> +#include "r600.h"
>  #include "r600d.h"
>  #include "r600_reg_safe.h"
>
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
