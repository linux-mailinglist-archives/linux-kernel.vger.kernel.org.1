Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADB2D2C90C3
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 23:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388536AbgK3WNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 17:13:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728305AbgK3WNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 17:13:39 -0500
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F5ADC0613D2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 14:12:59 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id h19so12950873otr.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 14:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ko/Y/d940PG7gzeTfAkhVNOkEcH+zDyjEv09WIfO+ts=;
        b=c8emkxQ4UGyIzOdTalRXEKd9zWQiFAIoHc/XMWNhZMW/pJmLgbb2c50mQ+fBBqCYrE
         xKAz6avQRxYUfXqsOPwneeJV7ng+h8rvNzW/UJXzNjsST+NLmzc1TPzDEmOgccK90o6R
         H1drjJbrYNlTpUu5xPR+hv5jA0aD1mOATn9z62pvu1UGVo36s9LR0zLAb5wELbMj74OY
         jCdoxGwCoqvUN7hl3ahokowwR1z9NsKWUSXv+JhtUXahehUlibFPoDFF7ZV0mHy0I5o0
         0MHZ2wlZ88SMoVi5KdfPrpomX3VSyYXVFlqq8IVTNQ/oCGDYhMfbw9bgwWyEfWq4F82K
         +tqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ko/Y/d940PG7gzeTfAkhVNOkEcH+zDyjEv09WIfO+ts=;
        b=AaypXotB2GBZOHRhrtH55JL18dfosDlOwBgDCDHfrvF9Pd+CJRnS2tkAzA8n4yuVJ7
         Th8nAt+nUw/YudDntO4DAi8JT2xn433y2AIBNx3JkYTTSN/8J5KMOn04CjzTtHDmUM/b
         fOfuSADptafD9xdtoTEXzf9UgQKceVn56lQfpmYaNW24fj/OntjXBhA80/GAZpcjv0Q0
         u1hMv+obqQ9lVEzPXHutGhlugsVRDn/LHxR5gP66Old0faLT+3Zp7ulFfUBuP4z3T0oS
         QBocZ65wm/oxFU+yVbn14bSeGu+NHvqZe/CPS2BCxeygrQ0aqdLxrbRSXhKy5ecPibC3
         ZEjg==
X-Gm-Message-State: AOAM530n9O89BsHdevBZq7Qon0sb03HWLwXSlM2vhsayw8JoaOpToFXt
        Ca7iaBpuzbyMwVRNfdpQpK8r0Tf7FkpKb3J9KHgX7RhU
X-Google-Smtp-Source: ABdhPJzwfwaCH6CxO0QiLpZdVxucsgVTZu/e6PxyEz7vwJkJCVTbuKu5kldkBXaL6jGb5EaGJEK8TK17U27ERsMPAVg=
X-Received: by 2002:a9d:4713:: with SMTP id a19mr19151847otf.132.1606774378866;
 Mon, 30 Nov 2020 14:12:58 -0800 (PST)
MIME-Version: 1.0
References: <20201124193824.1118741-1-lee.jones@linaro.org> <20201124193824.1118741-14-lee.jones@linaro.org>
In-Reply-To: <20201124193824.1118741-14-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 30 Nov 2020 17:12:47 -0500
Message-ID: <CADnq5_Pewh8FRTiEeHMbj8+zVFgfZP2KA9hPq1Unu1t4SjDkkQ@mail.gmail.com>
Subject: Re: [PATCH 13/40] drm/amd/amdgpu/dce_v11_0: Supply description for
 function param 'async'
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

On Tue, Nov 24, 2020 at 2:44 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/dce_v11_0.c:255: warning: Function parameter =
or member 'async' not described in 'dce_v11_0_page_flip'
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
>  drivers/gpu/drm/amd/amdgpu/dce_v11_0.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/dce_v11_0.c
> index c62c56a69fda6..1b6ff04700118 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
> @@ -246,6 +246,7 @@ static void dce_v11_0_pageflip_interrupt_fini(struct =
amdgpu_device *adev)
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
