Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC692E0DB3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 18:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbgLVRMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 12:12:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727225AbgLVRMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 12:12:06 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0384CC0613D6;
        Tue, 22 Dec 2020 09:11:26 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id q5so12597957ilc.10;
        Tue, 22 Dec 2020 09:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AINn8Nb9q8jvWLVllpPnrH3quR2dm0zbu53bd3Z1QEM=;
        b=OcnlWLaXZ87Ny1FYkp/STIe/tMokwF7G5NePJX6JueRCVHVN/2elCWq2SdIGJ+rY4C
         WH+fYThmcMzOFbPb3aZDAq6R8Hp3I3GU3DhkM59IaSAEAtbu7D5R8mQQnLMg48Kf6Xck
         aVYsLGe1sQph/M5JrGLLxs+Bo3SoQgp/0CT3j1pR8v2iXgXYoT4UM8F6JVi3oAki5C5S
         WHMhCtf5tbsXXvY1cxBQbAUKF2aS8XdZBTAG5chy17i+MaSk/g1Yz3EZDvkaOoajYk1O
         mF0zht+fjY0wjO6sfSUJsBROKOP/hzXMomaO0ly0MEx+7kxnrpVUCaMQIKiQw914b3Dy
         v8pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AINn8Nb9q8jvWLVllpPnrH3quR2dm0zbu53bd3Z1QEM=;
        b=MdxDozQCov6df3OGOOpUj29fCroOFn5Rjgm4xq1OuY4IgjBVTnFwqmSzcWvm25bsIq
         zkAvOKxdbxMJnHx+8J5hCNU0sg+dODA2O4ldzKmNmJvlTlu0t16hB/B++O5g6L0kigrG
         w38rkbqc5Dvd47mP9JLQ2iDUN5BiAgzkt3CdmOBpmamAwhUX1RNuBSqaenuMtSh762HQ
         nb+cTpt1QqfyEIpouw4Lufwu+cvrdT9/KIz+LDW0f2EcrMT8HvR/ej21Y+vvyZDrIc/h
         S6wZEp3w+sGzNppnqloRt3IkomBb6jtrleApTtNFuRfF8Y7DOtdBl3XUwJJSGEbJGBVv
         ciDA==
X-Gm-Message-State: AOAM533E/z3TuleBLVYkDAIitwNcTO/gj33M3/XD98Dw9L7QB/z/dQ1p
        2bKd5tEaUMQC4fLKoydY2XtOfoZDQM9TbZUVAgIMAmTl+5E=
X-Google-Smtp-Source: ABdhPJyjewsF6LN9BzDE3u42TsMLG/EfcpvoC9t225/gplNBE3msFizR70EcnejPc1vXA1P5F1kTLaVC8Y3sxdjTJRk=
X-Received: by 2002:a92:512:: with SMTP id q18mr21940753ile.147.1608657085336;
 Tue, 22 Dec 2020 09:11:25 -0800 (PST)
MIME-Version: 1.0
References: <1608064956-5512-1-git-send-email-milan.lakhani@codethink.co.uk>
 <20201221095209.4dd4233e@lwn.net> <CAKXUXMwR9i5bJx+_rXkv4SK0yU1cHpGexH9RjsN7UFqJ-Ozsew@mail.gmail.com>
 <7a6ab1d3-a5f5-d4ae-61e2-0a52419732f6@infradead.org>
In-Reply-To: <7a6ab1d3-a5f5-d4ae-61e2-0a52419732f6@infradead.org>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Tue, 22 Dec 2020 18:11:14 +0100
Message-ID: <CAKXUXMxU1EQ+n+AsiQWNPxx=iO-U_e1V6dwqABbn=uJ8CCxepw@mail.gmail.com>
Subject: Re: [PATCH v2] Documentation: process: Correct numbering
To:     Randy Dunlap <rdunlap@infradead.org>,
        Milan Lakhani <milan.lakhani@codethink.co.uk>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-safety@lists.elisa.tech,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 22, 2020 at 5:36 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 12/22/20 8:23 AM, Lukas Bulwahn wrote:
