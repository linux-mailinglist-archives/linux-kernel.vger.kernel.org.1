Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 252712E33F1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 04:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbgL1Dsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Dec 2020 22:48:39 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:39458 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726167AbgL1Dsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Dec 2020 22:48:39 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=chenshiyan@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UJwcEqn_1609127268;
Received: from localhost(mailfrom:chenshiyan@linux.alibaba.com fp:SMTPD_---0UJwcEqn_1609127268)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 28 Dec 2020 11:47:57 +0800
From:   chenshiyan <chenshiyan@linux.alibaba.com>
To:     fweisbec@gmail.com, tglx@linutronix.de, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V1] nohz: exit nohz idle before invoking softirq
Date:   Mon, 28 Dec 2020 11:47:48 +0800
Message-Id: <1609127268-40179-1-git-send-email-chenshiyan@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "shiyan.csy" <shiyan.csy@alibaba-inc.com>

exit nohz idle before invoking softirq, or it maymiss
some ticks during softirq.

Signed-off-by: Shiyan Chen <chenshiyan@linux.alibaba.com>
---
 kernel/softirq.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index 9d71046..59bd6fe 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -404,6 +404,10 @@ static inline void tick_irq_exit(void)
 		if (!in_irq())
 			tick_nohz_irq_exit();
 	}
+
+	/* need to exit nohz idle if there's a softirq */
+	if (in_serving_softirq() || local_softirq_pending())
+		tick_nohz_idle_exit();
 #endif
 }
 
@@ -416,10 +420,11 @@ static inline void __irq_exit_rcu(void)
 #endif
 	account_hardirq_exit(current);
 	preempt_count_sub(HARDIRQ_OFFSET);
-	if (!in_interrupt() && local_softirq_pending())
-		invoke_softirq();
 
+	/* must call before invoke_softirq */
 	tick_irq_exit();
+	if (!in_interrupt() && local_softirq_pending())
+		invoke_softirq();
 }
 
 /**
-- 
1.8.3.1

