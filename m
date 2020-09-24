Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42A3E27704A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 13:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbgIXLut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 07:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbgIXLus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 07:50:48 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E237C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 04:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rDWsOy5XYmG2oBnGA9WBK17qRdFGsjpp+rSZ4gjvLrA=; b=r277Py9LPE+bkc1lDFf3IDTWyG
        l5btRKziJl1ythwwObXD9ZZ3oKaZX/6zUGZEwBrMGzVIJJ565KEK08MySo8+VT2PL9hVCguR7lNPq
        Rf4xDOLMEJvPEy+LDe6DByWxe0FpfXm1g3u7uUfcEJdiemOoUoH345jDwkYEHQKvSl3wGP5vY8nK+
        agkUrTIodptBqQ9ZF1GoqzlcFZsUfBpicYbIg+zAJ9hAMuEQ4nHeVgBJwiMAIL146HMQ5qKYmIyL4
        aAZFRJtCa7oTpJfVmsPF/fKZvnWgrHAbmtTohsz1A1qXs2eWgG6I6WBzxhxCu+GgF/E/LDgJPz+VN
        fWL7R/SQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kLPlt-0001rT-07; Thu, 24 Sep 2020 11:50:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9CDF5303DA0;
        Thu, 24 Sep 2020 13:50:42 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8989A2022B66B; Thu, 24 Sep 2020 13:50:42 +0200 (CEST)
Date:   Thu, 24 Sep 2020 13:50:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Rik van Riel <riel@surriel.com>
Subject: Re: sched: rq->nr_iowait transiently going negative after the recent
 p->on_cpu optimization
Message-ID: <20200924115042.GG2628@hirez.programming.kicks-ass.net>
References: <20200918172759.GA4247@mtj.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918172759.GA4247@mtj.thefacebook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 18, 2020 at 01:27:59PM -0400, Tejun Heo wrote:
> Hello,
> 
> Peter, I noticed /proc/stat::procs_blocked going U64_MAX transiently once in
> the blue moon without any other persistent issues. After looking at the code
> with Rik for a bit, the culprit seems to be c6e7bd7afaeb ("sched/core:
> Optimize ttwu() spinning on p->on_cpu") - it changed where ttwu dec's
> nr_iowait and it looks like that can happen before the target task gets to
> inc.

Hurmph.. I suppose you're right :/ And this is an actual problem?

I think the below should cure that, but blergh, not nice. If you could
confirm, I'll try and think of something nicer.


diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ebb90572e10d..259a4ae8ab8e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2505,7 +2505,12 @@ ttwu_do_activate(struct rq *rq, struct task_struct *p, int wake_flags,
 #ifdef CONFIG_SMP
 	if (wake_flags & WF_MIGRATED)
 		en_flags |= ENQUEUE_MIGRATED;
+	else
 #endif
+	if (p->in_iowait) {
+		delayacct_blkio_end(p);
+		atomic_dec(&task_rq(p)->nr_iowait);
+	}
 
 	activate_task(rq, p, en_flags);
 	ttwu_do_wakeup(rq, p, wake_flags, rf);
@@ -2892,11 +2897,6 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 	if (READ_ONCE(p->on_rq) && ttwu_runnable(p, wake_flags))
 		goto unlock;
 
-	if (p->in_iowait) {
-		delayacct_blkio_end(p);
-		atomic_dec(&task_rq(p)->nr_iowait);
-	}
-
 #ifdef CONFIG_SMP
 	/*
 	 * Ensure we load p->on_cpu _after_ p->on_rq, otherwise it would be
@@ -2967,6 +2967,11 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 
 	cpu = select_task_rq(p, p->wake_cpu, SD_BALANCE_WAKE, wake_flags);
 	if (task_cpu(p) != cpu) {
+		if (p->in_iowait) {
+			delayacct_blkio_end(p);
+			atomic_dec(&task_rq(p)->nr_iowait);
+		}
+
 		wake_flags |= WF_MIGRATED;
 		psi_ttwu_dequeue(p);
 		set_task_cpu(p, cpu);
