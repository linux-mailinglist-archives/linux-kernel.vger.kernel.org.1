Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1E21D1C8C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 May 2020 19:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389985AbgEMRry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 May 2020 13:47:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:39528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732670AbgEMRry (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 13:47:54 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D060205ED;
        Wed, 13 May 2020 17:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589392073;
        bh=64XpWK0I1GiESXwdrMeHn0bioGw4ekTpqsu47mGpGPc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bfQogv8gvtMXjDqLZGW+c91J8DJzphV/C2BFil7WUJrU381fYrtj6fZEcBImre81t
         NrN172gCzV49QviZJjgetezTJNkqz5LtMBwi40BchiKIFqSxl8xRtLEmFsK0YVzOP5
         qa1cfSgy6Whh2jxACy/DkzPU4ac3afuKfd/PpHVs=
Date:   Wed, 13 May 2020 18:47:48 +0100
From:   Will Deacon <will@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH v5 00/18] Rework READ_ONCE() to improve codegen
Message-ID: <20200513174747.GB24836@willie-the-truck>
References: <CANpmjNNo3rhwqG=xEbpP9JiSd8-Faw8fkoUhYJjesHK5S5_KQQ@mail.gmail.com>
 <20200512190755.GL2957@hirez.programming.kicks-ass.net>
 <CANpmjNNeSnrAgfkskE5Y0NNu3-DS6hk+SwjkBunrr8FRxwwT-Q@mail.gmail.com>
 <20200513111057.GN2957@hirez.programming.kicks-ass.net>
 <CANpmjNMariz3-keqwUsLHVrpk2r7ThLSKtkhHxTDa3SEGeznhA@mail.gmail.com>
 <20200513123243.GO2957@hirez.programming.kicks-ass.net>
 <20200513124021.GB20278@willie-the-truck>
 <CANpmjNM5XW+ufJ6Mw2Tn7aShRCZaUPGcH=u=4Sk5kqLKyf3v5A@mail.gmail.com>
 <20200513165008.GA24836@willie-the-truck>
 <CANpmjNN=n59ue06s0MfmRFvKX=WB2NgLgbP6kG_MYCGy2R6PHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNN=n59ue06s0MfmRFvKX=WB2NgLgbP6kG_MYCGy2R6PHg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 07:32:58PM +0200, Marco Elver wrote:
