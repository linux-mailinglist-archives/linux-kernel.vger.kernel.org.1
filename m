Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6D82AE16A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 22:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731718AbgKJVOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 16:14:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbgKJVOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 16:14:52 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A71C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 13:14:51 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id c16so4592746wmd.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 13:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pxsubSKIzvYm5GX7ose/r3DE5/fWORy3pWS1sa1asC8=;
        b=J3d3ZNCfN7YF6oUQxAhPbQLbYF5ssw9fUrPsw1Erny85gCHm5ArDSOhL8e6GrzkF2V
         9JeD4AQJWYCoRQfs2V0FFymScYHBw5H8r3Zwld1znfWyDbdjBkJ1JYvaE/IAWtjpmqxD
         3kLPY/UcL0idZzX1FwDcHdkC51aE8IFPiVuf/2tJHadsYhY+lyNDXUFIvrIi6nXXksHY
         bQfC5VlGLRnrJdSFlWP7BklZeiN/yF34YfdTy/Ce/MiqXSmNfNUfrj70okVFqetyYhAZ
         y60GsdcKDpfcBi2vOBro24XjrNSyje7VF0xYxIZW++18Pp3lqsmkA1CJiayKcQwbUYvh
         Wo4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pxsubSKIzvYm5GX7ose/r3DE5/fWORy3pWS1sa1asC8=;
        b=qjQCY/DxFYqiLgabILKyJTGOU927tuxTwOCGStBKPj6xhnYTk9buDNYIRFZjHNAct4
         11L1eenEgTQFeYalGl7KWgZnILmq5RzD64nyHKN8WDpCuULWY6r1ENNR40kj0RSSgG5B
         v2khCIxdr0spgc6NneJm5Q8Cy5JJ+64qn8x1jMNGk4JpQpnIXg/b8fPKWvtmorNicZ0S
         oTvrpUnk7WycfKeKLHxw6d7xzyCu3i7hKSwnt3jc4mWBcKJHKsHBvR2F98Al4Eu75/Mw
         xFG63Yrj5dHjoQirOhtPkNbXNYJJP1E8YPxw1LNlZdMAMoxaJup9568GoR8Ody8bQjPQ
         l/tg==
X-Gm-Message-State: AOAM531ztqAOZTR4LM0daQw47Ert9HeKxazZ0kUuNM+XrLTrd/lzqYe2
        efWv68xuV+ENJYV/ctuHVhLzUoVmaoBiQ10JXVk=
X-Google-Smtp-Source: ABdhPJwZx/rH071+rhpAeh4rIejVLAxwyHRrjLJsRtxyfqR7h/IbMSnb9CF4BixMsn8ypO3Rs314hHkuf5bB7aQf9Eo=
X-Received: by 2002:a1c:46c6:: with SMTP id t189mr28956wma.79.1605042890238;
 Tue, 10 Nov 2020 13:14:50 -0800 (PST)
MIME-Version: 1.0
References: <20201105144517.1826692-1-lee.jones@linaro.org> <20201105144517.1826692-16-lee.jones@linaro.org>
In-Reply-To: <20201105144517.1826692-16-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 10 Nov 2020 16:14:38 -0500
Message-ID: <CADnq5_PZRM0wmrcJAGfdyFqnR68gbVQK76TrHSbJJRK1t8cT8g@mail.gmail.com>
Subject: Re: [PATCH 15/19] gpu: drm: radeon: radeon_drv: Remove unused
 variable 'ret'
To:     Lee Jones <lee.jones@linaro.org>
Cc:     David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Gareth Hughes <gareth@valinux.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 5, 2020 at 9:52 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/radeon/radeon_drv.c: In function =E2=80=98radeon_pmops_r=
untime_suspend=E2=80=99:
>  drivers/gpu/drm/radeon/radeon_drv.c:455:6: warning: variable =E2=80=98re=
t=E2=80=99 set but not used [-Wunused-but-set-variable]
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Gareth Hughes <gareth@valinux.com>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/radeon/radeon_drv.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon=
/radeon_drv.c
> index 65061c949aeea..f5f1cb700d873 100644
> --- a/drivers/gpu/drm/radeon/radeon_drv.c
> +++ b/drivers/gpu/drm/radeon/radeon_drv.c
> @@ -452,7 +452,6 @@ static int radeon_pmops_runtime_suspend(struct device=
 *dev)
>  {
>         struct pci_dev *pdev =3D to_pci_dev(dev);
>         struct drm_device *drm_dev =3D pci_get_drvdata(pdev);
> -       int ret;
>
>         if (!radeon_is_px(drm_dev)) {
>                 pm_runtime_forbid(dev);
> @@ -462,7 +461,7 @@ static int radeon_pmops_runtime_suspend(struct device=
 *dev)
>         drm_dev->switch_power_state =3D DRM_SWITCH_POWER_CHANGING;
>         drm_kms_helper_poll_disable(drm_dev);
>
> -       ret =3D radeon_suspend_kms(drm_dev, false, false, false);
> +       radeon_suspend_kms(drm_dev, false, false, false);
>         pci_save_state(pdev);
>         pci_disable_device(pdev);
>         pci_ignore_hotplug(pdev);
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
