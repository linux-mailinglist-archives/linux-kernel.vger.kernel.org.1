Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4332A3346
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 19:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbgKBSsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 13:48:10 -0500
Received: from foss.arm.com ([217.140.110.172]:36218 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725846AbgKBSsH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 13:48:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 772CC1424;
        Mon,  2 Nov 2020 10:48:06 -0800 (PST)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4081B3F719;
        Mon,  2 Nov 2020 10:48:05 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [PATCH v4 1/3] sched: Add WF_TTWU, WF_EXEC wakeup flags
Date:   Mon,  2 Nov 2020 18:45:12 +0000
Message-Id: <20201102184514.2733-2-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201102184514.2733-1-valentin.schneider@arm.com>
References: <20201102184514.2733-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To remove the sd_flag parameter of select_task_rq(), we need another way of
encoding wakeup types. There already is a WF_FORK flag, add the missing two.

With that said, we still need an easy way to turn WF_foo into
SD_bar (e.g. WF_TTWU into SD_BALANCE_WAKE). As suggested by Peter, let's
make our lives easier and make them match exactly, and throw in some
compile-time checks for good measure.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/sched.h | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index df80bfcea92e..65666c52f347 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1714,13 +1714,20 @@ static inline int task_on_rq_migrating(struct task_struct *p)
 	return READ_ONCE(p->on_rq) == TASK_ON_RQ_MIGRATING;
 }
 
-/*
- * wake flags
- */
-#define WF_SYNC			0x01		/* Waker goes to sleep after wakeup */
-#define WF_FORK			0x02		/* Child wakeup after fork */
-#define WF_MIGRATED		0x04		/* Internal use, task got migrated */
-#define WF_ON_CPU		0x08		/* Wakee is on_cpu */
+/* Wake flags. The first three directly map to some SD flag value */
+#define WF_EXEC     0x02 /* Wakeup after exec; maps to SD_BALANCE_EXEC */
+#define WF_FORK     0x04 /* Wakeup after fork; maps to SD_BALANCE_FORK */
+#define WF_TTWU     0x08 /* Wakeup;            maps to SD_BALANCE_WAKE */
+
+#define WF_SYNC     0x10 /* Waker goes to sleep after wakeup */
+#define WF_MIGRATED 0x20 /* Internal use, task got migrated */
+#define WF_ON_CPU   0x40 /* Wakee is on_cpu */
+
+#ifdef CONFIG_SMP
+static_assert(WF_EXEC == SD_BALANCE_EXEC);
+static_assert(WF_FORK == SD_BALANCE_FORK);
+static_assert(WF_TTWU == SD_BALANCE_WAKE);
+#endif
 
 /*
  * To aid in avoiding the subversion of "niceness" due to uneven distribution
-- 
2.27.0

