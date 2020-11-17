Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E74D2B6DA1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 19:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729415AbgKQSnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 13:43:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbgKQSnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 13:43:01 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 745CBC0613CF;
        Tue, 17 Nov 2020 10:42:59 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id c17so24188547wrc.11;
        Tue, 17 Nov 2020 10:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sCMQ/QonvivA+lIMBxKQU3+hpAIR8NvsAFKTyOancic=;
        b=GvXFWHCgA+OCToZUPLj9a0WvXhkO+wcsaN34rwur1n8sRxT3eIe2VSgX0Qm5R5Sogs
         JTdWc2LRy6jtqkaMHA4E1BCp0oAXKj1yvJLOQQ04C1xADC9TN3Xhil2Mi3phOLIM0diZ
         eOm2CEMWHqsgyriBBGxULfRWvpm6p0ym6dR9ggLfo8vVTZ1wfEKDO4WULuffA1ivfE3p
         CO6HsAyrmuHft+150tGUARYOIPm9af6LjYqrGa53flJy7Lw8Fh8WjizLO5KLncFIl1eP
         dCDojQVDAbAgwk/dkNUqJc98UQRDncud/7nTlQecShy3GdOvr5cR1Yk1E6XzLcj2YM4p
         E+6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sCMQ/QonvivA+lIMBxKQU3+hpAIR8NvsAFKTyOancic=;
        b=fI1nybFRK8CL83LwaOKHbaKGkQJhbXuOHapu1lbu9GrvYHg5Yp8YWKa6BkhIicoxL5
         hCcR7Fmai1uRNmSkRiUFfy4KAwg/jv1I0Dg4oTglv3lgBODpqX9WNwaiAsXeX3SgYflS
         fQopJ+Xk/hSV44bMRY1MOKk8UAvha4qaKpwVvvCuxAuHPLppx7zM2r/g5hGLNI6jeEkW
         Ss6mQGQHqQhg0XTQuNu2mOHyx7uE0ZlubFPholbOGCnEw60cL8hdvDvvUNo6W18C+u/f
         daacT4jnOs5sVGGCgVRtFB7JXGvvmTRA47C5r+7HjhWyovpv6QN1YDxt7pB82U/6D13E
         bmvA==
X-Gm-Message-State: AOAM531NDkoze3wkvrr+V9jPgmE978bX0dq1su4NSqHfSc+43gUld7WR
        lve7g6FTsd9RbHg1mTdT97iP7eoVbLFKt5CiPA0=
X-Google-Smtp-Source: ABdhPJyhhbPWxQDD0L/vTj/Ph0WR5F1wMtAKEbsL4r39UQpFucNpmyQfQlTisLjsWBuS1l+uhFLwNKL2xtOl+y3bt9g=
X-Received: by 2002:adf:e551:: with SMTP id z17mr951496wrm.374.1605638578216;
 Tue, 17 Nov 2020 10:42:58 -0800 (PST)
MIME-Version: 1.0
References: <20201117131137.420396-1-colin.king@canonical.com>
In-Reply-To: <20201117131137.420396-1-colin.king@canonical.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 17 Nov 2020 13:42:46 -0500
Message-ID: <CADnq5_PK_Z3eAwK6gNOu-KP1nV2=xiMS3O3RbQbYuRaQUOn7qA@mail.gmail.com>
Subject: Re: [PATCH][next] drm/amd/pm: fix spelling mistakes in dev_warn messages
To:     Colin King <colin.king@canonical.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 8:11 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> There are two spelling mistakes in dev_warn messages. Fix these.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> index afa542a5af5f..9a2f72f21ed8 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> @@ -689,14 +689,14 @@ static int vangogh_od_edit_dpm_table(struct smu_context *smu, enum PP_OD_DPM_TAB
>
>                 if (input[0] == 0) {
>                         if (input[1] < smu->gfx_default_hard_min_freq) {
> -                               dev_warn(smu->adev->dev, "Fine grain setting minimun sclk (%ld) MHz is less than the minimum allowed (%d) MHz\n",
> +                               dev_warn(smu->adev->dev, "Fine grain setting minimum sclk (%ld) MHz is less than the minimum allowed (%d) MHz\n",
>                                         input[1], smu->gfx_default_hard_min_freq);
>                                 return -EINVAL;
>                         }
>                         smu->gfx_actual_hard_min_freq = input[1];
>                 } else if (input[0] == 1) {
>                         if (input[1] > smu->gfx_default_soft_max_freq) {
> -                               dev_warn(smu->adev->dev, "Fine grain setting maximun sclk (%ld) MHz is greater than the maximum allowed (%d) MHz\n",
> +                               dev_warn(smu->adev->dev, "Fine grain setting maximum sclk (%ld) MHz is greater than the maximum allowed (%d) MHz\n",
>                                         input[1], smu->gfx_default_soft_max_freq);
>                                 return -EINVAL;
>                         }
> --
> 2.28.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
