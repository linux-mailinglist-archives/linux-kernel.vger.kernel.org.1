Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC03D2590B8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Sep 2020 16:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbgIAOhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Sep 2020 10:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728272AbgIAOTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 10:19:33 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17AE4C061249
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 07:19:33 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id w2so1343268wmi.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 07:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d0qADbe6lms6ja4jpLh/7o17Sin0XkGvPQGFqKKb+qg=;
        b=as6ZhId9BGoiIsUyZNdl9MSpaccNfWAqHVVOh4EZLW3JAc7umkdnIUkQYJW9Y/O7O6
         V/3ukFkjQ1fQ1J4BmR9M3TZVjFuHNa7tAvFQy/qtRvWhU5kqhcjh5wGmooW0riApIaAC
         qdU8ki+7vWhPKZn2Q/o+8neu2WcjW+svESa4ASqDpoR4edxM8444vT0U3pWovFpXRhDR
         XDZ062GHZLCaaxuJWsVUogdrjcyQqVDllx7IoAzq2iXEbz5xDISPSFoZpAddlGpJfHwT
         1g22zEyYs0IK+9XPqgqhxPXLzNySLPlLzaOI12aM2dwwTU98/CpSdK8jqxCgW/JFIYXW
         xrSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d0qADbe6lms6ja4jpLh/7o17Sin0XkGvPQGFqKKb+qg=;
        b=UUV+ttT45KhbOjAzOtBlsHxuwjau6oBe31mMbWkKTBsE9I4WJlRbex/eBDnMiLnazj
         4JRwno5UdLDblm3Djm5Pk1DJCQCuapJRggvqfCUADDLAS+sY8OnxAJDkGjssgr+rrav5
         sm4DWF671t8TGoEEFq0ML2tLy6Hw+0oR7etXjowR6Fa//s4FotFzV/KJxTUdtFN3RrlB
         hPGpA8887kaYokajttOMrbR6j9TuTCbrap6rqUE0rbwIaeaZs6kbUwZ05nxtSiwYjhTC
         iR4ZPRGonB/6I2FlQfQeeoC8bKN5yLgr+xjK2M4xXd2PmmuAA9aP4KII9R+rioguthIj
         QkTQ==
X-Gm-Message-State: AOAM530Ug/lbhPeqRdM7puFapZYk004mVG3T5TldxkKkYOXyn4RCw0CH
        XTTXlIRAbba3JFAjfwj6QqSq3JEVv/UQVb1Euhw=
X-Google-Smtp-Source: ABdhPJx3A8LQc1AKi5DhvdsaNfy/S9210zyQvGHZaEZytNnb0nVwDTHCrkHOYp694kkRcwuI/Tuh7/aRO9coNr/vsSw=
X-Received: by 2002:a7b:cb17:: with SMTP id u23mr2075647wmj.79.1598969971757;
 Tue, 01 Sep 2020 07:19:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200901063227.6057-1-kai.heng.feng@canonical.com>
In-Reply-To: <20200901063227.6057-1-kai.heng.feng@canonical.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 1 Sep 2020 10:19:20 -0400
Message-ID: <CADnq5_MXs-=BpMrYVudhHPjTpgs1XUE=GEujpp5AeYy5vWS=YA@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: Reset ASIC if suspend is not managed by
 platform firmware
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:RADEON and AMDGPU DRM DRIVERS" 
        <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 1, 2020 at 3:32 AM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> Suspend with s2idle or by the following steps cause screen frozen:
>  # echo devices > /sys/power/pm_test
>  # echo freeze > /sys/power/mem
>
> [  289.625461] [drm:uvd_v1_0_ib_test [radeon]] *ERROR* radeon: fence wait timed out.
> [  289.625494] [drm:radeon_ib_ring_tests [radeon]] *ERROR* radeon: failed testing IB on ring 5 (-110).
>
> The issue doesn't happen on traditional S3, probably because firmware or
> hardware provides extra power management.
>
> Inspired by Daniel Drake's patch [1] on amdgpu, using a similar approach
> can fix the issue.

It doesn't actually fix the issue.  The device is never powered down
so you are using more power than you would if you did not suspend in
the first place.  The reset just works around the fact that the device
is never powered down.

Alex

>
> [1] https://patchwork.freedesktop.org/patch/335839/
>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/gpu/drm/radeon/radeon_device.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_device.c b/drivers/gpu/drm/radeon/radeon_device.c
> index 266e3cbbd09b..df823b9ad79f 100644
> --- a/drivers/gpu/drm/radeon/radeon_device.c
> +++ b/drivers/gpu/drm/radeon/radeon_device.c
> @@ -33,6 +33,7 @@
>  #include <linux/slab.h>
>  #include <linux/vga_switcheroo.h>
>  #include <linux/vgaarb.h>
> +#include <linux/suspend.h>
>
>  #include <drm/drm_cache.h>
>  #include <drm/drm_crtc_helper.h>
> @@ -1643,6 +1644,8 @@ int radeon_suspend_kms(struct drm_device *dev, bool suspend,
>                 rdev->asic->asic_reset(rdev, true);
>                 pci_restore_state(dev->pdev);
>         } else if (suspend) {
> +               if (pm_suspend_no_platform())
> +                       rdev->asic->asic_reset(rdev, true);
>                 /* Shut down the device */
>                 pci_disable_device(dev->pdev);
>                 pci_set_power_state(dev->pdev, PCI_D3hot);
> --
> 2.17.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
