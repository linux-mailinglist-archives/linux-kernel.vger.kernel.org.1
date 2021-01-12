Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC522F3342
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 15:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732868AbhALOwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 09:52:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbhALOwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 09:52:36 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FAF5C061795
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 06:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=9apJ3vLH8qvbGl8I/z7Yt7/ksUH6Z7wLqAefhHfM72s=; b=CPlrrgnIqG1cGUWUN1TNTvLztG
        7FNIq6d4ZK/eQFLk4PpQO0jxkSI41jvE0NDUVXMR/vaeu8h9O8+pr0UHVvEHzIy8LAbgvhFFdxV76
        XFJSNWFSU9byFXsYZcSQJVrQqaf7k8n8bY6oVAjrU0q5MO9uWpCtbirkQrJDyTCEug5il+GQ25j6f
        lycZkOqD9bzQT43wTTnF0HWf6yLfXJzvLr8lMZ9J92+/7zL1fiuljTDxOpIkEYB5naaa7QIqoftHL
        +NBYtp1ojRXO9DJ7EKjGibJmWythd2eunC9YgE63WxV98zzpL6HU5esk9Cg6/U9vtDVkynVGhY0ZB
        Uxp4TilQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kzL1I-0000cd-HL; Tue, 12 Jan 2021 14:51:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C7C5C30504E;
        Tue, 12 Jan 2021 15:51:38 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id AA78C20C228D8; Tue, 12 Jan 2021 15:51:38 +0100 (CET)
Message-ID: <20210112144843.788106541@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 12 Jan 2021 15:43:46 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, jiangshanlai@gmail.com,
        valentin.schneider@arm.com, cai@redhat.com,
        vincent.donnefort@arm.com, decui@microsoft.com, paulmck@kernel.org,
        vincent.guittot@linaro.org, rostedt@goodmis.org, axboe@kernel.dk,
        tj@kernel.org, peterz@infradead.org
Subject: [PATCH 2/4] kthread: Extract KTHREAD_IS_PER_CPU
References: <20210112144344.850850975@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a need to distinguish geniune per-cpu kthreads from kthreads
that happen to have a single CPU affinity.

Geniune per-cpu kthreads are kthreads that are CPU affine for
correctness, these will obviously have PF_KTHREAD set, but must also
have PF_NO_SETAFFINITY set, lest userspace modify their affinity and
ruins things.

However, these two things are not sufficient, PF_NO_SETAFFINITY is
also set on other tasks that have their affinities controlled through
other means, like for instance workqueues.

Therefore another bit is needed; it turns out kthread_create_per_cpu()
already has such a bit: KTHREAD_IS_PER_CPU, which is used to make
kthread_park()/kthread_unpark() work correctly.

Expose this flag and remove the implicit setting of it from
kthread_create_on_cpu(); the io_uring usage of it seems dubious at
best.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/kthread.h |    3 +++
 kernel/kthread.c        |   25 ++++++++++++++++++++++++-
 kernel/sched/core.c     |    2 +-
 kernel/sched/sched.h    |    4 ++--
 kernel/smpboot.c        |    1 +
 kernel/workqueue.c      |   11 +++++++++--
 6 files changed, 40 insertions(+), 6 deletions(-)

--- a/include/linux/kthread.h
+++ b/include/linux/kthread.h
@@ -33,6 +33,9 @@ struct task_struct *kthread_create_on_cp
 					  unsigned int cpu,
 					  const char *namefmt);
 
+void kthread_set_per_cpu(struct task_struct *k, bool set);
+bool kthread_is_per_cpu(struct task_struct *k);
+
 /**
  * kthread_run - create and wake a thread.
  * @threadfn: the function to run until signal_pending(current).
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -493,11 +493,34 @@ struct task_struct *kthread_create_on_cp
 		return p;
 	kthread_bind(p, cpu);
 	/* CPU hotplug need to bind once again when unparking the thread. */
-	set_bit(KTHREAD_IS_PER_CPU, &to_kthread(p)->flags);
 	to_kthread(p)->cpu = cpu;
 	return p;
 }
 
+void kthread_set_per_cpu(struct task_struct *k, bool set)
+{
+	struct kthread *kthread = to_kthread(k);
+	if (!kthread)
+		return;
+
+	if (set) {
+		WARN_ON_ONCE(!(k->flags & PF_NO_SETAFFINITY));
+		WARN_ON_ONCE(k->nr_cpus_allowed != 1);
+		set_bit(KTHREAD_IS_PER_CPU, &kthread->flags);
+	} else {
+		clear_bit(KTHREAD_IS_PER_CPU, &kthread->flags);
+	}
+}
+
+bool kthread_is_per_cpu(struct task_struct *k)
+{
+	struct kthread *kthread = to_kthread(k);
+	if (!kthread)
+		return false;
+
+	return test_bit(KTHREAD_IS_PER_CPU, &kthread->flags);
+}
+
 /**
  * kthread_unpark - unpark a thread created by kthread_create().
  * @k:		thread created by kthread_create().
--- a/kernel/smpboot.c
+++ b/kernel/smpboot.c
@@ -188,6 +188,7 @@ __smpboot_create_thread(struct smp_hotpl
 		kfree(td);
 		return PTR_ERR(tsk);
 	}
+	kthread_set_per_cpu(tsk, true);
 	/*
 	 * Park the thread so that it could start right on the CPU
 	 * when it is available.


