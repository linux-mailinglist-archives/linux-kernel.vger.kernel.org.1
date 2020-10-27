Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED7D229AB60
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 13:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750494AbgJ0MDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 08:03:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:52684 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392817AbgJ0MDc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 08:03:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603800211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hWGO+wgus4kWHPC+VhS08PmcvN1URgUtllGdjVaM6wQ=;
        b=RXCsYfboU0K+wR/VnqL5H+nN539TqC+ijVXgXjUmH8Un7citZDzkm7UK6a6l2w5LGM/JDc
        Hx628zIDbrzG9K6lB2vd0r41did9Rt7kHwPIjcqPf2O/l2UxMmFyYQjpOqK6gj1oj42W51
        4pWtg4flqZw3XARWlky62WzWkU5qRSE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 80E4FB2F0;
        Tue, 27 Oct 2020 12:03:31 +0000 (UTC)
Date:   Tue, 27 Oct 2020 13:03:30 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] printf: fix Woverride-init warning for EDEADLK errno
Message-ID: <20201027120330.GD31882@alley>
References: <20201026215004.3893088-1-arnd@kernel.org>
 <8f5c673a-0265-a6d0-57fc-98c788caadc9@rasmusvillemoes.dk>
 <CAK8P3a2WhAP7Cj+cgYyFEVVQL-1oSOdS1mcN7=o75u24s09-Uw@mail.gmail.com>
 <20201027091218.GB31882@alley>
 <13d87c71-66b2-2abb-825d-6e8e2e47d22a@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13d87c71-66b2-2abb-825d-6e8e2e47d22a@rasmusvillemoes.dk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2020-10-27 11:55:56, Rasmus Villemoes wrote:
> On 27/10/2020 10.12, Petr Mladek wrote:
> > On Tue 2020-10-27 09:46:28, Arnd Bergmann wrote:
> >> On Tue, Oct 27, 2020 at 8:23 AM Rasmus Villemoes
> >> <linux@rasmusvillemoes.dk> wrote:
> >>> On 26/10/2020 22.49, Arnd Bergmann wrote:
> >>>> From: Arnd Bergmann <arnd@arndb.de>
> >>>
> >>> NAK. That would end up using the "EDEADLOCK" string for the value 35 on
> >>> those architectures where they are the same, despite EDEADLK being the
> >>> by far the most used symbol. See the comments and original commit log,
> >>> the placement of these is deliberate.
> > 
> > Good point.
> > 
> >> Ok, I see.
> >>
> >>> How about we do this instead?
> >>>
> >>> when building with W=1. As the use of multiple initializers for the
> >>> same entry here is quite deliberate, explicitly disable that warning
> >>> for errname.o.
> >>>
> >>> diff --git a/lib/Makefile b/lib/Makefile
> >>> index ce45af50983a2a5e3582..a98119519e100103818d 100644
> >>> --- a/lib/Makefile
> >>> +++ b/lib/Makefile
> >>> @@ -224,6 +224,7 @@ obj-$(CONFIG_HAVE_ARCH_TRACEHOOK) += syscall.o
> >>>
> >>>  obj-$(CONFIG_DYNAMIC_DEBUG_CORE) += dynamic_debug.o
> >>>  obj-$(CONFIG_SYMBOLIC_ERRNAME) += errname.o
> >>> +CFLAGS_errname.o += $(call cc-disable-warning, override-init)
> >>>
> >>
> >> This works, but it disables a potentially useful warning in case we
> >> get another conflict in this file, so I'd prefer to find a way to
> >> avoid the warning rather than force-disabling it.
> > 
> > Yeah, I think that it is better to explicitely disable the less used
> > variant in the code than hiding the double initialization. It will
> > be clear what is going on.
> > 
> > 
> >> How about adding the #ifdef around the EDEADLOCK line
> >> instead of the EDEADLK one? Something like
> >>
> >> diff --git a/lib/errname.c b/lib/errname.c
> >> index 0c4d3e66170e..93043fb960cc 100644
> >> --- a/lib/errname.c
> >> +++ b/lib/errname.c
> >> @@ -38,7 +38,10 @@ static const char *names_0[] = {
> >>         E(ECOMM),
> >>         E(ECONNABORTED),
> >>         E(ECONNRESET),
> >> +       E(EDEADLK), /* EDEADLOCK */
> >> +#if EDEADLK != EDEADLOCK /* mips, sparc, powerpc */
> >>         E(EDEADLOCK),
> >> +#endif
> >>         E(EDESTADDRREQ),
> >>         E(EDOM),
> >>         E(EDOTDOT),
> >> @@ -169,7 +172,6 @@ static const char *names_0[] = {
> >>         E(ECANCELED), /* ECANCELLED */
> >>         E(EAGAIN), /* EWOULDBLOCK */
> >>         E(ECONNREFUSED), /* EREFUSED */
> >> -       E(EDEADLK), /* EDEADLOCK */
> > 
> > This should stay :-)
> > 
> 
> No, Arnd moved it next to EDEADLOCK, which is fine (it can lose the
> comment /* EDEADLOCK */, though; the comment on the ifdef is
> sufficient). Especially when:
> 
> > And we should remove the ECANCELLED definition. It is always the same
> > as ECANCELED and replaced. We do not define EWOULDBLOCK and
> > EREFUSED either.
> 
> Yes, I'm not sure why I elided EWOULDBLOCK and EREFUSED but not
> ECANCELLED. So let's move EAGAIN, ECONNREFUSED and ECANCELED to their
> proper alphabetic place. But I also want to add a check that the things
> we've elided match some value that we do handle. So add something like
> 
> #ifdef EREFUSED /* parisc */
> static_assert(EREFUSED == ECONNREFUSED);
> #endif
> 
> #ifdef ECANCELLED /* parisc */
> static_assert(ECANCELLED == ECANCELED);
> #endif
> 
> static_assert(EAGAIN == EWOULDBLOCK); /* everywhere */
> 
> so that if we ever import some arch that defines EREFUSED to something
> other than ECONNREFUSED, it would be caught. Essentially, errname.c
> should mention every #define E* that appears in any errno*.h.

Sounds like a good plan.

Arnd, are you going to take care of this or should we clean up it ourself?

Best Regards,
Petr
