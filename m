Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 653372A851F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 18:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731594AbgKERkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 12:40:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbgKERkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 12:40:55 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B137C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 09:40:55 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id h4so438146pjk.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 09:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=M9ihP9we/zZDj1bRQBGaWng2JQ4juZGWzyhKriRhb/c=;
        b=i1HADtwImSCJ0eNMPOeOuYQZZSp3gxw07xNwRbTgMlWN18IbrOQBjFaeNrWIoTxCzO
         TEk+8mphIK5upO0csZf6bbXFrIKJe0sGKep4NHtOJzcI/xu6ThXpGtpBsUJXue+AY5IU
         Ib/RpWT2bOE66N3XjmtfED/fX/XrCmzp+S8nhhpkBduSn2eh4/YHFrr9E3G+kKGBf5x6
         jd5LCYpXZtgbljcgme26T2qQJnfI5Wl8qbTCT3VRqww1NteqsYFUth22vPhZlbqoKvBh
         XbHVkuqFe/uzBDXTm2BVZaa2O85OqQLird/QrbNHEoBWDAW6qMqB1bSdV5zQVyp2V1v+
         3Hvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=M9ihP9we/zZDj1bRQBGaWng2JQ4juZGWzyhKriRhb/c=;
        b=K9LaInQ28YlEZMNbLDoTwdtvoy+0KMrLrVYO5bOxkxFgZ2SPG6WVVtwNnKVlDu8Kwq
         nHK8AX5wPt99SHwn6kMogzJKGTO2P9OBwDWgsFx2J3rwkTLzNx7WuuIfhUSu3sdUXrrs
         B1x2TcbLRxvUhykXvhKzku6QNjG02ZAzUR1VCV8bYMBN3ulNK5DFOs7VmPpTERg7sstN
         J/PTSwlgmyNXSocyDo9FB9hPweLWIbMwRIND+JQj/doftRd8pbMtVrwiQf2CD8bFkmbT
         om2+Eak5PMXGMX0z0KRWOfHxaJ5ynRs4UPTHV4PJD6gH3yTKdooT4YOPK3cyUCsPQI55
         UmQw==
X-Gm-Message-State: AOAM532rjoklKgrmwUwNO2rHPds6BPeFgxfnV11b7zA15QLZ53MnquNu
        VJFGApj16I81Z292TV5974Y=
X-Google-Smtp-Source: ABdhPJwiu6z6dYW6rbmjufMJoVFUNrZfv0xXtUieOqcdG+bof+LS4G4dnlUfXfA72/6/pUZ7RzGEDA==
X-Received: by 2002:a17:90a:5d17:: with SMTP id s23mr3529740pji.103.1604598054856;
        Thu, 05 Nov 2020 09:40:54 -0800 (PST)
Received: from localhost ([160.202.157.3])
        by smtp.gmail.com with ESMTPSA id l7sm2742527pjg.29.2020.11.05.09.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 09:40:54 -0800 (PST)
Date:   Thu, 5 Nov 2020 23:10:45 +0530
From:   Deepak R Varma <mh12gx2825@gmail.com>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/vgm: replace idr_init() by idr_init_base()
Message-ID: <20201105174045.GA41810@localhost>
References: <20201104112338.GA29271@localhost>
 <20201105094215.GT401619@phenom.ffwll.local>
 <20201105103116.GA29881@localhost>
 <CAKMK7uF0buRA-FfoY2=FbZQO-cqgSwZXRWwNQ2xkBdZAS=JuRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uF0buRA-FfoY2=FbZQO-cqgSwZXRWwNQ2xkBdZAS=JuRA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 05, 2020 at 12:16:34PM +0100, Daniel Vetter wrote:
> On Thu, Nov 5, 2020 at 11:31 AM Deepak R Varma <mh12gx2825@gmail.com> wrote:
> >
> > On Thu, Nov 05, 2020 at 10:42:15AM +0100, Daniel Vetter wrote:
> > > On Wed, Nov 04, 2020 at 04:53:38PM +0530, Deepak R Varma wrote:
> > > > idr_init() uses base 0 which is an invalid identifier. The new function
> > > > idr_init_base allows IDR to set the ID lookup from base 1. This avoids
> > > > all lookups that otherwise starts from 0 since 0 is always unused.
> > > >
> > > > References: commit 6ce711f27500 ("idr: Make 1-based IDRs more efficient")
> > > >
> > > > Signed-off-by: Deepak R Varma <mh12gx2825@gmail.com>
> > >
> > > Tiny typo in the commit message summary: s/vgm/vgem/
> > >
> > > Also can you pls resbumit this with intel-gfx mailing list on cc (like for
> > > i915)? There's a CI bot there which runs a few vgem tests, would be good
> > > to confirm nothing has been broken.
> >
> > Hi Daniel,
> > sure. I will correct the summary typo and also feed it to the CI bot.
> >
> > Also, according to Felix Kuehling's comment on a similar patch for
> > drm/amdkfd driver, an ID can be 0. The change I am proposing is more
> > efficient for conditions that do not want to use ID as 0. Otherwise,
> > id = 0 is an acceptable possibility. So, my statement that "Id 0 is an invalid
> > identifier" is not true.
> >
> > Can you please comment if this is accurate and I should reword my log
> > message as well?
> 
> You need to review the vgem code to see whether we're using id 0 as
> invalid identifier or not. That's part of the work that needs to be
> done here. Best would be to explain the evidence you've found in the
> commit message, why id 0 is invalid for this specific code. Since yes
> in general that's not true, it depends how the idr is used.
> -Daniel
> 
You are correct. For the vgem driver, id 0 is not used. The patch
should then apply to this driver.

Thank you very much Daniel. I have just sent v2 of the patch with your
suggestions.

./drv

> >
> > Thank you.
> > ./drv
> >
> > >
> > > Otherwise lgtm.
> > >
> > > Thanks, Daniel
> > >
> > > > ---
> > > >  drivers/gpu/drm/vgem/vgem_fence.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/vgem/vgem_fence.c b/drivers/gpu/drm/vgem/vgem_fence.c
> > > > index 17f32f550dd9..2902dc6e64fa 100644
> > > > --- a/drivers/gpu/drm/vgem/vgem_fence.c
> > > > +++ b/drivers/gpu/drm/vgem/vgem_fence.c
> > > > @@ -233,7 +233,7 @@ int vgem_fence_signal_ioctl(struct drm_device *dev,
> > > >  int vgem_fence_open(struct vgem_file *vfile)
> > > >  {
> > > >     mutex_init(&vfile->fence_mutex);
> > > > -   idr_init(&vfile->fence_idr);
> > > > +   idr_init_base(&vfile->fence_idr, 1);
> > > >
> > > >     return 0;
> > > >  }
> > > > --
> > > > 2.25.1
> > > >
> > >
> > > --
> > > Daniel Vetter
> > > Software Engineer, Intel Corporation
> > > http://blog.ffwll.ch
> 
> 
> 
> -- 
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