> > On Mon, Dec 21, 2020 at 5:52 PM Jonathan Corbet <corbet@lwn.net> wrote:
> >>
> >> On Tue, 15 Dec 2020 20:42:36 +0000
> >> Milan Lakhani <milan.lakhani@codethink.co.uk> wrote:
> >>
> >>> Renumber the steps in submit-checklist.rst as some numbers were skipped.
> >>>
> >>> Fixes: 72deb455b5ec ("block: remove CONFIG_LBDAF")
> >>> Signed-off-by: Milan Lakhani <milan.lakhani@codethink.co.uk>
> >>> ---
> >>>  Documentation/process/submit-checklist.rst | 24 ++++++++++++------------
> >>>  1 file changed, 12 insertions(+), 12 deletions(-)
> >>>
> >>> diff --git a/Documentation/process/submit-checklist.rst b/Documentation/process/submit-checklist.rst
> >>> index 1879f88..230ee42 100644
> >>> --- a/Documentation/process/submit-checklist.rst
> >>> +++ b/Documentation/process/submit-checklist.rst
> >>> @@ -75,44 +75,44 @@ and elsewhere regarding submitting Linux kernel patches.
> >>>  13) Has been build- and runtime tested with and without ``CONFIG_SMP`` and
> >>>      ``CONFIG_PREEMPT.``
> >>>
> >>> -16) All codepaths have been exercised with all lockdep features enabled.
> >>> +14) All codepaths have been exercised with all lockdep features enabled.
> >>>
> >>> -17) All new ``/proc`` entries are documented under ``Documentation/``
> >>> +15) All new ``/proc`` entries are documented under ``Documentation/``
> >> [...]
> >>
> >> I've applied this, but, if you're going to stick a "Fixes" tag onto a
> >> patch, it's probably only polite to copy the original author.  I'm not
> >> fully convinced that the tag is warranted in this case.
> >>
> >> This document seems out of date in a number of ways; it could really use a
> >> rather more thorough updating than this.
> >>
> >
> > Jon, I completely agree on your out-of-date comment. That is why we
> > pointed Milan to that checklist to start with some small basic changes
> > and continue with increasingly more challenging and complex updates.
> >
> > Milan, next update for you to consider: what does "make headers_check"
> > do nowadays? (spoiler alert: it does nothing) Adjust the documentation
> > for that.
> >
> > Then, a more general improvement: think about structuring the
> > checklist to follow the structure of the other submission guidelines.
> > So, reorder the current checklist and check if the step is mentioned
> > in submitting-patches and where and make the checklist much more
> > aligned to submitting-patches.
>
> Please do not move item #1. It is #1 for a reason.
>

Randy, thanks for your hint.

We will consider that. I never considered this list ordered by
priority but maybe somebody did really consider it with those
priorities. To me, it seemed rather randomly sorted (with some
duplicates) or somehow sorted by the various topics a patch might
touch (e.g., some rules on Kconfig, then some rules for device
drivers, then some on documenting APIs, then some on testing options).

Interestingly, I could not find any mention of checklist item #1 in
development-process.rst and further linked pages, despite it being
very explicit on various other points.

Just for the record on my investigation, it is also not mentioned in
submitting-patches, which I did not expect, though, because that guide
touches more on the specific stage of preparing a submission than on
the creation of a code change.

So, if item #1 is so important to the development process, it might
deserve to be mentioned elsewhere with some explanation as well.

Side remark: I am also wondering if a clang-tidy check could actually
check that property of proper includes with a quick rule; that would
be a nice showcase for clang-tidy if that can be implemented quickly.

Milan, you see there is quite some potential work here.

Milan, maybe you can find some good way of structuring the checklist
and make sure that #1 is still clear to be most important.

I am happy to assist you, Milan, on improving this checklist.

Lukas
