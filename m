Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1172EFA51
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 22:22:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729702AbhAHVWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 16:22:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728587AbhAHVWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 16:22:02 -0500
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59348C061757
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 13:21:22 -0800 (PST)
Received: by mail-oo1-xc35.google.com with SMTP id x23so2731820oop.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 13:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6Lpk5Nv67FloCKNgJyqOZp3CuSqmycAftdWsVy2MVY8=;
        b=JofLM2g4qOdL/1LisOZ/7pwproBEDUQX5RuX2+p4EQhwSKhTJtOioUVfePZuYnPTgk
         o7sq//QH/ZIC0PX/1pr6HHs/SIcrLl6O1nHY7nvIvM3VAd33tV63zl80Na3qJRK39a4/
         VD2EGGmwT9XJs75Ie80eP1qTJKMYjLn9HfAwA6t4s8PjyfhAr4hnn7XaSwtmQ9cZD0H/
         kHx1WlSTxMoZ72m4obBWQrRzr5z3qhRnyrsix30dhvwuBA6NxqCC0r1NQExCuN73Z86N
         7e9CXiMWBKbGvjLlfH1c4hGscdPazEYgL8fJ09t16SeJYVilMW+vYYk9ZRGNZxTfNHib
         q81A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6Lpk5Nv67FloCKNgJyqOZp3CuSqmycAftdWsVy2MVY8=;
        b=UZUZtVV5CV/yrjQICCx74QKsCzMSJ9snTUJy59+rfiEuHQSRClSwJwV1a5fb0Yaz64
         YyeegBjrUw4mLAxvV4QpSa4eonINy9nr0JCXqkNeUhf6cUtCsVpUywqBH25P138DoM4z
         pqMb3S7I2il0EfYLl/DPC+WeJN/zJn0MByMVsFy7CNPO9jR463NrrCZ25VnUccepWxDq
         6H/O06SoL8egPqwU5hhDubAJD2U00gSfb/UW0GN5fUdau64gApojsRCNrtHvcvKMUUPi
         AdUARkyN97oPY4hdZATMA5N7co2+3SW7YXPn6CMCpVnPZcS2dQ2Ecr0i31nEPb6MM4Gt
         wL2Q==
X-Gm-Message-State: AOAM532MmhXgUUCQfUnAqXaydB5Nit3mlSA3+PVb7783S3KChZWoyDSC
        ChjJjOLCrlG1MmqCHMwmWX0Qk3TGLAcaJcrS4Zx4GcGw
X-Google-Smtp-Source: ABdhPJwQt80yhixZjvEfkgfZaFjtYpFY+vEbRMPf8v5ZRXKhLXU1iA9vOFs8uzULqYySxidd4F9IjxYSKZF5StHfp9M=
X-Received: by 2002:a4a:a2c5:: with SMTP id r5mr5583822ool.72.1610140881856;
 Fri, 08 Jan 2021 13:21:21 -0800 (PST)
MIME-Version: 1.0
References: <20210108201457.3078600-1-lee.jones@linaro.org> <20210108201457.3078600-33-lee.jones@linaro.org>
In-Reply-To: <20210108201457.3078600-33-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 8 Jan 2021 16:21:10 -0500
Message-ID: <CADnq5_O-f1rMA61GmaoYQmDFH9wS-QPs3=gBT2vm8ujhdf=F+g@mail.gmail.com>
Subject: Re: [PATCH 32/40] drm/amd/display/dc/dce/dce_aux: Remove unused
 function 'get_engine_type'
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Leo Li <sunpeng.li@amd.com>, LKML <linux-kernel@vger.kernel.org>,
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

On Fri, Jan 8, 2021 at 3:16 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_aux.c:391:25: warning: =
no previous prototype for =E2=80=98get_engine_type=E2=80=99 [-Wmissing-prot=
otypes]
>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
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
>  drivers/gpu/drm/amd/display/dc/dce/dce_aux.c | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c b/drivers/gpu/d=
rm/amd/display/dc/dce/dce_aux.c
> index cda5fd0464bc5..3204292a5aeae 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
> @@ -388,12 +388,6 @@ static enum aux_channel_operation_result get_channel=
_status(
>         }
>  }
>
> -enum i2caux_engine_type get_engine_type(
> -               const struct dce_aux *engine)
> -{
> -       return I2CAUX_ENGINE_TYPE_AUX;
> -}
> -
>  static bool acquire(
>         struct dce_aux *engine,
>         struct ddc *ddc)
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
