Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D53D02B3F1F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 09:52:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbgKPIvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 03:51:12 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7247 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726172AbgKPIvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 03:51:12 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CZN8D1cN6zkY6m;
        Mon, 16 Nov 2020 16:50:52 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Mon, 16 Nov 2020 16:51:00 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] mm/page_alloc: Mark some symbols with static keyword
Date:   Mon, 16 Nov 2020 17:02:45 +0800
Message-ID: <1605517365-65858-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following sparse warnings:

mm/page_alloc.c:3040:6: warning: symbol '__drain_all_pages' was not declared. Should it be static?
mm/page_alloc.c:6349:6: warning: symbol '__zone_set_pageset_high_and_batch' was not declared. Should it be static?

Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 mm/page_alloc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 63d8d8b..e7548344 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3037,7 +3037,7 @@ static void drain_local_pages_wq(struct work_struct *work)
  * that need the guarantee that every CPU has drained can disable the
  * optimizing racy check.
  */
-void __drain_all_pages(struct zone *zone, bool force_all_cpus)
+static void __drain_all_pages(struct zone *zone, bool force_all_cpus)
 {
 	int cpu;
 
@@ -6346,7 +6346,7 @@ static void pageset_init(struct per_cpu_pageset *p)
 	pcp->batch = BOOT_PAGESET_BATCH;
 }
 
-void __zone_set_pageset_high_and_batch(struct zone *zone, unsigned long high,
+static void __zone_set_pageset_high_and_batch(struct zone *zone, unsigned long high,
 		unsigned long batch)
 {
 	struct per_cpu_pageset *p;
-- 
2.6.2

