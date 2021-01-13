Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D28DD2F418D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 03:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727663AbhAMCOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 21:14:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727639AbhAMCOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 21:14:00 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50BFFC061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 18:13:14 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id r9so472274otk.11
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 18:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VUErmH4SeZXO4Kr8KDNU7modu5yLT0KfCdnqky8Jm9I=;
        b=FW8cX9veX+LBKIj5m27B315KkVZT+X9hG2Z45JLm+nZdocmYuMAaAvb0WkwDdZGZ9K
         1QLY7ifS5JBnKQPL3rYSSlbkkwqlLNBrcMF12D0MxCTS4zeWFA1L78g8mQJYXJ/9rZ+w
         tuUi8J2tgJdIPsWemgqUFc7bb7iiV2mxhod3tWUZ/VQZXnh52fOnA/Arsb/ADNCk7WvG
         aCvHCmLpMl3PGJ3SElu8xpyUGmh0ikW7XAnxm7wL2sxjmmkMuOUjwtYV6UKjhoWpRbXW
         r7YAeve6N82Ch5cwV/SAAE8JC6hLLpwMAu9LCsTzma1NrPvVCoyPnE1aQzf5e/hEU/RB
         A0cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VUErmH4SeZXO4Kr8KDNU7modu5yLT0KfCdnqky8Jm9I=;
        b=juyHFoHl8kDxPKQsEa+TcBkSYnPCGSjDAqn+92OaZToUiyZgTt9ZWuLQDhnTUuEZvu
         0tzQuZwEAerFoLJnlvOKvsXl7BV9nKLtHaBwPfcdPXvYgcuppjSfGT3A27Ubgl4w2fn9
         QZjMWqh8ZX0yJAs1KvN+jJBegwHaZJTRctJ+wm8GM5bdYrIc/CgavFb/MoMeeojnuLtl
         q2YI3bbgRcZN46MA5nFORkKXHlxeWsVUmc3eyPPcvhGiTm4bD3AXeiuotSt8BhD5SmWS
         KHK22AQqx5nM3N+Pysz7nnpEklEiG/Q5Mx4BE7bjGi30ZtsGIoT4vhk5K1JwCLe6hOJY
         c52w==
X-Gm-Message-State: AOAM533TjE4ybe4Q5Vq6/gt6Yp0rqM2zgjSD3x84+mLFZ0tbD5cIfofB
        qOQW1HHPhpZT0DXpDz7z/MeRR22ojrWFigN1t7g=
X-Google-Smtp-Source: ABdhPJx36T5OeO+AaMTA5m5RLolSfjCa11TSPHz/G8MAsXeyZ5DSaXrSiWbAE7+GkK7C/htsTmaIXDTTbAZcKtwkwGA=
X-Received: by 2002:a9d:2ac2:: with SMTP id e60mr1515820otb.23.1610503993648;
 Tue, 12 Jan 2021 18:13:13 -0800 (PST)
MIME-Version: 1.0
References: <1610481442-6606-1-git-send-email-jrdr.linux@gmail.com> <20210113011901.GA135176@hr-amd>
In-Reply-To: <20210113011901.GA135176@hr-amd>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 12 Jan 2021 21:13:02 -0500
Message-ID: <CADnq5_NUaqHWW7A32M1BeQ+rHPS8WZ-0OnVXtD3m7pB3ZpHyYA@mail.gmail.com>
Subject: Re: [PATCH] drm: amdgpu: pm: Mark vangogh_clk_dpm_is_enabled() as static
To:     Huang Rui <ray.huang@amd.com>
Cc:     Souptick Joarder <jrdr.linux@gmail.com>,
        "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "Lazar, Lijo" <Lijo.Lazar@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "Hou, Xiaomeng (Matthew)" <Xiaomeng.Hou@amd.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Quan, Evan" <Evan.Quan@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 8:19 PM Huang Rui <ray.huang@amd.com> wrote:
>
> On Wed, Jan 13, 2021 at 03:57:22AM +0800, Souptick Joarder wrote:
> > kernel test robot throws below warnings ->
> >
> > drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/vangogh_ppt.c:594:6:
> > warning: no previous prototype for 'vangogh_clk_dpm_is_enabled'
> > [-Wmissing-prototypes]
> > drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/vangogh_ppt.c:594:6:
> > warning: no previous prototype for function 'vangogh_clk_dpm_is_enabled'
> > [-Wmissing-prototypes]
> >
> > Mark vangogh_clk_dpm_is_enabled() as static.
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> > ---
> >  drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> > index 75ddcad..3ffe56e 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> > @@ -610,7 +610,7 @@ static int vangogh_get_profiling_clk_mask(struct smu_context *smu,
> >       return 0;
> >  }
> >
> > -bool vangogh_clk_dpm_is_enabled(struct smu_context *smu,
> > +static bool vangogh_clk_dpm_is_enabled(struct smu_context *smu,
> >                               enum smu_clk_type clk_type)
>
> Ah, I have another patch which will use this function in another file.
>

I can drop it if you plan to land those patches soon.

Alex


> Thanks,
> Ray
>
> >  {
> >       enum smu_feature_mask feature_id = 0;
> > --
> > 1.9.1
> >
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
