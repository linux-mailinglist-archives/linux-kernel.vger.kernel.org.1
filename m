Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8452F3E1A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394220AbhALWFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 17:05:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394147AbhALWEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 17:04:54 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C48CDC061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 14:04:13 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id w3so3793505otp.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 14:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=20iRatogXKctWuCSvC+xfnFlPUF7GqkY4/aok3Z1trg=;
        b=r21FEgHp1vFsdhCcrMKN4hSIIgqsRz8//hcQrdf1SZO7OTrAElURZARDPSO6CZdgLJ
         DICQniV60nSGoYnQW/qgnEaANWsnS1UZ8X/aXZk7T+KEhCdomYQQUsvrY/AgXtgDev1e
         xqrXFt+LbzVdZoy4mOVnI1j9hFn7Kse7Ayt3btBCYMuE1lfI9xfJ4bzwQlqj9itQ40Zk
         zdgYOKg8JTDxMkBtNwqAP6VtG+hqBKQJSMNgt79I7kmGMcLRDLCbb8IsBBcX9qmIPq7G
         FY7qZDNQWDZasdcpWCJnfAR5rlN8On6PufVN4si7zyOzRShEpKNtTfPaEBx7oob16Lbw
         KTfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=20iRatogXKctWuCSvC+xfnFlPUF7GqkY4/aok3Z1trg=;
        b=ouQC5wFT5KRNXiSvwQgFIiKDamneAKGCK0JwgzsFr9ebsSkIbDtF0iyGeMh3lflSjI
         ju8wytTt6lzmYU/716buZQTHf9mZQyYfyRJAUSzG/ExVmWrdlqi03X71obBXg/uHMnTh
         ymroWXgfKTcfPCiZBjmjSC44+i8XPbZqoDy1B5YDk7ZoSY6LaHuXNqeEw6zy3WkcdCdj
         uUAS76BbHLoE018J44d5ZuO1VCRkdwgCsTsThRcNCvZsldbXNvr4X3ZtCQ9yhawm+bv4
         ocVt/VvCN70kSQcafcNTa7fEPZNn6McpVkomV/cQLxlWdKv7/quxG5AUcCxwDybZzfQ6
         oylg==
X-Gm-Message-State: AOAM533rUvQBGKeFkkrBN28xvH9/aEIgTAL6NGVwoG77T/yJbEB4tFmW
        0jEzY37XnI8UEinoVZ1mUjnfj8S32uUSY+WarPM=
X-Google-Smtp-Source: ABdhPJyfFwlgdzLPNsDb2NafsNzOVsdOGOdv1zgXDC8wcRobwTbGBFQ+8OB2KxA7P4FzPyVsTyKw/qe3+C/roofQ+wk=
X-Received: by 2002:a9d:75d4:: with SMTP id c20mr989297otl.311.1610489053276;
 Tue, 12 Jan 2021 14:04:13 -0800 (PST)
MIME-Version: 1.0
References: <20210111191926.3688443-1-lee.jones@linaro.org> <20210111191926.3688443-10-lee.jones@linaro.org>
In-Reply-To: <20210111191926.3688443-10-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 12 Jan 2021 17:04:02 -0500
Message-ID: <CADnq5_PVviC6oYp_mSeY+oYgXE3Ubvuu-sd=MHACTbiVq1mtdg@mail.gmail.com>
Subject: Re: [PATCH 09/40] drm/amd/display/dc/gpio/diagnostics/hw_factory_diag:
 Include our own header containing prototypes
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

On Mon, Jan 11, 2021 at 2:19 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/diagnostics/hw_factory_dia=
g.c:50:6: warning: no previous prototype for =E2=80=98dal_hw_factory_diag_f=
pga_init=E2=80=99 [-Wmissing-prototypes]
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
>  .../gpu/drm/amd/display/dc/gpio/diagnostics/hw_factory_diag.c    | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/gpio/diagnostics/hw_factory_d=
iag.c b/drivers/gpu/drm/amd/display/dc/gpio/diagnostics/hw_factory_diag.c
> index df68430aeb0c2..c6e28f6bf1a27 100644
> --- a/drivers/gpu/drm/amd/display/dc/gpio/diagnostics/hw_factory_diag.c
> +++ b/drivers/gpu/drm/amd/display/dc/gpio/diagnostics/hw_factory_diag.c
> @@ -28,6 +28,7 @@
>   */
>
>  #include "dm_services.h"
> +#include "hw_factory_diag.h"
>  #include "include/gpio_types.h"
>  #include "../hw_factory.h"
>
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
