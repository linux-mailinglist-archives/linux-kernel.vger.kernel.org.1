Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 729561A65FF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Apr 2020 13:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729290AbgDMLzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Apr 2020 07:55:12 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2309 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727907AbgDMLzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 07:55:11 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 293DEE77BF1E146064DD;
        Mon, 13 Apr 2020 19:55:08 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Mon, 13 Apr 2020 19:54:59 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>,
        <linux-kernel@vger.kernel.org>
CC:     Zou Wei <zou_wei@huawei.com>
Subject: [PATCH-next] sched/topology: use true, false for bool variable
Date:   Mon, 13 Apr 2020 20:01:21 +0800
Message-ID: <1586779281-103078-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes coccicheck warning:

kernel/sched/topology.c:224:3-22: WARNING: Assignment of 0/1 to bool variable
kernel/sched/topology.c:226:3-22: WARNING: Assignment of 0/1 to bool variable

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 kernel/sched/topology.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 8344757b..e4d6464 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -221,9 +221,9 @@ int sched_energy_aware_handler(struct ctl_table *table, int write,
 		state = static_branch_unlikely(&sched_energy_present);
 		if (state != sysctl_sched_energy_aware) {
 			mutex_lock(&sched_energy_mutex);
-			sched_energy_update = 1;
+			sched_energy_update = true;
 			rebuild_sched_domains();
-			sched_energy_update = 0;
+			sched_energy_update = false;
 			mutex_unlock(&sched_energy_mutex);
 		}
 	}
-- 
2.6.2

