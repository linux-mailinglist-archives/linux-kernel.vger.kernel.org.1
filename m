Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D207281AC6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 20:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387934AbgJBSXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 14:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgJBSXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 14:23:11 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AECCC0613D0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 11:23:09 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id p15so3227843ejm.7
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 11:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4bzPIab4VFKjJVRS8nUYS5ckBsBdN2UEpwZV//i/pfs=;
        b=BoHELb4SMe2EXLTnmM7crMW7z4e5rCSlUGYMOrIAdjXmRa3XEtuHqpDmH9BXvnlB4K
         FYNksaqBSlgCn4zswwkJWAcIh4aB3l6sw6PQ7aZlBMWf+vEZvvhTe1LzhF2w+hgsLdUs
         9CCEQOqi7ooFv0hOakm61xTH7y/mUb3L2/qlk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4bzPIab4VFKjJVRS8nUYS5ckBsBdN2UEpwZV//i/pfs=;
        b=McBFuvWsFSyPGRajT7ZkwvLNF/k0++Xx21HNG60fZSyPnuYvliwPUXnBHgK9RnJI4q
         RcMmN+IqaZmnx2hYdK8AveV+OlAMNaaKlZANJM2d9uvH7eNxml+8CbG23uMNZLkXA7Ff
         G5GARhdk+RU/Igablce57IvfsV5x2MZr5K902RVVnk26kBN4O4xh24E1ZEqqlKS9yBCL
         Ww/lWn+nHze1CHA1AsILNd73krg3R1sTUoMQ7+7sbRTf9KrhwQQ4+X8upe4v8ZcCspm1
         SSyXUUj+LumE50UqrWo6f1bVwwBh9uLNA0xmwUPDhI/uarVagkHMFRC2q7vqciXvWsb0
         u2dQ==
X-Gm-Message-State: AOAM530OepRyPzxLMTeNA5eoESNE4O4Fll0xxbFH+JGf57fX1HIwGnpM
        Mp3zFz0i1X3Lw2MkDADZMN+7UhajCS1Tpw==
X-Google-Smtp-Source: ABdhPJyJPSbaQiOeSNXPGgZDJUmsVh1aPA3V0OEKXn+8SJMARnewKGjbgS/Ae9snktSaFbGt+fUVwg==
X-Received: by 2002:a17:906:60d6:: with SMTP id f22mr3522196ejk.250.1601662987645;
        Fri, 02 Oct 2020 11:23:07 -0700 (PDT)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id h2sm1638085ejk.33.2020.10.02.11.23.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2020 11:23:06 -0700 (PDT)
Received: by mail-wm1-f54.google.com with SMTP id v12so2680346wmh.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 11:23:06 -0700 (PDT)
X-Received: by 2002:a1c:a5c8:: with SMTP id o191mr4341034wme.127.1601662986038;
 Fri, 02 Oct 2020 11:23:06 -0700 (PDT)
MIME-Version: 1.0
References: <20201002175303.390363-1-daniel.vetter@ffwll.ch>
In-Reply-To: <20201002175303.390363-1-daniel.vetter@ffwll.ch>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Fri, 2 Oct 2020 20:22:49 +0200
X-Gmail-Original-Message-ID: <CAAFQd5AsFOau=m_3UPh2tKqwiUJaY4NH9HHrHJ17gbCLDgTNCQ@mail.gmail.com>
Message-ID: <CAAFQd5AsFOau=m_3UPh2tKqwiUJaY4NH9HHrHJ17gbCLDgTNCQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm/frame-vec: Drop gup_flags from get_vaddr_frames()
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Pawel Osciak <pawel@osciak.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Omer Shpigelman <oshpigelman@habana.ai>,
        Tomer Tayar <ttayar@habana.ai>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pawel Piskorski <ppiskorski@habana.ai>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 2, 2020 at 7:53 PM Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
>
> FOLL_WRITE | FOLL_FORCE is really the only reasonable thing to do for
> simple dma device that can't guarantee write protection. Which is also
> what all the callers are using.
>
> So just simplify this.
>
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Inki Dae <inki.dae@samsung.com>
> Cc: Joonyoung Shim <jy0922.shim@samsung.com>
> Cc: Seung-Woo Kim <sw0312.kim@samsung.com>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Pawel Osciak <pawel@osciak.com>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Tomasz Figa <tfiga@chromium.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Oded Gabbay <oded.gabbay@gmail.com>
> Cc: Omer Shpigelman <oshpigelman@habana.ai>
> Cc: Tomer Tayar <ttayar@habana.ai>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Pawel Piskorski <ppiskorski@habana.ai>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-samsung-soc@vger.kernel.org
> Cc: linux-media@vger.kernel.org
> Cc: linux-mm@kvack.org
> ---
>  drivers/gpu/drm/exynos/exynos_drm_g2d.c           | 3 +--
>  drivers/media/common/videobuf2/videobuf2-memops.c | 3 +--
>  drivers/misc/habanalabs/common/memory.c           | 3 +--
>  include/linux/mm.h                                | 2 +-
>  mm/frame_vector.c                                 | 4 ++--
>  5 files changed, 6 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_g2d.c b/drivers/gpu/drm/exynos/exynos_drm_g2d.c
> index 967a5cdc120e..ac452842bab3 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_g2d.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_g2d.c
> @@ -480,8 +480,7 @@ static dma_addr_t *g2d_userptr_get_dma_addr(struct g2d_data *g2d,
>                 goto err_free;
>         }
>
> -       ret = get_vaddr_frames(start, npages, FOLL_FORCE | FOLL_WRITE,
> -               g2d_userptr->vec);
> +       ret = get_vaddr_frames(start, npages, g2d_userptr->vec);
>         if (ret != npages) {
>                 DRM_DEV_ERROR(g2d->dev,
>                               "failed to get user pages from userptr.\n");
> diff --git a/drivers/media/common/videobuf2/videobuf2-memops.c b/drivers/media/common/videobuf2/videobuf2-memops.c
> index 6e9e05153f4e..9dd6c27162f4 100644
> --- a/drivers/media/common/videobuf2/videobuf2-memops.c
> +++ b/drivers/media/common/videobuf2/videobuf2-memops.c
> @@ -40,7 +40,6 @@ struct frame_vector *vb2_create_framevec(unsigned long start,
>         unsigned long first, last;
>         unsigned long nr;
>         struct frame_vector *vec;
> -       unsigned int flags = FOLL_FORCE | FOLL_WRITE;
>
>         first = start >> PAGE_SHIFT;
>         last = (start + length - 1) >> PAGE_SHIFT;
> @@ -48,7 +47,7 @@ struct frame_vector *vb2_create_framevec(unsigned long start,
>         vec = frame_vector_create(nr);
>         if (!vec)
>                 return ERR_PTR(-ENOMEM);
> -       ret = get_vaddr_frames(start & PAGE_MASK, nr, flags, vec);
> +       ret = get_vaddr_frames(start & PAGE_MASK, nr, vec);
>         if (ret < 0)
>                 goto out_destroy;
>         /* We accept only complete set of PFNs */

For drivers/media/common/videobuf2/:

Acked-by: Tomasz Figa <tfiga@chromium.org>

Best regards,
Tomasz
