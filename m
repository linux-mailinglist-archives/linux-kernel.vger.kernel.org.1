Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC1127F288
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 21:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730228AbgI3TWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 15:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgI3TWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 15:22:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E4CC061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 12:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mzoge1vMkR/T6AFDq9SykRx8CLYszMD0V5SjriFX2to=; b=hpc/gT+dCMSkZkhWX8zQgqU5Il
        8Eb4v6jC4PzAWq8ok9AOzpquAk5AtNfnSWk9fMOYyHTmxOrlJ4ZKZWeZdRL7/PmkLI2XBrSTD4zbe
        UtaRfns59571+PyoGGxxiW3r5elO1G9AWg9zQev4Y6W6zME2cAHYBz4A2eauW7v2Iaju4abOgkfCu
        YZ+VnOUP3DbxQ1MzRjzNSOXcrN9N2sBfYpCcrljG8e/tREeG4Kopevfwwej1cme5sSECYXLzRN29A
        QSCeujtfXa+0jof+ZkUMnrGws5hbGeuaoqZiir/AdHUgWd1aKPGkSNmpEST9Ne0pEXp3p09cTtV2A
        uutNCYIQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kNhgZ-000717-E4; Wed, 30 Sep 2020 19:22:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 852933011F0;
        Wed, 30 Sep 2020 21:22:42 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3F30C2011672D; Wed, 30 Sep 2020 21:22:42 +0200 (CEST)
Date:   Wed, 30 Sep 2020 21:22:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [WARNING] kernel/rcu/tree.c:1058 rcu_irq_enter+0x15/0x20
Message-ID: <20200930192242.GM2611@hirez.programming.kicks-ass.net>
References: <20200917131647.2b55ebb1@gandalf.local.home>
 <20200930181323.GF2628@hirez.programming.kicks-ass.net>
 <20200930151026.4a87ab79@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930151026.4a87ab79@gandalf.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 03:10:26PM -0400, Steven Rostedt wrote:
> On Wed, 30 Sep 2020 20:13:23 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> >  diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
> > > index 6a584b3e5c74..3e5bc1dd71c6 100644
> > > --- a/include/linux/lockdep.h
> > > +++ b/include/linux/lockdep.h
> > > @@ -550,7 +550,8 @@ do {									\
> > >  
> > >  #define lockdep_assert_irqs_disabled()					\
> > >  do {									\
> > > -	WARN_ON_ONCE(debug_locks && raw_cpu_read(hardirqs_enabled));	\
> > > +	WARN_ON_ONCE(debug_locks && raw_cpu_read(hardirqs_enabled) &&	\
> > > +           likely(!(current->lockdep_recursion & LOCKDEP_RECURSION_MASK)));\
> > >  } while (0)  
> > 
> > Blergh, IIRC there's header hell that way. The sane fix is killing off
> > that trace_*_rcuidle() disease.
> 
> Really?
> 
> I could run this through all my other tests to see if that is the case.
> That is, to see if it stumbles across header hell.

I went through a lot of pain to make that per-cpu to avoid using
current. But that might've been driven by
lockdep_assert_preemption_disabled(), which is used in seqlock.h which
in turn is included all over the place.

That said, there's at least two things we can do:

 - make lockdep_recursion per-cpu too, IIRC we only ever set that when
   we have IRQs disabled anyway.

OR

 - inspired by the above, as can save/clear - restore hardirqs_enabled
   when we frob lockdep_recursion.

Admittedly, the second is somewhat gross :-)
