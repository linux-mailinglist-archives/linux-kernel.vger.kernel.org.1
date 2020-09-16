Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 616E826C6B7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 20:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbgIPSBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 14:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727699AbgIPR64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:58:56 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D52C014D59
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 06:36:41 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id o5so6891362wrn.13
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 06:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=r5jUXeSw/4ggqv8IN7COH2Z5GZeDPF7AGOPBRf1SYI0=;
        b=ig6ZQKRGLyN6XNhUpuB/u1pVkJdj64SQdhmlbQamjF9zW8WxwgHX1uqj35w+Xh2ZnA
         lD5sTpJuT/IFOZ+atqmjosTryiHlchqSSgFArIFZ8STOIm6Z2qcBbzFDFQEZBWNSOk/p
         aMuxEjt3Wz+xLbTA+ufEdFluAW6+dOhwH08vfKdYOvFPArPtyQ+XIEIMa6yIKdHZp0tm
         y9HTxRGTWaNMz1g9BYfpbfgTQzTiln06WuohZir74vPBN10YC79eL23pvynVfE/wEbsx
         Ow0vPp2hHlmqLC79I/m/Bsn/ABVTMxAvXJcvMmF0jGh3F9GdQQn3nS5p6Qx7uPI6Tg33
         BghA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=r5jUXeSw/4ggqv8IN7COH2Z5GZeDPF7AGOPBRf1SYI0=;
        b=R083x7/gu0yIEA34mRXD5mELI6IC1orAOHmWPy5+7cwNhxb/PjLMHXCr4Sh8/s+A4l
         3yx1VUncDsovzkcH6+8zZanXgl9KfUCYOJjdDROOzqyGpGa5eLaOC+PHGbSEsAeD+I3O
         KhwQlCLiGg1FPXv8VpPVHD4A6WVUG4sa4Ct5oSfmvYrDVBaRWuXCC22AWXWTJTgsbdyN
         l8X45DBQ9F092LRoy04HHxL2PO4sq/ojfhbvcujQYDoxI3Xv4+Ut0/Z6efVW7OHJSEFi
         vW8BJXCe0Q44VQO9Kn3+DcSIU+joi1S6rJXOuv16VHXc51n7eplOo/WVOjG1UVtrkGmf
         HmJQ==
X-Gm-Message-State: AOAM531umg5qELKxhI0VsiBxaUuTVyEp5Fuc+HLVYCFVivC/zuu74O4N
        4VD7Y0SFRA+ysqNvuDKh66dNlmSN3J18dZTI7bA=
X-Google-Smtp-Source: ABdhPJz0EHmnPCfH0eRO3mR2rVLD52zmKN9kD0WOxU4XQOjqSUjfS6kR79//Svvg/jabT/LHpVLj1OT8TcgFsVfvbkw=
X-Received: by 2002:adf:f290:: with SMTP id k16mr28611770wro.124.1600263399711;
 Wed, 16 Sep 2020 06:36:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200909130720.105234-1-zhengbin13@huawei.com>
 <1fce0f2a-3777-e6d8-5a09-30261f843cfd@amd.com> <CADnq5_NoeFbBAMT6s_ictVXsUc2tx1U48MLxnMbAr2Sd58jyYA@mail.gmail.com>
 <20200915193549.GP6112@intel.com> <6658f89f-6957-e6ea-af41-7625f1fd3cb1@gmail.com>
 <20200916075156.GU438822@phenom.ffwll.local>
In-Reply-To: <20200916075156.GU438822@phenom.ffwll.local>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 16 Sep 2020 09:36:28 -0400
Message-ID: <CADnq5_OS814FxmadZ9yBkrY6ije8h7FxswWstsxNr3rw=Bum=Q@mail.gmail.com>
Subject: Re: [PATCH -next 0/8] drm/amd/amdgpu: fix comparison pointer to bool warning
To:     Christian Koenig <christian.koenig@amd.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Alex Deucher <alexdeucher@gmail.com>, yi.zhang@huawei.com,
        Dave Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Zheng Bin <zhengbin13@huawei.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        "Deucher, Alexander" <alexander.deucher@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 3:51 AM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Wed, Sep 16, 2020 at 09:38:34AM +0200, Christian K=C3=B6nig wrote:
