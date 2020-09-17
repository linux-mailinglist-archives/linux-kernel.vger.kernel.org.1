Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5806E26DAB9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 13:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgIQLts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 07:49:48 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13232 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726822AbgIQLrA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 07:47:00 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9018B256F03204D11C74;
        Thu, 17 Sep 2020 19:46:55 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Thu, 17 Sep 2020
 19:46:49 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] mm: avoid possible multiple call to swap_node()
Date:   Thu, 17 Sep 2020 07:44:49 -0400
Message-ID: <20200917114449.35285-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cache the swap_node() in a local variable to avoid possible multiple call
to swap_node(), though compiler may do this for us.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/swapfile.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 20012c0c0252..cd66b50f0490 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2454,7 +2454,7 @@ static void setup_swap_info(struct swap_info_struct *p, int prio,
 			    unsigned char *swap_map,
 			    struct swap_cluster_info *cluster_info)
 {
-	int i;
+	int i, node;
 
 	if (prio >= 0)
 		p->prio = prio;
@@ -2465,11 +2465,12 @@ static void setup_swap_info(struct swap_info_struct *p, int prio,
 	 * low-to-high, while swap ordering is high-to-low
 	 */
 	p->list.prio = -p->prio;
+	node = swap_node(p);
 	for_each_node(i) {
 		if (p->prio >= 0)
 			p->avail_lists[i].prio = -p->prio;
 		else {
-			if (swap_node(p) == i)
+			if (node == i)
 				p->avail_lists[i].prio = 1;
 			else
 				p->avail_lists[i].prio = -p->prio;
-- 
2.19.1

