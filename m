Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3442F1ACE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 17:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388656AbhAKQUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 11:20:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727917AbhAKQUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 11:20:36 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69617C061786;
        Mon, 11 Jan 2021 08:19:56 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id a109so226226otc.1;
        Mon, 11 Jan 2021 08:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kQk/AQM450K6HsYuxG7JpSAzrWu0ODwrljUZHEZN97M=;
        b=dib3q2aYgXhFR9Mf7C8qJfqLetr7N5C9iZNxz+f92ooZvmeeYlb3kE2bmHv4nRrPxE
         t0/Cd/9TWcFLTAfL2uT7zM9d9dbk0YIH0rAPHIIOvyRCaruyj/tCr2k3GNMmbtcmZNxc
         454czti9ohIoixYtZ0PjaPbiwgwkOJXeFHq/iA6PGdinWBxxK4FbdWhBV3fnBqKAflQ5
         t2u4gzdijpxx8XiFKIbTJgwS6hIXUOU4fCUZoEP8a/Pzi7ALxA4Ml3FsLWconULeyeFc
         MCenWkYxvsphNjwz336GKmx1fYOvaIR4dHL1ll35Xbc58KJcfVWGb/GmDfoxY3LpvdiK
         446w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kQk/AQM450K6HsYuxG7JpSAzrWu0ODwrljUZHEZN97M=;
        b=te33UedrSKjpADPQvjNxjRC4XRK9a/POjZS5hAlFbi8nPDtMFJQxaojI+mSl7Byqzk
         6NQ9Q0B0RaTL2Z9JI4Bczwd0cD5ZrkhPKV7gvVsmk76aeRpy4TVuKIIXgyrm1aMB6g0c
         giKyg9z8aoln94fDh4iMBb/lO5ioA4p/R1v74aczMFk7OrsE7hzi3Ah1X2pfh4P+AbET
         NjF2cT6ydEJPAm3V5Oy22zXZJWQ0/M3dolqM8wJAuv9wx6G5ak4YQA0iq73bmxy43yjA
         +G2xggfsmIzWwCuIg67bZwbzDFL2bHecjYsIPIwh0YEKRQ/8vrJa/yhdYd7aikgo3fmk
         4QDg==
X-Gm-Message-State: AOAM531RByzKRW+9ZNjLG/7H4VNn2dFPITbOHxZoSs7OYzhd81RNFnlf
        7PLZ4eA96Ht0FUMim9PLFGHyd8/PJANEfSC+uFs7/5cC
X-Google-Smtp-Source: ABdhPJxjNJBIzHwvnWd7Rrj2OAzVwaOmzGHq9pKe7Im3VwHt0XIVxupVuAcl3wvoGfnI9OUDToAvu9pw2dMY3+pjTfs=
X-Received: by 2002:a05:6830:1d66:: with SMTP id l6mr11413214oti.23.1610381995915;
 Mon, 11 Jan 2021 08:19:55 -0800 (PST)
MIME-Version: 1.0
References: <20210111114638.16530-1-colin.king@canonical.com>
In-Reply-To: <20210111114638.16530-1-colin.king@canonical.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 11 Jan 2021 11:19:45 -0500
Message-ID: <CADnq5_PoOSL3XMrK+ZTwppU0wqV3+uOHptA7=GN=EPDRqMZkSQ@mail.gmail.com>
Subject: Re: [PATCH][next] drm/amdgpu: Add missing BOOTUP_DEFAULT to profile_name[]
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

On Mon, Jan 11, 2021 at 6:46 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> A recent change added a new BOOTUP_DEFAULT power profile mode
> to the PP_SMC_POWER_PROFILE enum but omitted updating the
> corresponding profile_name array.  Fix this by adding in the
> missing BOOTUP_DEFAULT to profile_name[].
>
> Addresses-Coverity: ("Out-of-bounds read")
> Fixes: c27c9778a19e ("drm/amd/powerplay: support BOOTUP_DEFAULT power profile mode")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> index 75ddcadf3802..4763cb095820 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> @@ -774,6 +774,7 @@ static int vangogh_get_power_profile_mode(struct smu_context *smu,
>                                            char *buf)
>  {
>         static const char *profile_name[] = {
> +                                       "BOOTUP_DEFAULT",
>                                         "FULL_SCREEN_3D",
>                                         "VIDEO",
>                                         "VR",
> --
> 2.29.2
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
