Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 867FA25A6A2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Sep 2020 09:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbgIBHZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Sep 2020 03:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727796AbgIBHZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 03:25:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6458C061244
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 00:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=N/P10E2Wq6OV5XqWEJzhBkCnrFtL19WUaqQQLyurF0A=; b=hleKzprA/bNnE462tnxN2wX4B4
        QV2H0OQCmz/sD96hmU0tkZn4WYcfe62w/aIW2t3gmWQi3+UkE7sq6j4E/S0xOBcfDoVXjL9QX6Mzn
        Le+mtrkUNlrzsJDKbeUQh7oDondJuj8vMLAi8GA1Fy7/lwryBXAl84Q8/Q3+kKyobghJFCBhKSx31
        VpYfVuvh4uA2xWUZpp2lKsnnuvN3e26uHKy/gGr1DWoftmoRiGv/gKzwm1cNqtcgDqH9uJrSDWfZr
        DnqzpYOFJs75MYlyQ1WFsEqKEarbZSge6ecG6ElmsVWz7qhZ5X6m3zlvmS21RZdlPz8DMu0H/0DUL
        mAh9XZ1A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDN8D-00078B-Jb; Wed, 02 Sep 2020 07:24:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AA7B73003E5;
        Wed,  2 Sep 2020 09:24:32 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 993BE2B774669; Wed,  2 Sep 2020 09:24:32 +0200 (CEST)
Date:   Wed, 2 Sep 2020 09:24:32 +0200
From:   peterz@infradead.org
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org, will@kernel.org,
        npiggin@gmail.com, elver@google.com, jgross@suse.com,
        paulmck@kernel.org, rostedt@goodmis.org, rjw@rjwysocki.net,
        joel@joelfernandes.org, svens@linux.ibm.com, tglx@linutronix.de
Subject: Re: [PATCH v2 11/11] lockdep,trace: Expose tracepoints
Message-ID: <20200902072432.GI2674@hirez.programming.kicks-ass.net>
References: <20200821084738.508092956@infradead.org>
 <20200821085348.782688941@infradead.org>
 <20200902035146.GA45826@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902035146.GA45826@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 01, 2020 at 08:51:46PM -0700, Guenter Roeck wrote:
> On Fri, Aug 21, 2020 at 10:47:49AM +0200, Peter Zijlstra wrote:
> > The lockdep tracepoints are under the lockdep recursion counter, this
> > has a bunch of nasty side effects:
> > 
> >  - TRACE_IRQFLAGS doesn't work across the entire tracepoint
> > 
> >  - RCU-lockdep doesn't see the tracepoints either, hiding numerous
> >    "suspicious RCU usage" warnings.
> > 
> > Pull the trace_lock_*() tracepoints completely out from under the
> > lockdep recursion handling and completely rely on the trace level
> > recusion handling -- also, tracing *SHOULD* not be taking locks in any
> > case.
> > 
> 
> Wonder what is worse - the problem or its fix. This patch results in
> a number of WARNING backtraces for several archtectures/platforms.
> Reverting it fixes the problems.

Without all this there was a recursion that could crash. But yes,
tedious.

OTOH the warnings are about real bugs that were pre-existing, we now see
them and can fix them.

I'll reply to ARM separately, but let's have a peek at s390.

> s390:
> 
> [   19.490586] =============================
> [   19.490752] WARNING: suspicious RCU usage
> [   19.490921] 5.9.0-rc3 #1 Not tainted
> [   19.491086] -----------------------------
> [   19.491253] include/trace/events/lock.h:37 suspicious rcu_dereference_check() usage!

> [   19.493147]  [<00000000001d5de2>] lock_acquire+0x41a/0x498
> [   19.493320]  [<0000000000103b72>] enabled_wait+0xca/0x198
> [   19.493493]  [<0000000000103f80>] arch_cpu_idle+0x20/0x38

Does this help?

---

diff --git a/arch/s390/kernel/idle.c b/arch/s390/kernel/idle.c
index c73f50649e7e..f7f1e64e0d98 100644
--- a/arch/s390/kernel/idle.c
+++ b/arch/s390/kernel/idle.c
@@ -39,14 +39,13 @@ void enabled_wait(void)
 	local_irq_restore(flags);
 
 	/* Account time spent with enabled wait psw loaded as idle time. */
-	/* XXX seqcount has tracepoints that require RCU */
-	write_seqcount_begin(&idle->seqcount);
+	raw_write_seqcount_begin(&idle->seqcount);
 	idle_time = idle->clock_idle_exit - idle->clock_idle_enter;
 	idle->clock_idle_enter = idle->clock_idle_exit = 0ULL;
 	idle->idle_time += idle_time;
 	idle->idle_count++;
 	account_idle_time(cputime_to_nsecs(idle_time));
-	write_seqcount_end(&idle->seqcount);
+	raw_write_seqcount_end(&idle->seqcount);
 }
 NOKPROBE_SYMBOL(enabled_wait);
 
