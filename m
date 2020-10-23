Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5261A296CD0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 12:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S462293AbgJWKZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 06:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S462247AbgJWKZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 06:25:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521B5C0613D5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 03:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=NZ9nghvIXs+efdG5GPWjSl7ZfyU5HUFp1/vX6ef/GjU=; b=nxyGPnBtpLj3U7/w18CSgI9dby
        f3mDS2LIKIORbKHf19kmYnX+Rcd7ne2Bwmp5o/2tuvPlbRjpPyDLJTuiRrxAFH+UVcJe4iHvTXHa7
        nFzFN6xm1JvZH9KiCDpASkwAPhnkDdLrVRw4VBY8pHOXVfFopxkj9Esecwlpo86r3Im6bH4pCmMKg
        hUT94MawQUcg8o20QDGbQiTNoVC6LPWtNghbVotYEyTlZ8tKxhiJwP+OvMYKXPoc7oJgxp3XXq9WD
        s4TzioEXrjWA2TtqZdI8Xyq99JhbkRX0HFQXG8MkO/oOmfuO2KeKxiEw43T+Ar7a6TcjSSibhut2D
        cNNVOOMg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kVuFp-0002tK-FU; Fri, 23 Oct 2020 10:25:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E0B51307975;
        Fri, 23 Oct 2020 12:24:56 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 789DD29DDA666; Fri, 23 Oct 2020 12:24:56 +0200 (CEST)
Message-ID: <20201023102347.593984734@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 23 Oct 2020 12:12:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, bigeasy@linutronix.de,
        qais.yousef@arm.com, swood@redhat.com, peterz@infradead.org,
        valentin.schneider@arm.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vincent.donnefort@arm.com, tj@kernel.org,
        ouwen210@hotmail.com
Subject: [PATCH v4 16/19] sched/proc: Print accurate cpumask vs migrate_disable()
References: <20201023101158.088940906@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ensure /proc/*/status doesn't print 'random' cpumasks due to
migrate_disable().

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 fs/proc/array.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -382,9 +382,9 @@ static inline void task_context_switch_c
 static void task_cpus_allowed(struct seq_file *m, struct task_struct *task)
 {
 	seq_printf(m, "Cpus_allowed:\t%*pb\n",
-		   cpumask_pr_args(task->cpus_ptr));
+		   cpumask_pr_args(&task->cpus_mask));
 	seq_printf(m, "Cpus_allowed_list:\t%*pbl\n",
-		   cpumask_pr_args(task->cpus_ptr));
+		   cpumask_pr_args(&task->cpus_mask));
 }
 
 static inline void task_core_dumping(struct seq_file *m, struct mm_struct *mm)


