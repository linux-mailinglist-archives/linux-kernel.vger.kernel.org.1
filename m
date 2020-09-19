Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 242B5270D33
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 12:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbgISKqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Sep 2020 06:46:54 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:52056 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726311AbgISKqx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Sep 2020 06:46:53 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E36F54600D799DB3AC9E;
        Sat, 19 Sep 2020 18:46:50 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.253) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Sat, 19 Sep 2020 18:46:40 +0800
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
Subject: [PATCH v2 1/2] libnvdimm/badrange: remove two redundant list_empty() branches
Date:   Sat, 19 Sep 2020 18:45:45 +0800
Message-ID: <20200919104546.3848-2-thunder.leizhen@huawei.com>
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

In add_badrange() or badblocks_populate(), the list_empty() branch does
the same things as the code after list_for_each_entry().

The pseudo code is as follows:
1)	if (list_empty()) {
		do things-A
		return Y;
	}

2)	list_for_each_entry()
		do things-B	//can only be entered if !list_empty()

3)	do things-A
        return Y;

It's very clear that, the processing result after deleting 1) is the same
as that before deleting 1).

So delete 1) to simplify code.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/nvdimm/badrange.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/nvdimm/badrange.c b/drivers/nvdimm/badrange.c
index b9eeefa27e3a507..9fdba8c43e8605e 100644
--- a/drivers/nvdimm/badrange.c
+++ b/drivers/nvdimm/badrange.c
@@ -53,13 +53,6 @@ static int add_badrange(struct badrange *badrange, u64 addr, u64 length)
 	bre_new = kzalloc(sizeof(*bre_new), GFP_KERNEL);
 	spin_lock(&badrange->lock);
 
-	if (list_empty(&badrange->list)) {
-		if (!bre_new)
-			return -ENOMEM;
-		append_badrange_entry(badrange, bre_new, addr, length);
-		return 0;
-	}
-
 	/*
 	 * There is a chance this is a duplicate, check for those first.
 	 * This will be the common case as ARS_STATUS returns all known
@@ -215,9 +208,6 @@ static void badblocks_populate(struct badrange *badrange,
 {
 	struct badrange_entry *bre;
 
-	if (list_empty(&badrange->list))
-		return;
-
 	list_for_each_entry(bre, &badrange->list, list) {
 		u64 bre_end = bre->start + bre->length - 1;
 
-- 
1.8.3


