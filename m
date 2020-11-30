Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 393512C917F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 23:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388728AbgK3WuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 17:50:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388721AbgK3WuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 17:50:05 -0500
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A47D2C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 14:49:25 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id e105so967765ote.5
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 14:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bzJwkZIz7kl6fhYUImeAIlsAKf62NSFlF6oC5OffnRw=;
        b=HatqDxz4UFz+rfmzrNA2CN47GpWWN0jcH2jAKj6hlFoKnrNJ5JchjzYzOYlQ4F98Iu
         /y1vrjuPsDdMbUfOgSOhjjkf15NolmEeeeE8kwcIw0UxgNQ5lrSPnbnHw+Z1JR7K3rjU
         4W8RHh8ogH2UfYaDYkE0oaM1alUZq6N3iL2/UTpaEJdX2Objl7WrY9b5RcaUbATGhC53
         msgmLtetVPgjVRYgX9SRvlxuJnGwwlPBFGZh/qXGBpyM01kRbLg9ORdztYCk8W5Sl4Li
         5a733ICe5hl8rYrtsm7L++R1NWC+Dg5kPneiDHL/U5aQMlPxey3dXnYI2GEjBzSdFP+F
         N/wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bzJwkZIz7kl6fhYUImeAIlsAKf62NSFlF6oC5OffnRw=;
        b=e5nmioQdzjZs76yjXzIv1ApmzGVxBIaUpf0Q73qCIqliVhzL+Py4FT5aS7dimMv8Od
         v+y1zISzdpsoTg4aRb4mH5tXh8X6dVMI3kwzAEGJ010RIhsxVXTCbsedJqxC+CO5ggQ8
         j7dahAjVcj2786G63ZymBWpdaVe9DK6/7VWSsPc/dC9tRCT1W/Epdb6Y2lKGo/OXLlqB
         jMK/0CunGJ7fEqevDniHYXdR04uhOLT5GwFro5LXAtZcvvb49GMRmzOirjXso//US+zw
         eAkSkn6TenphokFKfVsTQ+XNu6GsYsEEoz2ZOpsgnATJV+NSK0kl1LaH8UucuGf1VeVK
         LEew==
X-Gm-Message-State: AOAM5310yHdfRKFUpQX8iHypeWWUS8g2yaM4lB7W5OzCUtTSISp7asb3
        6TqyNZuhHodgzQIGJMUvLG3MFFx2LHDowiu6k+A=
X-Google-Smtp-Source: ABdhPJxa/myszQklUKIl9V0fscEIrdxL5Ryo54OSBNEgXsCa/Tqn04ZVbGs3Dp98BBxFZq6wEAvDl4w+G4/PwZ8UMy4=
X-Received: by 2002:a05:6830:22e4:: with SMTP id t4mr19081521otc.23.1606776565150;
 Mon, 30 Nov 2020 14:49:25 -0800 (PST)
MIME-Version: 1.0
References: <20201124193824.1118741-1-lee.jones@linaro.org> <20201124193824.1118741-34-lee.jones@linaro.org>
In-Reply-To: <20201124193824.1118741-34-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 30 Nov 2020 17:49:14 -0500
Message-ID: <CADnq5_PW+aNfEskumWeChATQwvXOOdXVXQRixMvBh3WJhaBekQ@mail.gmail.com>
Subject: Re: [PATCH 33/40] drm/amd/amdgpu/vcn_v3_0: Remove unused variable
 'direct_poll' from 'vcn_v3_0_start_sriov()'
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

On Tue, Nov 24, 2020 at 2:45 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c: In function =E2=80=98vcn_v3_0_sta=
rt_sriov=E2=80=99:
>  drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c:1242:3: warning: variable =E2=80=
=98direct_poll=E2=80=99 set but not used [-Wunused-but-set-variable]
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
>  drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v3_0.c
> index c5e0a531cabaf..e05af69651723 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -1238,8 +1238,6 @@ static int vcn_v3_0_start_sriov(struct amdgpu_devic=
e *adev)
>                 direct_wt =3D { {0} };
>         struct mmsch_v3_0_cmd_direct_read_modify_write
>                 direct_rd_mod_wt =3D { {0} };
> -       struct mmsch_v3_0_cmd_direct_polling
> -               direct_poll =3D { {0} };
>         struct mmsch_v3_0_cmd_end end =3D { {0} };
>         struct mmsch_v3_0_init_header header;
>
> @@ -1247,8 +1245,6 @@ static int vcn_v3_0_start_sriov(struct amdgpu_devic=
e *adev)
>                 MMSCH_COMMAND__DIRECT_REG_WRITE;
>         direct_rd_mod_wt.cmd_header.command_type =3D
>                 MMSCH_COMMAND__DIRECT_REG_READ_MODIFY_WRITE;
> -       direct_poll.cmd_header.command_type =3D
> -               MMSCH_COMMAND__DIRECT_REG_POLLING;
>         end.cmd_header.command_type =3D
>                 MMSCH_COMMAND__END;
>
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
