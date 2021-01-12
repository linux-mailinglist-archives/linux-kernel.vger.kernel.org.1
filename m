Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07A8A2F3F66
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:46:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438214AbhALWQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 17:16:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436976AbhALWPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 17:15:36 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E99C0C061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 14:14:55 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id x13so4054676oic.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 14:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mgU5jkLsPTxf7PjvzoVb968S/d/btYMMsecHfiFbgnQ=;
        b=SLfTxXfiNSmIywoBUgkSSVTP7YVFGG2QGXJT22GiWycCWedrsEUjcZ5K/MQzjx+ycI
         T7EXLjC4Eg2Px3Hk4JYmemIN8ROwHpXlnsQxomhQND0quXx0XQBSBqXKelj4IDypCqMW
         okmMo3Xqq1gF5tYkB8Zq3G6ruThIOvkQjleIq/mJX4CLKtkIifaQEiSjq5f2dcvYuU4y
         0mlSJQNb4NTcw4PfCi57r/qQICtx0Hwq6t3tIulFNvu8aAv711ryGoJuHkatBdYJ/l6j
         BX2HcGjiuDGvNdUzDyzp6IFimXbyqe5PqChLfBXif+acOH8wSZ4NPXROcgjXhKjxDb8p
         tomQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mgU5jkLsPTxf7PjvzoVb968S/d/btYMMsecHfiFbgnQ=;
        b=A7rNeYlMC+11o0UdYBpC27I4v9XWvDy5qQTVkXdsq89flLdzlgjDSt2tEXdNC1gOju
         2+0cdHY5WsmrfvWUO6iRFIcj4eR3bBkZc6AuJuLn46DWO/F7AZJ3+OmZSlm+u50EkGPe
         SX1QQG385aojcv74Bh5RsKgGfQBiNtMpZ5eaHFUGF/G1Few03mSQQCkd2KyksuFZu86j
         2QoD5lXKr/UMhLzrRvxwSxwO1W7EunUcx02v8YhTjdOUi+DGxsq9EsSVPMBAFrC4yTOZ
         H0Z6nZOC7NoFUXL2RCeAFLdcq++XWIJoYj1sSeU+tckbiUCsGAjgBD4/WN85UAisklZY
         lU8g==
X-Gm-Message-State: AOAM530lZdhdGkbHxPTy3nVEg6OsOMqf76NLaHHhcJPpm5spqb6DZkWC
        TPn2swdWupNvy8sm8qtSuJKg4BqoLUdVN0tXeqM=
X-Google-Smtp-Source: ABdhPJzNkqC3YkrL9KY0P3P5EnFnUOd5nlAzmlvic7hUx5DKSOy0ZUhYY/iGLcG/F4erX5sLzTr0o8N+AQFxWt10MZs=
X-Received: by 2002:aca:4f97:: with SMTP id d145mr785715oib.123.1610489695373;
 Tue, 12 Jan 2021 14:14:55 -0800 (PST)
MIME-Version: 1.0
References: <20210111191926.3688443-1-lee.jones@linaro.org> <20210111191926.3688443-17-lee.jones@linaro.org>
In-Reply-To: <20210111191926.3688443-17-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 12 Jan 2021 17:14:40 -0500
Message-ID: <CADnq5_NOmrELAah=Qt37rLQeW05RCEmmnhLDfNwAh8mpkybJyQ@mail.gmail.com>
Subject: Re: [PATCH 16/40] drm/amd/display/dc/dce120/dce120_timing_generator:
 Demote non-kerneldoc headers
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

On Mon, Jan 11, 2021 at 2:20 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_timing_generator.=
c:602:13: warning: =E2=80=98dce120_timing_generator_get_position=E2=80=99 d=
efined but not used [-Wunused-function]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_timing_generator.=
c:73: warning: Cannot understand  *****************************************=
************************************
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce120/dce120_timing_generator.=
c:593: warning: Cannot understand  ****************************************=
*************************************
>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied.  Thanks!

Alex

> ---
>  .../gpu/drm/amd/display/dc/dce120/dce120_timing_generator.c   | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce120/dce120_timing_generato=
r.c b/drivers/gpu/drm/amd/display/dc/dce120/dce120_timing_generator.c
> index ebc7d61e8bf36..d02ecb983c9cd 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce120/dce120_timing_generator.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce120/dce120_timing_generator.c
> @@ -69,7 +69,7 @@
>  #define CRTC_REG_SET_3(reg, field1, val1, field2, val2, field3, val3)  \
>                 CRTC_REG_SET_N(reg, 3, FD(reg##__##field1), val1, FD(reg#=
#__##field2), val2, FD(reg##__##field3), val3)
>
> -/**
> +/*
>   ***********************************************************************=
******
>   *  Function: is_in_vertical_blank
>   *
> @@ -589,7 +589,7 @@ static void dce120_timing_generator_set_drr(
>         }
>  }
>
> -/**
> +/*
>   ***********************************************************************=
******
>   *  Function: dce120_timing_generator_get_position
>   *
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
