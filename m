Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4D192C9331
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 00:51:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388987AbgK3Xvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 18:51:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388889AbgK3Xvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 18:51:40 -0500
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0000C0613D2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 15:50:59 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id j15so16222107oih.4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 15:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2ca7PVpfytP1aPxU/j7JaxFmM8F00V9fbvYGUUacr9k=;
        b=ttnDYv3OBicGp7V380L+l24bkmTquhvYef/qfRDSGKWmiY+SU7cvfUHG2Y++y+zFWz
         WnXKyBGE9yXnU/2/EVgnUcNjOjfXcFqjjUezT+t8QqOCJ7ZGnW/qg46I8c96lJC4fij5
         xjImTsd7cAdGTUjdtlrv/xNrClp1HqVkxDt/19aCERWkQvRp9LnsZ1McxuHaosDgaNO7
         YhZNowI/EuQLS83lXRQVY5BnPv0QFIMsFUCNxox+zMMmHnBtldVVclzUsSc8kMbYKhvI
         zyt8bl2z0Dxlti/o9V3PHFs5/XGt0cq9MvTS6xtRTqH642BCnyYbBz90aykczzN4WdJk
         C03A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2ca7PVpfytP1aPxU/j7JaxFmM8F00V9fbvYGUUacr9k=;
        b=NFj3tZ3lRxy/d7Ipqqp9UR/8QuXH4kfNQOkanHFMSNwoJcIFO+cykWmuXpCeIuyelR
         nPqzdNZjsP+5KTURiwW9tJXQCWWC9kZcaAr/q+Yua4kdeG876q/x51GhNn1RBDr5ZhgM
         PDX8ikI+C6BEdvKFAG0dLQFksdJeguoR5NqKUtQfCzYTcNkAJwuFKCoIvAFbLPBHUNEk
         q6lnY6PVoKytI0yWEuCvgN7Fgmv746mDeUbicFvkMCEDz44LEti32rnUfFipxGaINkUu
         qVnXlEKJObapQq7C+XO+n4fVXGWnEbcoGhv6UScYQjODBTH2olHXXjNSZebL0SH1moVr
         b4jg==
X-Gm-Message-State: AOAM532/MVVEcwziJ4z0aagwhTwmgDOO9yP4qqGygvqQr0RnhYbEA6pB
        dLigxmDtBFuHGB2uvVyycWgdmEpaI2Bo8pnDsA0=
X-Google-Smtp-Source: ABdhPJwsEAd+N0VpI7gu+4CCxBbJl4uiCP5TmE/VOSPicY6NcrNiAgVV26fqk/OXYwVj8lmQ07kr1SowZ/1KcZ4cCCA=
X-Received: by 2002:aca:f50e:: with SMTP id t14mr188996oih.123.1606780259177;
 Mon, 30 Nov 2020 15:50:59 -0800 (PST)
MIME-Version: 1.0
References: <20201126134240.3214176-1-lee.jones@linaro.org> <20201126134240.3214176-27-lee.jones@linaro.org>
In-Reply-To: <20201126134240.3214176-27-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 30 Nov 2020 18:50:47 -0500
Message-ID: <CADnq5_PR73t=pkaVpSydDGG6NO6zedopQhy6jJthQn6RJucL1w@mail.gmail.com>
Subject: Re: [PATCH 26/40] drm/amd/pm/powerplay/hwmgr/hwmgr: Move
 'vega12_hwmgr_init()'s prototype to shared header
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
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega12_hwmgr.c:2862:5: =
warning: no previous prototype for =E2=80=98vega12_hwmgr_init=E2=80=99 [-Wm=
issing-prototypes]
>  2862 | int vega12_hwmgr_init(struct pp_hwmgr *hwmgr)
>  | ^~~~~~~~~~~~~~~~~
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
> index 393e4e76a8961..499f2520b1aa3 100644
> --- a/drivers/gpu/drm/amd/pm/inc/hwmgr.h
> +++ b/drivers/gpu/drm/amd/pm/inc/hwmgr.h
> @@ -830,5 +830,6 @@ int hwmgr_handle_task(struct pp_hwmgr *hwmgr,
>
>  int smu7_init_function_pointers(struct pp_hwmgr *hwmgr);
>  int smu8_init_function_pointers(struct pp_hwmgr *hwmgr);
> +int vega12_hwmgr_init(struct pp_hwmgr *hwmgr);
>
>  #endif /* _HWMGR_H_ */
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c b/drivers/gpu=
/drm/amd/pm/powerplay/hwmgr/hwmgr.c
> index 7999091cca16e..49f8a331eb02e 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c
> @@ -47,7 +47,6 @@ extern const struct pp_smumgr_func smu10_smu_funcs;
>  extern const struct pp_smumgr_func vega20_smu_funcs;
>
>  extern int vega10_hwmgr_init(struct pp_hwmgr *hwmgr);
> -extern int vega12_hwmgr_init(struct pp_hwmgr *hwmgr);
>  extern int vega20_hwmgr_init(struct pp_hwmgr *hwmgr);
>  extern int smu10_init_function_pointers(struct pp_hwmgr *hwmgr);
>
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
