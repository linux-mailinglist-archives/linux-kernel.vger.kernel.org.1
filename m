Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 098DA27A0E7
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 14:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbgI0M3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 08:29:19 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:51516 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726149AbgI0M3T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 08:29:19 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 79A83F47D96D066F4DD9;
        Sun, 27 Sep 2020 20:29:17 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Sun, 27 Sep 2020
 20:29:11 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <feng.tang@intel.com>
CC:     <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH] percpu_counter: Use helper macro abs()
Date:   Sun, 27 Sep 2020 08:27:46 -0400
Message-ID: <20200927122746.5964-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use helper macro abs() to simplify the "x >= t || x <= -t" cmp.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 lib/percpu_counter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/percpu_counter.c b/lib/percpu_counter.c
index a2345de90e93..35aba0bd2bed 100644
--- a/lib/percpu_counter.c
+++ b/lib/percpu_counter.c
@@ -85,7 +85,7 @@ void percpu_counter_add_batch(struct percpu_counter *fbc, s64 amount, s32 batch)
 
 	preempt_disable();
 	count = __this_cpu_read(*fbc->counters) + amount;
-	if (count >= batch || count <= -batch) {
+	if (abs(count) >= batch) {
 		unsigned long flags;
 		raw_spin_lock_irqsave(&fbc->lock, flags);
 		fbc->count += count;
-- 
2.19.1

