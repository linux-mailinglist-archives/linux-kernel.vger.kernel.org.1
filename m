Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB74300965
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 18:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729682AbhAVRQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 12:16:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729719AbhAVRKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 12:10:01 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD6DC061788
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 09:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3UdzW0vQOnefu0MUYDc0akk5oqwvE8zGjctjGlyHUaM=; b=ID7oReFsxbnsQPHFJWuOJyN8xx
        4C03JzUhg5WTJHkxMquvt5b0T8tAANACLFDPU740TIW6rQcLPEy++5F/FRvN3a+rftNeJye2HZkE9
        zQGSyH1ekJaKC6cF+53He+bDsehH6S1aHRsXCcZxtc/UGDVyr1mx+SsrKs2gOxyyFb7hrRvIE6Tad
        uPaPqMtoJGvgp1H5cTVO3udhe7bK9EPXwl1XrkEpcn07RIWrDL3fz8XNw3VYRuLuWb+JAsSRY9Vt3
        lFlgEbpbx417cGletFgQ1USkOeoSluh12S+MKKaDb9j/Ka7444+5j5n8cTI1Fz/aVnN4BPfUdAhzW
        5vOulJRQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l2zv8-000zmV-EC; Fri, 22 Jan 2021 17:08:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 618023012DF;
        Fri, 22 Jan 2021 18:08:25 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3EE152027D394; Fri, 22 Jan 2021 18:08:25 +0100 (CET)
Date:   Fri, 22 Jan 2021 18:08:25 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Michal Hocko <mhocko@suse.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Jason Baron <jbaron@akamai.com>
Subject: Re: [RFC PATCH 6/8] preempt/dynamic: Provide
 preempt_schedule[_notrace]() static calls
Message-ID: <YAsGiUYf6NyaTplX@hirez.programming.kicks-ass.net>
References: <20210118141223.123667-1-frederic@kernel.org>
 <20210118141223.123667-7-frederic@kernel.org>
 <20210122165226.GD16371@worktop.programming.kicks-ass.net>
 <CAMj1kXHLL1_WGztYoxGS=12zY5ZxGskptPf4nV78pL7m02pdOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHLL1_WGztYoxGS=12zY5ZxGskptPf4nV78pL7m02pdOA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 22, 2021 at 05:57:53PM +0100, Ard Biesheuvel wrote:
> On Fri, 22 Jan 2021 at 17:53, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Mon, Jan 18, 2021 at 03:12:21PM +0100, Frederic Weisbecker wrote:
> > > +#ifdef CONFIG_PREEMPT_DYNAMIC
> > > +DEFINE_STATIC_CALL(preempt_schedule, __preempt_schedule_func());
> > > +EXPORT_STATIC_CALL(preempt_schedule);
> > > +#endif
> >
> > > +#ifdef CONFIG_PREEMPT_DYNAMIC
> > > +DEFINE_STATIC_CALL(preempt_schedule_notrace, __preempt_schedule_notrace_func());
> > > +EXPORT_STATIC_CALL(preempt_schedule_notrace);
> > > +#endif
> >
> > So one of the things I hates most of this is that is allows 'random'
> > modules to hijack the preemption by rewriting these callsites. Once you
> > export the key, we've lost.
> >
> 
> Are these supposed to be switchable at any time? Or only at boot? In
> the latter case, can't we drop the associated data structure in
> __ro_after_init so it becomes R/O when booting completes?

Doesn't work, loading modules modifies the key -- we recently had
someone complain about that for jump_label.

And also, I have this patch...

---
Subject: sched: Add /debug/sched_preempt
From: Peter Zijlstra <peterz@infradead.org>
Date: Fri Jan 22 13:01:58 CET 2021

