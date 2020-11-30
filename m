Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61A572C91E5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 00:03:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388858AbgK3XB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 18:01:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbgK3XB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 18:01:29 -0500
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D8CC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 15:00:43 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id f48so4512792otf.8
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 15:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=c2OtGSBC7TESexKrUVyZrfSsC93ikbUp2j1aDogad7I=;
        b=CiV20Ruuz3z0SrYSz7pHUGehHyKwapSqeMEMA4JshZT2zlNhnqiHgOvZqhDZjbRaqQ
         F7hbbNFtQxwgU2wqFEXPS6dQG5h8KdEKVuVEDqodBdkabVb1eNFP/wDado4lYZQSL6KV
         fr9WAMLKRb/nA74/1Olai+S7rgM6xthhBJlqqHTK5MXZNnpoPuYRfKsn2z4mAGOGtgkY
         8upoVTAW7LwIdDEHOx3P3cTcs3ioZGe3UChp/uiK8k1UwNgBUXHo8+lDhVsn8vT37Y7T
         Z+h1pVWsfyHba5exvH8vebXsTErreVpvzAqx539uN6gMs1GPMNeybpeNZWl7+BL3dHui
         28Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=c2OtGSBC7TESexKrUVyZrfSsC93ikbUp2j1aDogad7I=;
        b=oeagYFbCLEg6N8oJ6mzganH6bAN/9gpUpNDXmgNlTdt5m1E+moMRQbJHd1zNBMybWG
         l8djGq0ZprRAM6MLbTec6rB/wAFkcbRoAO9zQUEiYjIGCJkZU15MqVay/lP5P6m5Xp4I
         Ih8rDdavs6BMhfDfC8aTfncBIGDzb6Tg3sEs0SKIiYdokUjWnWjb9O0IhLG851bDJeqx
         drTcvU3EthN9Wm4OeevMeUbb/GW/rluY0MTlrigKfT1mGcm9qQs59wTia+bdoMC5L71f
         gzwaYs3xxE89q19I33lt/Z23mAbNk1n3U5XLfaPC/Zr4F0Z17l7XVy5NUwhXPCNzdi/8
         K4Zw==
X-Gm-Message-State: AOAM531K2IN7gbGw8sO/o6J3Pgb3NrGJEWmhCZp9CDk0zmnvp/faHoMQ
        /Q+mwPLICLQF5LsfX27xMTJBEaFrtuNC80+nWM8=
X-Google-Smtp-Source: ABdhPJwgNfM7b2UZgVPJnnlUV4BdyS78F8kAPr5fNml5z3/Al2+I/kobGylistYkJYci2iMC7fQizizRoOiPVQzy6JQ=
X-Received: by 2002:a9d:5388:: with SMTP id w8mr18849654otg.311.1606777241064;
 Mon, 30 Nov 2020 15:00:41 -0800 (PST)
MIME-Version: 1.0
References: <20201124193824.1118741-1-lee.jones@linaro.org> <20201124193824.1118741-38-lee.jones@linaro.org>
In-Reply-To: <20201124193824.1118741-38-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 30 Nov 2020 18:00:29 -0500
Message-ID: <CADnq5_MiLffHWwF4tMh_y3CBkjcrH5ixZw-pwEyd=RBosrwZwA@mail.gmail.com>
Subject: Re: [PATCH 37/40] drm/amd/pm/swsmu/smu12/renoir_ppt: Demote
 kernel-doc formatting abuse
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
>  drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gp=
u/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> index 46c44f0abdfb8..d3641a8ed99c0 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> @@ -170,7 +170,7 @@ static int renoir_init_smc_tables(struct smu_context =
*smu)
>         return -ENOMEM;
>  }
>
> -/**
> +/*
>   * This interface just for getting uclk ultimate freq and should't intro=
duce
>   * other likewise function result in overmuch callback.
>   */
> @@ -656,7 +656,7 @@ static int renoir_get_power(struct smu_context *smu, =
uint32_t *value)
>         return 0;
>  }
>
> -/**
> +/*
>   * This interface get dpm clock table for dc
>   */
>  static int renoir_get_dpm_clock_table(struct smu_context *smu, struct dp=
m_clocks *clock_table)
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
