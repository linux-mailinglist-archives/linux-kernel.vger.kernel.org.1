Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3F602EF94E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 21:36:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729222AbhAHUfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 15:35:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727443AbhAHUfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 15:35:17 -0500
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B036C061380
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 12:34:22 -0800 (PST)
Received: by mail-oo1-xc2c.google.com with SMTP id x23so2699209oop.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 12:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Nn5Yj71tkKIVrulq1WIDxZxckjqVz9PFKak3TcGJVF0=;
        b=moUBx6E02X34CiH2aZUlZWkIkglOKoDjtYh17GXYyicOZbLSi9/7jas14rvX8JC7Jm
         d20hG0sgrjmOh1mN1ukeRuluOMuoGTUtfeV+hSOIGsIB4pbCI0dKyeX1q2D9c7BIMvq8
         mo/WdUUymM0x+y1+YBq8yZ9dxvyrfJCBzu+jEORkqGkIr707jgDMnK5/1p4C7XQi0Bz9
         Zg0VkXuYhdNoXRW4uARrdSAhDtIgMffhHmSw/FpwElhVLYFGcoXX3ZCNyfIgCIrgD51P
         EFV3y68F3p7vJEdxRdnTZndxVbMSebvqu2xhuFfUZGNf5Ps1ZJ6CfD/1tkA4YtDxF4sC
         4o3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Nn5Yj71tkKIVrulq1WIDxZxckjqVz9PFKak3TcGJVF0=;
        b=bp08TNpem4Pne6V2l7xcUxUoSAAu+U+4frHLuzAV158A6HDmnpkZhNyzGiQ4k/JjLa
         Rx6Zt8XPGr5jtQAjQpa1EsF1iVlMZ0VvlGUq2ZsAZIeOp+Q2yC/p0oEplZbiZs+fF+zM
         9SQ+BV0g2eKPyFDeTRfWqqy32RPfp4AeCkZV10p1pMqa2a3F7p3BqWWIxrO4DwYN9Q9w
         2l9PIJhMnsNFTLL2ikRg5haXqVuptmoBFtNntzphputzt0DuQLQpadoYkY2kq51AdWKQ
         1KPERIl6qGUpppbrCX2iVyTGj0+6v0aciucpLJyQ+dlAY2GxlJKyIEjwnTWVC0LS1UlM
         i0Tg==
X-Gm-Message-State: AOAM531oOwCMom6RPTwWx5zetCY4PprwSD+44fv4VE2sjsTOtqNiGtUc
        KeeshjmHBor9FsQqCoiENagxJCWQ15NZxmAT6qw=
X-Google-Smtp-Source: ABdhPJzS2GpG+PF4XXrf90up0wn3fJ1R8B3W9Fo+t+b0+7NVShJkdDQdv1Rqlv//xNl4nKVcjrFVwLkoPl7y0nM9h4E=
X-Received: by 2002:a4a:6c45:: with SMTP id u5mr5577304oof.61.1610138062004;
 Fri, 08 Jan 2021 12:34:22 -0800 (PST)
MIME-Version: 1.0
References: <20210108201457.3078600-1-lee.jones@linaro.org> <20210108201457.3078600-9-lee.jones@linaro.org>
In-Reply-To: <20210108201457.3078600-9-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 8 Jan 2021 15:34:11 -0500
Message-ID: <CADnq5_PMi=7n+7McEhm23ZjhjYQNpJYqRknYj8d=0J-d7wWvAA@mail.gmail.com>
Subject: Re: [PATCH 08/40] drm/amd/pm/powerplay/hwmgr/vega12_hwmgr: Fix legacy
 function header formatting
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
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega12_hwmgr.c:728: war=
ning: Function parameter or member 'hwmgr' not described in 'vega12_init_sm=
c_table'
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
>  drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c b/driv=
ers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
> index dc206fa88c5e5..c0753029a8e2a 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
> @@ -718,12 +718,11 @@ static int vega12_save_default_power_profile(struct=
 pp_hwmgr *hwmgr)
>  #endif
>
>  /**
> -* Initializes the SMC table and uploads it
> -*
> -* @param    hwmgr  the address of the powerplay hardware manager.
> -* @param    pInput  the pointer to input data (PowerState)
> -* @return   always 0
> -*/
> + * Initializes the SMC table and uploads it
> + *
> + * @hwmgr:  the address of the powerplay hardware manager.
> + * return:  always 0
> + */
>  static int vega12_init_smc_table(struct pp_hwmgr *hwmgr)
>  {
>         int result;
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
