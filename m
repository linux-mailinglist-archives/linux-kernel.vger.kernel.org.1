Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C71072C9260
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 00:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729612AbgK3XSy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 18:18:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbgK3XSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 18:18:53 -0500
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D9FC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 15:18:07 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id y74so16118522oia.11
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 15:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=C7PinMSDxT1TDnGp4Uxl3lW8a+kzcDKRcBmpoKDWXck=;
        b=QqGSR/CecXkCQqNWiUVQ3x7oIKUjYWSlbL/kIrQv76YPayngtzffCNfLlAMNyLIrWx
         vJlIHFArtnWorW7U9iQFwHscmgrgKhkPRyM7X/AxNiiQU9MeSYOIwceX8InATsHxHEnD
         mtB5OCTPcn+QX8tsij/VO00sUER+7WYE1i2mPttiq1fC7q51TR2DyODZ4Dt1viz3svQa
         mombypA8IlE+Xn4O2ZcscFWGurbUkWwLyodOYQfNwdXsSzYGe1P47GRnnl+KU/ytYR0m
         JtzGWkwfcUjh+IbTulu0MzSPyjKJz2G6wR+FJBaV0tunY8dvjFcmB30HCcZec4k3BlIi
         fgFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=C7PinMSDxT1TDnGp4Uxl3lW8a+kzcDKRcBmpoKDWXck=;
        b=f2SsY4sTe4hINnfrzmcJl2NCxuobTXS7xEy1pTodEusj9fZatKLLHycSw/eqYHQxWS
         sjnoIuwizJupzpKs0LUO7OG9k80fCVWsxdDBzU86v65Cr0vGxswhuy+mzFiRAqBKyYua
         YyTKZDaqjIlnkT2x5vhQkcMRjOJIACOxG5qt0a4Y5QmXaoHWKZ7OiUJYbA/OC/9HBifX
         t1eh6Ucid7HjDXFEwH6OFN+DVCNQd5h/wQnAmle7y0f39/Be9pKow8aREzoQr/z3Q119
         yD7rX0IBsLe6yAU+DLc6vlTfl4Tyf9/M6Tqjj+p61bLfCSF4gtslOPczLqvyvM8TqgJs
         pW4Q==
X-Gm-Message-State: AOAM533tn/drxW7KU/Tl13gcj+wX310QTa6EXa71F4VpcqZqqQwitkja
        A4YqTLEB47SMkRMvrMYJikY6xtAPuaTZ5JcJ5Yw=
X-Google-Smtp-Source: ABdhPJyveZpV+lcjNiVSe5NCFpk5s0+ulSEhgu6bAY1Pjr4rDw///J9UhNlLTgqW5QGCLGrtX0hOFWL6KbmrsfNYIug=
X-Received: by 2002:aca:f50e:: with SMTP id t14mr99714oih.123.1606778287242;
 Mon, 30 Nov 2020 15:18:07 -0800 (PST)
MIME-Version: 1.0
References: <20201126134240.3214176-1-lee.jones@linaro.org> <20201126134240.3214176-7-lee.jones@linaro.org>
In-Reply-To: <20201126134240.3214176-7-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 30 Nov 2020 18:17:56 -0500
Message-ID: <CADnq5_Ni=mj9KKcJn4wexsSKg1RK_GG_iDHz4Btk+6eBC0eHhQ@mail.gmail.com>
Subject: Re: [PATCH 06/40] drm/amd/pm/powerplay/smumgr/smu9_smumgr: Include
 our own header containing our prototypes
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
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/smu9_smumgr.c:38:6: wa=
rning: no previous prototype for =E2=80=98smu9_is_smc_ram_running=E2=80=99 =
[-Wmissing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/smu9_smumgr.c:112:5: w=
arning: no previous prototype for =E2=80=98smu9_send_msg_to_smc=E2=80=99 [-=
Wmissing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/smu9_smumgr.c:140:5: w=
arning: no previous prototype for =E2=80=98smu9_send_msg_to_smc_with_parame=
ter=E2=80=99 [-Wmissing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/smu9_smumgr.c:165:10: =
warning: no previous prototype for =E2=80=98smu9_get_argument=E2=80=99 [-Wm=
issing-prototypes]
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
>  drivers/gpu/drm/amd/pm/powerplay/smumgr/smu9_smumgr.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu9_smumgr.c b/driv=
ers/gpu/drm/amd/pm/powerplay/smumgr/smu9_smumgr.c
> index 8a9aee85043ec..23e5de3c4ec16 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu9_smumgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu9_smumgr.c
> @@ -22,6 +22,7 @@
>   */
>
>  #include "smumgr.h"
> +#include "smu9_smumgr.h"
>  #include "vega10_inc.h"
>  #include "soc15_common.h"
>  #include "pp_debug.h"
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
