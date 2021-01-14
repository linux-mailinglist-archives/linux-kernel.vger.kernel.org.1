Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 694F92F6738
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 18:16:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728863AbhANRPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 12:15:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726172AbhANRPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 12:15:45 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6142C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:15:04 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id q25so5832043otn.10
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=v+IWiGsFZpYty9uPEMCbFqjqaqqlfa3/+90RuBzx60o=;
        b=ten/ALZCvZdzN086fa5oMkKYJcezQlWqXYa+356BpaFzTsBA82jf4vMt0ECAfFgpPu
         vhqCzyxC9gnklgm/vuVULZWq5T/pEF6Lk5dkAyBWV0/lNWpkgSd5nf/DhiPWvIS2YR9m
         GApsWRH2deCphZOz04NpVmiGvlCHQuunIQrYbarn4bAh93NUc4O9YD9bvrfP4Xw2yO52
         p98NMIV1S6RPJRnmykyn95ma9O+PxTUQPipKu4qW2OxqCCbeTuXEsIW9elKEToepCamU
         cU28kuMX7obX/k8ivRp1vNy/OYXGFitv1UwQFAz+uTA9k+5v+s63Ymw/ot4G5EFMltbG
         CzeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=v+IWiGsFZpYty9uPEMCbFqjqaqqlfa3/+90RuBzx60o=;
        b=NPhYyk8RydH34AOjtACEkHIcsrlBenDdKegtqBDd1eGIBJvfC/Yz0+9lrKW4r2kgeY
         WtqYY37mW1vyCoN6tktNv5GV2Eg1QDWCCQIRYCmgJmQ22u7i2D72ijuBhWWWFjufRN8k
         Mcx3r2ya31XWceYrH69iNDt7vEn//Eat+mhAJLSQmCFWLpXQLuSsq8z600mTs7kFgaar
         YNbwPWLEhClBnEmbObzgHLyLZZbirQ4VJvkP1LJ7BP1mVFNQ32MNQep1eVhW8pRs9lvs
         3hWccJBqMlEKluTzgMt+ELNUUUxrXmuox//E1VwmqjoxA39peBz8D1b/rt3zqJId9GiG
         3UEA==
X-Gm-Message-State: AOAM530nmYedENynTxS1pyMdPSoFLuBSt7ui4KKoF36nU6e1EYnyi3zL
        C2CxqjRBhPPikWTJkz1zcdHIdDSSPJvUbIRP3i0=
X-Google-Smtp-Source: ABdhPJyNJkE4H9tRyMCJgxPE3E10+sCah9UThloK7fktb03JAQOwNC6kFkzOOzCmgkcMv9EvXNFYrMoRUM+lxEXjgLo=
X-Received: by 2002:a05:6830:1b7b:: with SMTP id d27mr5473943ote.132.1610644504422;
 Thu, 14 Jan 2021 09:15:04 -0800 (PST)
MIME-Version: 1.0
References: <20210113080752.1003793-1-lee.jones@linaro.org> <20210113080752.1003793-16-lee.jones@linaro.org>
In-Reply-To: <20210113080752.1003793-16-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 14 Jan 2021 12:14:53 -0500
Message-ID: <CADnq5_McjDiGUNYfLaZV4F1rH_NZ-U3GMuEBpjFhEHYoChg3WQ@mail.gmail.com>
Subject: Re: [PATCH 15/30] drm/amd/display/dc/dce80/dce80_resource: Include
 our own header containing prototypes
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Leo Li <sunpeng.li@amd.com>, Anthony Koo <Anthony.Koo@amd.com>,
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

On Wed, Jan 13, 2021 at 3:08 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce80/dce80_resource.c:1126:23:=
 warning: no previous prototype for =E2=80=98dce80_create_resource_pool=E2=
=80=99 [-Wmissing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce80/dce80_resource.c:1325:23:=
 warning: no previous prototype for =E2=80=98dce81_create_resource_pool=E2=
=80=99 [-Wmissing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce80/dce80_resource.c:1520:23:=
 warning: no previous prototype for =E2=80=98dce83_create_resource_pool=E2=
=80=99 [-Wmissing-prototypes]
>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Anthony Koo <Anthony.Koo@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c b/driv=
ers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
> index fe5d716084363..725d92e40cd30 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
> @@ -60,6 +60,8 @@
>  #include "dce/dce_i2c.h"
>  /* TODO remove this include */
>
> +#include "dce80_resource.h"
> +
>  #ifndef mmMC_HUB_RDREQ_DMIF_LIMIT
>  #include "gmc/gmc_7_1_d.h"
>  #include "gmc/gmc_7_1_sh_mask.h"
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
