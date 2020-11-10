Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 210472AE3B4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 23:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732257AbgKJWwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 17:52:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730254AbgKJWwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 17:52:50 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C810C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:52:50 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id c9so4895994wml.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BTUC8FGVFqMBk4snTGanieGNzV4iLNTVLOe0fp5iFJw=;
        b=nZZ1N8XhJjaYvDaWcKRrmJOA182Qv5EYevTAHwGaTVKT3oZungrBofi5oWopQUQiDY
         gH+Wx0ePJdMx+iXnjJAJMvqIYxZ6/sPgQASoeKy9U95dp6Ikk5DiyLN63Pz95pWJpjd2
         4eNvQWGNyvmFftw3a1qxnOTwrpuPWJfzlF9GzwglKDdvPg+B27/P/jm+wzXHHM4tyuRf
         1937y9nx4THLF3zXB+TwDVfNmPhfAbQUpUmb5E33gKZW6JgC9DeguacX36PW+49sYqdH
         6Xx+BssWUhachCYdtiQlMMb+VLrwpyeDZz4VcRH7NkZ+/z03P28H7idE58FF4ZPEG3VP
         bu1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BTUC8FGVFqMBk4snTGanieGNzV4iLNTVLOe0fp5iFJw=;
        b=jGdKtf7EzhB31rNUqAu7PAF88Wqq5y8cgiYptSmQ19BRkdZLLaosEK5M0VnC0Zr3S3
         M+B5ytACXKZ75xRu5/SS1n/n6hd0XeADXdRPKaOqltWzM5lOVeHPrHSLzxwqWOsjZQ+u
         lwtI0M5o0XCzQFNm+ULmx4wKBumzozByrqbBBMG6x6j/EE3pScTiX5rAVbCVh+RdlOvX
         QfSiAjXdw7TnJ1wX/1SEIM/lt7vsFTiM/8Jt2/7AIy5BkmO07HpQrQ1lb3z8S4OMjyta
         BzV7wlk9PS+ZnkmGahnJXqB2LmUQ11iLFtIABW0fqRoAeLxIfuUHjdau1gDrnyV4+cSB
         d//w==
X-Gm-Message-State: AOAM532x5ajBPJ7rZrlSz+PVA12X9KkHH/lOo3RpS6LAX4x/+KFtfAol
        hC5k8Fcky2UY9tksCB0bOP5rRvOAvxT/L3aMtFk=
X-Google-Smtp-Source: ABdhPJxYIo1s9wv4msja3saUKvR3ou3NcBd36aXO0rfsTLFYntEjLMAkd2UWAOlzziavsGn3nfAcxctDilUGRad18RM=
X-Received: by 2002:a1c:1c3:: with SMTP id 186mr377724wmb.39.1605048768842;
 Tue, 10 Nov 2020 14:52:48 -0800 (PST)
MIME-Version: 1.0
References: <20201110193112.988999-1-lee.jones@linaro.org> <20201110193112.988999-2-lee.jones@linaro.org>
In-Reply-To: <20201110193112.988999-2-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 10 Nov 2020 17:52:37 -0500
Message-ID: <CADnq5_MMDnk7fvoOv8poVvCx1EVGQ0XvujHG=fBwR5XgSO+qww@mail.gmail.com>
Subject: Re: [PATCH 01/30] drm/radeon/evergreen: Add comment for
 'evergreen_page_flip()'s 'async' param
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
>  drivers/gpu/drm/radeon/evergreen.c: In function =E2=80=98evergreen_gpu_i=
nit=E2=80=99:
>  drivers/gpu/drm/radeon/evergreen.c:1419: warning: Function parameter or =
member 'async' not described in 'evergreen_page_flip'
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied with minor fixups.  Thanks!

Alex

> ---
>  drivers/gpu/drm/radeon/evergreen.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/radeon/evergreen.c b/drivers/gpu/drm/radeon/=
evergreen.c
> index 4eb3f9bc8fa8b..c9a9a87959f9e 100644
> --- a/drivers/gpu/drm/radeon/evergreen.c
> +++ b/drivers/gpu/drm/radeon/evergreen.c
> @@ -1412,6 +1412,7 @@ void dce4_wait_for_vblank(struct radeon_device *rde=
v, int crtc)
>   * @rdev: radeon_device pointer
>   * @crtc_id: crtc to cleanup pageflip on
>   * @crtc_base: new address of the crtc (GPU MC address)
> + * @async: Set retrace
>   *
>   * Triggers the actual pageflip by updating the primary
>   * surface base address (evergreen+).
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
