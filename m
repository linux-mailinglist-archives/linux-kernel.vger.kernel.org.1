Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6100E2AE41B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 00:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732240AbgKJXcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 18:32:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730254AbgKJXcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 18:32:47 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE58C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 15:32:45 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id s8so296089wrw.10
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 15:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=G2LNzsbApo8M0xKgAstakRoXzap3k+FbU2qW0LU5sPI=;
        b=tQxnrN0q6Q/syhhHoDsN9FyMEvILP+4QqoyWhcoxi/jMtiFuoIFplJNIlXU6BXd6YV
         CzXI2zJSVF7XI141i8F1UWr3DaraAD/WVGvwJx5pRhdSXLn2he6kJS0k0HiJnzpwlt3+
         Ag6CdaVrcF9GYB6qjHD5gNZIAdoO5rxnnTdF1GuF7t91672+G//dv50KhlpGDhs/1r1g
         /ns5+uwLmFHakfUhZSzCXo+9Ht3crBXAz9pMjVzadeqd9LXgZwV6/t59Jk2tw1t01kVh
         H8lyFo/MS7d5kqNyzBzG6y3wnSpAQmoltKkwuxbZpCOTkXB8Y8kT2fItwOapVDdeN48V
         aEEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=G2LNzsbApo8M0xKgAstakRoXzap3k+FbU2qW0LU5sPI=;
        b=DwBUjTJb5Gi57aei6AhmA8UKU+rQdAAqCm8eUNKrGIFfiMVePprXGUz+YCqOZn/GU8
         hA95Av07z8YNHCfDPP7aZGoo6AZ3wGKuDLMjlplDx//VvD5yDg/Fu5G+rh8dcC0AOrDa
         1c+FVyjnjIXBZ3dY1E6hbvo8qoE7Ltl25zrqL7PRebaDjHuAkHun7FzfTcr30Llx/RFX
         TrHBcDcYGcbnaH3uFmgyrkhnd0r38k70/ObOtDTuHnmZmYCjBduaMzsxzOnnn6dwKh7r
         vkocYNKwhCW3fnTaWDhSHQHuhYOFN9GFtDkKclZJa7+fWFypijOVTJp9sRUhklxGBuh7
         Rl4g==
X-Gm-Message-State: AOAM531BWkc/NP0U3oTBd4+5eMsecaE94ONLPROypqduEM10iC3LZHnJ
        Fz0RtGiKurnduf8QeS9r0Y3YCJNq7+UBmJJ37t6mD0yf
X-Google-Smtp-Source: ABdhPJwBhuwfCBjZ2GW4NzKxgbF5f5GHB8cCuow49g3N137G7vUt28YS1cjus/0GCFCS8Hne/xKkCUuWC6JHawJQv/E=
X-Received: by 2002:adf:f246:: with SMTP id b6mr26147827wrp.111.1605051164306;
 Tue, 10 Nov 2020 15:32:44 -0800 (PST)
MIME-Version: 1.0
References: <20201110193112.988999-1-lee.jones@linaro.org> <20201110193112.988999-4-lee.jones@linaro.org>
In-Reply-To: <20201110193112.988999-4-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 10 Nov 2020 18:32:31 -0500
Message-ID: <CADnq5_N18U4GdWbJALbJwKTXcmvqE8_hE2FpzYNT7O2zigCVbw@mail.gmail.com>
Subject: Re: [PATCH 03/30] drm/radeon/ni: Demote vague attempt at function
 header doc
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

On Tue, Nov 10, 2020 at 2:31 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/radeon/ni.c: In function =E2=80=98cayman_gpu_init=E2=80=
=99:
>  drivers/gpu/drm/radeon/ni.c:2679: warning: Function parameter or member =
'ring' not described in 'cayman_vm_flush'
>  drivers/gpu/drm/radeon/ni.c:2679: warning: Function parameter or member =
'vm_id' not described in 'cayman_vm_flush'
>  drivers/gpu/drm/radeon/ni.c:2679: warning: Function parameter or member =
'pd_addr' not described in 'cayman_vm_flush'
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
>  drivers/gpu/drm/radeon/ni.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/ni.c b/drivers/gpu/drm/radeon/ni.c
> index 53a4d5c109794..12dd082069649 100644
> --- a/drivers/gpu/drm/radeon/ni.c
> +++ b/drivers/gpu/drm/radeon/ni.c
> @@ -2668,11 +2668,9 @@ void cayman_vm_decode_fault(struct radeon_device *=
rdev,
>                block, mc_id);
>  }
>
> -/**
> +/*
>   * cayman_vm_flush - vm flush using the CP
>   *
> - * @rdev: radeon_device pointer
> - *
>   * Update the page table base and flush the VM TLB
>   * using the CP (cayman-si).
>   */
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
