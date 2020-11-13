Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 019D12B21DE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 18:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbgKMRRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 12:17:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbgKMRRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 12:17:55 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62293C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 09:18:08 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id k2so10770734wrx.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 09:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MGDV1m39Q0RpjWz9porpS9WltATtsX2nbsrGwBakBoI=;
        b=cNu+U8JzWYov9+pOuR15lmt9jJN7mU15Fct9ujeB8OBZYHXJijUkou+Rbp9bEgJkzg
         vxa9qAnS4Grf/3uzQvgJqQIbo1wvji0mABrMYjia8ZfwxiKoEiEPiKdH7c6W9LrEysK2
         h8fzkxnD/3UbZD6iqHYdBRwFk9NwubRM9VFsCPkqbg4pl7oRssQ6VIcGdRr1qvcQxrvM
         fsuUgOEWDejY9NGe7DO1reHM/rt5qlrUu0k5P7I85l/LLpEh8SbKiak4YWKRCHXie5cg
         955XfNbnmsskkY8HF1eXKAChkyaWiZsRqy5E3lNLEq/bkG+IGAW4WaGHFFDuEBxRBt6V
         ssbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MGDV1m39Q0RpjWz9porpS9WltATtsX2nbsrGwBakBoI=;
        b=Pix37qnTGwIcije7PnDksGEsv1KogW08Kv4bszIBO/r7PJUMci8isoIYrc6zY0T4Uk
         yXpMpQaaJf+vKrpu5fRv5eYJEWdFcM1/4bBHKvWhjiqnQwvfUOpY3y4jdNxcpcL67vlR
         gKB/bzFCIIzLLFTaifBEwmrjxgGVI0D+l/PLylTeSkQp6fJ2+GqTrec2UimG6Pw+0xkV
         dB6cqqoDrHG4QpPUnH/DmfKzDXZqUyf27te4lgKNsOeGAb9vg2GayhvhVw5ccN1wpN1i
         /DM4fnMRSwgmR4f0yTY7uUYEEczLfrNHwSt/O/Xzpdt1E309/Yz6Of6rIRMmTNtCeNRt
         +NNg==
X-Gm-Message-State: AOAM531QkZJ5r93keDrBiOqKWqD8lD4qkuNHb1hOgeJZ8ytm7lV86IQO
        aPWkfSNk3vlEj5p+00En1ypJA6doY08Pzmwz93E=
X-Google-Smtp-Source: ABdhPJyc+LFP+psa3kZ9XXFFTBsO7MMYF0HBYfo22CWlrebU7Zt7G1eB3hJqkmoT0bo6m/ImkA8fBnM1ja1uK8dwDkk=
X-Received: by 2002:adf:8028:: with SMTP id 37mr4635256wrk.111.1605287884168;
 Fri, 13 Nov 2020 09:18:04 -0800 (PST)
MIME-Version: 1.0
References: <20201113134938.4004947-1-lee.jones@linaro.org> <20201113134938.4004947-12-lee.jones@linaro.org>
In-Reply-To: <20201113134938.4004947-12-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 13 Nov 2020 12:17:52 -0500
Message-ID: <CADnq5_NuaUM7Ch==-ZkjzdsSeUL9uw6h9Amp10F4Ncoiwku3ZQ@mail.gmail.com>
Subject: Re: [PATCH 11/40] drm/amd/amdgpu/amdgpu_pll: Fix kernel-doc
 formatting, missing and extra params
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
>  drivers/gpu/drm/amd/amdgpu/amdgpu_pll.c:121: warning: Function parameter=
 or member 'freq' not described in 'amdgpu_pll_compute'
>  drivers/gpu/drm/amd/amdgpu/amdgpu_pll.c:121: warning: Function parameter=
 or member 'fb_div_p' not described in 'amdgpu_pll_compute'
>  drivers/gpu/drm/amd/amdgpu/amdgpu_pll.c:121: warning: Function parameter=
 or member 'frac_fb_div_p' not described in 'amdgpu_pll_compute'
>  drivers/gpu/drm/amd/amdgpu/amdgpu_pll.c:121: warning: Function parameter=
 or member 'ref_div_p' not described in 'amdgpu_pll_compute'
>  drivers/gpu/drm/amd/amdgpu/amdgpu_pll.c:121: warning: Function parameter=
 or member 'post_div_p' not described in 'amdgpu_pll_compute'
>  drivers/gpu/drm/amd/amdgpu/amdgpu_pll.c:317: warning: Excess function pa=
rameter 'encoder' description in 'amdgpu_pll_get_shared_nondp_ppll'
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
>  drivers/gpu/drm/amd/amdgpu/amdgpu_pll.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pll.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_pll.c
> index 1f2305b7bd135..f2e20666c9c1b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pll.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pll.c
> @@ -102,11 +102,12 @@ static void amdgpu_pll_get_fb_ref_div(unsigned nom,=
 unsigned den, unsigned post_
>   * amdgpu_pll_compute - compute PLL paramaters
>   *
>   * @pll: information about the PLL
> + * @freq: requested frequency
>   * @dot_clock_p: resulting pixel clock
> - * fb_div_p: resulting feedback divider
> - * frac_fb_div_p: fractional part of the feedback divider
> - * ref_div_p: resulting reference divider
> - * post_div_p: resulting reference divider
> + * @fb_div_p: resulting feedback divider
> + * @frac_fb_div_p: fractional part of the feedback divider
> + * @ref_div_p: resulting reference divider
> + * @post_div_p: resulting reference divider
>   *
>   * Try to calculate the PLL parameters to generate the given frequency:
>   * dot_clock =3D (ref_freq * feedback_div) / (ref_div * post_div)
> @@ -308,7 +309,6 @@ int amdgpu_pll_get_shared_dp_ppll(struct drm_crtc *cr=
tc)
>   * amdgpu_pll_get_shared_nondp_ppll - return the PPLL used by another no=
n-DP crtc
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
