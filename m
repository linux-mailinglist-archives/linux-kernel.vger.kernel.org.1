Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9B402AB77C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 12:48:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729645AbgKILs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 06:48:27 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7619 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbgKILsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 06:48:23 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CV8Q22gCVzLwXq;
        Mon,  9 Nov 2020 19:48:10 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Mon, 9 Nov 2020 19:48:09 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <paul.gortmaker@windriver.com>, <paulmck@kernel.org>,
        <peterz@infradead.org>, <akpm@linux-foundation.org>,
        <abelits@marvell.com>
CC:     <pjt@google.com>, <jinyuqi@huawei.com>,
        <linux-kernel@vger.kernel.org>, Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] cpumask: use false and true for bool variables
Date:   Mon, 9 Nov 2020 19:59:50 +0800
Message-ID: <1604923190-70981-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix coccicheck warnings:

./lib/cpumask.c:342:6-13: WARNING: Comparison of 0/1 to bool variable
./lib/cpumask.c:351:33-40: WARNING: Comparison of 0/1 to bool variable
./lib/cpumask.c:406:3-11: WARNING: Assignment of 0/1 to bool variable

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 lib/cpumask.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/cpumask.c b/lib/cpumask.c
index 34ecb30..74d0cf1 100644
--- a/lib/cpumask.c
+++ b/lib/cpumask.c
@@ -339,7 +339,7 @@ static int find_nearest_node(int *node_dist, bool *used)
 
 	/* Choose the first unused node to compare */
 	for (i = 0; i < nr_node_ids; i++) {
-		if (used[i] == 0) {
+		if (used[i] == false) {
 			min_dist = node_dist[i];
 			node_id = i;
 			break;
@@ -348,7 +348,7 @@ static int find_nearest_node(int *node_dist, bool *used)
 
 	/* Compare and return the nearest node */
 	for (i = 0; i < nr_node_ids; i++) {
-		if (node_dist[i] < min_dist && used[i] == 0) {
+		if (node_dist[i] < min_dist && used[i] == false) {
 			min_dist = node_dist[i];
 			node_id = i;
 		}
@@ -403,7 +403,7 @@ unsigned int cpumask_local_spread(unsigned int i, int node)
 							       flags);
 					return cpu;
 				}
-			used[id] = 1;
+			used[id] = true;
 		}
 		spin_unlock_irqrestore(&spread_lock, flags);
 
-- 
2.6.2