> > Am 15.09.20 um 21:35 schrieb Ville Syrj=C3=A4l=C3=A4:
> > > On Tue, Sep 15, 2020 at 03:16:32PM -0400, Alex Deucher wrote:
> > > > I question the value of these warnings.  Why even have a boolean ty=
pe
> > > > if you are going to get warnings when you use them...
> > > > That said, applied to avoid getting these patches again and again
> > > > every time someone sees this.
> > > if (this_is_sparta)
> > > if (this_is_sparta =3D=3D true)
> > > if (this_is_sparta !=3D false)
> > >
> > > I think the first one reads the best, and avoids having to
> > > decide between truth and falsehood :)
> >
> > +1
>
> +1, especially because we also have the inversion when using negative
> errno codes for failures and 0 as success, which results in
>
>         if (errno =3D=3D 0) /* success case */
>
> but
>         if (bool =3D=3D 0) /* failure case */
>
> now creative people do sometimes
>
>         if (!errno) /* success case */
>
> which I think is horribly confusing. So imo for more easier telling apart
> of these too I think consistently using the short form for booleans, and
> consistently using the more explicit long form for errno checks is a Very
> Good Pattern :-)

I don't disagree with your logic, but we regularly get patches to
convert errno checks to drop the direct comparison because that is the
"preferred kernel style".  Arguably, we should be explicit in all
cases as that avoids all confusion.  With that in mind, my original
point stands.  Why have a type when comparisons against valid settings
for that type produce errors?

Alex

>
> Cheers, Daniel
>
> >
> > Christian.
> >
> > >
> > > > Alex
> > > >
> > > > On Wed, Sep 9, 2020 at 9:21 AM Christian K=C3=B6nig <christian.koen=
ig@amd.com> wrote:
> > > > > Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com> for the=
 series.
> > > > >
> > > > > Am 09.09.20 um 15:07 schrieb Zheng Bin:
> > > > > > Zheng Bin (8):
> > > > > >     drm/amd/amdgpu: fix comparison pointer to bool warning in g=
fx_v9_0.c
> > > > > >     drm/amd/amdgpu: fix comparison pointer to bool warning in g=
fx_v10_0.c
> > > > > >     drm/amd/amdgpu: fix comparison pointer to bool warning in s=
dma_v5_0.c
> > > > > >     drm/amd/amdgpu: fix comparison pointer to bool warning in s=
dma_v5_2.c
> > > > > >     drm/amd/amdgpu: fix comparison pointer to bool warning in s=
i.c
> > > > > >     drm/amd/amdgpu: fix comparison pointer to bool warning in u=
vd_v6_0.c
> > > > > >     drm/amd/amdgpu: fix comparison pointer to bool warning in
> > > > > >       amdgpu_atpx_handler.c
> > > > > >     drm/amd/amdgpu: fix comparison pointer to bool warning in s=
dma_v4_0.c
> > > > > >
> > > > > >    drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c | 4 ++--
> > > > > >    drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c           | 2 +-
> > > > > >    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c            | 2 +-
> > > > > >    drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c           | 4 ++--
> > > > > >    drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c           | 2 +-
> > > > > >    drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c           | 2 +-
> > > > > >    drivers/gpu/drm/amd/amdgpu/si.c                  | 2 +-
> > > > > >    drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c            | 4 ++--
> > > > > >    8 files changed, 11 insertions(+), 11 deletions(-)
> > > > > >
> > > > > > --
> > > > > > 2.26.0.106.g9fadedd
> > > > > >
> > > > > _______________________________________________
> > > > > amd-gfx mailing list
> > > > > amd-gfx@lists.freedesktop.org
> > > > > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> > > > _______________________________________________
> > > > dri-devel mailing list
> > > > dri-devel@lists.freedesktop.org
> > > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> >
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
