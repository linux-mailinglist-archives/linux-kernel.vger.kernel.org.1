Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6CA2A7CC3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 12:16:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730059AbgKELQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 06:16:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgKELQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 06:16:47 -0500
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F43BC0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 03:16:47 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id x1so1250034oic.13
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 03:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UszkOiciKi1uHSlkdshllKEw9+T6ITNIT1mnjF8bYTY=;
        b=R0t4CKpyo+uaCbfna6NGaIp9rLnm26RsohzyWNNDVpMXpRLkwzdJoPYsdthmBnsJi+
         izN+ltDHSwXYQ+7GMJORyR+T+1JeK3FjYoLK401V0Y2cCRvxXvHANDwXmSoTwq0+1zEw
         ecoDwMZ8RZWe0v5Pe1lPc/iAujCW8VgaahM1s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UszkOiciKi1uHSlkdshllKEw9+T6ITNIT1mnjF8bYTY=;
        b=o8zHEzoxgkBVL9fmR26Uc3nHYRHs5+diam0UoACqC0JdRcyr22a/YCht/PIOY9QBtK
         Ll6OZrkn6e5WOiFWIR9SMLOAfRl2uwnJAxWN4K/OhAPyBmLO3tyH+8zOGHiVbqKl0G1r
         0Z+X/HnB4IS8o/jYNWzq+bwpzOLcRMaljRUgG4JNdPX0u1D7yfsyOgMkygmIbtoqnXMa
         8ryyoqxuJqMMsmzXucDsHCip8Frvx3VX2zEh9Nn5S643PjwyYLrZNVYaFMN2WakclbWJ
         uloB/ch09tyWpz27PfEWRl7dxDjsuFKGDtEaLt0d4Ytvwk5wN9FXzFKWoYteOnesb8EH
         Heaw==
X-Gm-Message-State: AOAM532rC36qYkZAmKLDZ5k5U4oj9JUG3QPnc+g18pNhHh4njfkUMdEG
        ftprAj4zqcHTajlMBJz5/aGPHynWbvv62lnI9lKisHBmWS3WPg==
X-Google-Smtp-Source: ABdhPJy7rvSgYNi1XYKgWMkyr7U0fbTSy8ZOBfLBzFaROy9lsHMPGmQFMIqiUbMl7tzF52kCTP0NO6wtuawINX+sUVc=
X-Received: by 2002:aca:b141:: with SMTP id a62mr1132355oif.101.1604575006528;
 Thu, 05 Nov 2020 03:16:46 -0800 (PST)
MIME-Version: 1.0
References: <20201104112338.GA29271@localhost> <20201105094215.GT401619@phenom.ffwll.local>
 <20201105103116.GA29881@localhost>
In-Reply-To: <20201105103116.GA29881@localhost>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Thu, 5 Nov 2020 12:16:34 +0100
Message-ID: <CAKMK7uF0buRA-FfoY2=FbZQO-cqgSwZXRWwNQ2xkBdZAS=JuRA@mail.gmail.com>
Subject: Re: [PATCH] drm/vgm: replace idr_init() by idr_init_base()
To:     Deepak R Varma <mh12gx2825@gmail.com>
Cc:     David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 5, 2020 at 11:31 AM Deepak R Varma <mh12gx2825@gmail.com> wrote:
>
> On Thu, Nov 05, 2020 at 10:42:15AM +0100, Daniel Vetter wrote:
> > On Wed, Nov 04, 2020 at 04:53:38PM +0530, Deepak R Varma wrote:
> > > idr_init() uses base 0 which is an invalid identifier. The new function
> > > idr_init_base allows IDR to set the ID lookup from base 1. This avoids
> > > all lookups that otherwise starts from 0 since 0 is always unused.
> > >
> > > References: commit 6ce711f27500 ("idr: Make 1-based IDRs more efficient")
> > >
> > > Signed-off-by: Deepak R Varma <mh12gx2825@gmail.com>
> >
> > Tiny typo in the commit message summary: s/vgm/vgem/
> >
> > Also can you pls resbumit this with intel-gfx mailing list on cc (like for
> > i915)? There's a CI bot there which runs a few vgem tests, would be good
> > to confirm nothing has been broken.
>
> Hi Daniel,
> sure. I will correct the summary typo and also feed it to the CI bot.
>
> Also, according to Felix Kuehling's comment on a similar patch for
> drm/amdkfd driver, an ID can be 0. The change I am proposing is more
> efficient for conditions that do not want to use ID as 0. Otherwise,
> id = 0 is an acceptable possibility. So, my statement that "Id 0 is an invalid
> identifier" is not true.
>
> Can you please comment if this is accurate and I should reword my log
> message as well?

You need to review the vgem code to see whether we're using id 0 as
invalid identifier or not. That's part of the work that needs to be
done here. Best would be to explain the evidence you've found in the
commit message, why id 0 is invalid for this specific code. Since yes
in general that's not true, it depends how the idr is used.
-Daniel

>
> Thank you.
> ./drv
>
> >
> > Otherwise lgtm.
> >
> > Thanks, Daniel
> >
> > > ---
> > >  drivers/gpu/drm/vgem/vgem_fence.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/gpu/drm/vgem/vgem_fence.c b/drivers/gpu/drm/vgem/vgem_fence.c
> > > index 17f32f550dd9..2902dc6e64fa 100644
> > > --- a/drivers/gpu/drm/vgem/vgem_fence.c
> > > +++ b/drivers/gpu/drm/vgem/vgem_fence.c
> > > @@ -233,7 +233,7 @@ int vgem_fence_signal_ioctl(struct drm_device *dev,
> > >  int vgem_fence_open(struct vgem_file *vfile)
> > >  {
> > >     mutex_init(&vfile->fence_mutex);
> > > -   idr_init(&vfile->fence_idr);
> > > +   idr_init_base(&vfile->fence_idr, 1);
> > >
> > >     return 0;
> > >  }
> > > --
> > > 2.25.1
> > >
> >
> > --
> > Daniel Vetter
> > Software Engineer, Intel Corporation
> > http://blog.ffwll.ch



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
