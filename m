Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E07DD2C2C69
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 17:12:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390197AbgKXQK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 11:10:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728249AbgKXQK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 11:10:58 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130ABC0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 08:10:58 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id m6so22861971wrg.7
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 08:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=libUlVl49I/i7vBirvP7mh4EFHUzeyktEhxk+XKEmZI=;
        b=XX94/Y1UCtmAsaoEgud7ffheaR5OREUQ6G+avAgY1e1dlbFOGmjiGpiw/lDwc0wOTU
         LRxo5TGuL8YoNnaEbsFTv6Lrx4kzRjpA6iPMvvcp5CZhcgFdNyJ35nPZJ8BVepMu2D6W
         7o9FaKxCdd+aQc9nDq3KPCft4zzGHqLD3UhLyye3tEJzy/Lalevqic3b9FggA7/NrL1U
         fABnVTAs944tsJdn1Q8v9LfXM/lPAzyv5YdyK+jgeDgH2vkQbQ2qcbJFckKi4pRQ3duI
         QyZH07iQ4Y9uacmIbZPcrr/yqdwW+UWAPgurdM5R6mdBLNdwotYYRS9HA/3bC7s3QO4l
         dQiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=libUlVl49I/i7vBirvP7mh4EFHUzeyktEhxk+XKEmZI=;
        b=tN+kpid68WjlWoS4WSfXDV9MUduDovOsYFXpHHVOezyOvOzUmr5GpLd6LCOGjLs2/N
         Qp6zQaF4pO2x9qBitHxYDRtt8NPbQMXvgoGgTo/scd/xHw5MLYxN3jKip0Fztm78jWhg
         uefvNaqcyyMNnzBnUeCn95Et/QRZJdkidvG8o0e5lhjUzmkYMUevhIysOgqSbBWSZKbF
         I5ghJM5ouYHW9SAiAdroUinD4Uvm+8kB0jBE+sCtbcnSXtjHQuMKR7R68XOv1G/WyH5l
         Q2vWOgL1ZY2MrjWebyVFY0u1AmQ1ClMqkJcRgb2VaD5U4pLPhwnAaCD2ZW7guDtLNny3
         NUNA==
X-Gm-Message-State: AOAM530nZeTkpo5BaSWB3zYK5+15d2cKFZ7HvxTF8q4LSDRAW9CR7NkF
        A9eciU3XJXw7/Oopr/uVT/nqphtzwOQb3wMce0T42JJN
X-Google-Smtp-Source: ABdhPJzL3wH6V4aUxvIZUY/x1zyXe3RFBUZkm6ERX/NuxGg/yrAcxGOyHtr9vRR3Vv7QuHI/WrDxWdIIxSPsVcO+IhU=
X-Received: by 2002:adf:e551:: with SMTP id z17mr6171532wrm.374.1606234256820;
 Tue, 24 Nov 2020 08:10:56 -0800 (PST)
MIME-Version: 1.0
References: <20201123111919.233376-1-lee.jones@linaro.org> <20201123111919.233376-23-lee.jones@linaro.org>
In-Reply-To: <20201123111919.233376-23-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 24 Nov 2020 11:10:45 -0500
Message-ID: <CADnq5_NiF-gb0748yid+1y1UwjO91=LO8zK5uHcTU+ojZ6T_Uw@mail.gmail.com>
Subject: Re: [PATCH 22/40] drm/amd/amdgpu/dce_v6_0: Fix formatting and missing
 parameter description issues
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

On Mon, Nov 23, 2020 at 6:20 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/dce_v6_0.c:192: warning: Function parameter o=
r member 'async' not described in 'dce_v6_0_page_flip'
>  drivers/gpu/drm/amd/amdgpu/dce_v6_0.c:1050: warning: Cannot understand  =
*
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
>  drivers/gpu/drm/amd/amdgpu/dce_v6_0.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/=
amdgpu/dce_v6_0.c
> index 9439763493464..83a88385b7620 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> @@ -180,6 +180,7 @@ static void dce_v6_0_pageflip_interrupt_fini(struct a=
mdgpu_device *adev)
>   * @adev: amdgpu_device pointer
>   * @crtc_id: crtc to cleanup pageflip on
>   * @crtc_base: new address of the crtc (GPU MC address)
> + * @async: asynchronous flip
>   *
>   * Does the actual pageflip (evergreen+).
>   * During vblank we take the crtc lock and wait for the update_pending
> @@ -1047,7 +1048,6 @@ static u32 dce_v6_0_line_buffer_adjust(struct amdgp=
u_device *adev,
>
>
>  /**
> - *
>   * dce_v6_0_bandwidth_update - program display watermarks
>   *
>   * @adev: amdgpu_device pointer
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