Add a debugfs file to muck about with the preempt mode at runtime.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c |  135 ++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 126 insertions(+), 9 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5362,37 +5362,154 @@ EXPORT_STATIC_CALL(preempt_schedule_notr
  *   preempt_schedule_notrace   <- preempt_schedule_notrace
  *   irqentry_exit_cond_resched <- irqentry_exit_cond_resched
  */
-static int __init setup_preempt_mode(char *str)
+
+enum {
+	preempt_dynamic_none = 0,
+	preempt_dynamic_voluntary,
+	preempt_dynamic_full,
+};
+
+static int preempt_dynamic_mode = preempt_dynamic_full;
+
+static int sched_dynamic_mode(const char *str)
+{
+	if (!strcmp(str, "none"))
+		return 0;
+
+	if (!strcmp(str, "voluntary"))
+		return 1;
+
+	if (!strcmp(str, "full"))
+		return 2;
+
+	return -1;
+}
+
+static void sched_dynamic_update(int mode)
 {
-	if (!strcmp(str, "none")) {
+	/*
+	 * Avoid {NONE,VOLUNTARY} -> FULL transitions from ever ending up in
+	 * the ZERO state, which is invalid.
+	 */
+	static_call_update(cond_resched, __cond_resched);
+	static_call_update(might_resched, __cond_resched);
+	static_call_update(preempt_schedule, __preempt_schedule_func());
+	static_call_update(preempt_schedule_notrace, __preempt_schedule_notrace_func());
+	static_call_update(irqentry_exit_cond_resched, irqentry_exit_cond_resched);
+
+	switch (mode) {
+	case preempt_dynamic_none:
 		static_call_update(cond_resched, __cond_resched);
 		static_call_update(might_resched, (typeof(&__cond_resched)) __static_call_return0);
 		static_call_update(preempt_schedule, (typeof(&preempt_schedule)) NULL);
 		static_call_update(preempt_schedule_notrace, (typeof(&preempt_schedule_notrace)) NULL);
 		static_call_update(irqentry_exit_cond_resched, (typeof(&irqentry_exit_cond_resched)) NULL);
-		pr_info("Dynamic Preempt: %s\n", str);
-	} else if (!strcmp(str, "voluntary")) {
+		pr_info("Dynamic Preempt: none\n");
+		break;
+
+	case preempt_dynamic_voluntary:
 		static_call_update(cond_resched, __cond_resched);
 		static_call_update(might_resched, __cond_resched);
 		static_call_update(preempt_schedule, (typeof(&preempt_schedule)) NULL);
 		static_call_update(preempt_schedule_notrace, (typeof(&preempt_schedule_notrace)) NULL);
 		static_call_update(irqentry_exit_cond_resched, (typeof(&irqentry_exit_cond_resched)) NULL);
-		pr_info("Dynamic Preempt: %s\n", str);
-	} else if (!strcmp(str, "full")) {
+		pr_info("Dynamic Preempt: voluntary\n");
+		break;
+
+	case preempt_dynamic_full:
 		static_call_update(cond_resched, (typeof(&__cond_resched)) __static_call_return0);
 		static_call_update(might_resched, (typeof(&__cond_resched)) __static_call_return0);
 		static_call_update(preempt_schedule, __preempt_schedule_func());
 		static_call_update(preempt_schedule_notrace, __preempt_schedule_notrace_func());
 		static_call_update(irqentry_exit_cond_resched, irqentry_exit_cond_resched);
-		pr_info("Dynamic Preempt: %s\n", str);
-	} else {
-		pr_warn("Dynamic Preempt: Unsupported preempt mode %s, default to full\n", str);
+		pr_info("Dynamic Preempt: full\n");
+		break;
+	}
+
+	preempt_dynamic_mode = mode;
+}
+
+static int __init setup_preempt_mode(char *str)
+{
+	int mode = sched_dynamic_mode(str);
+	if (mode < 0) {
+		pr_warn("Dynamic Preempt: unsupported mode: %s\n", str);
 		return 1;
 	}
+
+	sched_dynamic_update(mode);
 	return 0;
 }
 __setup("preempt=", setup_preempt_mode);
 
+#ifdef CONFIG_SCHED_DEBUG
+
+static ssize_t sched_dynamic_write(struct file *filp, const char __user *ubuf,
+				   size_t cnt, loff_t *ppos)
+{
+	char buf[16];
+	int mode;
+
+	if (cnt > 15)
+		cnt = 15;
+
+	if (copy_from_user(&buf, ubuf, cnt))
+		return -EFAULT;
+
+	buf[cnt] = 0;
+	mode = sched_dynamic_mode(strstrip(buf));
+	if (mode < 0)
+		return mode;
+
+	sched_dynamic_update(mode);
+
+	*ppos += cnt;
+
+	return cnt;
+}
+
+static int sched_dynamic_show(struct seq_file *m, void *v)
+{
+	static const char * preempt_modes[] = {
+		"none", "voluntary", "full"
+	};
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(preempt_modes); i++) {
+		if (preempt_dynamic_mode == i)
+			seq_puts(m, "(");
+		seq_puts(m, preempt_modes[i]);
+		if (preempt_dynamic_mode == i)
+			seq_puts(m, ")");
+
+		seq_puts(m, " ");
+	}
+
+	seq_puts(m, "\n");
+	return 0;
+}
+
+static int sched_dynamic_open(struct inode *inode, struct file *filp)
+{
+	return single_open(filp, sched_dynamic_show, NULL);
+}
+
+static const struct file_operations sched_dynamic_fops = {
+	.open		= sched_dynamic_open,
+	.write		= sched_dynamic_write,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static __init int sched_init_debug_dynamic(void)
+{
+	debugfs_create_file("sched_preempt", 0644, NULL, NULL, &sched_dynamic_fops);
+	return 0;
+}
+late_initcall(sched_init_debug_dynamic);
+
+#endif /* CONFIG_SCHED_DEBUG */
 #endif /* CONFIG_PREEMPT_DYNAMIC */
 
 
