Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE5A2C9255
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 00:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbgK3XQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 18:16:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726737AbgK3XQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 18:16:57 -0500
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61EA5C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 15:16:17 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id n12so13080573otk.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 15:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WoziKHC+v4Z3OAENXM/ouuGFrIDPeNU+vHY9PKFX1EM=;
        b=Pmy0R54X8eY3knO6XtefsNf8EC9w4xiJxLjtgN5Tp6Vhq/RY8OyUihEHnHGfSTxzqX
         JPqwtrF2ZdRDapeZMAiWyQ2Dysy9uI1WoxNHoGszY5iXvKvUOx9GQOWAjMUpo6IITdBN
         ynHDBk2ntelaAUmkczLDpSO1I/niJf8Ceg1taGPQ/xhpMZisbzpqjHKkZ2zHilkTH9iR
         9dtmLZfbWbJvFDVkHnBwmxkvr/xzSLiyMrzAPUpvqBv47gNYJyyhy2eJYrLkwhO8mEjA
         lLQeoC5TWcxbRPXziaOI8q63Omvxx0xhgDyJHnYjThuDwMFby1GNLfD+ZCElOvyeUXKT
         qskw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WoziKHC+v4Z3OAENXM/ouuGFrIDPeNU+vHY9PKFX1EM=;
        b=CUh0XcxWsT1gW2LgWto1P2UYKAs6DZl08IXkhK7baJiZiXYAKH0I1SwbvcE7vpWSgk
         jCwh19j4/CwxfjsesoVzqyBHRET46mltE5I9r8elahDRup+Mk5qVtPGCNZWfpTbUOFLz
         fYJnuBTkHvI37trs/wFAjZPhk6QAt7OvKzk/i/yfJhM2iGeSdxxRJRquwfFAZPv97xTd
         X1R/Ggj0FatOLvjR6YSSazniUOq/BJ5mORTkTdGzhu/Vi5LIlFBEkKb1GFQYx14Z+9Bf
         T51+yZoM8Z6is5/QdJWXnG0XNVAsNKpQUT9RMjCR7+VhkY0FoN1YyWly4Nz4rDNnaQuN
         QN0A==
X-Gm-Message-State: AOAM531hDVS2cLmdeW2uDZNAg3abGeI7zifjaTCpMr9vv5QOSrWinq26
        gMi/qI002yXWIvMci0lFMAcaCSge2Ds4K8I7Q2c=
X-Google-Smtp-Source: ABdhPJzppF+6OtMTgVzZ9oC0mWh6FYFcWr0qeCVxeAKLpnIGdZmnV2XdLi5F60mTJbI9WFpvP4nD9Tj8gx2MTKQXwEA=
X-Received: by 2002:a9d:4713:: with SMTP id a19mr19346501otf.132.1606778176787;
 Mon, 30 Nov 2020 15:16:16 -0800 (PST)
MIME-Version: 1.0
References: <20201126134240.3214176-1-lee.jones@linaro.org> <20201126134240.3214176-5-lee.jones@linaro.org>
In-Reply-To: <20201126134240.3214176-5-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 30 Nov 2020 18:16:05 -0500
Message-ID: <CADnq5_P3Rc+UVH1wwgb0xNN4YkhqzBucZK=EMYOdfPt3FccFZA@mail.gmail.com>
Subject: Re: [PATCH 04/40] drm/amd/pm/powerplay/smumgr/iceland_smumgr: Make
 function called by reference static
To:     Lee Jones <lee.jones@linaro.org>
Cc:     David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Huang Rui <ray.huang@amd.com>,
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
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/iceland_smumgr.c:2085:=
5: warning: no previous prototype for =E2=80=98iceland_thermal_setup_fan_ta=
ble=E2=80=99 [-Wmissing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/iceland_smumgr.c: In f=
unction =E2=80=98iceland_thermal_setup_fan_table=E2=80=99:
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/iceland_smumgr.c:2093:=
6: warning: variable =E2=80=98res=E2=80=99 set but not used [-Wunused-but-s=
et-variable]
>
> Cc: Evan Quan <evan.quan@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Huang Rui <ray.huang@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/pm/powerplay/smumgr/iceland_smumgr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/iceland_smumgr.c b/d=
rivers/gpu/drm/amd/pm/powerplay/smumgr/iceland_smumgr.c
> index 431ad2fd38df1..6a0f581de999b 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/iceland_smumgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/iceland_smumgr.c
> @@ -2082,7 +2082,7 @@ static int iceland_init_smc_table(struct pp_hwmgr *=
hwmgr)
>         return 0;
>  }
>
> -int iceland_thermal_setup_fan_table(struct pp_hwmgr *hwmgr)
> +static int iceland_thermal_setup_fan_table(struct pp_hwmgr *hwmgr)
>  {
>         struct smu7_smumgr *smu7_data =3D (struct smu7_smumgr *)(hwmgr->s=
mu_backend);
>         SMU71_Discrete_FanTable fan_table =3D { FDO_MODE_HARDWARE };
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
