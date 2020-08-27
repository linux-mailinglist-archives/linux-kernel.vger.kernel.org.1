Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA79B254515
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Aug 2020 14:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729048AbgH0MiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Aug 2020 08:38:05 -0400
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:42223 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728957AbgH0MMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 08:12:48 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1618609|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_enroll_verification|0.0266949-0.00317964-0.970125;FP=10364181428023396474|1|1|9|0|-1|-1|-1;HT=e01l04362;MF=frank@allwinnertech.com;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.IOlFrJR_1598530361;
Received: from allwinnertech.com(mailfrom:frank@allwinnertech.com fp:SMTPD_---.IOlFrJR_1598530361)
          by smtp.aliyun-inc.com(10.147.42.198);
          Thu, 27 Aug 2020 20:12:45 +0800
From:   Frank Lee <frank@allwinnertech.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de
Cc:     linux-kernel@vger.kernel.org, tiny.windzz@gmail.com,
        Yangtao Li <frank@allwinnertech.com>
Subject: [PATCH] sched: idle: Change the cpu_idle_poll() return type to void
Date:   Thu, 27 Aug 2020 20:12:25 +0800
Message-Id: <20200827121225.2991-1-frank@allwinnertech.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yangtao Li <frank@allwinnertech.com>

No one cares about the return value of this function, which only
increases the time spent in idle loop. Let's drop it.

Signed-off-by: Yangtao Li <frank@allwinnertech.com>

---
 kernel/sched/idle.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 6bf34986f45c..5250a7c466e6 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -52,7 +52,7 @@ static int __init cpu_idle_nopoll_setup(char *__unused)
 __setup("hlt", cpu_idle_nopoll_setup);
 #endif
 
-static noinline int __cpuidle cpu_idle_poll(void)
+static noinline void __cpuidle cpu_idle_poll(void)
 {
 	rcu_idle_enter();
 	trace_cpu_idle_rcuidle(0, smp_processor_id());
@@ -65,8 +65,6 @@ static noinline int __cpuidle cpu_idle_poll(void)
 	start_critical_timings();
 	trace_cpu_idle_rcuidle(PWR_EVENT_EXIT, smp_processor_id());
 	rcu_idle_exit();
-
-	return 1;
 }
 
 /* Weak implementations for optional arch specific functions */
-- 
2.28.0

