Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01CED297432
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 18:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S462662AbgJWQfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 12:35:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:33336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S460729AbgJWQdv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 12:33:51 -0400
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED1C924706;
        Fri, 23 Oct 2020 16:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603470829;
        bh=rItW9x31JNK0epQQegBAn1Gj/Xyt1H69mENmOqwza/Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SzI3oyhH9/LZ0/V8EuroC56RaZXZpviO+rugkXUBxXAFTeXVbfURNV+u9Af2fw9B6
         ivzwN0j1YGhKc4oR50WDNJaENI+aNAqk9e0RQEuPtJc4fB4oY9jIlsmf96v8gqmINX
         YKMszTP0AiYyNxmrmwSByiELMEsb0PTcUeRRN9UE=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kW00g-002Axp-P7; Fri, 23 Oct 2020 18:33:46 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 53/56] shed: fix kernel-doc markup
Date:   Fri, 23 Oct 2020 18:33:40 +0200
Message-Id: <21eac4426e02193aab877564f7d7d99114627a46.1603469755.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1603469755.git.mchehab+huawei@kernel.org>
References: <cover.1603469755.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel-doc requires that a kernel-doc markup to be immediatly
below the function prototype, as otherwise it will rename it.
So, move sys_sched_yield() markup to the right place.

Also fix the cpu_util() markup: Kernel-doc markups
should use this format:
        identifier - description

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 kernel/sched/core.c | 16 ++++++++--------
 kernel/sched/fair.c |  3 ++-
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 8160ab5263f8..f7189247f007 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6076,14 +6076,6 @@ SYSCALL_DEFINE3(sched_getaffinity, pid_t, pid, unsigned int, len,
 	return ret;
 }
 
-/**
- * sys_sched_yield - yield the current processor to other threads.
- *
- * This function yields the current CPU to other tasks. If there are no
- * other threads running on this CPU then this function will return.
- *
- * Return: 0.
- */
 static void do_sched_yield(void)
 {
 	struct rq_flags rf;
@@ -6105,6 +6097,14 @@ static void do_sched_yield(void)
 	schedule();
 }
 
+/**
+ * sys_sched_yield - yield the current processor to other threads.
+ *
+ * This function yields the current CPU to other tasks. If there are no
+ * other threads running on this CPU then this function will return.
+ *
+ * Return: 0.
+ */
 SYSCALL_DEFINE0(sched_yield)
 {
 	do_sched_yield();
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index aa4c6227cd6d..94386fcfafcf 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6287,7 +6287,8 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 }
 
 /**
- * Amount of capacity of a CPU that is (estimated to be) used by CFS tasks
+ * cpu_util - Amount of capacity of a CPU that is (estimated to be)
+ *	used by CFS tasks
  * @cpu: the CPU to get the utilization of
  *
  * The unit of the return value must be the one of capacity so we can compare
-- 
2.26.2

