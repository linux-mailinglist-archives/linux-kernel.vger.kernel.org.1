Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6942C9292
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 00:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388473AbgK3Xcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 18:32:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387524AbgK3Xcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 18:32:42 -0500
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FEE2C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 15:32:02 -0800 (PST)
Received: by mail-oo1-xc43.google.com with SMTP id l20so3107203oot.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 15:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+4SG1W6ZYxr21uP2r2HXOaj3oH3XrFM1o5qmgSoZzy0=;
        b=W8P4tc7lqvKcl6a682oVHo8LIL7zrF3HorAGO901QT9xJcv+mt4nN6VQuV2x4Rkm6P
         5b2nR8Gq0AuFtzHQ+rAWlF5X11SU9FxyROTtoCzkoVeuvvY67NwM0PBkjJ6vk85K7KcK
         0PQtSIW0lMXYzvjVSnrwqjs25P1AePYUzeHdR2zH2NLv1qWEQIhZ3HhKmD53wUrQ8sVh
         0JmwnwIvO/Qh1BQY9NsckOckCjyV8nSmw/pATYJKdwYj0PkRG3vgCvW5LacqrCGEkkMX
         FAathHy1+jxH6hZC073PN9FW88OKd3xgfpG8URkJsfSKLabb6vlqMbE56iDB68Lj7c4m
         t1jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+4SG1W6ZYxr21uP2r2HXOaj3oH3XrFM1o5qmgSoZzy0=;
        b=B+uLH5n1rwBvKO1MosZqWcDPeTG/8xkoohKG42c0lxGT+rjmkBslPCAcuaQ4d8UayL
         fC60U5RIpAj9FgIlHMKj8KZRjOPuuAutU6vULVLzOSyg4GHD3Y5DfOuT2q55KpmJbf2V
         25hBWCfvJ6QKkQp+SRQ0bAvbdVfTJfWLiY4MIQ6H1SPD4cGnFjCmbXd/PqRqgpeUSAu9
         FmMVzvHf497JLqCio0RvNMWe3g3TT3m8ZKSi0rM6g7oSDLt7YJoGQTEj/0HklOsuL0ES
         s3W632Qnjyr2c1jKKTpKABxJaKJWyOB9gt4ACArQq29snpR7tDt3TnvgHLRMxmK9g8Bz
         tVFw==
X-Gm-Message-State: AOAM533Hb1YPKV0XRvcN6+Qtwa+li5Vkf/sMmuLgusL5MP4hlQ1BnYMk
        olFGla1n+Vz+uzU+zx9ZtWAfsR2inscZ1cGOmC4=
X-Google-Smtp-Source: ABdhPJzQIvDtzw/bx/lT+aZ9bxgSsYcP1s6cpKoEtS3ZahAioGtuidQu7LMMgOkM0uQaLQWTQK+wLcG2UpUHTggobuA=
X-Received: by 2002:a4a:e0ce:: with SMTP id e14mr6193oot.72.1606779121408;
 Mon, 30 Nov 2020 15:32:01 -0800 (PST)
MIME-Version: 1.0
References: <20201126134240.3214176-1-lee.jones@linaro.org> <20201126134240.3214176-12-lee.jones@linaro.org>
In-Reply-To: <20201126134240.3214176-12-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 30 Nov 2020 18:31:50 -0500
Message-ID: <CADnq5_ORvcezYqvKv6xs8JKKFDxZ=Lrm9GOCxYBeJ8-fJAd0wg@mail.gmail.com>
Subject: Re: [PATCH 11/40] drm/amd/pm/powerplay/hwmgr/ppevvmath: Place
 variable declaration under same clause as its use
To:     Lee Jones <lee.jones@linaro.org>
Cc:     David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Evan Quan <evan.quan@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 26, 2020 at 8:43 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/ppevvmath.h: In functio=
n =E2=80=98fMultiply=E2=80=99:
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/ppevvmath.h:336:22: war=
ning: variable =E2=80=98Y_LessThanOne=E2=80=99 set but not used [-Wunused-b=
ut-set-variable]
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/ppevvmath.h:336:7: warn=
ing: variable =E2=80=98X_LessThanOne=E2=80=99 set but not used [-Wunused-bu=
t-set-variable]
>
> Cc: Evan Quan <evan.quan@amd.com>
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
>  drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppevvmath.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppevvmath.h b/drivers=
/gpu/drm/amd/pm/powerplay/hwmgr/ppevvmath.h
> index 8f50a038396ce..dac29fe6cfc6f 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppevvmath.h
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppevvmath.h
> @@ -333,14 +333,14 @@ static fInt fMultiply (fInt X, fInt Y) /* Uses 64-b=
it integers (int64_t) */
>  {
>         fInt Product;
>         int64_t tempProduct;
> +
> +       /*The following is for a very specific common case: Non-zero numb=
er with ONLY fractional portion*/
> +       /* TEMPORARILY DISABLED - CAN BE USED TO IMPROVE PRECISION
>         bool X_LessThanOne, Y_LessThanOne;
>
>         X_LessThanOne =3D (X.partial.real =3D=3D 0 && X.partial.decimal !=
=3D 0 && X.full >=3D 0);
>         Y_LessThanOne =3D (Y.partial.real =3D=3D 0 && Y.partial.decimal !=
=3D 0 && Y.full >=3D 0);
>
> -       /*The following is for a very specific common case: Non-zero numb=
er with ONLY fractional portion*/
> -       /* TEMPORARILY DISABLED - CAN BE USED TO IMPROVE PRECISION
> -
>         if (X_LessThanOne && Y_LessThanOne) {
>                 Product.full =3D X.full * Y.full;
>                 return Product
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