> On Wed, 13 May 2020 at 18:50, Will Deacon <will@kernel.org> wrote:
> >
> > On Wed, May 13, 2020 at 03:15:55PM +0200, Marco Elver wrote:
> > > On Wed, 13 May 2020 at 14:40, Will Deacon <will@kernel.org> wrote:
> > > >
> > > > On Wed, May 13, 2020 at 02:32:43PM +0200, Peter Zijlstra wrote:
> > > > > On Wed, May 13, 2020 at 01:48:41PM +0200, Marco Elver wrote:
> > > > >
> > > > > > Disabling most instrumentation for arch/x86 is reasonable. Also fine
> > > > > > with the __READ_ONCE/__WRITE_ONCE changes (your improved
> > > > > > compiler-friendlier version).
> > > > > >
> > > > > > We likely can't have both: still instrument __READ_ONCE/__WRITE_ONCE
> > > > > > (as Will suggested) *and* avoid double-instrumentation in arch_atomic.
> > > > > > If most use-cases of __READ_ONCE/__WRITE_ONCE are likely to use
> > > > > > data_race() or KCSAN_SANITIZE := n anyway, I'd say it's reasonable for
> > > > > > now.
> > > >
> > > > I agree that Peter's patch is the right thing to do for now. I was hoping we
> > > > could instrument __{READ,WRITE}_ONCE(), but that we before I realised that
> > > > __no_sanitize_or_inline doesn't seem to do anything.
> > > >
> > > > > Right, if/when people want sanitize crud enabled for x86 I need
> > > > > something that:
> > > > >
> > > > >  - can mark a function 'no_sanitize' and all code that gets inlined into
> > > > >    that function must automagically also not get sanitized. ie. make
> > > > >    inline work like macros (again).
> > > > >
> > > > > And optionally:
> > > > >
> > > > >  - can mark a function explicitly 'sanitize', and only when an explicit
> > > > >    sanitize and no_sanitize mix in inlining give the current
> > > > >    incompatible attribute splat.
> > > > >
> > > > > That way we can have the noinstr function attribute imply no_sanitize
> > > > > and frob the DEFINE_IDTENTRY*() macros to use (a new) sanitize_or_inline
> > > > > helper instead of __always_inline for __##func().
> > > >
> > > > Sounds like a good plan to me, assuming the compiler folks are onboard.
> > > > In the meantime, can we kill __no_sanitize_or_inline and put it back to
> > > > the old __no_kasan_or_inline, which I think simplifies compiler.h and
> > > > doesn't mislead people into using the function annotation to avoid KCSAN?
> > > >
> > > > READ_ONCE_NOCHECK should also probably be READ_ONCE_NOKASAN, but I
> > > > appreciate that's a noisier change.
> > >
> > > So far so good, except: both __no_sanitize_or_inline and
> > > __no_kcsan_or_inline *do* avoid KCSAN instrumenting plain accesses, it
> > > just doesn't avoid explicit kcsan_check calls, like those in
> > > READ/WRITE_ONCE if KCSAN is enabled for the compilation unit. That's
> > > just because macros won't be redefined just for __no_sanitize
> > > functions. Similarly, READ_ONCE_NOCHECK does work as expected, and its
> > > access is unchecked.
> > >
> > > This will have the expected result:
> > > __no_sanitize_or_inline void foo(void) { x++; } // no data races reported
> > >
> > > This will not work as expected:
> > > __no_sanitize_or_inline void foo(void) { READ_ONCE(x); }  // data
> > > races are reported
> >
> > But the problem is that *this* does not work as expected:
> >
> > unsigned long __no_sanitize_or_inline foo(unsigned long *ptr)
> > {
> >         return READ_ONCE_NOCHECK(*ptr);
> > }
> >
> > which I think means that the function annotation is practically useless.
> 
> Let me understand the problem better:
> 
> - We do not want __tsan_func_entry/exit (looking at the disassembly,
> these aren't always generated).
> - We do not want kcsan_disable/enable calls (with the new __READ_ONCE version).
> - We do *not* want the call to __read_once_word_nocheck if we have
> __no_sanitize_or_inline. AFAIK that's the main problem -- this applies
> to both KASAN and KCSAN.

Sorry, I should've been more explicit. The code above, with KASAN enabled,
compiles to:

ffffffff810a2d50 <foo>:
ffffffff810a2d50:       48 8b 07                mov    (%rdi),%rax
ffffffff810a2d53:       c3                      retq

but with KCSAN enabled, compiles to:

ffffffff8109ecd0 <foo>:
ffffffff8109ecd0:       53                      push   %rbx
ffffffff8109ecd1:       48 89 fb                mov    %rdi,%rbx
ffffffff8109ecd4:       48 8b 7c 24 08          mov    0x8(%rsp),%rdi
ffffffff8109ecd9:       e8 52 9c 1a 00          callq  ffffffff81248930 <__tsan_func_entry>
ffffffff8109ecde:       48 89 df                mov    %rbx,%rdi
ffffffff8109ece1:       e8 1a 00 00 00          callq  ffffffff8109ed00 <__read_once_word_nocheck>
ffffffff8109ece6:       48 89 c3                mov    %rax,%rbx
ffffffff8109ece9:       e8 52 9c 1a 00          callq  ffffffff81248940 <__tsan_func_exit>
ffffffff8109ecee:       48 89 d8                mov    %rbx,%rax
ffffffff8109ecf1:       5b                      pop    %rbx
ffffffff8109ecf2:       c3                      retq

Is that expected? There don't appear to be any more annotations to throw
at it.

> From what I gather, we want to just compile the function as if the
> sanitizer was never enabled. One reason for why this doesn't quite
> work is because of the preprocessor.
> 
> Note that the sanitizers won't complain about these accesses, which
> unfortunately is all these attributes ever were documented to do. So
> the attributes aren't completely useless. Why doesn't
> K[AC]SAN_SANITIZE := n work?

I just don't get the point in having a function annotation if you then have to
pass flags at the per-object level. That also then necessitates either weird
refactoring and grouping of code into "noinstrument.c" type files, or blanket
disabling of instrumentation for things like arch/x86/

Will
