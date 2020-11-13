Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 794192B220F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 18:21:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbgKMRVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 12:21:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbgKMRVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 12:21:19 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E46C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 09:21:33 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id c17so10705863wrc.11
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 09:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SaGao1tKm3mRqKHn9uYPiR9Lgxh4rF18jpQ1IyMagMs=;
        b=pokhlglWjLCpsi+Qubq1+o3SojdpIF6vqNo8tiP+jWOODLOX0GJ435yGXTAom/WNom
         5D3R6VcCPJHXod+IzT+VR1LIvO7UmHFJ+S4Qwvgg1km0Jl4xov5Y0Q55JJYYEIsz+Ut6
         0/HqoqaOpqyU3Y5cSUz3lJ/k+zC+yJ8SpKtJWzsrQB88Fx28x+i5p36nnD9zfJnus5Ze
         9Q5wthfUAztVFarfbeuspBMRxZNwPOVMCsXP6ZBRJD2fnbpu+sR2nVC99w76Ia6IRrye
         H/FdJCQ1yy2B3zwgRAaN1uASo8EFXPqQmoB39PYBvLt5H6UVYM/Fmf+EIPktCtt6Zn2w
         q/Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SaGao1tKm3mRqKHn9uYPiR9Lgxh4rF18jpQ1IyMagMs=;
        b=HVA+eBqoqqTuS6Yaq9PIOYP8Sxzh8TvvHd++xTwOm9Lt6KANDIIHbb9DF8254dgQdq
         V0Kp3dh6VKRVg3wEC1sT83RMb8qxwI0m/gy+GIrJIewZZFbIObGcM4iHbpu1SYtf1QkC
         tvWcit6Op873WL7KDesoBjEr6hPWIlR8sRBSGNE1Sv8N7MulgHQUplLrakody4n7vXdN
         LFQq+pe0gyqflww8cpDQ5LFjfeXT0mZ1ExLJRqiBABA9hV87M9KMwSPzX/AzW4HWW8vp
         K2y0A+c/vMwMYvfjambKfu4iLnL/lgQ7i6sbpaGOp4N7mU1x1BLNGlaDHf6Iij1QrDMH
         ky5g==
X-Gm-Message-State: AOAM532OJULopgNtYtkfR6SKpQ/lx2Z9uSPDPZNKvrj1Bneg7v3p/uDr
        0NO23BqGmOuqfgFcNevgF3/syMc6qhREh7xo2Hk=
X-Google-Smtp-Source: ABdhPJynB1E+xEniE0aIBmPKpJFPsVffvQtiSgMPbRJBSdgVZRIxmJd2duaz/aUMjwdEw1vd5Xq04oVsaVucUwy1cTM=
X-Received: by 2002:adf:e9c9:: with SMTP id l9mr5024750wrn.124.1605288088922;
 Fri, 13 Nov 2020 09:21:28 -0800 (PST)
MIME-Version: 1.0
References: <20201113134938.4004947-1-lee.jones@linaro.org> <20201113134938.4004947-22-lee.jones@linaro.org>
In-Reply-To: <20201113134938.4004947-22-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 13 Nov 2020 12:21:17 -0500
Message-ID: <CADnq5_MU1jW68oamtqo+Vg3ASXdM9_WZ9HqJLSiwH+WYySUvLg@mail.gmail.com>
Subject: Re: [PATCH 21/40] drm/amd/amdgpu/amdgpu_virt: Make local function
 'amdgpu_virt_update_vf2pf_work_item()' static
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

On Fri, Nov 13, 2020 at 8:50 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c:560:6: warning: no previous pro=
totype for =E2=80=98amdgpu_virt_update_vf2pf_work_item=E2=80=99 [-Wmissing-=
prototypes]
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
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_virt.c
> index 8aff6ef50f918..905b85391e64a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -557,7 +557,7 @@ static int amdgpu_virt_write_vf2pf_data(struct amdgpu=
_device *adev)
>         return 0;
>  }
>
> -void amdgpu_virt_update_vf2pf_work_item(struct work_struct *work)
> +static void amdgpu_virt_update_vf2pf_work_item(struct work_struct *work)
>  {
>         struct amdgpu_device *adev =3D container_of(work, struct amdgpu_d=
evice, virt.vf2pf_work.work);
>
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
