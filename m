Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E95FA2B2222
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 18:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgKMRYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 12:24:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbgKMRYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 12:24:50 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DFF6C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 09:25:04 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id 33so10751132wrl.7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 09:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uBRhPERLFwM9kVQueXTDW4VzWLQKorMvtcJ1DKfFCr8=;
        b=gbibu0MT1eCJuXVDo5/wiV3XKB65YBnbQ1ZN+z8148AhZ+PoypqBMpT/ghUmb5r6uF
         VEb8iLpHG7oZw7PTew5daLieAieoISp/P9NhxPZdI5hJC/Dgq8/6vwcF0ZRXnTYYjfgC
         /ZS+DuxHiONLTjpX2BNn3PJFShJfck9CZLqlw/PvtmvFLFcJR8Ao+CXaafdfGoS/Parm
         6luXFr/SxpPzLRjcX0MAbFIouieeFFC1VOQtH8JE3RaS0qEdKGHeS8EBx470tyxjMlW6
         5YQAIVbd/MF3AAq3ApGHpZ8dqaevXSzq6M9jQX13whxrx34ARrURpJYO1EQ8UO6vYhR8
         qb2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uBRhPERLFwM9kVQueXTDW4VzWLQKorMvtcJ1DKfFCr8=;
        b=TEPtgWf96c4Ow5IQxypT/us3GcrfQM7FbbguOtWSR0zHN/FiDO95FdggixsrsDATG6
         x1OxLWvMu4p89DoFUt4pp2hkFLERvumQiIJuTBH4LYn4htOX+Imf5wkWzLbr9a9kqDxu
         +9rPYEQVj8ppQneUXmspxvkA2xYnWqRWFFnAKiYbOaPt5lD+w1MuIbeJam//BVSMNSL6
         yCEuw2xeNqK0262A8ZOYR3wQiMMMxB6ZK+vYU6AYymF+2wbUz0fzeVB3NlUejSod1pWZ
         1hXlilpLGK9vwv0KvZbm1Y+7eh+KJJhvQF2IIrjaCAeW0IRQUMYagUi4LiavDDD/WcfO
         +GMw==
X-Gm-Message-State: AOAM530yGcIzATFJQhNloT0f42UKvryNxHPUTrymGdN2SkWhtk7hZ16E
        aEQTJx+Dt9DxSJ5qk6G4/YK3mu4FN3CMejSxj20=
X-Google-Smtp-Source: ABdhPJxtNQRZV0jj9joYdWfh3kfNhGsqnXi4N5xFBsTJ5f47wweNLoUMzJSeS0o2sdUa4Fnt9rH9xeb73/U4vUysprM=
X-Received: by 2002:adf:e9c9:: with SMTP id l9mr5043675wrn.124.1605288298092;
 Fri, 13 Nov 2020 09:24:58 -0800 (PST)
MIME-Version: 1.0
References: <20201113134938.4004947-1-lee.jones@linaro.org> <20201113134938.4004947-23-lee.jones@linaro.org>
In-Reply-To: <20201113134938.4004947-23-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 13 Nov 2020 12:24:46 -0500
Message-ID: <CADnq5_OmY=tfLL9zsr9wMrMjTkHBWeeRvkui4wqEut=UUwyNBg@mail.gmail.com>
Subject: Re: [PATCH 22/40] drm/amd/amdgpu/amdgpu_sched: Consume our own header
 containing prototypes
To:     Lee Jones <lee.jones@linaro.org>
Cc:     David Airlie <airlied@linux.ie>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Andres Rodriguez <andresx7@gmail.com>,
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
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c:35:5: warning: no previous pro=
totype for =E2=80=98amdgpu_to_sched_priority=E2=80=99 [-Wmissing-prototypes=
]
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c:122:5: warning: no previous pr=
ototype for =E2=80=98amdgpu_sched_ioctl=E2=80=99 [-Wmissing-prototypes]
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Luben Tuikov <luben.tuikov@amd.com>
> Cc: Andres Rodriguez <andresx7@gmail.com>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_sched.c
> index 0da0a0d986720..b7d861ed52849 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
> @@ -29,7 +29,7 @@
>  #include <drm/amdgpu_drm.h>
>
>  #include "amdgpu.h"
> -
> +#include "amdgpu_sched.h"
>  #include "amdgpu_vm.h"
>
>  int amdgpu_to_sched_priority(int amdgpu_priority,
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
