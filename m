Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42B412EF95B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 21:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729401AbhAHUhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 15:37:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729340AbhAHUhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 15:37:19 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 278FCC061380
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 12:36:39 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id l200so12750532oig.9
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 12:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=b9Rt82GW8KWAByvkk9obV3ZIpw1Casv9Xpm9XTSxgNs=;
        b=HXrJtALQglLUwlcIYLv0Pbm6fo7Eqd5MwfW8CipxsdU4Phc62azLX0mGKOTknkBc/k
         7nTbukE/fL/3jZWuGVCFK23DE6Bs8lb5ijmbBRkbpo6h0KJuwY01vKWaf0eV298hCOGD
         5Saz1R/TcjwL/wK27pWBeCgCFctg9UDdZMo50o+gBqxzKc4o7E0OqqvgDIIP0s6MCif/
         IZBAs/4GLJR3cO9yPbThH0DuyP53X3e59xxdYb2aAzt0NLBeGebTEWInG3o5L8eWC/AR
         N+pWh3ZkvPhhb7dpwzUXakp0m7CNBw38hTLwYQgyIiC+p0ldApfPE7DKR7KOdIik8Plq
         0Mlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=b9Rt82GW8KWAByvkk9obV3ZIpw1Casv9Xpm9XTSxgNs=;
        b=Zv6z4m7IIFZVIUhoKrO0qI1H73wJ3iXb9Tt39dYiFYl6mmZYRcPQ+KPmAY3REAYWBs
         6Dv8ospVVUFT7qt5DulO1SvSoy+XkRBf9TXUAiVdjSq29FJ+OkKdmoJn6CkPw+U2cWHx
         jop1cIJ3S1jdFT6g84LMoO+2YUfST4j7RBWxwS3RvpI1Y5iniQfdxzU5J0SwzopKjhgR
         wuRWEUnjzBzLwGmFmzB/zqenI21wlUmX1I41E4HhochcwbnbWd0L4Gdz+Dobgo/Pb0g2
         Eq17kt2fsJBVf3LZIPWrbTIL8oECUwFycuS9qZkbJ0ZwPw1Hy+DKYtAQ44+xkmeLuWwx
         1CjA==
X-Gm-Message-State: AOAM530Ii3yW5LGv1221OGJhlEthiBPk4D3vES6tDe/5B7rkj8Q1eOu7
        WeiIEHQy7M4v2jz2NWxbeYX1tNGHaB33uFV2wLU=
X-Google-Smtp-Source: ABdhPJybhF2d2ICidbN92E2NRo7ryVGnG5mjIKZVjTCsffYlCCozzKgjlHnZjBK0989Ey5syJ6aNgkcI9BG8WFHkcz0=
X-Received: by 2002:aca:6202:: with SMTP id w2mr3296602oib.5.1610138198672;
 Fri, 08 Jan 2021 12:36:38 -0800 (PST)
MIME-Version: 1.0
References: <20210108201457.3078600-1-lee.jones@linaro.org> <20210108201457.3078600-12-lee.jones@linaro.org>
In-Reply-To: <20210108201457.3078600-12-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 8 Jan 2021 15:36:27 -0500
Message-ID: <CADnq5_M=FvTBgvVkU5-s8A8-wd8APyRETdR-M__6hD=Mmnp5eg@mail.gmail.com>
Subject: Re: [PATCH 11/40] drm/amd/pm/powerplay/hwmgr/hwmgr: Move prototype
 into shared header
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

On Fri, Jan 8, 2021 at 3:15 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega10_hwmgr.c:5474:5: =
warning: no previous prototype for =E2=80=98vega10_hwmgr_init=E2=80=99 [-Wm=
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
>  drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c        | 2 +-
>  drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.h | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c b/drivers/gpu=
/drm/amd/pm/powerplay/hwmgr/hwmgr.c
> index 6a7de8b898faf..f2cef0930aa96 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c
> @@ -33,6 +33,7 @@
>  #include "ppsmc.h"
>  #include "amd_acpi.h"
>  #include "pp_psm.h"
> +#include "vega10_hwmgr.h"
>
>  extern const struct pp_smumgr_func ci_smu_funcs;
>  extern const struct pp_smumgr_func smu8_smu_funcs;
> @@ -46,7 +47,6 @@ extern const struct pp_smumgr_func vega12_smu_funcs;
>  extern const struct pp_smumgr_func smu10_smu_funcs;
>  extern const struct pp_smumgr_func vega20_smu_funcs;
>
> -extern int vega10_hwmgr_init(struct pp_hwmgr *hwmgr);
>  extern int smu10_init_function_pointers(struct pp_hwmgr *hwmgr);
>
>  static int polaris_set_asic_special_caps(struct pp_hwmgr *hwmgr);
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.h b/driv=
ers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.h
> index f752b4ad0c8ae..07c06f8c90b09 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.h
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.h
> @@ -442,5 +442,6 @@ int vega10_update_uvd_dpm(struct pp_hwmgr *hwmgr, boo=
l bgate);
>  int vega10_update_samu_dpm(struct pp_hwmgr *hwmgr, bool bgate);
>  int vega10_update_acp_dpm(struct pp_hwmgr *hwmgr, bool bgate);
>  int vega10_enable_disable_vce_dpm(struct pp_hwmgr *hwmgr, bool enable);
> +int vega10_hwmgr_init(struct pp_hwmgr *hwmgr);
>
>  #endif /* _VEGA10_HWMGR_H_ */
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
