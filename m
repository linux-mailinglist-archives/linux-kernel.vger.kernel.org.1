Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11B172C93A0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 01:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730657AbgLAAGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 19:06:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbgLAAGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 19:06:02 -0500
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA90C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 16:05:22 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id h3so16252210oie.8
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 16:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7BTne8SIxbBFHAj//gRT0I7jmTcVfU7zja0kcb89Maw=;
        b=XwFwFP5VKQvAjlOlCnUb9C0k+8u7IQBdEwENOiKjGpYUhhJ2ARUNhURKaKtQxncV8G
         q/XKFGS2/hlRVXidDfvt1MzIYWF5Hix2RSQUw0gG9kHVmHh6KW1wF40+RzC/IYDcbxxw
         fNAZE4lwbLIhYEPU/BpAOX6i2h93EFQZPoMe6tD8EiHQZmglaKiw04gez3McFgLYPwEs
         QDcc2tLuuwQlWIRHSTp8Sj1P2GtzB5OJAafErrvH+yIGAXKej14XyU35vhlzl/iWDdIF
         uHcIwq5suzy5Zh7NR+XQxoKctJ4lnz9n6eAUO6s/UZhydqTP0QTELXtwkdrJp5qM/ciS
         BdMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7BTne8SIxbBFHAj//gRT0I7jmTcVfU7zja0kcb89Maw=;
        b=JASFncmxa3ushqb+5AhxKplbHq53HwK1/xDGHkXFq8CfAAHGIkslsZme1tQ7Nplk+N
         DDXCsSOj302q3MrPCwpaoymelSK7ti+Iif6bO8kwqZZ2Bln8rIu2Dq8fpsf+XDC4uULI
         pjnBl0d1mM3hg2PEZpaLlunqoqLDW1KiYwgR1wTXYcxq+xLc6bi8DxOIAuUoMp8eG839
         JpjIU4keJedB0U7ZrKgjcPOSDc/hTMqq7LPiF7R8nAz9rGx7co/yVwPYY1EqeJ9Y8QJR
         HsN2W5U0ak+KJLHU1FkNEw3NJAuWKPfpwKOFORwo9Bz64juHjZqf7SdSkF+F6CagDtJa
         dHNA==
X-Gm-Message-State: AOAM532o7lxOaBe3cHcFj1haReKv6s2Y1c1qsD0i0PHixu4RB9G93bmx
        fR1Ml9BrWhw+vazAYBFwacPJ7JgBWQLdSS3z3OM=
X-Google-Smtp-Source: ABdhPJxVHgdB7XwPl5ai+49mqjjJlX1RpCRFPnKeMadWF7tL8axXfV/9Pz5hvPub5yxk7sXGVF7zHrhDmiNr5sXYJE4=
X-Received: by 2002:aca:f50e:: with SMTP id t14mr30258oih.123.1606781121640;
 Mon, 30 Nov 2020 16:05:21 -0800 (PST)
MIME-Version: 1.0
References: <20201126134240.3214176-1-lee.jones@linaro.org> <20201126134240.3214176-38-lee.jones@linaro.org>
In-Reply-To: <20201126134240.3214176-38-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 30 Nov 2020 19:05:10 -0500
Message-ID: <CADnq5_NBWdiQm32886bsGCqSpJFYe5R+Cm7pgLTXyNYBwxNAGA@mail.gmail.com>
Subject: Re: [PATCH 37/40] drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu: Remove
 unused function 'pp_nv_set_pme_wa_enable()'
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

On Thu, Nov 26, 2020 at 8:44 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_pp_smu.c:664:2=
0: warning: no previous prototype for =E2=80=98pp_nv_set_pme_wa_enable=E2=
=80=99 [-Wmissing-prototypes]
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
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c | 16 ----------------
>  1 file changed, 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c b/d=
rivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
> index ac0a0539854ef..607ec09994456 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
> @@ -661,22 +661,6 @@ static enum pp_smu_status pp_nv_set_wm_ranges(struct=
 pp_smu *pp,
>         return PP_SMU_RESULT_OK;
>  }
>
> -static enum pp_smu_status pp_nv_set_pme_wa_enable(struct pp_smu *pp)
> -{
> -       const struct dc_context *ctx =3D pp->dm;
> -       struct amdgpu_device *adev =3D ctx->driver_context;
> -       struct smu_context *smu =3D &adev->smu;
> -
> -       if (!smu->ppt_funcs)
> -               return PP_SMU_RESULT_UNSUPPORTED;
> -
> -       /* 0: successful or smu.ppt_funcs->set_azalia_d3_pme =3D NULL;  1=
: fail */
> -       if (smu_set_azalia_d3_pme(smu))
> -               return PP_SMU_RESULT_FAIL;
> -
> -       return PP_SMU_RESULT_OK;
> -}
> -
>  static enum pp_smu_status pp_nv_set_display_count(struct pp_smu *pp, int=
 count)
>  {
>         const struct dc_context *ctx =3D pp->dm;
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
