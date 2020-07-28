Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9C0823086F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jul 2020 13:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728991AbgG1LP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jul 2020 07:15:27 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8291 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728946AbgG1LP1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 07:15:27 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 1965B9CA871939C9FC9A;
        Tue, 28 Jul 2020 19:15:23 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Tue, 28 Jul 2020
 19:15:15 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>
CC:     <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH] sched: remove duplicated tick_nohz_full_enabled() check
Date:   Tue, 28 Jul 2020 19:17:55 +0800
Message-ID: <1595935075-14223-1-git-send-email-linmiaohe@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miaohe Lin <linmiaohe@huawei.com>

The func tick_nohz_full_enabled() is also called by tick_nohz_full_cpu().
So this one is duplicated and should be removed.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 kernel/sched/sched.h | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 877fb08eb1b0..02028f785f87 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1930,12 +1930,7 @@ extern int __init sched_tick_offload_init(void);
  */
 static inline void sched_update_tick_dependency(struct rq *rq)
 {
-	int cpu;
-
-	if (!tick_nohz_full_enabled())
-		return;
-
-	cpu = cpu_of(rq);
+	int cpu = cpu_of(rq);
 
 	if (!tick_nohz_full_cpu(cpu))
 		return;
-- 
2.19.1

