Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2E729A775
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 10:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895493AbgJ0JMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 05:12:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:48472 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2895486AbgJ0JMW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 05:12:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603789939;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oqO4YOOJLxsZ25iDw7v69GavVRBWOAM8Kd9gENpNFLU=;
        b=AAq89f1yc62Q8WIWLTA1lKkiPd5NGiQmibyfBZVqOkrixdX9trWStOkOppKaOaswTekV7C
        FZmOQsolYEFx0Vh/39E5Ik1oTWSbplodJlhX9bDWn9g3PRfcmdihkLRsCLrIdXdeAvaegM
        lv7O+0VB5xOJ1WhCWkbUeMqiiPaRNhE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 76189B062;
        Tue, 27 Oct 2020 09:12:19 +0000 (UTC)
Date:   Tue, 27 Oct 2020 10:12:18 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] printf: fix Woverride-init warning for EDEADLK errno
Message-ID: <20201027091218.GB31882@alley>
References: <20201026215004.3893088-1-arnd@kernel.org>
 <8f5c673a-0265-a6d0-57fc-98c788caadc9@rasmusvillemoes.dk>
 <CAK8P3a2WhAP7Cj+cgYyFEVVQL-1oSOdS1mcN7=o75u24s09-Uw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2WhAP7Cj+cgYyFEVVQL-1oSOdS1mcN7=o75u24s09-Uw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2020-10-27 09:46:28, Arnd Bergmann wrote:
> On Tue, Oct 27, 2020 at 8:23 AM Rasmus Villemoes
> <linux@rasmusvillemoes.dk> wrote:
> > On 26/10/2020 22.49, Arnd Bergmann wrote:
> > > From: Arnd Bergmann <arnd@arndb.de>
> >
> > NAK. That would end up using the "EDEADLOCK" string for the value 35 on
> > those architectures where they are the same, despite EDEADLK being the
> > by far the most used symbol. See the comments and original commit log,
> > the placement of these is deliberate.

Good point.

> Ok, I see.
> 
> > How about we do this instead?
> >
> > when building with W=1. As the use of multiple initializers for the
> > same entry here is quite deliberate, explicitly disable that warning
> > for errname.o.
> >
> > diff --git a/lib/Makefile b/lib/Makefile
> > index ce45af50983a2a5e3582..a98119519e100103818d 100644
> > --- a/lib/Makefile
> > +++ b/lib/Makefile
> > @@ -224,6 +224,7 @@ obj-$(CONFIG_HAVE_ARCH_TRACEHOOK) += syscall.o
> >
> >  obj-$(CONFIG_DYNAMIC_DEBUG_CORE) += dynamic_debug.o
> >  obj-$(CONFIG_SYMBOLIC_ERRNAME) += errname.o
> > +CFLAGS_errname.o += $(call cc-disable-warning, override-init)
> >
> 
> This works, but it disables a potentially useful warning in case we
> get another conflict in this file, so I'd prefer to find a way to
> avoid the warning rather than force-disabling it.

Yeah, I think that it is better to explicitely disable the less used
variant in the code than hiding the double initialization. It will
be clear what is going on.


> How about adding the #ifdef around the EDEADLOCK line
> instead of the EDEADLK one? Something like
> 
> diff --git a/lib/errname.c b/lib/errname.c
> index 0c4d3e66170e..93043fb960cc 100644
> --- a/lib/errname.c
> +++ b/lib/errname.c
> @@ -38,7 +38,10 @@ static const char *names_0[] = {
>         E(ECOMM),
>         E(ECONNABORTED),
>         E(ECONNRESET),
> +       E(EDEADLK), /* EDEADLOCK */
> +#if EDEADLK != EDEADLOCK /* mips, sparc, powerpc */
>         E(EDEADLOCK),
> +#endif
>         E(EDESTADDRREQ),
>         E(EDOM),
>         E(EDOTDOT),
> @@ -169,7 +172,6 @@ static const char *names_0[] = {
>         E(ECANCELED), /* ECANCELLED */
>         E(EAGAIN), /* EWOULDBLOCK */
>         E(ECONNREFUSED), /* EREFUSED */
> -       E(EDEADLK), /* EDEADLOCK */

This should stay :-)

And we should remove the ECANCELLED definition. It is always the same
as ECANCELED and replaced. We do not define EWOULDBLOCK and
EREFUSED either.

Best Regards,
Petr
