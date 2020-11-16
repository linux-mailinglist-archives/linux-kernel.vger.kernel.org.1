Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0CF2B5248
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 21:17:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732602AbgKPUQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 15:16:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729344AbgKPUQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 15:16:57 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC74C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:16:57 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id 23so20185388wrc.8
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iLPALqEQiM6jDL+mCkTNxXZv8QcvmWDHOLkPd8CS1b4=;
        b=Ta2D67qLLEYrg8GhEch6dOd4yTiw339hDecmpbTuQ86ZWBZIUrFU9RwWoKwWkuaUJ2
         EBeTYbQJ+07LB+0HcvYBhK1aVtG7fV5H8Yj4Hdt8lUO6kqPaTuvSmiD1WT/VNTej2tO+
         naWC3eqj+4qhIUBEnt4rEkO81zDhUT6MdOiE3WQKC9HxYXuckd8sIypF8fHkDGwc6KNF
         ggtNG6qbwtm2VCvTUPoxyYWYkmouZkLA4uq8GR9pcjrkXp0j9/1aihukqm4mw3K8jEWZ
         EAr4lNNc4fChcTwpLyPs+mdhfUw46Mvh8u9BcSKVgBJP2SCSkxtQjkgJ7CapaIbL3pBU
         9dvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iLPALqEQiM6jDL+mCkTNxXZv8QcvmWDHOLkPd8CS1b4=;
        b=pTMSu5fjcd0BoAzbqXxwGtnP+IGP9FUcjIY+UBCRrBiDBAuvQEjhSPqrdL8Bpe5/Cm
         ZoCe+C+1diCDMF7NILBhyCC8EMt4OTT6Sg37mamK9J78ec5bZb5MrdjVHTCS83iV/CwV
         R809nA63XHUyCjInd6qAIlyt+TAi7HmjkhMmKEw7xD0pev6ocnMmHUR05DgfoE7rcIsF
         ROmkiCSldbrPJQLUkM3kaD4nQ8ec1UUTqI1x/C8QrffMcBcevtxKJMaO308JCM6orxmJ
         mJ10lIrTF5InZyhrFvc95vFVC7gLn+49HhW6OYDp9xLRI0RK0Zwxrvksa+KNRlM+1pY5
         XS8Q==
X-Gm-Message-State: AOAM531jSfVhEK7GaFmbUok35CMO9VZVvlom2AJVeVFKYu/V57IQO87D
        cRCYKjWW2V06DBGPWq7rQ3V1hieP4mL308Z8MS4=
X-Google-Smtp-Source: ABdhPJwUchvyXjzuMjKCjVfeAtTXUEDmkr0D32kySo0C2GRIt0OX31+iccB6sYoBnE5gShhRlMi4jZ1soDLk9E8ziJo=
X-Received: by 2002:a5d:6992:: with SMTP id g18mr21055026wru.362.1605557816070;
 Mon, 16 Nov 2020 12:16:56 -0800 (PST)
MIME-Version: 1.0
References: <20201116173700.1830487-1-lee.jones@linaro.org> <20201116173700.1830487-24-lee.jones@linaro.org>
In-Reply-To: <20201116173700.1830487-24-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 16 Nov 2020 15:16:45 -0500
Message-ID: <CADnq5_P_S4sXJzof9_mWAAAVzqBqSBYwtyUeDpLqgbWSz7Dw4g@mail.gmail.com>
Subject: Re: [PATCH 23/43] drm/radeon/evergreen_dma: Move 'evergreen_gpu_check_soft_reset()'s
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
>  drivers/gpu/drm/radeon/evergreen.c:3825:5: warning: no previous prototyp=
e for =E2=80=98evergreen_gpu_check_soft_reset=E2=80=99 [-Wmissing-prototype=
s]
>  3825 | u32 evergreen_gpu_check_soft_reset(struct radeon_device *rdev)
>  | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
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
>  drivers/gpu/drm/radeon/evergreen.h     | 1 +
>  drivers/gpu/drm/radeon/evergreen_dma.c | 3 +--
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/evergreen.h b/drivers/gpu/drm/radeon/=
evergreen.h
> index 30c9ca99ced90..eb46ac7776951 100644
> --- a/drivers/gpu/drm/radeon/evergreen.h
> +++ b/drivers/gpu/drm/radeon/evergreen.h
> @@ -47,5 +47,6 @@ int sumo_rlc_init(struct radeon_device *rdev);
>  void evergreen_gpu_pci_config_reset(struct radeon_device *rdev);
>  u32 evergreen_get_number_of_dram_channels(struct radeon_device *rdev);
>  void evergreen_print_gpu_status_regs(struct radeon_device *rdev);
> +u32 evergreen_gpu_check_soft_reset(struct radeon_device *rdev);
>
>  #endif                         /* __RADEON_EVERGREEN_H__ */
> diff --git a/drivers/gpu/drm/radeon/evergreen_dma.c b/drivers/gpu/drm/rad=
eon/evergreen_dma.c
> index 767857d4a8c5c..52c79da1ecf57 100644
> --- a/drivers/gpu/drm/radeon/evergreen_dma.c
> +++ b/drivers/gpu/drm/radeon/evergreen_dma.c
> @@ -24,10 +24,9 @@
>
>  #include "radeon.h"
>  #include "radeon_asic.h"
> +#include "evergreen.h"
>  #include "evergreend.h"
>
> -u32 evergreen_gpu_check_soft_reset(struct radeon_device *rdev);
> -
>  /**
>   * evergreen_dma_fence_ring_emit - emit a fence on the DMA ring
>   *
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
