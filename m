Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C67632F3DF8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:44:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393792AbhALV7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 16:59:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393782AbhALV7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 16:59:12 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F2BAC061794
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 13:58:31 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id 9so4014946oiq.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 13:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=w18T70m4lkwRPMiPMR134n9wU13dWJxLSQUBF6LNCsc=;
        b=BL/njEzcAiq3Zpu7sZCqsrz1x6pqD4L5U0ECVx0gvXYbE4/ZXX0pVI+4nM2xgArpoP
         fMsITr+IqJmsxccdfl0HNa2N7kfFCrGrIX4RYBFD4d429siBlUyooygos4f3i1mNtcSS
         8q7aCwotCsWDcHAHzXJ6dK6CYPkOIGlQ3o0bJDEGW/EQdVFKJK1KH8qcCrGAfXVpqAtQ
         oSVtv9dGhPD+OsYMOpURTQsW9gzPAMEGDB+Ef0hxRKknvY97vHBdcQTnQxvHA2bga34C
         iUtTKsn9WGW5dSiU/6WH5h/cX1UrK1gh4VH1Q2dMaxfFPsg/GAGjOdOdpNhfIGirCZfy
         ft6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=w18T70m4lkwRPMiPMR134n9wU13dWJxLSQUBF6LNCsc=;
        b=Xc7kooiGtbLz8RkSHSoh/ncJN7lryyG0zZStHExzFAxkr0ab3FGHeNVDLICLgBTepf
         Q/JsUhirHcvMGIzsAaZn/bStp4UQKIOosGvXeQQ2a3gW2PTWpB6mZXalXQX2BZbEHmc+
         yP0OZRB+bRsD6nyyoj+MpudPLXjG/NUCP1r+vvfb0BaTKEWxV0ARnDZS1cjj3QU9Udbu
         l7jAWqbF/xrNwTaVaVfdJqcsQ9M5mo1Kw8lN70eAju5fjyNt43j+xWsY2qMl1Q2EbOfm
         6SjQSsxUmZSkvVpQTOGedcfdeKMtxlBw6d5rTG/GNAyKCbCpn3G+1B0CsUu/JHl3dLlw
         92hg==
X-Gm-Message-State: AOAM53219tX6wjcoP381JnZOPlJ0i3aw5GkiZrYd1PDyiEnksHXTDOtT
        WUGvduJMKgulkpRh+zJT0vDnbGPPa3YOptqRAGk=
X-Google-Smtp-Source: ABdhPJy9NwdyHTgzkc+OqNv3L/bhSJUX6/1k4y+l+Z2+MrFcnGrHnmxsOdqo6PwYGS1pQzNpAaTCjNoKFdnYhS/LTtw=
X-Received: by 2002:aca:6202:: with SMTP id w2mr727504oib.5.1610488711091;
 Tue, 12 Jan 2021 13:58:31 -0800 (PST)
MIME-Version: 1.0
References: <20210111191926.3688443-1-lee.jones@linaro.org> <20210111191926.3688443-3-lee.jones@linaro.org>
In-Reply-To: <20210111191926.3688443-3-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 12 Jan 2021 16:58:20 -0500
Message-ID: <CADnq5_P-dj79Rx+8O7c6oVAtsUPjV-mn2FxXqsdx-uV76U4wwA@mail.gmail.com>
Subject: Re: [PATCH 02/40] drm/amd/display/dc/dce/dce_link_encoder: Remove
 unused variable 'value0'
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Leo Li <sunpeng.li@amd.com>, Mauro Rossi <issor.oruam@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 2:19 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_link_encoder.c: In func=
tion =E2=80=98dce110_link_encoder_update_mst_stream_allocation_table=E2=80=
=99:
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_link_encoder.c:1506:11:=
 warning: variable =E2=80=98value0=E2=80=99 set but not used [-Wunused-but-=
set-variable]
>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Mauro Rossi <issor.oruam@gmail.com>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c b/driv=
ers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
> index 0ef2f4d9d8bf3..1e77ffee71b30 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
> @@ -1503,7 +1503,6 @@ void dce110_link_encoder_update_mst_stream_allocati=
on_table(
>         const struct link_mst_stream_allocation_table *table)
>  {
>         struct dce110_link_encoder *enc110 =3D TO_DCE110_LINK_ENC(enc);
> -       uint32_t value0 =3D 0;
>         uint32_t value1 =3D 0;
>         uint32_t value2 =3D 0;
>         uint32_t slots =3D 0;
> @@ -1604,7 +1603,7 @@ void dce110_link_encoder_update_mst_stream_allocati=
on_table(
>         do {
>                 udelay(10);
>
> -               value0 =3D REG_READ(DP_MSE_SAT_UPDATE);
> +               REG_READ(DP_MSE_SAT_UPDATE);
>
>                 REG_GET(DP_MSE_SAT_UPDATE,
>                                 DP_MSE_SAT_UPDATE, &value1);
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
