Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37A562EF882
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 21:05:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729108AbhAHUEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 15:04:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729057AbhAHUE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 15:04:29 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB939C0612AD
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 12:03:13 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id h205so25798081lfd.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 12:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PmspDcv/ocVoLjM7eZCys1d3yrpEciEb1QwZ9ZHCG10=;
        b=BK/5L/vmNIcg4m+RxJlM6MSBoYFNRgclyJ3q7dL4Xn+udGNWmcjBD/magHIwpo/iOs
         W4/GoBbDVvgnMvBl4GEuZQbo3jGtrL4vsK3dKcclqKMZygPwOVPxGbmLu8GWxVw6SjtZ
         MAsSFa5bDGCIwjrhbwDLN8kkunnSOyISqo78A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PmspDcv/ocVoLjM7eZCys1d3yrpEciEb1QwZ9ZHCG10=;
        b=kTBNJV42r3TuNw3xxh53gi9YXdW3Z0k9Eq07QCpXzjfgzVEKs+lB4vzCjiXwA+9MwK
         R/q0MxSu8AouKDhQBx3N2WVXj/4K386+NAI31cTslkWmX44HSvocF8Njc7M3+VJFYLhU
         v3qaGyg2mkY1QYVvuXq1r6Z55Pi8jaHGNSvhPFmWD+SS9vzdVxtsYRNb2q6xNvMG7L7F
         CGDZBeO2KbniD9YX38DvlaCOc6JN2AIYlohpJHgyTkA63lJm+x9nkkrthzKp6tKpGw2B
         ZYVgwpPhfo2kEghPAi2mAUoWz66PUX6WxTP+nnihO05h2/xXb4w6TZJIZ+rd/2B7Zqfv
         P6hw==
X-Gm-Message-State: AOAM531hjzts45sDkADVm4CKxajg1oI9bF7FM1nS53Is0Y2pqdJFLzMK
        yfi1rPDmtheOWnZcc6CKhevJaLg8DhmFZg==
X-Google-Smtp-Source: ABdhPJwv+tYnwhjOA4nb2zmYKWCikIBftohQSSbYPEaWR8WsFQ1IK2Ii/hcIkMfvBAP9pWt2ROUdoQ==
X-Received: by 2002:a05:6512:22cd:: with SMTP id g13mr2059991lfu.368.1610136191608;
        Fri, 08 Jan 2021 12:03:11 -0800 (PST)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id v23sm2333439ljg.97.2021.01.08.12.03.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jan 2021 12:03:10 -0800 (PST)
Received: by mail-lf1-f49.google.com with SMTP id u25so5024453lfc.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 12:03:10 -0800 (PST)
X-Received: by 2002:ac2:41d9:: with SMTP id d25mr2021963lfi.377.1610136189681;
 Fri, 08 Jan 2021 12:03:09 -0800 (PST)
MIME-Version: 1.0
References: <20210106115359.GB26994@C02TD0UTHF1T.local> <20210106135253.GJ1551@shell.armlinux.org.uk>
 <20210106172033.GA2165@willie-the-truck> <20210106223223.GM1551@shell.armlinux.org.uk>
 <20210107111841.GN1551@shell.armlinux.org.uk> <20210107124506.GO1551@shell.armlinux.org.uk>
 <CAK8P3a2TXPfFpgy+XjpDzOqt1qpDxufwiD-BLNbn4W_jpGp98g@mail.gmail.com>
 <20210107133747.GP1551@shell.armlinux.org.uk> <CAK8P3a2J8fLjPhyV0XUeuRBdSo6rz1gU4wrQRyfzKQvwhf22ag@mail.gmail.com>
 <X/gkMmObbkI4+ip/@hirez.programming.kicks-ass.net> <20210108092655.GA4031@willie-the-truck>
In-Reply-To: <20210108092655.GA4031@willie-the-truck>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 8 Jan 2021 12:02:53 -0800
X-Gmail-Original-Message-ID: <CAHk-=whnKkj5CSbj-uG_MVVUsPZ6ppd_MFhZf_kpXDkh2MAVRA@mail.gmail.com>
Message-ID: <CAHk-=whnKkj5CSbj-uG_MVVUsPZ6ppd_MFhZf_kpXDkh2MAVRA@mail.gmail.com>
Subject: Re: Aarch64 EXT4FS inode checksum failures - seems to be weak memory
 ordering issues
To:     Will Deacon <will@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        linux-toolchains@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 8, 2021 at 1:27 AM Will Deacon <will@kernel.org> wrote:
>
> On Fri, Jan 08, 2021 at 10:21:54AM +0100, Peter Zijlstra wrote:
> > On Thu, Jan 07, 2021 at 10:20:38PM +0100, Arnd Bergmann wrote:
> > > On Thu, Jan 7, 2021 at 2:37 PM Russell King - ARM Linux admin
> >
> > > > So, do we raise the minimum gcc version for the kernel as a whole to 5.1
> > > > or just for aarch64?
> > >
> > > I'd personally love to see gcc-5 as the global minimum version, as that
> > > would let us finally use --std=gnu11 features instead of gnu89. [There are
> > > a couple of useful features that are incompatible with gnu89, and
> > > gnu99/gnu11 support in gcc didn't like the kernel sources]
> >
> > +1 for raising the tree-wide minimum (again!). We actually have a bunch
> > of work-arounds for 4.9 bugs we can get rid of as well.
>
> We even just added another one for arm64 KVM! [1]
>
> So yes, I'm in favour of leaving gcc 4.9 to rot as well, especially after
> this ext4 debugging experience.

Well, honestly, I'm always in favor of having people not use ancient
compilers, but both of the issues at hand do seem to be specific to
arm64.

The "gcc before 5.1 generates incorrect stack pointer writes on arm64"
sounds pretty much deadly, and I think means that yes, for arm64 we
simply need to require 5.1 or newer.

I also suspect there is much less reason to use old gcc's on arm64. I
can't imagine that people really run very old setups, Is some old RHEL
version even relevant for arm64?

So while I'd love to just say "everybody needs to make sure they have
an up-to-date compiler", my git feel is that at least with the current
crop of issues, there is little to really push us globally.

I appreciate Arnd pointing out "--std=gnu11", though. What are the
actual relevant language improvements?

Variable declarations in for-loops is the only one I can think of. I
think that would clean up some code (and some macros), but might not
be compelling on its own.

               Linus
