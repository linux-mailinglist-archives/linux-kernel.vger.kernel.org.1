Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB720270D32
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 12:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbgISKqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Sep 2020 06:46:53 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:52062 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726041AbgISKqx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Sep 2020 06:46:53 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E731E4417A714F281C9A;
        Sat, 19 Sep 2020 18:46:50 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.253) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Sat, 19 Sep 2020 18:46:41 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Oliver O'Halloran <oohall@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Markus Elfring <Markus.Elfring@web.de>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Libin <huawei.libin@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v2 2/2] libnvdimm/badrange: eliminate a meaningless spinlock operation
Date:   Sat, 19 Sep 2020 18:45:46 +0800
Message-ID: <20200919104546.3848-3-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20200919104546.3848-1-thunder.leizhen@huawei.com>
References: <20200919104546.3848-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

badrange_add() take the lock "badrange->lock", but it's released
immediately in add_badrange(), protect nothing.

The pseudo code is as follows:
In badrange_add():
	spin_lock(&badrange->lock);	<---------------
	rc = add_badrange(badrange, addr, length);	|
In add_badrange():					|
	//do nothing					|
	spin_unlock(&badrange->lock);	<---------------
	bre_new = kzalloc(sizeof(*bre_new), GFP_KERNEL);
	spin_lock(&badrange->lock);	<--- lock again

This lock/unlock operation is meaningless.

Because the static function add_badrange() is only called by
badrange_add(), so move its content into badrange_add() then delete it.
By the way, move "kfree(bre_new)" out of the lock protection, it really
doesn't need.

Fixes: b3b454f694db ("libnvdimm: fix clear poison locking with spinlock ...")
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/nvdimm/badrange.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/nvdimm/badrange.c b/drivers/nvdimm/badrange.c
index 9fdba8c43e8605e..7f78b659057902d 100644
--- a/drivers/nvdimm/badrange.c
+++ b/drivers/nvdimm/badrange.c
@@ -45,12 +45,12 @@ static int alloc_and_append_badrange_entry(struct badrange *badrange,
 	return 0;
 }
 
-static int add_badrange(struct badrange *badrange, u64 addr, u64 length)
+int badrange_add(struct badrange *badrange, u64 addr, u64 length)
 {
 	struct badrange_entry *bre, *bre_new;
 
-	spin_unlock(&badrange->lock);
 	bre_new = kzalloc(sizeof(*bre_new), GFP_KERNEL);
+
 	spin_lock(&badrange->lock);
 
 	/*
@@ -63,6 +63,7 @@ static int add_badrange(struct badrange *badrange, u64 addr, u64 length)
 			/* If length has changed, update this list entry */
 			if (bre->length != length)
 				bre->length = length;
+			spin_unlock(&badrange->lock);
 			kfree(bre_new);
 			return 0;
 		}
@@ -72,22 +73,15 @@ static int add_badrange(struct badrange *badrange, u64 addr, u64 length)
 	 * as any overlapping ranges will get resolved when the list is consumed
 	 * and converted to badblocks
 	 */
-	if (!bre_new)
+	if (!bre_new) {
+		spin_unlock(&badrange->lock);
 		return -ENOMEM;
-	append_badrange_entry(badrange, bre_new, addr, length);
-
-	return 0;
-}
-
-int badrange_add(struct badrange *badrange, u64 addr, u64 length)
-{
-	int rc;
+	}
 
-	spin_lock(&badrange->lock);
-	rc = add_badrange(badrange, addr, length);
+	append_badrange_entry(badrange, bre_new, addr, length);
 	spin_unlock(&badrange->lock);
 
-	return rc;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(badrange_add);
 
-- 
1.8.3


