Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7D12D0FB2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 12:49:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgLGLs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 06:48:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbgLGLs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 06:48:28 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45156C0613D0
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 03:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=edP2H5YMzTq6JDL5+Mwz3TSesMidmvdEM37da6u28Ng=; b=xJRNEc1nQVU5maBnwk6Y0WRQNL
        tMlybxaeMVkp6INeWlcl+KqGuMQgbAQA4I6a8FQjkzEi07ShBuiIWUHb3CkwFi6QqGliblhKZyoTt
        4cc5KJaZiYykRsYVeu/61mPE5HNDG23kGWfoEb1Q4HXWUV1r/6HGJCCBJYpT/kjpWpN7No1a5GYbA
        /Xc4BZVqOTUeIEz9Z4RUFQsEylCsamgxo0PMRswxhPVO5nCjFOuJzODqciDQzJ33oGvjM2aERhaRq
        ljRQ+f1GyR8rXvW95nCU42hvDwaqKAlOVnF18j2ImrxTdLudgHKl3MMY6mDjHAV9Eu+UnV/J/mRRx
        a0XUj1Zg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kmEzZ-0003LX-6a; Mon, 07 Dec 2020 11:47:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D0CEB301478;
        Mon,  7 Dec 2020 12:47:43 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BBE3E2081295B; Mon,  7 Dec 2020 12:47:43 +0100 (CET)
Date:   Mon, 7 Dec 2020 12:47:43 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paul McKenney <paulmck@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [patch V2 9/9] tasklets: Prevent kill/unlock_wait deadlock on RT
Message-ID: <20201207114743.GK3040@hirez.programming.kicks-ass.net>
References: <20201204170151.960336698@linutronix.de>
 <20201204170805.627618080@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201204170805.627618080@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 04, 2020 at 06:02:00PM +0100, Thomas Gleixner wrote:
> @@ -825,7 +848,20 @@ void tasklet_kill(struct tasklet_struct
>  
>  	while (test_and_set_bit(TASKLET_STATE_SCHED, &t->state)) {
>  		do {
> -			yield();
>  		} while (test_bit(TASKLET_STATE_SCHED, &t->state));
>  	}
>  	tasklet_unlock_wait(t);


Egads... should we not start by doing something like this?


---
diff --git a/kernel/softirq.c b/kernel/softirq.c
index d5bfd5e661fc..95ff5b7f1833 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -529,6 +529,16 @@ void __tasklet_hi_schedule(struct tasklet_struct *t)
 }
 EXPORT_SYMBOL(__tasklet_hi_schedule);
 
+static inline bool tasklet_clear_sched(struct tasklet_struct *t)
+{
+	if (test_and_clear_bit(TASKLET_STATE_SCHED, &t->state)) {
+		wake_up_var(&t->state);
+		return true;
+	}
+
+	return false;
+}
+
 static void tasklet_action_common(struct softirq_action *a,
 				  struct tasklet_head *tl_head,
 				  unsigned int softirq_nr)
@@ -548,8 +558,7 @@ static void tasklet_action_common(struct softirq_action *a,
 
 		if (tasklet_trylock(t)) {
 			if (!atomic_read(&t->count)) {
-				if (!test_and_clear_bit(TASKLET_STATE_SCHED,
-							&t->state))
+				if (!tasklet_clear_sched(t))
 					BUG();
 				if (t->use_callback)
 					t->callback(t);
@@ -609,13 +618,11 @@ void tasklet_kill(struct tasklet_struct *t)
 	if (in_interrupt())
 		pr_notice("Attempt to kill tasklet from interrupt\n");
 
-	while (test_and_set_bit(TASKLET_STATE_SCHED, &t->state)) {
-		do {
-			yield();
-		} while (test_bit(TASKLET_STATE_SCHED, &t->state));
-	}
+	while (test_and_set_bit(TASKLET_STATE_SCHED, &t->state))
+		wait_var_event(&t->state, !test_bit(TASKLET_STATE_SCHED, &t->state));
+
 	tasklet_unlock_wait(t);
-	clear_bit(TASKLET_STATE_SCHED, &t->state);
+	tasklet_clear_sched(t);
 }
 EXPORT_SYMBOL(tasklet_kill);
 
