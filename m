Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC26426CB33
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 22:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbgIPUXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 16:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727094AbgIPR2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:28:38 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26EEEC02C28F
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 08:31:43 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id g4so7400804wrs.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 08:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=9cI/Q3uj4XukmIC4z8WNHvSj/a5e8kMejOwJHwyLhrU=;
        b=AM+EYquCzfIKg9LA8lupSx3x3fv80mV8XsdCao572x7y+f/jTyZhXBwzrc0WjnQou8
         LrCfZ50AraT6NxKKEryKLx4mXtBR5VtT4qys9tKcbvpyx2AL35v5k0GhLaNw/8gavSU8
         IsuN1Obfj09QlPgHgTIBmdOQvsn9a1XVQaKgk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=9cI/Q3uj4XukmIC4z8WNHvSj/a5e8kMejOwJHwyLhrU=;
        b=tjpDmNJ1VmOdxpfML2Z5/gs2X+UEoqd7nhoKW9tItcjY78DgQADbNuV7DWK10KKPPD
         hhKJhlWlal/EGepmAtUOV5afVunKD3lZwRNwPm1CFPpDI89qFwk16IaBLi4z9nICrZ+7
         vAqhz7a1o6Vubm3wD5JwD2yf4dLfkVpbER2OC0my9iwYE0OMrwImMGZnnCWptl0M+byL
         yihSdytu407uvI0vJPSTaeiqMUD1BhwLu/7UDMyfbj+Ab8Ro1gOED/BIZ9ofEFc+5mq2
         4JNli6vzWx2JQmyqHFg3wGQYRCiKabnsLgWhaVa8sDspRQ7+aJUvQK5Ov9UgG6aKGkLR
         EKnQ==
X-Gm-Message-State: AOAM532P9Vn/woOvwifkJLBxeFbc8c0qJejJcMNYuPsaQmnWHMar79qb
        lY75waEulBEOYKIBpHSn0Wv/++PqVh3L0+oN
X-Google-Smtp-Source: ABdhPJzS3ONUGxvj8D+IIvQbIM66/m0KNy7Rh9Y4UxkZuG8AIJ3dk9r1W8t5jYlSX5UuYWW6Uyecjw==
X-Received: by 2002:adf:a4cc:: with SMTP id h12mr22069549wrb.123.1600270301723;
        Wed, 16 Sep 2020 08:31:41 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id z15sm32992374wrv.94.2020.09.16.08.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 08:31:40 -0700 (PDT)
Date:   Wed, 16 Sep 2020 17:31:38 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc:     Alex Deucher <alexdeucher@gmail.com>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>, yi.zhang@huawei.com,
        Dave Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Zheng Bin <zhengbin13@huawei.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        "Deucher, Alexander" <alexander.deucher@amd.com>
Subject: Re: [PATCH -next 0/8] drm/amd/amdgpu: fix comparison pointer to bool
 warning
Message-ID: <20200916153138.GR438822@phenom.ffwll.local>
Mail-Followup-To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexdeucher@gmail.com>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
        yi.zhang@huawei.com, Dave Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Zheng Bin <zhengbin13@huawei.com>,
        Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
        "Deucher, Alexander" <alexander.deucher@amd.com>
References: <20200909130720.105234-1-zhengbin13@huawei.com>
 <1fce0f2a-3777-e6d8-5a09-30261f843cfd@amd.com>
 <CADnq5_NoeFbBAMT6s_ictVXsUc2tx1U48MLxnMbAr2Sd58jyYA@mail.gmail.com>
 <20200915193549.GP6112@intel.com>
 <6658f89f-6957-e6ea-af41-7625f1fd3cb1@gmail.com>
 <20200916075156.GU438822@phenom.ffwll.local>
 <CADnq5_OS814FxmadZ9yBkrY6ije8h7FxswWstsxNr3rw=Bum=Q@mail.gmail.com>
 <372d7001-22cc-79b6-83b8-2fd75a1804d5@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <372d7001-22cc-79b6-83b8-2fd75a1804d5@amd.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 04:02:18PM +0200, Christian König wrote:
> Am 16.09.20 um 15:36 schrieb Alex Deucher:
> > On Wed, Sep 16, 2020 at 3:51 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> > > On Wed, Sep 16, 2020 at 09:38:34AM +0200, Christian König wrote:
> > > > Am 15.09.20 um 21:35 schrieb Ville Syrjälä:
> > > > > On Tue, Sep 15, 2020 at 03:16:32PM -0400, Alex Deucher wrote:
> > > > > > I question the value of these warnings.  Why even have a boolean type
> > > > > > if you are going to get warnings when you use them...
> > > > > > That said, applied to avoid getting these patches again and again
> > > > > > every time someone sees this.
> > > > > if (this_is_sparta)
> > > > > if (this_is_sparta == true)
> > > > > if (this_is_sparta != false)
> > > > > 
> > > > > I think the first one reads the best, and avoids having to
> > > > > decide between truth and falsehood :)
> > > > +1
> > > +1, especially because we also have the inversion when using negative
> > > errno codes for failures and 0 as success, which results in
> > > 
> > >          if (errno == 0) /* success case */
> > > 
> > > but
> > >          if (bool == 0) /* failure case */
> > > 
> > > now creative people do sometimes
> > > 
> > >          if (!errno) /* success case */
> > > 
> > > which I think is horribly confusing. So imo for more easier telling apart
> > > of these too I think consistently using the short form for booleans, and
> > > consistently using the more explicit long form for errno checks is a Very
> > > Good Pattern :-)
> > I don't disagree with your logic, but we regularly get patches to
> > convert errno checks to drop the direct comparison because that is the
> > "preferred kernel style".  Arguably, we should be explicit in all
> > cases as that avoids all confusion.  With that in mind, my original
> > point stands.  Why have a type when comparisons against valid settings
> > for that type produce errors?

