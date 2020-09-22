Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CDA527457B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 17:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726737AbgIVPjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 11:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbgIVPjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 11:39:33 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0515C061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 08:39:32 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id d4so3810650wmd.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 08:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+DDHh48hUhaZM9vXx+KNvw8NfXShcDtMcHxV9xxIOts=;
        b=V9x082tFsavECxmKgNMIK9Wq1WWUsqy/d69/S+J2gvE5b2H723klZEisQ60MVgW4Qi
         bmL/zxtUvGA5YhoErIhGZC0zyH+q1iIRBZvrSQVEqTKoSlUCP+ieT1SE9WdiLyhVGS13
         0QA8x2nJI3hruNv6pQJdKAXnvaiuR3mRCzBDzmqvw+dkx20/dKtlGPK3H+Za8w73s2kB
         etExTz7+7nw6Wbded+nlyg71BToKGzsNJnpIR5ZfMs2rmaDT0xbiU76fSZaectXwozLP
         nHWQrmK5u6NW5GxfchIv72aQpMXlb10nUI3pF5QdPv/BaaUzFVz9cuxiCIINQehNw9T9
         OKSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+DDHh48hUhaZM9vXx+KNvw8NfXShcDtMcHxV9xxIOts=;
        b=iMSRa6mL0B6KObPOvpLd/kAEFYNE/irpmsrksx3mgm+Ha7qEYc/VIlrsqMf01XVX5f
         7HTZEzrLV2qgGWQTsID93ZCfAIEnRMLM1vnfCUSg+0QmSx6kTtagE2GVreCsOvzcJ13d
         FCBwVhJI7mQm0PKnB7wY4BPnWKV5TQ9jTUHGXrfE6S3kFxVgpMhAp0nCblRpf+jHzYEA
         t1ABMEWlTRmveHNbTxPWj+9CWuemCXWvuk7Xf7PfwE+LMKGt4oF56e8b383XK3U/zL45
         n7sJOJuy1UBj2RFlMfqlORiHlzgZYKDy53vAIeEdh8JRySUZAQV4t6DEdL2rveGiaUjV
         cXRA==
X-Gm-Message-State: AOAM531IaAvCLVhNlRQKwz9IZl7cT7U+7+2Rh53+g39ZqgGg+m51uG/B
        8xykJ0ZfgsGsGbK43ovtmXDDnqQztrZLk37laa8=
X-Google-Smtp-Source: ABdhPJxOUJWknVLKUhCLW7xnXjLZyic+3stY5q2umXf20WkebOVMhD3AnwCsYAxz/rRo/Ey7dj3LYpsMveqbF3JMdX4=
X-Received: by 2002:a1c:a184:: with SMTP id k126mr1633913wme.39.1600789171418;
 Tue, 22 Sep 2020 08:39:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200922124029.27500-1-bernard@vivo.com>
In-Reply-To: <20200922124029.27500-1-bernard@vivo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 22 Sep 2020 11:39:20 -0400
Message-ID: <CADnq5_ODhc7PuiT6OY5hh1bLdR74iVYRnR1fWR2jZHtobdLr2g@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon:fix typoes in comments
To:     Bernard Zhao <bernard@vivo.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Tue, Sep 22, 2020 at 9:11 AM Bernard Zhao <bernard@vivo.com> wrote:
>
> Change the comment typo: "programm" -> "program".
>
> Signed-off-by: Bernard Zhao <bernard@vivo.com>
> ---
>  drivers/gpu/drm/radeon/uvd_v1_0.c | 4 ++--
>  drivers/gpu/drm/radeon/uvd_v2_2.c | 2 +-
>  drivers/gpu/drm/radeon/uvd_v4_2.c | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/uvd_v1_0.c b/drivers/gpu/drm/radeon/uvd_v1_0.c
> index 800721153d51..58557c2263a7 100644
> --- a/drivers/gpu/drm/radeon/uvd_v1_0.c
> +++ b/drivers/gpu/drm/radeon/uvd_v1_0.c
> @@ -117,7 +117,7 @@ int uvd_v1_0_resume(struct radeon_device *rdev)
>         if (r)
>                 return r;
>
> -       /* programm the VCPU memory controller bits 0-27 */
> +       /* program the VCPU memory controller bits 0-27 */
>         addr = (rdev->uvd.gpu_addr >> 3) + 16;
>         size = RADEON_GPU_PAGE_ALIGN(rdev->uvd_fw->size) >> 3;
>         WREG32(UVD_VCPU_CACHE_OFFSET0, addr);
> @@ -360,7 +360,7 @@ int uvd_v1_0_start(struct radeon_device *rdev)
>         /* Set the write pointer delay */
>         WREG32(UVD_RBC_RB_WPTR_CNTL, 0);
>
> -       /* programm the 4GB memory segment for rptr and ring buffer */
> +       /* program the 4GB memory segment for rptr and ring buffer */
>         WREG32(UVD_LMI_EXT40_ADDR, upper_32_bits(ring->gpu_addr) |
>                                    (0x7 << 16) | (0x1 << 31));
>
> diff --git a/drivers/gpu/drm/radeon/uvd_v2_2.c b/drivers/gpu/drm/radeon/uvd_v2_2.c
> index 23b18edda20e..6266167886d9 100644
> --- a/drivers/gpu/drm/radeon/uvd_v2_2.c
> +++ b/drivers/gpu/drm/radeon/uvd_v2_2.c
> @@ -109,7 +109,7 @@ int uvd_v2_2_resume(struct radeon_device *rdev)
>         if (r)
>                 return r;
>
> -       /* programm the VCPU memory controller bits 0-27 */
> +       /* program the VCPU memory controller bits 0-27 */
>         addr = rdev->uvd.gpu_addr >> 3;
>         size = RADEON_GPU_PAGE_ALIGN(rdev->uvd_fw->size + 4) >> 3;
>         WREG32(UVD_VCPU_CACHE_OFFSET0, addr);
> diff --git a/drivers/gpu/drm/radeon/uvd_v4_2.c b/drivers/gpu/drm/radeon/uvd_v4_2.c
> index dc54fa4aaea8..f9e97fa63674 100644
> --- a/drivers/gpu/drm/radeon/uvd_v4_2.c
> +++ b/drivers/gpu/drm/radeon/uvd_v4_2.c
> @@ -40,7 +40,7 @@ int uvd_v4_2_resume(struct radeon_device *rdev)
>         uint64_t addr;
>         uint32_t size;
>
> -       /* programm the VCPU memory controller bits 0-27 */
> +       /* program the VCPU memory controller bits 0-27 */
>
>         /* skip over the header of the new firmware format */
>         if (rdev->uvd.fw_header_present)
> --
> 2.28.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
