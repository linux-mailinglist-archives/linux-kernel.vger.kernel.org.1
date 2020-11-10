Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65CA72AE246
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 22:58:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731587AbgKJV6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 16:58:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbgKJV6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 16:58:36 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B27C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 13:58:36 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id c17so14360801wrc.11
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 13:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7PYKfcZgEbSn6FtgZH86ueoYk1FKRtzcitJv9QurNbU=;
        b=W05ZH9i7vYFC31OC7WJRYdfHRuE+Yz42XdxO/WY/O2SxZFD2q+cDt1PZZeBtYrSUi+
         UaBWZJdoxSrGVrXisDIygPG9gcsw12yg14d6vaSbqkVCTtevEozHzXw1RLTOhz6Ix3OR
         rA5vcp5pgw8YPSypwisP7rcpmTksmx7/5oXcS8eSBmebtaKrOARpkVv/64iFladQSEih
         ogi9lJ/CNWppmnHvpYLDJjwUgapdxKAZneii3pPxptW46yUU9ZyrgY8ZCqsNSozcjGyZ
         ifdvcUNNE3MumaMlPSEE9oxtCDR+Y5nVvP+T7j4VGP5V/lX0VChFbZnUH0lT197qPeuL
         yLvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7PYKfcZgEbSn6FtgZH86ueoYk1FKRtzcitJv9QurNbU=;
        b=QHmIiXH5NPIeS71+2Dp1Q/wpCAthYGsNfv3mcPskyaoxaCvfh3mWE+gTQIBwQX/QYs
         WZCvRDhns68DUUIXG8G2IseFuHDliDcC/II8gxlGrKgleppiVC5+UtoErH5OM6mSDNmu
         kQtu+dgdaU7cnXP8H8n2vQMZnGrAj3vKU4zevK9GY1oOQMsQ0SQZofSDq2b0vE4DXDfY
         cDViSDXKlwDI8UF/s46rqsSzM6k63rVyIrGmr/jRXMfXf21NW9NTL12Gbhs48NVVBmOC
         ASTgYNIlg3o/m/ci2OOrSpm9PBnB2mNHG+RCgAmXw20lhORt2ig5hrDSMMF65ov58WpU
         ff6g==
X-Gm-Message-State: AOAM531NJi3KtDrYlKWWKxxLUlIZf+Ar3xMsS27Ath4lmbeRel52Nzl5
        foTEWEhDjBY8qNioqcN1FAzCabyAl0EV7xt8TeQ=
X-Google-Smtp-Source: ABdhPJyoUDdn74KYisXTYC5nt7/YXLArSt/XMm5JQrl4xBlBvEuYS+aw97T/HcUfmwAapu3UwWQBkwDWlgpHGHS+MWI=
X-Received: by 2002:adf:f246:: with SMTP id b6mr25828792wrp.111.1605045514996;
 Tue, 10 Nov 2020 13:58:34 -0800 (PST)
MIME-Version: 1.0
References: <20201106214949.2042120-1-lee.jones@linaro.org> <20201106214949.2042120-14-lee.jones@linaro.org>
In-Reply-To: <20201106214949.2042120-14-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 10 Nov 2020 16:58:23 -0500
Message-ID: <CADnq5_MxhG6gYSWCo_xmwSu5AB1xoVtTS-hpR7d+FY=bUi0phA@mail.gmail.com>
Subject: Re: [PATCH 13/19] drm/radeon/radeon_drv: Move prototypes to a shared headerfile
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

On Fri, Nov 6, 2020 at 4:50 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  62 | void radeon_driver_unload_kms(struct drm_device *dev)
>  | ^~~~~~~~~~~~~~~~~~~~~~~~
>  drivers/gpu/drm/radeon/radeon_kms.c:105:5: warning: no previous prototyp=
e for =E2=80=98radeon_driver_load_kms=E2=80=99 [-Wmissing-prototypes]
>  105 | int radeon_driver_load_kms(struct drm_device *dev, unsigned long f=
lags)
>  | ^~~~~~~~~~~~~~~~~~~~~~
>  drivers/gpu/drm/radeon/radeon_kms.c:619:6: warning: no previous prototyp=
e for =E2=80=98radeon_driver_lastclose_kms=E2=80=99 [-Wmissing-prototypes]
>  619 | void radeon_driver_lastclose_kms(struct drm_device *dev)
>  | ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>  drivers/gpu/drm/radeon/radeon_kms.c:634:5: warning: no previous prototyp=
e for =E2=80=98radeon_driver_open_kms=E2=80=99 [-Wmissing-prototypes]
>  634 | int radeon_driver_open_kms(struct drm_device *dev, struct drm_file=
 *file_priv)
>  | ^~~~~~~~~~~~~~~~~~~~~~
>  drivers/gpu/drm/radeon/radeon_kms.c:705:6: warning: no previous prototyp=
e for =E2=80=98radeon_driver_postclose_kms=E2=80=99 [-Wmissing-prototypes]
>  705 | void radeon_driver_postclose_kms(struct drm_device *dev,
>  | ^~~~~~~~~~~~~~~~~~~~~~~~~~~
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
>  drivers/gpu/drm/radeon/radeon_drv.c | 6 ------
>  drivers/gpu/drm/radeon/radeon_drv.h | 7 +++++++
>  2 files changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon=
/radeon_drv.c
> index bb7b33e535f81..e0d664e9e2feb 100644
> --- a/drivers/gpu/drm/radeon/radeon_drv.c
> +++ b/drivers/gpu/drm/radeon/radeon_drv.c
> @@ -112,12 +112,6 @@
>  #define KMS_DRIVER_MAJOR       2
>  #define KMS_DRIVER_MINOR       50
>  #define KMS_DRIVER_PATCHLEVEL  0
> -int radeon_driver_load_kms(struct drm_device *dev, unsigned long flags);
> -void radeon_driver_unload_kms(struct drm_device *dev);
> -void radeon_driver_lastclose_kms(struct drm_device *dev);
> -int radeon_driver_open_kms(struct drm_device *dev, struct drm_file *file=
_priv);
> -void radeon_driver_postclose_kms(struct drm_device *dev,
> -                                struct drm_file *file_priv);
>  int radeon_suspend_kms(struct drm_device *dev, bool suspend,
>                        bool fbcon, bool freeze);
>  int radeon_resume_kms(struct drm_device *dev, bool resume, bool fbcon);
> diff --git a/drivers/gpu/drm/radeon/radeon_drv.h b/drivers/gpu/drm/radeon=
/radeon_drv.h
> index 173deb4634146..ac7970919c4d3 100644
> --- a/drivers/gpu/drm/radeon/radeon_drv.h
> +++ b/drivers/gpu/drm/radeon/radeon_drv.h
> @@ -118,4 +118,11 @@
>  long radeon_drm_ioctl(struct file *filp,
>                       unsigned int cmd, unsigned long arg);
>
> +int radeon_driver_load_kms(struct drm_device *dev, unsigned long flags);
> +void radeon_driver_unload_kms(struct drm_device *dev);
> +void radeon_driver_lastclose_kms(struct drm_device *dev);
> +int radeon_driver_open_kms(struct drm_device *dev, struct drm_file *file=
_priv);
> +void radeon_driver_postclose_kms(struct drm_device *dev,
> +                                struct drm_file *file_priv);
> +
>  #endif                         /* __RADEON_DRV_H__ */
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
