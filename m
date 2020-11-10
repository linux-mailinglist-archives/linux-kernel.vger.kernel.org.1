Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED03A2AE3BE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 23:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732598AbgKJWxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 17:53:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730254AbgKJWxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 17:53:49 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C59C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:53:49 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id 23so131028wrc.8
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vHZRYrwtaZgXO55je8F150N4Va6hou4CjPXMEe4tSEM=;
        b=GBPDmOWHHv3RXG9E2b2CYbLvP7IhPgpSFE+w9s3ACmwPVnDWsYdqZnNl2l4u2MP9W0
         8r2CKLSyJDO0QUNW3wzex8v8bEhv4ke5lgmlIXxoiOelHpdbgGYYEcbaQ37KYhQ2Nnrz
         qzpCYIudD7Hybhg9SazNN9/MSIhFCIlkkDyoWFCYnKj45w/NCHkY2WE9IlcH7ugB8exR
         FX8f6j3nhNCUZb5foaZVhPM94lgJbj0RBlfb8cZT6DXzxEPmnX4WGbY1xG4Lq8yaNtL/
         VmU1sW4gP3owP25/QMkojQdQGYkJf/0iv2KDXhERh3aOS4xye6LCdUR5bgmqjnkgJjN8
         5sQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vHZRYrwtaZgXO55je8F150N4Va6hou4CjPXMEe4tSEM=;
        b=Px+yaOnFZVxin8NDMJ5hjgkHAqtE99dH+dOBlxOznExT0LR1xVJgHCgavHk7tviTmQ
         Ae9VKlvRDQBmCjcruxW+etuyyXBUTRX/JqJ+elZuCHVn6EyS6/gyuqJcxM/8AdniTVQQ
         6UQ1y/tRu3VNwPTzBBGbWbZi04uLr7UvIP5KnGAXwpiBH0eg2S1mus3mlYTHq6aX1Rqs
         3SsmnPTwCOJJ/cXqA8EGgZdkyrOXhjmcqeNRi+OhlnL3QerPMZCywpMEAut0cxJ6qPnN
         K66V4QznK0s77HeZBQ3lH5c1MsgW2YjBi1rBi/6gdJZwDPba8Z7uWjI5b20ok9bPIW5W
         vo6g==
X-Gm-Message-State: AOAM5331/dJ82qBhTxPh6swKInr9AT4/FNXm36DDJ6bwDKYxILGvaeFC
        2oO50OleGJfETsOcMqqOX4r7MssrXwUUGDfPj/Q=
X-Google-Smtp-Source: ABdhPJzUi4ke0o2ZA8AV2zpXRBJnOJhPrZQ1Pb3T/Bju7hubif2LD9LSu1ApFM3CX/M+pdhfqmKdniM/fdysTKx9G5w=
X-Received: by 2002:adf:e9c9:: with SMTP id l9mr27942155wrn.124.1605048828034;
 Tue, 10 Nov 2020 14:53:48 -0800 (PST)
MIME-Version: 1.0
References: <20201110193112.988999-1-lee.jones@linaro.org> <20201110193112.988999-5-lee.jones@linaro.org>
In-Reply-To: <20201110193112.988999-5-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 10 Nov 2020 17:53:36 -0500
Message-ID: <CADnq5_NPS1-+jA=AUVY1g9Wm--pvmB=QUoCUTce4S_uwEziGDQ@mail.gmail.com>
Subject: Re: [PATCH 04/30] drm/radeon/si: Remove set but unused variable 'mc_shared_chmap'
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

On Tue, Nov 10, 2020 at 2:31 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/radeon/si.c: In function =E2=80=98si_gpu_init=E2=80=99:
>  drivers/gpu/drm/radeon/si.c:3090:6: warning: variable =E2=80=98mc_shared=
_chmap=E2=80=99 set but not used [-Wunused-but-set-variable]
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
>  drivers/gpu/drm/radeon/si.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/si.c b/drivers/gpu/drm/radeon/si.c
> index c27af89785f34..45076c27d7ded 100644
> --- a/drivers/gpu/drm/radeon/si.c
> +++ b/drivers/gpu/drm/radeon/si.c
> @@ -3088,7 +3088,7 @@ static void si_setup_rb(struct radeon_device *rdev,
>  static void si_gpu_init(struct radeon_device *rdev)
>  {
>         u32 gb_addr_config =3D 0;
> -       u32 mc_shared_chmap, mc_arb_ramcfg;
> +       u32 mc_arb_ramcfg;
>         u32 sx_debug_1;
>         u32 hdp_host_path_cntl;
>         u32 tmp;
> @@ -3200,7 +3200,7 @@ static void si_gpu_init(struct radeon_device *rdev)
>
>         WREG32(BIF_FB_EN, FB_READ_EN | FB_WRITE_EN);
>
> -       mc_shared_chmap =3D RREG32(MC_SHARED_CHMAP);
> +       RREG32(MC_SHARED_CHMAP);
>         mc_arb_ramcfg =3D RREG32(MC_ARB_RAMCFG);
>
>         rdev->config.si.num_tile_pipes =3D rdev->config.si.max_tile_pipes=
;
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
