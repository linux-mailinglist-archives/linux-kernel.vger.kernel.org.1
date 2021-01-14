Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA7D2F6759
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 18:23:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbhANRQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 12:16:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbhANRQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 12:16:40 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95407C061574
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:15:59 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id n42so5819960ota.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DZvV4C4oOxbUt8DFOQqdGw1qrGeev5cm2TlRav0Zgbg=;
        b=Jm2eHceCwQCHn1T1s2o2QxDhEZm8HGU1e+A6qmoo/h0EI4XLjZcGq2ufqEi91NgF7Y
         Q/TTXh3JtWB4ZGLpYnHkP+8BCUSvfunQOps/a+FZnQpyhK68gRKptoZk7dFr67VqSWlV
         7WC/5JYUfehMVvAdEX2pDEa23whOfu8Hp70Y2HvB8AkBR1WUlypA+/eUesJsZrUAOwRo
         xpfOBXu5yz3pm+ZxY17bMHuQGW55lxlc1RnN/jNVMVdf+NhTr0rmAnuvY9LQtMFrQPjo
         zI7LPHGC4Gk59WfeiUKFU0RkZU4ZsZZewqnQBtLMtm0V3tTUXykPg13703H6qC35w5mw
         Twuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DZvV4C4oOxbUt8DFOQqdGw1qrGeev5cm2TlRav0Zgbg=;
        b=pcCdJkJpGRH6PUOpOiITJmRJFF+osKtb56XVuGh5Gf3uVykXQ1sDfKjqSKPk6KPW+s
         QKyE0COiGfPLuyjuhTlH2BkrboL1xyjOsDkAZDFpqeGqBAqwB0u9rBQrvlx/pUUGz7Gp
         RKAgLkDmUT3d7EMNxzH5Gri2iCwgr4YwGipHVRdoK+RIvNWPrRnXqP96RMYSwQwSnrrM
         /dTyiGLoRoCk6wy4s6YVIWWLKlzGpzr2luFTVuTa4aavfvo64GMgRBTuKTBw2/aUDyHO
         1/aYShDfUEd6MQQV4qQlmMskQPX8msapeLuN74EVUPw8B3csSJlmeO3Jy18OzVmQs47V
         3THw==
X-Gm-Message-State: AOAM530+2UrG6oZBhCji9Zn1gRB2SkxxR6F2jzAgBIj/hvRtKQgIbexJ
        QT75X8orFqJozwxnTK2NalAtQECQdY5fBB5pi1M=
X-Google-Smtp-Source: ABdhPJxNPLzWD0PbWkQes1m6LSVXN5I1aVXiz8LrP2RuB2J4vu6EaUpE58YSeUKp6ix+V53hajfXB6+peVv/C1EzISs=
X-Received: by 2002:a9d:2ac2:: with SMTP id e60mr5208415otb.23.1610644557590;
 Thu, 14 Jan 2021 09:15:57 -0800 (PST)
MIME-Version: 1.0
References: <20210113080752.1003793-1-lee.jones@linaro.org> <20210113080752.1003793-18-lee.jones@linaro.org>
In-Reply-To: <20210113080752.1003793-18-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 14 Jan 2021 12:15:46 -0500
Message-ID: <CADnq5_PYBNHHVR3DGRCRTFU1gWTPNN_z=bQYG_PUp9soq_n94g@mail.gmail.com>
Subject: Re: [PATCH 17/30] drm/amd/display/dc/dce60/dce60_resource: Include
 our own header containing prototypes
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

On Wed, Jan 13, 2021 at 3:08 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce60/dce60_resource.c:1115:23:=
 warning: no previous prototype for =E2=80=98dce60_create_resource_pool=E2=
=80=99 [-Wmissing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce60/dce60_resource.c:1312:23:=
 warning: no previous prototype for =E2=80=98dce61_create_resource_pool=E2=
=80=99 [-Wmissing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce60/dce60_resource.c:1505:23:=
 warning: no previous prototype for =E2=80=98dce64_create_resource_pool=E2=
=80=99 [-Wmissing-prototypes]
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
>  drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c b/driv=
ers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
> index 64f4a0da146bf..dcfa0a3efa00d 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
> @@ -60,6 +60,8 @@
>  #include "dce/dce_i2c.h"
>  /* TODO remove this include */
>
> +#include "dce60_resource.h"
> +
>  #ifndef mmMC_HUB_RDREQ_DMIF_LIMIT
>  #include "gmc/gmc_6_0_d.h"
>  #include "gmc/gmc_6_0_sh_mask.h"
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
