Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC902B0FCB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 22:08:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbgKLVIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 16:08:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726337AbgKLVIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 16:08:36 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC838C0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 13:08:35 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id d142so6437347wmd.4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 13:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+uWZD9FIXBDt/FLwqqCp+AOrNnm42PFk2YUQ8URNfJw=;
        b=OnzSJgQWFb0jmu8Z0ztvodOnTtW+rNQsCRd/NgGB2oAxHG7ENqD5Tgi3xf3fqvgnc5
         AuCO2f487/z2cuENXMhv+LN8qbKGblyCZH1qtw37DnL9+Vfk31puwk4rHViWPCvF3cA8
         N+mbdxYQ+2kAgOlD4mZ00xwA6w+U/ygfcCovwE0bWvK+VOxsTNZBtAmwO8r1xg0nR4iK
         xKB31ttXILvIf/HtiZWy4wAxk7gRjQjG97LrdNFZQZTr+eQOpffQtYwz2u0AELaq/FW3
         bHy3cNO16zRNjGLojIF6ssNftSJeQCVPDLABR2tkic8MZLzs/H6Nn+kL8JwSAg1tN/ww
         xaIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+uWZD9FIXBDt/FLwqqCp+AOrNnm42PFk2YUQ8URNfJw=;
        b=bi51f1JLnsYCS5R9RoO+DsbaDcThydQvEGBRNlssWrcehsrP+ZcLA+yGaU1oMwgAlm
         TrrQ1ZG+IVPgRfiHZEcMNW8o2FdOuzNDSLu4IQHqpARnVvuPb6Iuixo2UlfenIRscz3J
         L6D8TeRIxZEdQxQF/zFJPQaqdju+VsnChQ1VECIUVd1EJv4TF5j0AZ0SBmpCwVrcaQ7Y
         EFTA5OU2SNMznXuV7pT0wSrWCD7XdMm/xHZOAME41tYr9wyYj7blCrqxRljctSnl2a8Y
         jFcGIgW3MXaty9o5hYSzQlhP1zCjPSDCqGHMAIwHDegoG8lXgzvjbS0nkEyNhoIoiSvn
         iSkg==
X-Gm-Message-State: AOAM533n/TPohcI+ikRWmhCaZOD6Ywuhqf4jwBuB4ZHTLnbqRHExjaYF
        v25NHA/pFua0CvKVVrR0TcTLiZx01tdGtilGdqjEIN52
X-Google-Smtp-Source: ABdhPJz/VgYcNcf8vhPSfH2uiDexOmE2ZvnT4ScZ7zzX9HFIqhjUcVls3fY+mh4NejYDadUdcouiECKJf3p5PoxxtsI=
X-Received: by 2002:a05:600c:2319:: with SMTP id 25mr1615761wmo.102.1605215314715;
 Thu, 12 Nov 2020 13:08:34 -0800 (PST)
MIME-Version: 1.0
References: <20201112190039.2785914-1-lee.jones@linaro.org> <20201112190039.2785914-7-lee.jones@linaro.org>
In-Reply-To: <20201112190039.2785914-7-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 12 Nov 2020 16:08:23 -0500
Message-ID: <CADnq5_PP5biKiPMGFDeE0-9cTyoaX12+NnbmLPFkT+UY25ifBg@mail.gmail.com>
Subject: Re: [PATCH 06/30] drm/amd/amdgpu/amdgpu_kms: Fix misnaming of
 parameter 'dev'
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

On Thu, Nov 12, 2020 at 2:01 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c:487: warning: Function parameter=
 or member 'dev' not described in 'amdgpu_info_ioctl'
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c:487: warning: Excess function pa=
rameter 'adev' description in 'amdgpu_info_ioctl'
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
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_kms.c
> index cec9aad8bdfa9..98721ae931841 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -474,7 +474,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *ad=
ev,
>  /**
>   * amdgpu_info_ioctl - answer a device specific request.
>   *
> - * @adev: amdgpu device pointer
> + * @dev: drm device pointer
>   * @data: request object
>   * @filp: drm filp
>   *
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
