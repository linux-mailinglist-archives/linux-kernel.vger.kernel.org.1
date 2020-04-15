Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CBC81AB320
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 23:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442278AbgDOVIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 17:08:41 -0400
Received: from foss.arm.com ([217.140.110.172]:52582 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2442233AbgDOVFn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 17:05:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 72FDD1396;
        Wed, 15 Apr 2020 14:05:30 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3F0653F6C4;
        Wed, 15 Apr 2020 14:05:29 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v3 5/9] sched: Add WF_TTWU, WF_EXEC wakeup flags
Date:   Wed, 15 Apr 2020 22:05:08 +0100
Message-Id: <20200415210512.805-6-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200415210512.805-1-valentin.schneider@arm.com>
References: <20200415210512.805-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To remove the sd_flag parameter of select_task_rq(), we need another way of
encoding wakeup kinds. There already is a WF_FORK flag, add the missing
ones.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/sched.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index db3a57675ccf..f32c5fa229af 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1684,11 +1684,13 @@ static inline int task_on_rq_migrating(struct task_struct *p)
 }
 
 /*
- * wake flags
+ * Wake flags
  */
 #define WF_SYNC			0x01		/* Waker goes to sleep after wakeup */
-#define WF_FORK			0x02		/* Child wakeup after fork */
-#define WF_MIGRATED		0x4		/* Internal use, task got migrated */
+#define WF_TTWU                 0x02            /* Regular task wakeup */
+#define WF_FORK			0x04		/* Child wakeup after fork */
+#define WF_EXEC			0x08		/* "Fake" wakeup at exec */
+#define WF_MIGRATED		0x10		/* Internal use, task got migrated */
 
 /*
  * To aid in avoiding the subversion of "niceness" due to uneven distribution
-- 
2.24.0

