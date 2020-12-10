Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43DEA2D622A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 17:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391429AbgLJQkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 11:40:15 -0500
Received: from foss.arm.com ([217.140.110.172]:52462 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727848AbgLJQkB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 11:40:01 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 48DA71FB;
        Thu, 10 Dec 2020 08:39:16 -0800 (PST)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E8E573F66B;
        Thu, 10 Dec 2020 08:39:13 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de,
        mingo@kernel.org, bigeasy@linutronix.de, qais.yousef@arm.com,
        swood@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vincent.donnefort@arm.com, tj@kernel.org,
        ouwen210@hotmail.com, Qian Cai <cai@redhat.com>
Subject: [PATCH 1/2] stop_machine: Add caller debug info to queue_stop_cpus_work
Date:   Thu, 10 Dec 2020 16:38:29 +0000
Message-Id: <20201210163830.21514-2-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201210163830.21514-1-valentin.schneider@arm.com>
References: <20201210163830.21514-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most callsites were covered by commit

  a8b62fd08505 ("stop_machine: Add function and caller debug info")

but this skipped queue_stop_cpus_work(). Add caller debug info to it.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/stop_machine.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
index 971d8acceaec..cbc30271ea4d 100644
--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -409,6 +409,7 @@ static bool queue_stop_cpus_work(const struct cpumask *cpumask,
 		work->fn = fn;
 		work->arg = arg;
 		work->done = done;
+		work->caller = _RET_IP_;
 		if (cpu_stop_queue_work(cpu, work))
 			queued = true;
 	}
-- 
2.27.0

