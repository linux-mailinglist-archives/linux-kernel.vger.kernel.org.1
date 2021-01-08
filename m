Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7952F2EFA1A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 22:17:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729642AbhAHVQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 16:16:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727845AbhAHVQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 16:16:25 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC2BC061574
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 13:15:44 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id b24so11111311otj.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 13:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RdHU0V+l/5mQjoD9Rkq0FokpPahQQiZHJdwaPeqIFOw=;
        b=N/9q3tnXNvoXj9NNSpNsp/WqUeWVnlXZmfdK5XKDodktfsDUrcKtMMoGr3+ipiy+kJ
         LSIfJyZzXDXtETPGIqnqGxqqHpxB9795RthL27QqsKOxtHlej07Jxk+VIk02x2vd5hLJ
         te5c3x9ZnSsi4p3D4P/7sBKCCs2vt2qB8JSpQiaJa0FoKFMLS+4/Hyla3wFQ6nKjBGuc
         oWwf64peHkELSW1QZsJRj+JSDPUuNtgOdYtDy1whEUtvKRbxmLJTLlY5EfEugO4y/awo
         8RjDEf2IScxGiMTzkQXE4agUt3YLLGoMaCW9jB+VtO5/0827gEWrmQQimdkjHRu1iwBZ
         sMeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RdHU0V+l/5mQjoD9Rkq0FokpPahQQiZHJdwaPeqIFOw=;
        b=JQ0co9Qm2Z2jowuE629ECXtsH/ogI47xy17RHKGXe/dCbPol1kNxwfvGGafPdaW0/3
         wY+27PvORB2oRoDrYuFYUjpDHtH+4fuQ5A7D3ZnYWb+iyGJ6RIIt63CG1aajkqpq5Tge
         69/KeCWComIQEgNnOg39YUeY2G3v6PLq0hY0+2sOM5MR0672gwOPEZg8jxbvOoWbwSjn
         sdXFFwMmqlRf5wk9cWf/rQjWA30R4r2uHb5+Ii744kxlGehwMCQZQaqA9k1+Qqa4hhE1
         7cJfPNJNYvEa8MRDskFbgWoCnqQenqFlDgSxu/cDy/e5Rg3wbzx7nqzPStuXjY1YgMJT
         kG8A==
X-Gm-Message-State: AOAM531BkIsRyrDQho2x3/pRwdZ+d8Z695OoatCO6bXqUJUrNd33az47
        Oodlwp0Pn8+sHMtheGALXvstCa0waOWdI/+AZUc=
X-Google-Smtp-Source: ABdhPJxUgRAka2RPKA+U8s8ytzVCIDZKjm/nFhiLdVPVHrGZ4YUvczYtQ+lBCAP0taI+zW0Tsik0GJrHRn2GsSUX9Zg=
X-Received: by 2002:a05:6830:1b7b:: with SMTP id d27mr4083848ote.132.1610140544373;
 Fri, 08 Jan 2021 13:15:44 -0800 (PST)
MIME-Version: 1.0
References: <20210108201457.3078600-1-lee.jones@linaro.org> <20210108201457.3078600-28-lee.jones@linaro.org>
In-Reply-To: <20210108201457.3078600-28-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 8 Jan 2021 16:15:33 -0500
Message-ID: <CADnq5_P=6PbbOLYE6PiXP1_J9weqZgrKRwGU3Q7ZsRnx7BX2eA@mail.gmail.com>
Subject: Re: [PATCH 27/40] drm/amd/pm/powerplay/hwmgr/vega10_hwmgr: Fix worthy
 function headers, demote barely documented one
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
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega10_hwmgr.c:1556: wa=
rning: Function parameter or member 'acg_freq' not described in 'vega10_pop=
ulate_single_gfx_level'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega10_hwmgr.c:1621: wa=
rning: Function parameter or member 'current_soc_did' not described in 'veg=
a10_populate_single_soc_level'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega10_hwmgr.c:1621: wa=
rning: Function parameter or member 'current_vol_index' not described in 'v=
ega10_populate_single_soc_level'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega10_hwmgr.c:1621: wa=
rning: Excess function parameter 'current_socclk_level' description in 'veg=
a10_populate_single_soc_level'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega10_hwmgr.c:1757: wa=
rning: Function parameter or member 'current_mem_vid' not described in 'veg=
a10_populate_single_memory_level'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega10_hwmgr.c:1757: wa=
rning: Function parameter or member 'current_memclk_level' not described in=
 'vega10_populate_single_memory_level'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega10_hwmgr.c:1757: wa=
rning: Function parameter or member 'current_mem_soc_vind' not described in=
 'vega10_populate_single_memory_level'
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega10_hwmgr.c:2871: wa=
rning: Function parameter or member 'bitmap' not described in 'vega10_start=
_dpm'
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
>  drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c b/driv=
ers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> index da470462d6e2c..29c99642d22d4 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> @@ -1549,6 +1549,7 @@ static int vega10_populate_smc_link_levels(struct p=
p_hwmgr *hwmgr)
>   * @hwmgr:      the address of the hardware manager
>   * @gfx_clock:  the GFX clock to use to populate the structure.
>   * @current_gfxclk_level:  location in PPTable for the SMC GFXCLK struct=
ure.
> + * @acg_freq:   ACG frequenty to return (MHz)
>   */
>  static int vega10_populate_single_gfx_level(struct pp_hwmgr *hwmgr,
>                 uint32_t gfx_clock, PllSetting_t *current_gfxclk_level,
> @@ -1612,7 +1613,8 @@ static int vega10_populate_single_gfx_level(struct =
pp_hwmgr *hwmgr,
>   *
>   * @hwmgr:     the address of the hardware manager.
>   * @soc_clock: the SOC clock to use to populate the structure.
> - * @current_socclk_level: location in PPTable for the SMC SOCCLK structu=
re.
> + * @current_soc_did:   DFS divider to pass back to caller
> + * @current_vol_index: index of current VDD to pass back to caller
>   * return:      0 on success
>   */
>  static int vega10_populate_single_soc_level(struct pp_hwmgr *hwmgr,
> @@ -1744,7 +1746,7 @@ static void vega10_populate_vddc_soc_levels(struct =
pp_hwmgr *hwmgr)
>         }
>  }
>
> -/**
> +/*
>   * Populates single SMC GFXCLK structure using the provided clock.
>   *
>   * @hwmgr:     the address of the hardware manager.
> @@ -2863,8 +2865,8 @@ static int vega10_stop_dpm(struct pp_hwmgr *hwmgr, =
uint32_t bitmap)
>  /**
>   * Tell SMC to enabled the supported DPMs.
>   *
> - * @hwmgr:  the address of the powerplay hardware manager.
> - * @bitmap  bitmap for the features to enabled.
> + * @hwmgr:   the address of the powerplay hardware manager.
> + * @bitmap:  bitmap for the features to enabled.
>   * return:  0 on at least one DPM is successfully enabled.
>   */
>  static int vega10_start_dpm(struct pp_hwmgr *hwmgr, uint32_t bitmap)
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
