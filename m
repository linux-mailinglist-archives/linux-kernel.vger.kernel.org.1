Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 421012C90C2
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 23:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730530AbgK3WNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 17:13:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728305AbgK3WNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 17:13:02 -0500
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA1CC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 14:12:16 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id n12so12928568otk.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 14:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=b6cW600D3AdtI4dxch+V0CvHl/L1hc8DgKLicXldcyE=;
        b=uP8r4KF/iPSPgSAL2eeX+38BNuoBBZ7WxsB3MyXavd6tHtbge0x157ZkkUsbp1+SGc
         uIWN9U6XADxT1kQ3y13NLuuzCiEnWUALOa5R6dKheQkeu0UnfC7AqDEzAVwh1AoBwNLR
         +XTk0rIP9YbrYEaMXrlawdoSsqM/JDAszbHhfoh6iwp74Usp4LD56eORUU56r3iyKcFn
         FJhGw1HdLxZ5QDJtMHdYdTUlQrGAbZWZ5x2vIZ9YrC0WAA96YnCLll1Kosz9lYnpz0mj
         GIl0XOph05Kk1fJQtcX2albqz6VUrV2iVD5E0tj6bdaradDh4AND/X7vpDX2/1jtw0ax
         PWZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=b6cW600D3AdtI4dxch+V0CvHl/L1hc8DgKLicXldcyE=;
        b=AMpDjTgBywiJv88ZAHVBbKhWMuCN209RjDzj9Msk7by12VfUCJxU3pCLpqZu6Fn+ya
         jzfoUwRBNBoWh6tdzRhhzo6FmFldPpLnaBch16J/qRRQV+c+dP8SlmoPpwy0cNIXQbN7
         T205IVK2+E8kmA0VL5/JKRxJNa7yhj/QMMNKOxCZE8Mwi/tF4P5OmEvnbo2Ncz/XEqE2
         tpngWCMOJGnqGO7lRReyppObQPpbOHwKYRjPTvUEpxsQ61+Bh/zGHxxR8P+UABNZnfLR
         Yubwk1+uuDi1STt02Axyart3169XAo7GUyDt56j9e3S/TL1A+HYJbYd5R+odKFHrVvfZ
         mLOg==
X-Gm-Message-State: AOAM532RI6nJT06lpcdIlGk+4wVarJ9lCXPnB7gOQKhdvmvhtxSzjK0C
        a7OYA/gDssYzNb1aThwFMyAoMAOUD1DabPPYWqQ=
X-Google-Smtp-Source: ABdhPJx/35GQhdOnFw7VTCZ+lBVMh3ZBoBITfoOtzcBZzHFCjSoRcnFLao8KkNUGe+ziH7tpEa3K8I38SabcSVIZKuo=
X-Received: by 2002:a9d:4713:: with SMTP id a19mr19149396otf.132.1606774335496;
 Mon, 30 Nov 2020 14:12:15 -0800 (PST)
MIME-Version: 1.0
References: <20201124193824.1118741-1-lee.jones@linaro.org> <20201124193824.1118741-13-lee.jones@linaro.org>
In-Reply-To: <20201124193824.1118741-13-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 30 Nov 2020 17:12:03 -0500
Message-ID: <CADnq5_OigHeSZuZv=EuPdJ8nfx3e1qY0gBYx7oO=kupo7Rqu8Q@mail.gmail.com>
Subject: Re: [PATCH 12/40] drm/amd/amdgpu/dce_v10_0: Supply description for
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

On Tue, Nov 24, 2020 at 2:45 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/dce_v10_0.c:237: warning: Function parameter =
or member 'async' not described in 'dce_v10_0_page_flip'
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
>  drivers/gpu/drm/amd/amdgpu/dce_v10_0.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c b/drivers/gpu/drm/amd=
/amdgpu/dce_v10_0.c
> index da240f8fafcf8..7944781e1086b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
> @@ -228,6 +228,7 @@ static void dce_v10_0_pageflip_interrupt_fini(struct =
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
