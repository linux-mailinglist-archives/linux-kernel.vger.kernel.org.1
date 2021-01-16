Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5CF92F8D2C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 12:47:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbhAPLoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 06:44:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727286AbhAPLom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 06:44:42 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDBA2C061799
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jan 2021 03:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=5+bURMTjNsaUVU325HY+fLJyyZiMYGp5PZEDOTyZKTo=; b=PkvNQvydv0LX+77SO6uqp2nGDl
        HQK17l2TmPUNGvuKFE0oEe1UpVJaCkDQ8a3HUZXwl8gBcALWb0ujWCAfKNSS2nGF856ncw5/mIThT
        P4snQVJIKAC6ewfghjBylmQe7a/eIlYysb/J2Zr7SYpXiIIksuSfr0u/pMB7p2UuF7AOt7mGzbDlx
        PZYz+pOuFTlMWehl2NZGkyG/GRr7JJLpxVR4V0JMriYp/J3QsQJD9QsPvwIvQTxtybg6abeUKSDic
        a0D7RHclAtz62zJs+6GejV50ieUmPAOzLnfrlWPEvhP0EZ+PdZKNttSFpTBptVZgxK8+k+77qupDb
        4hFU+oPQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l0jyT-00ADOE-M6; Sat, 16 Jan 2021 11:42:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5ADDD30377D;
        Sat, 16 Jan 2021 12:42:30 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 278932028A2D0; Sat, 16 Jan 2021 12:42:30 +0100 (CET)
Message-ID: <20210116113919.848133467@infradead.org>
User-Agent: quilt/0.66
Date:   Sat, 16 Jan 2021 12:30:37 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, jiangshanlai@gmail.com,
        valentin.schneider@arm.com, cai@redhat.com,
        vincent.donnefort@arm.com, decui@microsoft.com, paulmck@kernel.org,
        vincent.guittot@linaro.org, rostedt@goodmis.org, tj@kernel.org,
        peterz@infradead.org
Subject: [PATCH 4/8] kthread: Extract KTHREAD_IS_PER_CPU
References: <20210116113033.608340773@infradead.org>
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
---
 include/linux/kthread.h |    3 +++
 kernel/kthread.c        |   30 ++++++++++++++++++++++++++++--
 kernel/smpboot.c        |    1 +
 3 files changed, 32 insertions(+), 2 deletions(-)

--- a/include/linux/kthread.h
+++ b/include/linux/kthread.h
@@ -33,6 +33,9 @@ struct task_struct *kthread_create_on_cp
 					  unsigned int cpu,
 					  const char *namefmt);
 
+void kthread_set_per_cpu(struct task_struct *k, int cpu);
+bool kthread_is_per_cpu(struct task_struct *k);
+
 /**
  * kthread_run - create and wake a thread.
  * @threadfn: the function to run until signal_pending(current).
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -493,11 +494,36 @@ struct task_struct *kthread_create_on_cp
 		return p;
 	kthread_bind(p, cpu);
 	/* CPU hotplug need to bind once again when unparking the thread. */
-	set_bit(KTHREAD_IS_PER_CPU, &to_kthread(p)->flags);
 	to_kthread(p)->cpu = cpu;
 	return p;
 }
 
+void kthread_set_per_cpu(struct task_struct *k, int cpu)
+{
+	struct kthread *kthread = to_kthread(k);
+	if (!kthread)
+		return;
+
+	WARN_ON_ONCE(!(k->flags & PF_NO_SETAFFINITY));
+
+	if (cpu < 0) {
+		clear_bit(KTHREAD_IS_PER_CPU, &kthread->flags);
+		return;
+	}
+
+	kthread->cpu = cpu;
+	set_bit(KTHREAD_IS_PER_CPU, &kthread->flags);
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
+	kthread_set_per_cpu(tsk, cpu);
 	/*
 	 * Park the thread so that it could start right on the CPU
 	 * when it is available.


