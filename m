Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC04A2F671F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 18:15:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728307AbhANRNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 12:13:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728033AbhANRNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 12:13:24 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19509C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:12:44 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id s75so6655094oih.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=y5nzwxmDDL8KoR6FUdEDHJ+6iXx4WrUEgeA2us+HBBg=;
        b=JnACE68nragtnK2wSws6wgqbx1u3nM2KwBgQMrbZf0m/eZPqP2M/pvzXXw16i/trnb
         2gVO5SJ+p1B1x2MAcRhOX4vBcirxMCHg2S6AgnP3H6cCsa/3v3NDfEQR2gzdPww5eamn
         gCTdD5CRGKPq/eSr+Qpnw/pNpnuKPOirgI5o/VMOvcC4hB7NFnscHxAL5t75EvKwk3RP
         BzuRYqsRPCDYATOyDWdXFoHeM7GmABNqPRAyVial0p4QBa3pw4adafd/75jzkkLfu3xL
         er0N4yszk8zLG1IvpwGh9wlEWo0NWJgxv3l+g/eEkoVyAd+3qBFzNrwG+LIvDSWx+96m
         mfHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=y5nzwxmDDL8KoR6FUdEDHJ+6iXx4WrUEgeA2us+HBBg=;
        b=SNd8o6fRcsM39yOaLlZPbywHlfYivuP7mAO8L8jHy3QcazxIyLEmc/xoOsQeX0VqWU
         P56rLRwtZwuHAkNKyDAkFV8ubtD75O4JgumpvHVmk5YT5Esh2xoJbj8dzaLlRiSjyckY
         LEUkFnJRChAoIkjpg3OeSTv/xqYsRBnz0sdUUfetavmaz62Fuejv8Ar7/syc8gAMsdvI
         EP6AAc5dPPVwTxXcopP4w3qz4lpQbWvcMxU8LHIyMVNfesj2DYH3l00bDhoz0bcJwqwi
         GM7zZ6iN9+kqo2Aa5ONbKpK2wNes8DqtPhT0acuxWjxSo3M6QkPrw5v9MowDV4VotMdL
         gQ0w==
X-Gm-Message-State: AOAM533hL0keubFPh6JVGJUd70Z6zA+nDbXyTbxs2JyznICTj17nic+L
        KYArZj9+qJy1LwsE2lmjrh7xfFIE3BW9IEtFSqnua8b2
X-Google-Smtp-Source: ABdhPJwsyt2ceX5V5TWAh6XqwKrlbqZ0hwfqJdifmjPxMJTdBHCLOPkLsQ0U16bA2IEvBjfBEaMI8UowJArYNwrZt8c=
X-Received: by 2002:a54:4083:: with SMTP id i3mr3125212oii.120.1610644363569;
 Thu, 14 Jan 2021 09:12:43 -0800 (PST)
MIME-Version: 1.0
References: <20210113080752.1003793-1-lee.jones@linaro.org> <20210113080752.1003793-13-lee.jones@linaro.org>
In-Reply-To: <20210113080752.1003793-13-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 14 Jan 2021 12:12:32 -0500
Message-ID: <CADnq5_O4vTf45LPxLGQdKj=nQdk4aegF=mciQV8=rK3ahTvVdg@mail.gmail.com>
Subject: Re: [PATCH 12/30] drm/amd/display/dc/dce100/dce100_resource: Include
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
>  In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dce100/dc=
e100_resource.c:54:
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce100/dce100_resource.c:537:3:=
 note: in expansion of macro =E2=80=98MI_DCE8_MASK_SH_LIST=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce100/dce100_resource.c:537:3:=
 note: in expansion of macro =E2=80=98MI_DCE8_MASK_SH_LIST=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce100/dce100_resource.c:542:3:=
 note: in expansion of macro =E2=80=98MI_DCE8_MASK_SH_LIST=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce100/dce100_resource.c:542:3:=
 note: in expansion of macro =E2=80=98MI_DCE8_MASK_SH_LIST=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce100/dce100_resource.c:547:2:=
 note: in expansion of macro =E2=80=98DCE10_AUX_MASK_SH_LIST=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce100/dce100_resource.c:547:2:=
 note: in expansion of macro =E2=80=98DCE10_AUX_MASK_SH_LIST=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce100/dce100_resource.c:551:2:=
 note: in expansion of macro =E2=80=98DCE10_AUX_MASK_SH_LIST=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce100/dce100_resource.c:551:2:=
 note: in expansion of macro =E2=80=98DCE10_AUX_MASK_SH_LIST=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce100/dce100_resource.c:889:16=
: warning: no previous prototype for =E2=80=98dce100_add_stream_to_ctx=E2=
=80=99 [-Wmissing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce100/dce100_resource.c:916:16=
: warning: no previous prototype for =E2=80=98dce100_validate_plane=E2=80=
=99 [-Wmissing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce100/dce100_resource.c:925:24=
: warning: no previous prototype for =E2=80=98dce100_find_first_free_match_=
stream_enc_for_link=E2=80=99 [-Wmissing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce100/dce100_resource.c:1156:2=
3: warning: no previous prototype for =E2=80=98dce100_create_resource_pool=
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
>  drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c b/dr=
ivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c
> index 648169086bcf8..635ef0e7c7826 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c
> @@ -58,6 +58,8 @@
>  #include "dce/dce_abm.h"
>  #include "dce/dce_i2c.h"
>
> +#include "dce100_resource.h"
> +
>  #ifndef mmMC_HUB_RDREQ_DMIF_LIMIT
>  #include "gmc/gmc_8_2_d.h"
>  #include "gmc/gmc_8_2_sh_mask.h"
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
