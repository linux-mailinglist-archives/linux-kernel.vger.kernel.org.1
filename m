Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75BBB2AE26E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 23:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732232AbgKJWBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 17:01:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732112AbgKJWBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 17:01:34 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC11C0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:01:32 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id w24so4710148wmi.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qTpDe0/GgwmVIzYLbElPb7L7arHjRFtBiplih2oclJ0=;
        b=B6ZWARGY3lsVCwD5HBUd05aGlLnn/C7FD6J0fr+iMnG2GZZq+i8ZQXVFN79zr+W6Mf
         Ft4xCJu+ZSOQjtGvTPuDtk4QrKOWewMbMOL0YLnmxlsEXDml/p963wzIEs9cOho3HMVS
         x77Y0/1eSmIHUZ8xmuJJHkGh1Ql1v+zzqOIs7Azgbi5e6qNjLRlD8vvFN8zJoTXcARLa
         GeQggMx5mpA01/JvqxIBCbnSSTBopR2RpIu2aeGLYBdJGEaEl0KbWPh3+9TX53caW4yo
         Wwx44l/ENwrWS4ag34RvoW2bI144bNfFEZudwcrUawbljLIqGPatSL3nY+OxEbRbmkRK
         c2mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qTpDe0/GgwmVIzYLbElPb7L7arHjRFtBiplih2oclJ0=;
        b=NJnEGKHmdGFUqRLjVgYntyqVfhQWV0+xjcSfe9UxwyMiawHWFpbsiZglMl2o0LmFym
         1BZyEVjmnVvQ4dOMzPK70kD6c0OWdNzrvqe9NMwm0ZIHIbcyvnY55UHEKheTi5pkpp98
         vW0yxQEOJ5ik19ACA5dUJP0rmKiuIhKqzRWodAsoVCTJla7XDZm44qCxYWpOb5BUFts4
         OlbVA5yeTTSltCvTT+Qo6z866TzR+3/WDbVgUajjEoJ5Tn/Wn6Nv5kmY5AavMjVr8FOY
         na1CEvfIxCu6h8pZs+8GNQBiKBwahHTxOuGCVsjoYSqmeR/vf6Aqku3aH6vZ9mlrkEMW
         NJQg==
X-Gm-Message-State: AOAM5328nFraBsGIx01gyzGH6ulPLgXI9Oqypr1jJk5SZsOpip3RLZk8
        B85eqkbWlPvXoZS8HfEAD+16TtT6r3oOadaRznw=
X-Google-Smtp-Source: ABdhPJwKNw5JpBBAYWu5BZXxS+DNFZ94YS2hrzsr+ku6Hb5U1ENXppyhMmDWDQW2lx4JGYFinXlUPM6oE4CdsyzeYM0=
X-Received: by 2002:a1c:80cb:: with SMTP id b194mr196270wmd.73.1605045691426;
 Tue, 10 Nov 2020 14:01:31 -0800 (PST)
MIME-Version: 1.0
References: <20201106214949.2042120-1-lee.jones@linaro.org> <20201106214949.2042120-19-lee.jones@linaro.org>
In-Reply-To: <20201106214949.2042120-19-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 10 Nov 2020 17:01:19 -0500
Message-ID: <CADnq5_PKPiD5DOTCYgzDN8TJvb_PF0B+3bYC31qnaXSoCaoz5w@mail.gmail.com>
Subject: Re: [PATCH 18/19] drm/radeon/atombios_crtc: Remove description of
 non-existent function param 'encoder'
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

On Fri, Nov 6, 2020 at 4:50 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/radeon/atombios_crtc.c:1796: warning: Excess function pa=
rameter 'encoder' description in 'radeon_get_shared_nondp_ppll'
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
>  drivers/gpu/drm/radeon/atombios_crtc.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/radeon/atombios_crtc.c b/drivers/gpu/drm/rad=
eon/atombios_crtc.c
> index 91811757104c0..1979ed3d65472 100644
> --- a/drivers/gpu/drm/radeon/atombios_crtc.c
> +++ b/drivers/gpu/drm/radeon/atombios_crtc.c
> @@ -1787,7 +1787,6 @@ static int radeon_get_shared_dp_ppll(struct drm_crt=
c *crtc)
>   * radeon_get_shared_nondp_ppll - return the PPLL used by another non-DP=
 crtc
>   *
>   * @crtc: drm crtc
> - * @encoder: drm encoder
>   *
>   * Returns the PPLL (Pixel PLL) used by another non-DP crtc/encoder whic=
h can
>   * be shared (i.e., same clock).
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
