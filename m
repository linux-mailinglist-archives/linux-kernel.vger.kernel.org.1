Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7B24295953
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 09:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2508661AbgJVHih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 03:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2506642AbgJVHih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 03:38:37 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2982FC0613CE;
        Thu, 22 Oct 2020 00:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RfFhSbN11m3IitK97y6a7NzS38Ioj0KULanL8a1Qb1g=; b=J6K1M0sZPimUvXPrKztX0TlegH
        AH+DBbWHCdWcwcCvmioBKrnsQsRCXwcArtPEOlG1GfSppLCn/uRGjd+pYgeXiNVN2eTnSn2Yn+i0/
        XOxv8QbuwN8nvMT5ab+v5yfwYwAR5gjU+pi9ez4xw0tGaEOm8yX6aEt072WCU90caMRZtL2xWfP6s
        VHky+hFx9Rnja7nd6N0k565GMD3F1uPsvpEVHTwe6k2k/7Z06jmENm2bLnZJLzw3MYY/0wAo1oxjP
        Li6GyPsWND5HE40XKKV/BDs20COontaEBFHhRhfyK6OlOAjyJmTzn3rnEuPA5z1d18ap9f3KMz2by
        Eca2gNVw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kVVAw-0005Li-7r; Thu, 22 Oct 2020 07:38:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7C7583010D2;
        Thu, 22 Oct 2020 09:38:16 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5DE1C200D4C3C; Thu, 22 Oct 2020 09:38:16 +0200 (CEST)
Date:   Thu, 22 Oct 2020 09:38:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Jakub Jelinek <jakub@redhat.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        kernel test robot <lkp@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        LKP <lkp@lists.01.org>, Kees Cook <keescook@chromium.org>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-toolchains@vger.kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: Re: GCC section alignment, and GCC-4.9 being a weird one
Message-ID: <20201022073816.GQ2628@hirez.programming.kicks-ass.net>
References: <20200629003127.GB5535@shao2-debian>
 <20200630124628.GV4817@hirez.programming.kicks-ass.net>
 <20200630144905.GX4817@hirez.programming.kicks-ass.net>
 <58ff47cc-dc55-e383-7a5b-37008d145aba@gmail.com>
 <20201021080031.GY2628@hirez.programming.kicks-ass.net>
 <20201021131806.GA2176@tucnak>
 <20201021134436.GJ2628@hirez.programming.kicks-ass.net>
 <CAKwvOd=qi63We=6rLapb565giCVe-8a6d=-=3VZL6RWzhwAeZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOd=qi63We=6rLapb565giCVe-8a6d=-=3VZL6RWzhwAeZg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 21, 2020 at 10:42:01AM -0700, Nick Desaulniers wrote:
> On Wed, Oct 21, 2020 at 6:45 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > Ah, thanks!
> >
> > In that case something like the below ought to make it good.
> >
> > I'll go feed it to the robots, see if anything falls over.
> >
> > ---
> >  kernel/sched/deadline.c  | 4 +++-
> >  kernel/sched/fair.c      | 4 +++-
> >  kernel/sched/idle.c      | 4 +++-
> >  kernel/sched/rt.c        | 4 +++-
> >  kernel/sched/sched.h     | 3 +--
> >  kernel/sched/stop_task.c | 3 ++-
> >  6 files changed, 15 insertions(+), 7 deletions(-)
> >
> > diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> > index 6d93f4518734..f4855203143d 100644
> > --- a/kernel/sched/deadline.c
> > +++ b/kernel/sched/deadline.c
> > @@ -2504,7 +2504,9 @@ static void prio_changed_dl(struct rq *rq, struct task_struct *p,
> >  }
> >
> >  const struct sched_class dl_sched_class
> > -       __attribute__((section("__dl_sched_class"))) = {
> > +       __attribute__((section("__dl_sched_class")))
> > +       __attribute__((aligned(__alignof__(struct sched_class)))) = {
> 
> If you used some of the macros from
> include/linux/compiler_attributes.h like __section and __aligned, I
> would prefer it.  Please consider spelling out __attribute__(()) an
> antipattern.

Feh, and then suffer more patches because someone doesn't like how
__section uses # :/
