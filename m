Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 804CF2FE7D6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 11:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbhAUKl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 05:41:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729707AbhAUKiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 05:38:15 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40DDFC061757
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 02:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=iG+VYI5VLsPffn7LbYzbPRDpEEf5Kpxrq9KibfoDzJk=; b=mu8mZLV/JWUI6eSuuA5j/1B1si
        Gv/RakMeCMfx6QuhzfNr2d3/TY4OX44sMV6gif0PASRmd9lZdyv9em1yus3f8A19IJ3L42o6fPUMl
        px1iapXhAXxO7tDrVcehk9HNqqp/2m2TuxBO1ZMq8nMnw1TJAwjgkcbH2J2fQgGGsCIJa1SkcqwRR
        TkfDYrK6LQJcLQ/I05s/o4xwgmyF9wcVHmN40ityUvW8YRmE2cDgG0rA8DJmL69JFm7XEHigJms1Q
        7sas59Y/AnfDJykfbVrmcLZSEgsX5d3eYmKvBJnMSFmej/sSwcat3WUSQaoEZSzf8v4dy2cPr9ypQ
        qbbcaCFw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l2XKJ-00GvZj-Mf; Thu, 21 Jan 2021 10:36:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 07FF9305DD1;
        Thu, 21 Jan 2021 11:36:29 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 6D23A20C86814; Thu, 21 Jan 2021 11:36:28 +0100 (CET)
Message-ID: <20210121103506.826629830@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 21 Jan 2021 11:17:08 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, jiangshanlai@gmail.com,
        valentin.schneider@arm.com, cai@redhat.com,
        vincent.donnefort@arm.com, decui@microsoft.com, paulmck@kernel.org,
        vincent.guittot@linaro.org, rostedt@goodmis.org, tj@kernel.org,
        peterz@infradead.org
Subject: [PATCH -v3 6/9] workqueue: Restrict affinity change to rescuer
References: <20210121101702.402798862@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

create_worker() will already set the right affinity using
kthread_bind_mask(), this means only the rescuer will need to change
it's affinity.

Howveer, while in cpu-hot-unplug a regular task is not allowed to run
on online&&!active as it would be pushed away quite agressively. We
need KTHREAD_IS_PER_CPU to survive in that environment.

Therefore set the affinity after getting that magic flag.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/workqueue.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1849,12 +1849,6 @@ static void worker_attach_to_pool(struct
 	mutex_lock(&wq_pool_attach_mutex);
 
 	/*
-	 * set_cpus_allowed_ptr() will fail if the cpumask doesn't have any
-	 * online CPUs.  It'll be re-applied when any of the CPUs come up.
-	 */
-	set_cpus_allowed_ptr(worker->task, pool->attrs->cpumask);
-
-	/*
 	 * The wq_pool_attach_mutex ensures %POOL_DISASSOCIATED remains
 	 * stable across this function.  See the comments above the flag
 	 * definition for details.
@@ -1864,6 +1858,9 @@ static void worker_attach_to_pool(struct
 	else
 		kthread_set_per_cpu(worker->task, pool->cpu);
 
+	if (worker->rescue_wq)
+		set_cpus_allowed_ptr(worker->task, pool->attrs->cpumask);
+
 	list_add_tail(&worker->node, &pool->workers);
 	worker->pool = pool;
 


