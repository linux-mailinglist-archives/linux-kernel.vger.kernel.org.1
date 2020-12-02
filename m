Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05F2D2CC96B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 23:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387570AbgLBWL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 17:11:59 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8992 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727297AbgLBWL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 17:11:59 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CmY7t5gQVzhkrH;
        Thu,  3 Dec 2020 06:10:50 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.200.109) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Thu, 3 Dec 2020 06:11:06 +0800
From:   Barry Song <song.bao.hua@hisilicon.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>,
        <trivial@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        Barry Song <song.bao.hua@hisilicon.com>
Subject: [PATCH] sched/fair: trivial correction of the comment of newidle_balance
Date:   Thu, 3 Dec 2020 11:06:41 +1300
Message-ID: <20201202220641.22752-1-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.126.200.109]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

idle_balance() has been renamed to newidle_balance(). To differentiate
with nohz_idle_balance, it seems refining the comment will be helpful
for the readers of the code.

Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ae7ceba8fd4f..c1f86b8bdfda 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10505,7 +10505,7 @@ static inline void nohz_newidle_balance(struct rq *this_rq) { }
 #endif /* CONFIG_NO_HZ_COMMON */
 
 /*
- * idle_balance is called by schedule() if this_cpu is about to become
+ * newidle_balance is called by schedule() if this_cpu is about to become
  * idle. Attempts to pull tasks from other CPUs.
  *
  * Returns:
-- 
2.25.1

