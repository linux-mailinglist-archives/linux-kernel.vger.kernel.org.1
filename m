Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9102D2F34C2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 16:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392489AbhALPzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 10:55:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45665 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390291AbhALPzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 10:55:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610466853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hNrX2cCpCMWJHbf1S/ll7Ao4YqIHU0K4MvkLQc/laIc=;
        b=KAsArgCAv/2WXHqGrwikmdZSHCHPOuBiBsXYfizQl1q8aCrMFpxijCRKXKB33EfVteT8Rj
        A2RNhMZhQRT/pTo4AIWRwJRhHs6nhUMXAPDs6wKYg85eMJLhR+so/keTn0oM0vQOl/MUnx
        m0r3AM7g7YmOW/yZ4daRVr+ZtCsbMUs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-a3u4cZL6NBmss121V-8adQ-1; Tue, 12 Jan 2021 10:54:10 -0500
X-MC-Unique: a3u4cZL6NBmss121V-8adQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B78561DDE3;
        Tue, 12 Jan 2021 15:54:08 +0000 (UTC)
Received: from x1.com (ovpn-113-251.rdu2.redhat.com [10.10.113.251])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 81FDD5D9D2;
        Tue, 12 Jan 2021 15:54:03 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Marco Perronet <perronet@mpi-sws.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Li Zefan <lizefan@huawei.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        cgroups@vger.kernel.org
Subject: [PATCH 1/6] sched/deadline: Consolidate the SCHED_DL task_can_attach() check on its own function
Date:   Tue, 12 Jan 2021 16:53:40 +0100
Message-Id: <2d68af58a64b9141a84f7a76a3840e2e4a54f133.1610463999.git.bristot@redhat.com>
In-Reply-To: <cover.1610463999.git.bristot@redhat.com>
References: <cover.1610463999.git.bristot@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is easier to track the restrictions imposed on SCHED_DEADLINE
tasks if we keep them all together in a single function.

No function changes.

Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Li Zefan <lizefan@huawei.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: linux-kernel@vger.kernel.org
Cc: cgroups@vger.kernel.org
---
 kernel/sched/core.c     | 3 +--
 kernel/sched/deadline.c | 7 +++++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 7af80c3fce12..f4aede34449c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7142,8 +7142,7 @@ int task_can_attach(struct task_struct *p,
 		goto out;
 	}
 
-	if (dl_task(p) && !cpumask_intersects(task_rq(p)->rd->span,
-					      cs_cpus_allowed))
+	if (dl_task(p))
 		ret = dl_task_can_attach(p, cs_cpus_allowed);
 
 out:
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 75686c6d4436..c97d2c707b98 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2870,6 +2870,13 @@ int dl_task_can_attach(struct task_struct *p, const struct cpumask *cs_cpus_allo
 	bool overflow;
 	int ret;
 
+	/*
+	 * The task is not moving to another root domain, so it is
+	 * already accounted.
+	 */
+	if (cpumask_intersects(task_rq(p)->rd->span, cs_cpus_allowed))
+		return 0;
+
 	dest_cpu = cpumask_any_and(cpu_active_mask, cs_cpus_allowed);
 
 	rcu_read_lock_sched();
-- 
2.29.2

