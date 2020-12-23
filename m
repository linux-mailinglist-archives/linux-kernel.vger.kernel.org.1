Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94B802E1AA0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 10:54:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbgLWJwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 04:52:31 -0500
Received: from m12-14.163.com ([220.181.12.14]:47036 "EHLO m12-14.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728147AbgLWJwa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 04:52:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=i8T2Cm6FnxE8zbZXoy
        WDy2tvwCF9gtslIKw21Zf+WAg=; b=FL3R1PvJCdYCWLYTCzn6Ui927l8tOC577p
        fymgaHobLiQhXdsF00JK3wRgzJyyfW9Ibe9KEXkSLvlA+6aj1FfLbBRuiR499hsx
        XfYv9/jGa3RR9bW8btvbUIuK/Z/T1VwacrUcoFZCrur4KnvGWoZBSHsWH/X5Ty2z
        zekGK5Tow=
Received: from localhost.localdomain (unknown [14.17.22.31])
        by smtp10 (Coremail) with SMTP id DsCowAA3Sno6++JfDt+dcQ--.47865S3;
        Wed, 23 Dec 2020 16:09:31 +0800 (CST)
From:   ultrachin@163.com
To:     linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, heddchen@tencent.com, xiaoggchen@tencent.com
Subject: [PATCH] sched: pull tasks when CPU is about to run SCHED_IDLE tasks
Date:   Wed, 23 Dec 2020 16:09:28 +0800
Message-Id: <1608710968-31475-1-git-send-email-ultrachin@163.com>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: DsCowAA3Sno6++JfDt+dcQ--.47865S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrtFykKFyUXw45Xr18Xw45trb_yoW3Arc_ua
        n3Crsakr15tw1jyFWxurW7XFyFqa40gF95Cw12yrW5G3sYyws3JrZ5AFyrGrs3KrWUCF97
        Ar98WF92qr1xGjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0DUUUUUUUU==
X-Originating-IP: [14.17.22.31]
X-CM-SenderInfo: xxow2thfkl0qqrwthudrp/1tbivxsEWFWBtFpCkQAAsR
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen Xiaoguang <xiaoggchen@tencent.com>

Before a CPU switches from running SCHED_NORMAL task to
SCHED_IDLE task, trying to pull SCHED_NORMAL tasks from other
CPU by doing load_balance first.

Signed-off-by: Chen Xiaoguang <xiaoggchen@tencent.com>
Signed-off-by: Chen He <heddchen@tencent.com>
---
 kernel/sched/fair.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ae7ceba..0a26132 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7004,6 +7004,11 @@ struct task_struct *
 	struct task_struct *p;
 	int new_tasks;
 
+	if (prev &&
+	    fair_policy(prev->policy) &&
+	    sched_idle_cpu(rq->cpu))
+		goto idle;
+
 again:
 	if (!sched_fair_runnable(rq))
 		goto idle;
-- 
1.8.3.1


