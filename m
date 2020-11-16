Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 672992B5251
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 21:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732680AbgKPUSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 15:18:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727305AbgKPUSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 15:18:09 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A6FFC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:18:09 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id d142so539292wmd.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KZqmqxGqPK6VqNKe9Ti7XDUAlbTj58Qlz19pJExVnTg=;
        b=WRhGpWlqfJmtZNu+7ZH0F+HTmN8/hlYuP0qNGssvoKwOO0BGmSRkgQeqgqoNs1Rrh7
         VKldvTx5KTH8KQcAWaG6i/KddlYj/hLqbUOwntTP4tQD5I5VonYa/lPgILs0eitBSbkY
         WGkMdRFZtEafSgNBBa4ODW3XVr+J5hcIE1N08nuV0F3qqUt4ikeLPcgZMZuAGlRnCgjQ
         89sTP+moowpUOJTis6WPeb/Gza6WymJ14/EjKs9/kdm661g3jf50tBQ0c/aqONUJSzNb
         dGB0KE0Ui0WFOau6u9sL+e5OYz7nQI9PmblG3GNzcx7RplaTzDegH0urGRs2+N50ZCoC
         7T8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KZqmqxGqPK6VqNKe9Ti7XDUAlbTj58Qlz19pJExVnTg=;
        b=PxBW1/Vj9FyHqx2OWGY3i4udgtovtas7V89K7AAM151Cj7/WhPp812HHpozkYnNAXx
         ii0gWOuFJdyTLGtpkfx+yqEQ5+MT97/le8rxL+pzS6FCdrXU2Zi6Dz440qD0xlzWNpMx
         a/98QKTp8WNd7WNA6CK5fi5QvswH+fxqTLPGOaqcydBW6c8edZNJuQSWpKehbXrRERkM
         ajLFpLFklffOvBulPRn8h7r4QJU6jMCsyfLCtCZHtQk9W45LPVL+uw4cFWYG4mMdLjuy
         a0IVZl0AFisSzSDIGqQYYpsYuRFPwylBj9aQ7G6STjey1pVsK2bCtEGNGyFPDPSreTbA
         Cl/A==
X-Gm-Message-State: AOAM533Bfzi2MH7Cok4CynpsQtiiiUFqCqRD9G2Gi8rtRkXsQtd+am+o
        ZvK39QRdGtCyhu+RoYUH0yeUqypl3KazbLfnxWI=
X-Google-Smtp-Source: ABdhPJx4roMbFetpimCkZH90Ul1OHwO/R2XgPJbf1k+dtb8PTmQA6kOW6k5lSJ5rYaS7N5zpUEM+MjKICosYXe3rsVc=
X-Received: by 2002:a1c:1c3:: with SMTP id 186mr613978wmb.39.1605557888058;
 Mon, 16 Nov 2020 12:18:08 -0800 (PST)
MIME-Version: 1.0
References: <20201116173700.1830487-1-lee.jones@linaro.org> <20201116173700.1830487-25-lee.jones@linaro.org>
In-Reply-To: <20201116173700.1830487-25-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 16 Nov 2020 15:17:56 -0500
Message-ID: <CADnq5_M2P-nnRON_r2=JTvmxCwj+mcO2zMOtcLUOwYLXpSB-VA@mail.gmail.com>
Subject: Re: [PATCH 24/43] drm/radeon/r600: Move 'evergreen_rlc_resume()'s
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
>  drivers/gpu/drm/radeon/evergreen.c:4380:5: warning: no previous prototyp=
e for =E2=80=98evergreen_rlc_resume=E2=80=99 [-Wmissing-prototypes]
>  4380 | int evergreen_rlc_resume(struct radeon_device *rdev)
>  | ^~~~~~~~~~~~~~~~~~~~
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
>  drivers/gpu/drm/radeon/evergreen.h | 1 +
>  drivers/gpu/drm/radeon/r600.c      | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/radeon/evergreen.h b/drivers/gpu/drm/radeon/=
evergreen.h
> index eb46ac7776951..f8d772e612a48 100644
> --- a/drivers/gpu/drm/radeon/evergreen.h
> +++ b/drivers/gpu/drm/radeon/evergreen.h
> @@ -48,5 +48,6 @@ void evergreen_gpu_pci_config_reset(struct radeon_devic=
e *rdev);
>  u32 evergreen_get_number_of_dram_channels(struct radeon_device *rdev);
>  void evergreen_print_gpu_status_regs(struct radeon_device *rdev);
>  u32 evergreen_gpu_check_soft_reset(struct radeon_device *rdev);
> +int evergreen_rlc_resume(struct radeon_device *rdev);
>
>  #endif                         /* __RADEON_EVERGREEN_H__ */
> diff --git a/drivers/gpu/drm/radeon/r600.c b/drivers/gpu/drm/radeon/r600.=
c
> index 94e8815e5067d..b44e0c607b1b1 100644
> --- a/drivers/gpu/drm/radeon/r600.c
> +++ b/drivers/gpu/drm/radeon/r600.c
> @@ -39,6 +39,7 @@
>
>  #include "atom.h"
>  #include "avivod.h"
> +#include "evergreen.h"
>  #include "r600.h"
>  #include "r600d.h"
>  #include "rv770.h"
> @@ -113,7 +114,6 @@ static void r600_gpu_init(struct radeon_device *rdev)=
;
>  void r600_fini(struct radeon_device *rdev);
>  void r600_irq_disable(struct radeon_device *rdev);
>  static void r600_pcie_gen2_enable(struct radeon_device *rdev);
> -extern int evergreen_rlc_resume(struct radeon_device *rdev);
>
>  /*
>   * Indirect registers accessor
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
