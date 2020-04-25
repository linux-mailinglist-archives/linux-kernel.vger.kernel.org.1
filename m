Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6551B82AD
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Apr 2020 02:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbgDYARL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Apr 2020 20:17:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:33858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725851AbgDYARL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 20:17:11 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E7A82074F;
        Sat, 25 Apr 2020 00:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587773830;
        bh=KEl2gaBXH+6X5dWaLezp/cb/E07YVVUK5C2T1SMzhQw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=OmTWmL9q4YaYV0vu1h8mlnADBMP49KOWl8s5Y/AIeBUxNChvZmnoFQGftiqZqkoWg
         D7Fv9jlnMDUvX3rCmgwVsuQYf6oLzoRkXKpW5m9dW1bayt+2x9IDNliOrFt1qs86Zr
         BG4UwMNsxK/M9sWdAiFC6p2x5qz94gPZNDnHzuHw=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 724CF352339B; Fri, 24 Apr 2020 17:17:10 -0700 (PDT)
Date:   Fri, 24 Apr 2020 17:17:10 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Will Deacon <will@kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/2] kcsan: Add __kcsan_{enable,disable}_current()
 variants
Message-ID: <20200425001710.GF17661@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200424154730.190041-1-elver@google.com>
 <CANpmjNOaUc8-Y4MMre5mWLjywTZ+B0B9L-cQijeYEMcw9Vapsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNOaUc8-Y4MMre5mWLjywTZ+B0B9L-cQijeYEMcw9Vapsw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 24, 2020 at 05:57:04PM +0200, Marco Elver wrote:
> On Fri, 24 Apr 2020 at 17:47, Marco Elver <elver@google.com> wrote:
> >
> > The __kcsan_{enable,disable}_current() variants only call into KCSAN if
> > KCSAN is enabled for the current compilation unit. Note: This is
> > typically not what we want, as we usually want to ensure that even calls
> > into other functions still have KCSAN disabled.
> >
> > These variants may safely be used in header files that are shared
> > between regular kernel code and code that does not link the KCSAN
> > runtime.
> >
> > Signed-off-by: Marco Elver <elver@google.com>
> > ---
> > This is to help with the new READ_ONCE()/WRITE_ONCE():
> > https://lkml.kernel.org/r/20200424134238.GE21141@willie-the-truck
> >
> > These should be using __kcsan_disable_current() and
> > __kcsan_enable_current(), instead of the non-'__' variants.
> > ---
> 
> Paul: These 2 patches may want to be in the set for 5.8, depending on
> what Will wants to do.
> 
> An alternative would be that Will takes my 2 patches and carries them,
> avoiding some complex patch-dependency. That is assuming his set of
> patches will go in -tip on top of KCSAN.

For the moment I have pulled them into -rcu and am testing them,
thank you!  I will leave them in the v5.9 bucket for the moment,
but please let me know how things proceed with Will.

							Thanx, Paul

> Thanks,
> -- Marco
> 
> >  include/linux/kcsan-checks.h | 17 ++++++++++++++---
> >  kernel/kcsan/core.c          |  7 +++++++
> >  2 files changed, 21 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/linux/kcsan-checks.h b/include/linux/kcsan-checks.h
> > index ef95ddc49182..7b0b9c44f5f3 100644
> > --- a/include/linux/kcsan-checks.h
> > +++ b/include/linux/kcsan-checks.h
> > @@ -49,6 +49,7 @@ void kcsan_disable_current(void);
> >   * Supports nesting.
> >   */
> >  void kcsan_enable_current(void);
> > +void kcsan_enable_current_nowarn(void); /* Safe in uaccess regions. */
> >
> >  /**
> >   * kcsan_nestable_atomic_begin - begin nestable atomic region
> > @@ -149,6 +150,7 @@ static inline void __kcsan_check_access(const volatile void *ptr, size_t size,
> >
> >  static inline void kcsan_disable_current(void)         { }
> >  static inline void kcsan_enable_current(void)          { }
> > +static inline void kcsan_enable_current_nowarn(void)   { }
> >  static inline void kcsan_nestable_atomic_begin(void)   { }
> >  static inline void kcsan_nestable_atomic_end(void)     { }
> >  static inline void kcsan_flat_atomic_begin(void)       { }
> > @@ -165,15 +167,24 @@ static inline void kcsan_end_scoped_access(struct kcsan_scoped_access *sa) { }
> >
> >  #endif /* CONFIG_KCSAN */
> >
> > +#ifdef __SANITIZE_THREAD__
> >  /*
> > - * kcsan_*: Only calls into the runtime when the particular compilation unit has
> > - * KCSAN instrumentation enabled. May be used in header files.
> > + * Only calls into the runtime when the particular compilation unit has KCSAN
> > + * instrumentation enabled. May be used in header files.
> >   */
> > -#ifdef __SANITIZE_THREAD__
> >  #define kcsan_check_access __kcsan_check_access
> > +
> > +/*
> > + * Only use these to disable KCSAN for accesses in the current compilation unit;
> > + * calls into libraries may still perform KCSAN checks.
> > + */
> > +#define __kcsan_disable_current kcsan_disable_current
> > +#define __kcsan_enable_current kcsan_enable_current_nowarn
> >  #else
> >  static inline void kcsan_check_access(const volatile void *ptr, size_t size,
> >                                       int type) { }
> > +static inline void __kcsan_enable_current(void)  { }
> > +static inline void __kcsan_disable_current(void) { }
> >  #endif
> >
> >  /**
> > diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
> > index 40919943617b..0a0f018cb154 100644
> > --- a/kernel/kcsan/core.c
> > +++ b/kernel/kcsan/core.c
> > @@ -625,6 +625,13 @@ void kcsan_enable_current(void)
> >  }
> >  EXPORT_SYMBOL(kcsan_enable_current);
> >
> > +void kcsan_enable_current_nowarn(void)
> > +{
> > +       if (get_ctx()->disable_count-- == 0)
> > +               kcsan_disable_current();
> > +}
> > +EXPORT_SYMBOL(kcsan_enable_current_nowarn);
> > +
> >  void kcsan_nestable_atomic_begin(void)
> >  {
> >         /*
> > --
> > 2.26.2.303.gf8c07b1a785-goog
> >
