Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA0527E79B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 13:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728500AbgI3LZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 07:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbgI3LZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 07:25:27 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875FBC0613D0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 04:25:27 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id a2so1412801otr.11
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 04:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XPhNhgXjvXmO6qMe12Ico/ebR2/givwfQj61bckl1Qw=;
        b=ilt2tbwC7TC34+YDgjBCThqgVJBSTbEAwVvPYe1QHXusF6Z5z6Qhipdawxa2ueUHc/
         Z29fDYlSSnSdMgyHlZLEHRHHCCrU1VXxd0D4yc1r5I1TFQ8HqE4YbmwyD3qvfYnx7QeP
         4NwAkOjWuoMBi53qM8r+48EmM0QeY7MrIr5Fs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XPhNhgXjvXmO6qMe12Ico/ebR2/givwfQj61bckl1Qw=;
        b=L3xsWELfKCaPVzwYwbWqLM1PvErGemovWlAPw23GhrlpoFQahuRIRiiPPbK+wnfO73
         3vN9dHFb7DyzUqDreFLh19lGszNMZ+DEqg/dj3ZzxkXfG0gJ0QPEF2iSeb47D0wlTVWT
         e77pVEZaCkdxF/JsnFnOG+YFtC3ppZv/orYHk11r8bCNd7hcPF6R9bKBiDqZ2bvFsPot
         4S2fWuQfkw8/Lbur6wCJmeE7u1cY+21lMbPubqW/z3XadetuLPXJv3ELkmrFar0QI4d4
         Ri8ZNJAwZQe66fZ5HZ5xblQNhjLH2i65iyNP90KaOaIDDjOzIhK2JUNOtwCDpkIXOPYq
         m3OQ==
X-Gm-Message-State: AOAM5306GRKEFCvPqHnL8laRqdgYuQ/IGFXf6HJNeIaYTzld3tenSIj/
        G1FtRV31EbX/hgqhAMXAeO6mkC5nI0OPFleDKtKGBw==
X-Google-Smtp-Source: ABdhPJxEgm74LL2epdjXJXLLzINvmmFbGywbDO4Fc87teAZPaKspdA7yDK4a1Y64+ZE5t7m/SLjyxrDFnCEfpchc8Ko=
X-Received: by 2002:a05:6830:1e56:: with SMTP id e22mr1190431otj.303.1601465125944;
 Wed, 30 Sep 2020 04:25:25 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000006b9e8d059952095e@google.com> <cover.1600953813.git.yepeilin.cs@gmail.com>
 <3f754d60-1d35-899c-4418-147d922e29af@kernel.org> <20200925101300.GA890211@PWN>
 <20200925132551.GF438822@phenom.ffwll.local> <20200929123420.GA1143575@PWN>
 <CAKMK7uFY2zv0adjKJ_ORVFT7Zzwn075MaU0rEU7_FuqENLR=UA@mail.gmail.com>
 <20200930071151.GA1152145@PWN> <20200930095317.GX438822@phenom.ffwll.local> <20200930105553.GA1154238@PWN>
In-Reply-To: <20200930105553.GA1154238@PWN>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 30 Sep 2020 13:25:14 +0200
Message-ID: <CAKMK7uFzWZgs4rvqSXqn_ifr8utG_rNw54+y6CWjdV=Epak-iQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] Prevent out-of-bounds access for built-in font data buffers
To:     Peilin Ye <yepeilin.cs@gmail.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 12:56 PM Peilin Ye <yepeilin.cs@gmail.com> wrote:
>
> On Wed, Sep 30, 2020 at 11:53:17AM +0200, Daniel Vetter wrote:
> > On Wed, Sep 30, 2020 at 03:11:51AM -0400, Peilin Ye wrote:
> > > On Tue, Sep 29, 2020 at 04:38:49PM +0200, Daniel Vetter wrote:
> > > > On Tue, Sep 29, 2020 at 2:34 PM Peilin Ye <yepeilin.cs@gmail.com> wrote:
> > > > > Ah, and speaking of built-in fonts, see fbcon_startup():
> > > > >
> > > > >         /* Setup default font */
> > > > >                 [...]
> > > > >                 vc->vc_font.charcount = 256; /* FIXME  Need to support more fonts */
> > > > >                             ^^^^^^^^^^^^^^^
> > > > >
> > > > > This is because find_font() and get_default_font() return a `struct
> > > > > font_desc *`, but `struct font_desc` doesn't contain `charcount`. I
> > > > > think we also need to add a `charcount` field to `struct font_desc`.
> > > >
> > > > Hm yeah ... I guess maybe struct font_desc should be the starting
> > > > point for the kernel internal font structure. It's at least there
> > > > already ...
> > >
> > > I see, that will also make handling built-in fonts much easier!
> >
> > I think the only downside with starting with font_desc as the internal
> > font represenation is that there's a few fields we don't need/have for
> > userspace fonts (like the id/name stuff). So any helpers to e.g. print out
> > font information need to make sure they don't trip over that
> >
> > But otherwise I don't see a problem with this, I think.
>
> Yes, and built-in fonts don't use refcount. Or maybe we can let
> find_font() and get_default_font() kmalloc() a copy of built-in font
> data, then keep track of refcount for both user and built-in fonts, but
> that will waste a few K of memory for each built-in font we use...

A possible trick for this would be to make sure built-in fonts start
out with a refcount of 1. So never get freed. Plus maybe a check that
if the name is set, then it's a built-in font and if we ever underflow
the refcount we just WARN, but don't free anything.

Another trick would be kern_font_get/put wrappers (we'd want those
anyway if the userspace fonts are refcounted) and if kern_font->name
!= NULL (i.e. built-in font with name) then we simply don't call
kref_get/put.
-Daniel

> > > > I think for vc_date->vc_font we might need a multi-step approach:
> > > > - first add a new helper function which sets the font for a vc using
> > > > an uapi console_font struct (and probably hard-coded assumes cnt ==
> > > > 256.
> > >
> > > But user fonts may have a charcount different to 256... But yes I'll try
> > > to figure out how.
> >
> > Hm yeah, maybe we need a helper to give us the charcount then, which by
> > default is using the magic negative offset.
>
> Ah, I see! :)
>
> > Then once we've converted everything over to explicitly passing charcount
> > around, we can switch that helper. So something like
> >
> > int kern_font_charcount(struct kern_font *font);
> >
> > Feel free to bikeshed the struct name however you see fit :-)
>
> I think both `kern_font` and `font_desc` makes sense, naming is so
> hard...
>
> > > > For first steps I'd start with demidlayering some of the internal
> > > > users of uapi structs, like the console_font_op really shouldn't be
> > > > used anywhere in any function, except in the ioctl handler that
> > > > converts it into the right function call. You'll probably discover a
> > > > few other places like this on the go.
> > >
> > > Sure, I'll start from this, then cleaning up these dummy functions, then
> > > `vc_data`. Thank you for the insights!
> >
> > Please don't take this rough plan as fixed, it's just where I'd start from
> > browsing the code and your analysis a bit. We'll probably have to adapt as
> > we go and more nasty things turn up ...
>
> Sure, I'll first give it a try and see. Thank you!
>
> Peilin Ye
>


-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