Oh, I didn't know that this happens for errno too.

I withdraw my +1 and concur this is a bikeshed. I guess still applying to
shut up the patch stream is the most reasonable thing :-/
-Daniel

> Well it isn't an error, but raising a nice warning is most likely a good
> idea.

> 
> Christian.
> 
> > 
> > Alex
> > 
> > > Cheers, Daniel
> > > 
> > > > Christian.
> > > > 
> > > > > > Alex
> > > > > > 
> > > > > > On Wed, Sep 9, 2020 at 9:21 AM Christian König <christian.koenig@amd.com> wrote:
> > > > > > > Acked-by: Christian König <christian.koenig@amd.com> for the series.
> > > > > > > 
> > > > > > > Am 09.09.20 um 15:07 schrieb Zheng Bin:
> > > > > > > > Zheng Bin (8):
> > > > > > > >      drm/amd/amdgpu: fix comparison pointer to bool warning in gfx_v9_0.c
> > > > > > > >      drm/amd/amdgpu: fix comparison pointer to bool warning in gfx_v10_0.c
> > > > > > > >      drm/amd/amdgpu: fix comparison pointer to bool warning in sdma_v5_0.c
> > > > > > > >      drm/amd/amdgpu: fix comparison pointer to bool warning in sdma_v5_2.c
> > > > > > > >      drm/amd/amdgpu: fix comparison pointer to bool warning in si.c
> > > > > > > >      drm/amd/amdgpu: fix comparison pointer to bool warning in uvd_v6_0.c
> > > > > > > >      drm/amd/amdgpu: fix comparison pointer to bool warning in
> > > > > > > >        amdgpu_atpx_handler.c
> > > > > > > >      drm/amd/amdgpu: fix comparison pointer to bool warning in sdma_v4_0.c
> > > > > > > > 
> > > > > > > >     drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c | 4 ++--
> > > > > > > >     drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c           | 2 +-
> > > > > > > >     drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c            | 2 +-
> > > > > > > >     drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c           | 4 ++--
> > > > > > > >     drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c           | 2 +-
> > > > > > > >     drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c           | 2 +-
> > > > > > > >     drivers/gpu/drm/amd/amdgpu/si.c                  | 2 +-
> > > > > > > >     drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c            | 4 ++--
> > > > > > > >     8 files changed, 11 insertions(+), 11 deletions(-)
> > > > > > > > 
> > > > > > > > --
> > > > > > > > 2.26.0.106.g9fadedd
> > > > > > > > 
> > > > > > > _______________________________________________
> > > > > > > amd-gfx mailing list
> > > > > > > amd-gfx@lists.freedesktop.org
> > > > > > > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cchristian.koenig%40amd.com%7Cdc7a8d7517d341e3a80c08d85a458ba8%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637358602051676053&amp;sdata=MS0vcBcU7unXjEFlbd8kLbJkJ4sKcvIdLjc8yhX4UUI%3D&amp;reserved=0
> > > > > > _______________________________________________
> > > > > > dri-devel mailing list
> > > > > > dri-devel@lists.freedesktop.org
> > > > > > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Fdri-devel&amp;data=02%7C01%7Cchristian.koenig%40amd.com%7Cdc7a8d7517d341e3a80c08d85a458ba8%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637358602051686051&amp;sdata=MgfR%2BwCVY9gWfhQ9i5kWcKiiYkV1C8O2dEKlZYSqscE%3D&amp;reserved=0
> > > > _______________________________________________
> > > > dri-devel mailing list
> > > > dri-devel@lists.freedesktop.org
> > > > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Fdri-devel&amp;data=02%7C01%7Cchristian.koenig%40amd.com%7Cdc7a8d7517d341e3a80c08d85a458ba8%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637358602051686051&amp;sdata=MgfR%2BwCVY9gWfhQ9i5kWcKiiYkV1C8O2dEKlZYSqscE%3D&amp;reserved=0
> > > --
> > > Daniel Vetter
> > > Software Engineer, Intel Corporation
> > > https://nam11.safelinks.protection.outlook.com/?url=http%3A%2F%2Fblog.ffwll.ch%2F&amp;data=02%7C01%7Cchristian.koenig%40amd.com%7Cdc7a8d7517d341e3a80c08d85a458ba8%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637358602051686051&amp;sdata=GvLs5OXw2Ny%2BieJxm8hjawNb0rGA966539iAwlWwPMY%3D&amp;reserved=0
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
