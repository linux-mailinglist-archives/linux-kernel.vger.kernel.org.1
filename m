Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAD4E295CB7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 12:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896562AbgJVKak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 06:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2896499AbgJVKak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 06:30:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EADEBC0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 03:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vOBkIwiOHgx5SumbuPhJdJdqN5nmE0xP+/pWyRhtjPQ=; b=v83OcVQpV92ZmJ2acXElGmtWYT
        W8K0mzA9lrMzNTSH+R6PRvgD2hWydVBKU9ILUUWEaJ8/jscShESeG18uE4n9NFwYavR7R4br5f6YH
        pvlPfi0pd3dw499Xw6jo0E/zIG0KIkOu4W2CbJ3Bq5zkKrSTCPxFOyqHcgj0VLXzrfVNdiBv1+hBm
        ZBBMSHn8DuTnRUgwaGV3D/hClaTH+H8C2eLPdIytSCdAqolougwwNkcTGNCATFisPsIo09AtyeIFt
        bLu1WS37PnUbA3+BoTpYPET5fk+jYMOBkN46XmWJFspnPjVFP2lJBj15850qSrXT1c3y2MmO/13PS
        KnXf38MA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kVXrZ-0000Zg-DK; Thu, 22 Oct 2020 10:30:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4FBBF302753;
        Thu, 22 Oct 2020 12:30:28 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0B02C20325EC6; Thu, 22 Oct 2020 12:30:28 +0200 (CEST)
Date:   Thu, 22 Oct 2020 12:30:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     syzbot <syzbot+53f8ce8bbc07924b6417@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: BUG: using __this_cpu_read() in preemptible code in
 trace_hardirqs_on
Message-ID: <20201022103028.GC2611@hirez.programming.kicks-ass.net>
References: <000000000000e921b305b18ba0a7@google.com>
 <20201013091743.12c371a8@gandalf.local.home>
 <20201021131733.GH2628@hirez.programming.kicks-ass.net>
 <20201021103433.38fed220@gandalf.local.home>
 <20201021151237.GK2628@hirez.programming.kicks-ass.net>
 <20201021112757.0945a922@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201021112757.0945a922@gandalf.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 21, 2020 at 11:27:57AM -0400, Steven Rostedt wrote:
> On Wed, 21 Oct 2020 17:12:37 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > > > diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> > > > index 3e99dfef8408..9f818145ef7d 100644
> > > > --- a/kernel/locking/lockdep.c
> > > > +++ b/kernel/locking/lockdep.c
> > > > @@ -4057,9 +4057,6 @@ void lockdep_hardirqs_on_prepare(unsigned long ip)
> > > >  	if (unlikely(in_nmi()))
> > > >  		return;
> > > >  
> > > > -	if (unlikely(__this_cpu_read(lockdep_recursion)))
> > > > -		return;
> > > > -
> > > >  	if (unlikely(lockdep_hardirqs_enabled())) {  
> > > 
> > > Hmm, would moving the recursion check below the check of the
> > > lockdep_hardirqs_enable() cause a large skew in the spurious enable stats?
> > > May not be an issue, but something we should check to make sure that
> > > there's not a path that constantly hits this.  
> > 
> > Anything that sets recursion will have interrupts disabled.
> 
> It may have interrupts disabled, but does it have the hardirqs_enabled
> per_cpu variable set? The above check only looks at that, and doesn't check
> if interrupts are actually enabled.
> 
> For example, if lockdep is processing a mutex, it would set the recursion
> variable, but does it ever set the hardirqs_enabled variable to off?

Bah, I can't read. So I was looking at:

	if (DEBUG_LOCKS_WARN_ON(!irqs_disabled()))

but that wasn't what I actually moved around. *sigh*..

A well, I'll just remove the __ here. It's not like we super care about
performance here.

Something like so then..

---
Subject: lockdep: Fix preemption WARN for spurious IRQ-enable
From: Peter Zijlstra <peterz@infradead.org>
Date: Thu Oct 22 12:23:02 CEST 2020

It is valid (albeit uncommon) to call local_irq_enable() without first
having called local_irq_disable(). In this case we enter
lockdep_hardirqs_on*() with IRQs enabled and trip a preemption warning
for using __this_cpu_read().

Use this_cpu_read() instead to avoid the warning.

Fixes: 4d004099a6 ("lockdep: Fix lockdep recursion")
Reported-by: syzbot+53f8ce8bbc07924b6417@syzkaller.appspotmail.com
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -4057,7 +4057,7 @@ void lockdep_hardirqs_on_prepare(unsigne
 	if (unlikely(in_nmi()))
 		return;
 
-	if (unlikely(__this_cpu_read(lockdep_recursion)))
+	if (unlikely(this_cpu_read(lockdep_recursion)))
 		return;
 
 	if (unlikely(lockdep_hardirqs_enabled())) {
@@ -4126,7 +4126,7 @@ void noinstr lockdep_hardirqs_on(unsigne
 		goto skip_checks;
 	}
 
-	if (unlikely(__this_cpu_read(lockdep_recursion)))
+	if (unlikely(this_cpu_read(lockdep_recursion)))
 		return;
 
 	if (lockdep_hardirqs_enabled()) {
