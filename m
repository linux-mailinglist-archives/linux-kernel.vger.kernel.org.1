Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9483D2C2C6F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 17:12:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390235AbgKXQLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 11:11:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390105AbgKXQLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 11:11:49 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7D0C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 08:11:48 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id g14so7690648wrm.13
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 08:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yWBnAsL35h7coYRmd6KCcPiuKL0mldpz6aVNraU0pGg=;
        b=NP4SypGli7x9DynJs7n+UT0Qu+QOMiTALxeTz9iK20T5BS3LeIvpDRXBPeIou2Mfb0
         LOsUwxRA7ufIXwSrtzMrEhSo9J54a6YDU9tOIOAxJGR5yYxkNEWx0sQuPt06gKjS3E2T
         nGh+/Hlksh2xzQj2ZgwAq6hjD2m7aMthGFTLnIuu+///meA/TrJvjqoIRu0Ce6LJkZsS
         UuVI3FFbdMRRjehN67dbdCElKxiN2q96KX78eEugHCYendp+CNPjGw7V+KJ56nLkJskj
         iMKWDD7giCwO6og0jNBCqbatSUBBVt5Ao0zwsjD2yuN9Fn7VL2jPjzMkyg/8I5B1tI68
         3GSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yWBnAsL35h7coYRmd6KCcPiuKL0mldpz6aVNraU0pGg=;
        b=d1JFN8coTCSr7mxBYh4QmZApBvPJ4XS06xm0/jaZLwnmbClZQJklJmyCQe/jpAaL0p
         5aYK7aL754Xx36OsiQXMX0LcJJK6vw5HX8Ten2vBphYHWW27qv15i+wMjgcqmfFCjPyH
         XaIowqq5jrNJ8Mrd2nmpjTp0odMQ3H5dCuarTUuoDxQJuNzVmzr8TfktQ7q2btRKfDYf
         V8vKrAbbGMeAqVVTqsQNtWv0T38JBjc4mSL0yJ8ciKvD2+j9K9g/2t1efSteL1/hdjE+
         GTqoMATaft2PXYHHogJ+A7e+kvJ8Iic9v49lRZKORp9zCN9Trhi4W8MuxPb7H4rZ3Z/1
         T7dA==
X-Gm-Message-State: AOAM533xlSaHAH/d9aI1CqOZzdhJRbzy433MZkQWPWhlipv5tZVtywR3
        1gfI0rHUOhb9gIS27J6DVq6HRr/+ueC4r1n7mHU=
X-Google-Smtp-Source: ABdhPJw0msurlCJdUlLz8FT84ifhdXHmaoi1gvjtUeAEEZQg/e1bujCJGzGlPH6KS6IgPPLj3bFCVDTL+bjy7xBSEG8=
X-Received: by 2002:adf:8028:: with SMTP id 37mr6136762wrk.111.1606234306840;
 Tue, 24 Nov 2020 08:11:46 -0800 (PST)
MIME-Version: 1.0
References: <20201123111919.233376-1-lee.jones@linaro.org> <20201123111919.233376-24-lee.jones@linaro.org>
In-Reply-To: <20201123111919.233376-24-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 24 Nov 2020 11:11:35 -0500
Message-ID: <CADnq5_OdaPQrzCMdr3vPs6WOWvbKWhgAV8RvQ6M5roZq3jQ1Xg@mail.gmail.com>
Subject: Re: [PATCH 23/40] drm/amd/include/vega20_ip_offset: Mark top-level
 IP_BASE definition as __maybe_unused
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

On Mon, Nov 23, 2020 at 6:20 AM Lee Jones <lee.jones@linaro.org> wrote:
>
>  In file included from drivers/gpu/drm/amd/amdgpu/vega20_reg_init.c:27:
>  drivers/gpu/drm/amd/amdgpu/../include/vega20_ip_offset.h:154:29: warning=
: =E2=80=98XDMA_BASE=E2=80=99 defined but not used [-Wunused-const-variable=
=3D
>  154 | static const struct IP_BASE XDMA_BASE =3D{ { { { 0x00003400, 0, 0,=
 0, 0, 0 } },
>  | ^~~~~~~~~
>  drivers/gpu/drm/amd/amdgpu/../include/vega20_ip_offset.h:63:29: warning:=
 =E2=80=98FUSE_BASE=E2=80=99 defined but not used [-Wunused-const-variable=
=3D]
>  63 | static const struct IP_BASE FUSE_BASE =3D{ { { { 0x00017400, 0, 0, =
0, 0, 0 } },
>  | ^~~~~~~~~
>
> Fixes the following W=3D1 kernel build warning(s):
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
>  drivers/gpu/drm/amd/include/vega20_ip_offset.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/include/vega20_ip_offset.h b/drivers/gpu=
/drm/amd/include/vega20_ip_offset.h
> index 2a2a9cc8bedb6..1deb68f3d3341 100644
> --- a/drivers/gpu/drm/amd/include/vega20_ip_offset.h
> +++ b/drivers/gpu/drm/amd/include/vega20_ip_offset.h
> @@ -33,7 +33,7 @@ struct IP_BASE_INSTANCE
>  struct IP_BASE
>  {
>      struct IP_BASE_INSTANCE instance[MAX_INSTANCE];
> -};
> +} __maybe_unused;
>
>
>  static const struct IP_BASE ATHUB_BASE            =3D{ { { { 0x00000C20,=
 0, 0, 0, 0, 0 } },
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
