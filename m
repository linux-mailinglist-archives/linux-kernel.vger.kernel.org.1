Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5CF12808B9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 22:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727424AbgJAUsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 16:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbgJAUsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 16:48:07 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A39C0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 13:48:07 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id e16so228730wrm.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 13:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pWKX1vkQAtu4hoexOnxMFtWuUI/DIu3/+WqsN0eWvnQ=;
        b=LJn2+F5+GJuD9zKdAHEHlPEhk3Cp3zDiNcNUDjd6bL6VYj8JNE7Hgp8PAS7KBTmY1v
         LRWOFSRRtETaRV5isjhLjvnPQLu2zXH7lP860CiFgQf5dWXRmjpQB+stSi+0X6bZ5xUc
         p0xnUc9D5BILOelNLFogLx38FsNoF8EuMZ09n/Xt1cx8ncG4yF8JOHqol5ZUEPsN1uBH
         kGOq+X8a/NAAsx+GdRfr2ZT6zhxUHDl0hZrJABWa3EJsEjUG4n7dASv9NVFTKvNiGoEM
         hC7jfJqMHIRoQpnwmW9Uut+lRAONkOHlFRemhnY5icsOJ7TEhYW1sDrSltcdMHYU75e6
         W3+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pWKX1vkQAtu4hoexOnxMFtWuUI/DIu3/+WqsN0eWvnQ=;
        b=Oje94W0xp9Skjc++mTpSHNhDtJZdaR347pQUHSyvsmaMzVchs2xwdCksni9APapcze
         DG5ireRlN9N07VMXFqkKf4UBeKbtW4ia4f5ywzLQeLbZ4dUMDUXAgGiVz4joIj68n6Jq
         zoExeya+XfvMVuxuSE6PEm8gmOnCVWUq3qXGCL8bfIxGPTK7fUht31uehqtIAK4JyPJw
         9Z6j887LMoLPpdPh+hEygI5ne7Hn8DdtL6S9HF6z+dP7KmIlIwVPbkkjnWOfM6bFOv4l
         viQ/Ev75mrKR6CUD0vW/45JRIlqABjkVoAZ3444dPVreaFmouaEsf2y1sZL3/EZqlSsI
         GQuQ==
X-Gm-Message-State: AOAM531iPndb0k4MwjiRZ4Hp3huy2LMBLNIDiVz5gSic17zXP7Jg86jV
        seO6SoqQC39VsbyiTiVoT3icc3UaefRA54qpzbJ9KQjd
X-Google-Smtp-Source: ABdhPJwHa+MjqUMnY7p1Buv4fdAEdX6XVRxeBeIp0Rbkxs7rFc4ShHlAQfw4PTaCZhqwJMIOMk4pGvqnetBXi1TXfEk=
X-Received: by 2002:adf:dd82:: with SMTP id x2mr11634856wrl.419.1601585286333;
 Thu, 01 Oct 2020 13:48:06 -0700 (PDT)
MIME-Version: 1.0
References: <CADnq5_OOL3UZXKXEKU8VzkZAkOnk9HM8m=nEwywoQPm4GXs0rw@mail.gmail.com>
 <20201001195525.3477-2-dirk@gouders.net> <ghh7rdy9hg.fsf@gouders.net>
In-Reply-To: <ghh7rdy9hg.fsf@gouders.net>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 1 Oct 2020 16:47:55 -0400
Message-ID: <CADnq5_OUYWCceZm=sNpFZ7cquyxmz5GO5JPznyFhZDSu+pjj=Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] drm/amdgpu: fix NULL pointer dereference for Renoir
To:     Dirk Gouders <dirk@gouders.net>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 1, 2020 at 4:33 PM Dirk Gouders <dirk@gouders.net> wrote:
>
> Dirk Gouders <dirk@gouders.net> writes:
>
> > Commit c1cf79ca5ced46 (drm/amdgpu: use IP discovery table for renoir)
> > introduced a NULL pointer dereference when booting with
> > amdgpu.discovery=0, because it removed the call of vega10_reg_base_init()
> > for that case.
> >
> > Fix this by calling that funcion if amdgpu_discovery == 0 in addition to
> > the case that amdgpu_discovery_reg_base_init() failed.
> >
> > Fixes: c1cf79ca5ced46 (drm/amdgpu: use IP discovery table for renoir)
> > Signed-off-by: Dirk Gouders <dirk@gouders.net>
> > Cc: Hawking Zhang <Hawking.Zhang@amd.com>
> > Cc: Evan Quan <evan.quan@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/soc15.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
> > index 84d811b6e48b..f8cb62b326d6 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> > @@ -694,12 +694,12 @@ static void soc15_reg_base_init(struct amdgpu_device *adev)
> >                * it doesn't support SRIOV. */
> >               if (amdgpu_discovery) {
> >                       r = amdgpu_discovery_reg_base_init(adev);
> > -                     if (r) {
> > -                             DRM_WARN("failed to init reg base from ip discovery table, "
> > -                                      "fallback to legacy init method\n");
> > -                             vega10_reg_base_init(adev);
> > -                     }
> > +                     if (r == 0)
> > +                       break;
>
> Grrr, wrong indentation here.
> But I will wait for your review before v1.

Fixed up locally and applied.  Thanks!

Alex


>
> Dirk
>
>
> > +                     DRM_WARN("failed to init reg base from ip discovery table, "
> > +                              "fallback to legacy init method\n");
> >               }
> > +             vega10_reg_base_init(adev);
> >               break;
> >       case CHIP_VEGA20:
> >               vega20_reg_base_init(adev);
