Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB7E22F670E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 18:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbhANRLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 12:11:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbhANRLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 12:11:18 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F5EC061757
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:10:38 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id n42so5801002ota.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Z89knoWulPFq9AYPACpXwaMY0188RFnbZEaPd/jNiKk=;
        b=tKAOn7wfX5dFLUtkHs5SgiCpg1B9NAPXGFtpimqRlTRZJsi0tl0L3JYgib5/ajRIGf
         ely26qXO1Nteyw06CCfCYDTgTQUlYAkvMBK9aBgvAb3Vh3ZY2Ij2Xxjp/nQoHyHKHRc9
         59xmQFuWE6OgBtDvzsJncdPkInyr1964i3XQfJjcXkNUDHJ90gKkaOjKRU6CvQraRxXv
         VPZBfJvtAJZpDSavnA6kf+65zPB/0LQJk6341l+2eGD2QKbVKS3SorB1Ywvxzrsixgtt
         xKIICykn9PEXHW+obXPHvqcTNRERgii8P+xIqq3Z6P9NYVVEeGuI7+Y6RjrH+YYuO1YL
         UDqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Z89knoWulPFq9AYPACpXwaMY0188RFnbZEaPd/jNiKk=;
        b=tws941l8kuEVQesD+v9tAAz4KAP5fvmeIqiA+xWhDvbxf4p8QQaAPo6yRIFq8qAre4
         jVk1WjwzN2gZwkaCkKmYjkMkMc51PmX81lbhtFLGk5fNAEb6LjgB7+mlaSpSEK064GLi
         C8OXae4V9vk/tPeSqk5+n4NvNpgCoO7FdlACLJPgKKmbQFhUO8DVFlQpcFMUmslBm808
         hoy9nFWNLeq553OsCDPMwHUCbbN8F6BQWfI3iJpf5z79QaGJ5be2oXG85jGF0eUHI5C1
         KZM8SpYFY4Ui5eW2LVA++LaYg+AArZf5mrn1zf01p4RzQAoUTAxDmDqyNsnCSgJPBnlB
         opJA==
X-Gm-Message-State: AOAM530JLOn3szj9BLrC9rNKi035jJ4tw6k7DypvEeOPFIkt9IhOivAd
        So+iORvgu+HW5vWax3qEqX3eBoBxn15mLEU+DRw=
X-Google-Smtp-Source: ABdhPJxc4EKBNhvIxgoVQrOwTw3tJp6sS8rPoeHL+a74xvW4077JQ3w61iZAjTAB4y2hrlkfm80E7XAaNiEvcLdAXFM=
X-Received: by 2002:a9d:2ac2:: with SMTP id e60mr5189891otb.23.1610644237565;
 Thu, 14 Jan 2021 09:10:37 -0800 (PST)
MIME-Version: 1.0
References: <20210113080752.1003793-1-lee.jones@linaro.org> <20210113080752.1003793-10-lee.jones@linaro.org>
In-Reply-To: <20210113080752.1003793-10-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 14 Jan 2021 12:10:26 -0500
Message-ID: <CADnq5_OsqCBxMDGrY003+br1SR0=howMW=xynPXs_t1o-dF2jQ@mail.gmail.com>
Subject: Re: [PATCH 09/30] drm/amd/display/dc/dce112/dce112_resource: Include
 our own header file containing prototypes
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
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dce112_resource.c:883:6:=
 warning: no previous prototype for =E2=80=98dce112_validate_bandwidth=E2=
=80=99 [-Wmissing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dce112_resource.c:1008:1=
6: warning: no previous prototype for =E2=80=98dce112_add_stream_to_ctx=E2=
=80=99 [-Wmissing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dce112_resource.c:1407:2=
3: warning: no previous prototype for =E2=80=98dce112_create_resource_pool=
=E2=80=99 [-Wmissing-prototypes]
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
>  drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c b/dr=
ivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
> index c68e576a21990..ee55cda854bf4 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
> @@ -59,7 +59,9 @@
>  #include "dce/dce_11_2_sh_mask.h"
>
>  #include "dce100/dce100_resource.h"
> -#define DC_LOGGER \
> +#include "dce112_resource.h"
> +
> +#define DC_LOGGER                              \
>                 dc->ctx->logger
>
>  #ifndef mmDP_DPHY_INTERNAL_CTRL
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
