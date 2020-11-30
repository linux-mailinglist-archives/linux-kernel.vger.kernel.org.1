Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 898A62C92BA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 00:37:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388989AbgK3Xet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 18:34:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388951AbgK3Xes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 18:34:48 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F8CC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 15:34:07 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id z23so9434086oti.13
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 15:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PeewXy7NC7XXblYMxEWdawjkTVhWy4LJb2cZR8KPRgU=;
        b=ryNpJxgGgmPAR25f2mBd4A2HVAqiC4jjs1MlZnbBf9PfQn2NiNQLGpMA0a7MSZewPq
         d3CBIhmvc2Exao/qyM9B/GNxyo1GrnuxJ7gW21ZirtiXN3dkdXt+tqfjaVuTIHPZUv6j
         Nd3MyEHmNHFZCh+MkWJklXOnhcGxp0esx4qnFaOteCsB6IFOoDWgcsmffm/aCJpsMc2V
         jpZWX5VD1x4cZYigjtG/ktXhbwmn1lUx0jLEq2SSK76rniR+tDSVH0kn4/KsdbLtXzM9
         TmZhVWpWZ3L22hf1Bwv5fYKlwMjSvy0R0lJ7wqb5JQiQcoDzQybwFpoZGTSCnVyEzLvY
         opSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PeewXy7NC7XXblYMxEWdawjkTVhWy4LJb2cZR8KPRgU=;
        b=o6zfKfpFv1mvb+I2LSnD1m2OzrGT2UZ8NkuY44CBOFdHWIEHRuIiWYvu1B8yo8/cGO
         VjMRTchW8t/HVD3CWaG0lFRahGr5fyLmfkJlH5cd72B/8L3Pe7Xe0rhD5YHfs71PBTH1
         uNghB3mcBhVXMqlsDRM17LQOCF2aEGprqam89GJ63/sdVacoOEKra+Kw+pq/9U0j5SSL
         Lb+cGPW8PZFRZTstzlzkpMzLvO+6B4JsIOsrbdIQ1OnIEPAKQqh8UjBUc0ghuf2V4FP6
         2Gdy8Xwt4EC6JLIq8vg8/zQOlw881Risr9RTBD/j16XytUoAFE7uQaeq2oMvFDpVzGwg
         rFUA==
X-Gm-Message-State: AOAM530Us0LbBgn4JBKLq08AHWUBdj5gsIBIhprTn3jnsQS7cKkGVu0B
        DOoVLYEXsksxeQN2aaRo8USKACMsg9fy6dWvqNY=
X-Google-Smtp-Source: ABdhPJzbM+ERYLAt2H3fxGgdW4jJgjNLIKnHBnoHDRo0SfL7na09rjAyUilpsPkvBfuszsm/jzRc/smso1HH9R/7LUM=
X-Received: by 2002:a9d:5388:: with SMTP id w8mr18962424otg.311.1606779247247;
 Mon, 30 Nov 2020 15:34:07 -0800 (PST)
MIME-Version: 1.0
References: <20201126134240.3214176-1-lee.jones@linaro.org> <20201126134240.3214176-14-lee.jones@linaro.org>
In-Reply-To: <20201126134240.3214176-14-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 30 Nov 2020 18:33:55 -0500
Message-ID: <CADnq5_P=+P6MVzD0VTV9qYKAi=4KGvaBkSrEbwQVvUfbpSaivQ@mail.gmail.com>
Subject: Re: [PATCH 13/40] drm/amd/pm/powerplay/hwmgr/hwmgr: Move
 'smu7_init_function_pointers()'s prototype to header
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
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_hwmgr.c:5696:5: wa=
rning: no previous prototype for =E2=80=98smu7_init_function_pointers=E2=80=
=99 [-Wmissing-prototypes]
>  5696 | int smu7_init_function_pointers(struct pp_hwmgr *hwmgr)
>  | ^~~~~~~~~~~~~~~~~~~~~~~~~~~
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
>  drivers/gpu/drm/amd/pm/inc/hwmgr.h             | 1 +
>  drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c | 1 -
>  2 files changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/inc/hwmgr.h b/drivers/gpu/drm/amd/pm/=
inc/hwmgr.h
> index 0e22cba3ce3a6..393e4e76a8961 100644
> --- a/drivers/gpu/drm/amd/pm/inc/hwmgr.h
> +++ b/drivers/gpu/drm/amd/pm/inc/hwmgr.h
> @@ -828,6 +828,7 @@ int hwmgr_handle_task(struct pp_hwmgr *hwmgr,
>
>  #define PHM_ENTIRE_REGISTER_MASK 0xFFFFFFFFU
>
> +int smu7_init_function_pointers(struct pp_hwmgr *hwmgr);
>  int smu8_init_function_pointers(struct pp_hwmgr *hwmgr);
>
>  #endif /* _HWMGR_H_ */
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c b/drivers/gpu=
/drm/amd/pm/powerplay/hwmgr/hwmgr.c
> index ec17a3e63ea02..7999091cca16e 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c
> @@ -46,7 +46,6 @@ extern const struct pp_smumgr_func vega12_smu_funcs;
>  extern const struct pp_smumgr_func smu10_smu_funcs;
>  extern const struct pp_smumgr_func vega20_smu_funcs;
>
> -extern int smu7_init_function_pointers(struct pp_hwmgr *hwmgr);
>  extern int vega10_hwmgr_init(struct pp_hwmgr *hwmgr);
>  extern int vega12_hwmgr_init(struct pp_hwmgr *hwmgr);
>  extern int vega20_hwmgr_init(struct pp_hwmgr *hwmgr);
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
