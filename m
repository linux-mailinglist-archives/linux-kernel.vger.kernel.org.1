Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E84ED283E5F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 20:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728496AbgJESgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 14:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbgJESgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 14:36:18 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D44FDC0613CE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 11:36:17 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id d6so7509822pfn.9
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 11:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0wHD81aAh3Ob3GJ5aVvlWW4RHIkMZdoKTAx2sVZ9fTk=;
        b=vBtU369tbtM2Jid7AFMAhuTduuwSTM4AyN8H4Up07kr8IkkyV4rAC4JG1Fo3Ud/WKw
         ftULS/+AH1HaOFKMLvxqvmghjmqtP+IdxCZvtqdgAiaoW+vIQSms6DS2eDfMi3rPBtdZ
         gxXo00BFLa7vp5wCYmdO3wnLSIhAtRPM9rH4YLuuiqnFNB2xQnGdTepJdHgm70n5o19g
         La9EcHaAVaYi+XoWApK6eTv0t9Jmx2LpV8TUI+8IJk1Xr88aOnVUnTqxi1IRNLpXowOq
         HYgtVuWWJErS+krhYgKuL/+bMVWFZ3xm2/l7IpBM8VCYtnvyqkgKkzueiRKPlH110m5Z
         uIdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0wHD81aAh3Ob3GJ5aVvlWW4RHIkMZdoKTAx2sVZ9fTk=;
        b=YAr5FkC5K0oozUkZ01oTnEVFeDXEoIBJCpNE58LkVouNPZCYHed7eqgBZB1PPsmxHy
         UeuXj4b90oqkAO/I0jp1DW8kng40wEJzHbditxwLqMQE/3mjD1k2SwULBzx7IorL7Gix
         y0gI1L2w8jTWnpSVA8Y7xfjz7YhuJfARWEQ7Qs99Jcqt1WBxJXaAi73qs3iB7xrQWq16
         Iiox5sepN3QKTRo81GcFVqvGXbXicKleUj7EikWdMLbw7xEvhxIQfUYbbfcZ+lPBfDEN
         CfmvtylODN2fJKIyjFVDDQ/Z/bnSugHOv69Qj0bwZ/ghYO8t63i/+lY89ltL/stE8MUA
         bOSg==
X-Gm-Message-State: AOAM532tW96XNw9a7/G7FPSaSIciAsONm1JxtAvZbtsv/X8LUhvyDjH2
        sghkvIxr1GG2bQnU3+iOOrRffYuxOD9L5Tjq2tmeVg==
X-Google-Smtp-Source: ABdhPJyVasB7vnS5oomfZBIDxakgYFf6vf6IbI/3OgIQwWM8b/4BVU4p6FTFIja4W5oPmwJ2iOgszfcF385NslzeVpg=
X-Received: by 2002:a65:6858:: with SMTP id q24mr837940pgt.10.1601922977033;
 Mon, 05 Oct 2020 11:36:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200929192549.501516-1-ndesaulniers@google.com>
 <CA+icZUVgfnVQ1=zjUGhGKnJAs9g3Q06sWN3ffNdrfZMZLCEkbA@mail.gmail.com>
 <133589afbe999347454dfcc46ae782897bf9e3a2.camel@perches.com>
 <46f69161e60b802488ba8c8f3f8bbf922aa3b49b.camel@perches.com>
 <CAKwvOdkhyvTpY6pHT+CLSsBFuKRWsXucjbwN_tyJAsryZXvG1A@mail.gmail.com>
 <417ffa3fd3fba5d4a481db6a0b0c9b48cbbb17c4.camel@perches.com>
 <CAKwvOd=P+j0RaQfHsXPfB0EL3oRgAu8Q0+spUOn_v-p2+3=3pw@mail.gmail.com>
 <aefe941251d5d58062d06099afb58dea1d1d4e17.camel@perches.com>
 <46040e2776a4848add06126ce1cb8f846709294f.camel@perches.com>
 <CANiq72mSjs4myQQtUoegjRggjTx9UF70nAcWoXRoTeLMOuf0xQ@mail.gmail.com>
 <20201001193937.GM28786@gate.crashing.org> <61445711991c2d6eb7c8fb05bed2814458e2593b.camel@perches.com>
In-Reply-To: <61445711991c2d6eb7c8fb05bed2814458e2593b.camel@perches.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 5 Oct 2020 11:36:06 -0700
Message-ID: <CAKwvOdmW4ZSo0yz9ZUjFhjzzDkNAghKYk_hxn9tvrKLBgCXx-A@mail.gmail.com>
Subject: Re: [RFC PATCH next-20200930] treewide: Convert macro and uses of
 __section(foo) to __section("foo")
To:     Joe Perches <joe@perches.com>
Cc:     Segher Boessenkool <segher@kernel.crashing.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>, rcu@vger.kernel.org,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 1, 2020 at 1:19 PM Joe Perches <joe@perches.com> wrote:
>
> On Thu, 2020-10-01 at 14:39 -0500, Segher Boessenkool wrch/ote:
> > Hi!
> >
> > On Thu, Oct 01, 2020 at 12:15:39PM +0200, Miguel Ojeda wrote:
> > > > So it looks like the best option is to exclude these
> > > > 2 files from conversion.
> > >
> > > Agreed. Nevertheless, is there any reason arch/powerpc/* should not be
> > > compiling cleanly with compiler.h? (CC'ing the rest of the PowerPC
> > > reviewers and ML).
> >
> > You need to #include compiler_types.h to get this #define?
>
> Actually no, you need to add
>
> #include <linux/compiler_attributes.h>
>
> to both files and then it builds properly.
>
> Ideally though nothing should include this file directly.

That's because Kbuild injects it via command line flag `-include`.
(Well, it injects compiler_types.h which includes this).  If part of
the tree reset KBUILD_CFLAGS, that `-include` gets dropped.  I don't
think there's anything wrong with manually including it and adding `-I
<path>` (capital i) if needed.

>
> > (The twice-defined thing is a warning, not an error.  It should be fixed
> > of course, but it is less important; although it may be pointing to a
> > deeper problem.)
> >
> >
> > Segher
>


-- 
Thanks,
~Nick Desaulniers
