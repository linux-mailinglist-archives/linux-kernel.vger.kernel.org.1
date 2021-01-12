Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5A3F2F3F89
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:46:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731529AbhALW05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 17:26:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729804AbhALW0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 17:26:43 -0500
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78932C061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 14:26:03 -0800 (PST)
Received: by mail-oo1-xc36.google.com with SMTP id n127so16605ooa.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 14:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SNbCI8QXsw68f7cArm3g7fzx51ypEltbTSdK1JYnPSE=;
        b=rvB9yn151kICpyUsGCIqOBZDBv/QMlydvjzDatPpjwhMAi5h887EeYglO0YrS60Bug
         TADqyb9R1oD8GPT3BR3IuQZamXvr3s7P2He1HZWLlekMpfDzQR+hiVlb90yGC/SXHX6T
         X/Bn4AgH8eZqvA/nrm/X5OugRdmCQ/YWmx6c2XA1Rn1uxMyGkGKzmWA41iM+k4ddK+vq
         y4YPI5i84iT3PUz+u7k8lXJb5NTUWDqXi5tK0Ix3xWYSKO6NhkzzKJTtreASboCL/wbn
         7TOYFRfi4u6uBl/pGjvYt12jxCUQsyrHLGm95L+hBFdz8Iv3+8YnWGj0E0ml5bq/CJus
         jUug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SNbCI8QXsw68f7cArm3g7fzx51ypEltbTSdK1JYnPSE=;
        b=B4qOzTuovEnMef0RPlTIiFbQhq354iw7xeUhtmGrMAo9vTPThZKWp3ELXQ2sV438ly
         GNzorB39MRAkdZr5nf2RCmZHgO+cWZwnUfWmJsZiEN6wl0i7i5ZanmbXE6GWBVPgYDHu
         qcX/YTrPhRy2pjL/FOqoBiAhvIqWkQuPFLmRtOPBrHpgLtgRztut7QocB4oKvsqFe56h
         d3me18GqO3Cwz5myVkibG7mUqjKpeBXHrc8wUYBejNn7HrKPSCbXRcch3x6fvFCRjmHR
         mlkV3liEodmq3a4q+DVvOxvgCVcsdh7xUoguHoE2AnFGmqLGYk5+hQmm7QVk4Czb4vj4
         P6cQ==
X-Gm-Message-State: AOAM531KUTQaBHxSLPWnhG3J4mWqhErDEGnn5VA6B854O5fhgzqb4l74
        ky7SE2X3eTWuKwostJOwoY63CrPYrjGcpiAWYKE=
X-Google-Smtp-Source: ABdhPJwl82AhUlOj+8xTD00jkCRkRwEUvm+f6rSMzzMnuxSDkDI6yDrzeHf+3NyTqb+2neWNTj3xNpDc8ungkzhghtA=
X-Received: by 2002:a4a:a2c5:: with SMTP id r5mr786480ool.72.1610490362947;
 Tue, 12 Jan 2021 14:26:02 -0800 (PST)
MIME-Version: 1.0
References: <20210111191926.3688443-1-lee.jones@linaro.org> <20210111191926.3688443-25-lee.jones@linaro.org>
In-Reply-To: <20210111191926.3688443-25-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 12 Jan 2021 17:25:51 -0500
Message-ID: <CADnq5_PEmMUY8G8Yetd5t6g3KPMyNSz4vcp4rXk5+6reXjtyeg@mail.gmail.com>
Subject: Re: [PATCH 24/40] drm/amd/pm/swsmu/smu11/vangogh_ppt: Make local
 function 'vangogh_clk_dpm_is_enabled' static
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Xiaojian Du <Xiaojian.Du@amd.com>, David Airlie <airlied@linux.ie>,
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

On Mon, Jan 11, 2021 at 2:20 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/vangogh_ppt.c:613:6: warnin=
g: no previous prototype for =E2=80=98vangogh_clk_dpm_is_enabled=E2=80=99 [=
-Wmissing-prototypes]
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Xiaojian Du <Xiaojian.Du@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied the same patch from someone else earlier today.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/g=
pu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> index 75ddcadf3802a..37bd4c647418d 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> @@ -610,8 +610,8 @@ static int vangogh_get_profiling_clk_mask(struct smu_=
context *smu,
>         return 0;
>  }
>
> -bool vangogh_clk_dpm_is_enabled(struct smu_context *smu,
> -                               enum smu_clk_type clk_type)
> +static bool vangogh_clk_dpm_is_enabled(struct smu_context *smu,
> +                                      enum smu_clk_type clk_type)
>  {
>         enum smu_feature_mask feature_id =3D 0;
>
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
