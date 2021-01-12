Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 769F82F3DF2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:44:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393687AbhALV4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 16:56:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389967AbhALV4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 16:56:23 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81079C061786
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 13:55:43 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id x13so3807895oto.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 13:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=znljSH1AVX8WCZj65lTt4Z1+9uZGjTLRkQMrZFvuyb0=;
        b=CV4VfIRWfi0R9/UOm+paur3SzGdcvRbnkHekd5JubxUHCQAkXkIK2Z9cPb8PyhpTvZ
         haIsTianWtYzprVnfWkrnh82ZIrr166EBK7zYtipvKQ5n9NNGntN7JLbKaq4gZJ948xt
         nN+TjGiXHKayMml9rDHdyTDexB6e+r6R6G7CBHE1lI5H4h4iKTSaHZCrknbDrNv0qjXu
         w0iqKcPKP2cg8Ua4vQsnKKJJoboI9vZH/xTWJJy4AcWJx0Fiaj46mMyBV/igT4sYxqcb
         VLTYIN/3uOEIVFlTkSCJjPKOqMpP+3QNeyPBUqcxB0n6+PGLbBGrCFnrA3DybcUqRzK1
         avFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=znljSH1AVX8WCZj65lTt4Z1+9uZGjTLRkQMrZFvuyb0=;
        b=DqPCLDTfGAs8h3GHSeDFjCUVkquoclAcqRRSPYEvp0yreaJm9Htpi8+8ZyCrqn0VAX
         gIBBd9qaPmxnYYGrp4HloTgj6cqRpoBsUMFV8Dt6fjUAHlGXIb/j+xqBCoh4lFkMKc2c
         vgIrxVpVidw68LbRmiUiQ+dhk4HVzPRW3ugOIUMJ7rT6H/Kx6s+Lu7BzmoaIg4Y3w9yX
         mmNIBz0iShiDJsZ0iV+/JACya7XDooYiykHeT98e0cxAKIGiiMVWY93vPf5U9bTcocqp
         lhVzqmnbdh7TgLad+Xq1yQKl9pVW0o0rg62IPhzwum2sUHEzPrRweLezYPea1vM/fGhL
         5bsA==
X-Gm-Message-State: AOAM531SATR42LfU6sTmbTiiW0RV+tqBRey7U8lJ7DYPMSLU0QfFsBrF
        VCTMyzMrXV2SP8G+6hgsavXWUUCU6pLPoLNFZZo=
X-Google-Smtp-Source: ABdhPJwR/ymc04CZJMQdWGDMKno7UUdM4OLE4UWCwA6cNKKLq9gjW0kQ1EOAWWo6yQOox74aWqAH8fBH3/5czIA5ZxE=
X-Received: by 2002:a05:6830:1b7b:: with SMTP id d27mr1050326ote.132.1610488542949;
 Tue, 12 Jan 2021 13:55:42 -0800 (PST)
MIME-Version: 1.0
References: <1610481442-6606-1-git-send-email-jrdr.linux@gmail.com>
In-Reply-To: <1610481442-6606-1-git-send-email-jrdr.linux@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 12 Jan 2021 16:55:31 -0500
Message-ID: <CADnq5_OtfqEHXopb=CiY7YQ4otGoR_DUF8Sirv0Yob=Fe4Nv+A@mail.gmail.com>
Subject: Re: [PATCH] drm: amdgpu: pm: Mark vangogh_clk_dpm_is_enabled() as static
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        "Quan, Evan" <evan.quan@amd.com>,
        "Lazar, Lijo" <lijo.lazar@amd.com>, Jinzhou.Su@amd.com,
        Xiaomeng.Hou@amd.com,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 3:23 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> kernel test robot throws below warnings ->
>
> drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/vangogh_ppt.c:594:6:
> warning: no previous prototype for 'vangogh_clk_dpm_is_enabled'
> [-Wmissing-prototypes]
> drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/vangogh_ppt.c:594:6:
> warning: no previous prototype for function 'vangogh_clk_dpm_is_enabled'
> [-Wmissing-prototypes]
>
> Mark vangogh_clk_dpm_is_enabled() as static.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>

Applied.  Thanks!

Alex


> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> index 75ddcad..3ffe56e 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> @@ -610,7 +610,7 @@ static int vangogh_get_profiling_clk_mask(struct smu_context *smu,
>         return 0;
>  }
>
> -bool vangogh_clk_dpm_is_enabled(struct smu_context *smu,
> +static bool vangogh_clk_dpm_is_enabled(struct smu_context *smu,
>                                 enum smu_clk_type clk_type)
>  {
>         enum smu_feature_mask feature_id = 0;
> --
> 1.9.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
