Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7B82C2C24
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 17:00:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389877AbgKXP74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 10:59:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728249AbgKXP74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 10:59:56 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ABCAC0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 07:59:56 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id 64so9422913wra.11
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 07:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MOtYH7zmSkm/wyvjXA2uMSLKpOc4fBY8q1YbKJj9gW0=;
        b=ogvSpNCxGxIIwc+Bd8F9iaRRkhOWrd+JlcfhHNjNyPAJXK1DlhdusjdKggBPpofh6l
         +ynvtZftDwL+YuK24EjTioFRQxF0lsewJk+QqRs5xV8zptd8fs980w1Vb5Kz8Uqgshg2
         SV34dMaAhy82NU0P5OinQokTrIYWHJUFA0PxcfAFUl+pJI2zgFxYurkQ6lUm1gbpx8Wc
         ELyfteZLxmP/D7LrHQ1WPSwNIv81mNTUEOWvMNH8nWhIexb1cciBIWfORViOowp0ZjBx
         YmuaI8UJLMjng5XyURd4OhVVGdV4n5Kd8KvMEmdMZlfFozOVOmyldq4x43A3HBFHOQ6s
         jJKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MOtYH7zmSkm/wyvjXA2uMSLKpOc4fBY8q1YbKJj9gW0=;
        b=e0TzzcaQ7wCphyodtiTtzJXU3Bgdw+37HZ5w6MushKwWvVBQwjuacDmuer635iAd8r
         E2ga6cF8C+r97vAS7wz0Lb+bRPgoeTo/cvgF/LVt922nFgwPC/qIRRU7ULOYdXzgrOLV
         SawZFf0l18Pi3ylRguV0LFfyXyK8cjiKLcMJXRou5Ktkbksra+kx8Dx0e7KrJJzwkzYu
         eLovi7Syi63YFL3PGdfqmW5zfacFePFuB4oIDrXgxHbUVAXQEYcuhtMZ/6NsXDxeNYvZ
         5DOFhLOv8heUCGnq5YIuy717zw58hXaSuzIbQw2X5lE+VC/x1+mTDBA6IGHDXpr0SQj0
         AzsA==
X-Gm-Message-State: AOAM533e5nNsiMzhI/L0GWQdTnA2KNdOZS2OqwpIgFwUUleqSr8hs0w9
        4Dcy0fTnDxq2DFbR5ammDAnp+pks38M7A9X0yYA=
X-Google-Smtp-Source: ABdhPJwyF6prafk3stqFvVWr6XpQzFxZOZgLt6R8IKixuiSDtOBmePgANgSRdEfkuA8Foe9Xoa4nBPPW5wKbWZo2xGY=
X-Received: by 2002:a5d:400a:: with SMTP id n10mr5983166wrp.362.1606233594712;
 Tue, 24 Nov 2020 07:59:54 -0800 (PST)
MIME-Version: 1.0
References: <20201123111919.233376-1-lee.jones@linaro.org> <20201123111919.233376-8-lee.jones@linaro.org>
In-Reply-To: <20201123111919.233376-8-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 24 Nov 2020 10:59:43 -0500
Message-ID: <CADnq5_NwUvnMTrAO1t6KWVS=zVEodmYMr-D9_G_1gUM7x4yiiw@mail.gmail.com>
Subject: Re: [PATCH 07/40] drm/amd/amdgpu/dce_v8_0: Supply description for 'async'
To:     Lee Jones <lee.jones@linaro.org>
Cc:     David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 23, 2020 at 6:19 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/dce_v8_0.c:185: warning: Function parameter o=
r member 'async' not described in 'dce_v8_0_page_flip'
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Luben Tuikov <luben.tuikov@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied.  Thanks!

Alex


> ---
>  drivers/gpu/drm/amd/amdgpu/dce_v8_0.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/amd/=
amdgpu/dce_v8_0.c
> index 7973183fa335e..224b30214427f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
> @@ -176,6 +176,7 @@ static void dce_v8_0_pageflip_interrupt_fini(struct a=
mdgpu_device *adev)
>   * @adev: amdgpu_device pointer
>   * @crtc_id: crtc to cleanup pageflip on
>   * @crtc_base: new address of the crtc (GPU MC address)
> + * @async: asynchronous flip
>   *
>   * Triggers the actual pageflip by updating the primary
>   * surface base address.
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
