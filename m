Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06445270D7F
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 13:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbgISLMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Sep 2020 07:12:54 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:47032 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726041AbgISLMy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Sep 2020 07:12:54 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 47FCEF26C25183634819;
        Sat, 19 Sep 2020 19:12:52 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.253) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Sat, 19 Sep 2020 19:12:43 +0800
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
Subject: [PATCH v2 1/1] libnvdimm: slightly simplify available_slots_show()
Date:   Sat, 19 Sep 2020 19:11:12 +0800
Message-ID: <20200919111112.4074-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The type of "nfree" is u32, so "nfree - 1" can only be overflowed when
"nfree" is zero. Replace "if (nfree - 1 > nfree)" with "if (nfree == 0)"
seems more clear. And remove the assignment "nfree = 0", no need for it.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
v1 --> v2:
No change, just sent separately

v1:
https://lkml.org/lkml/2020/8/19/1465

 drivers/nvdimm/dimm_devs.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/nvdimm/dimm_devs.c b/drivers/nvdimm/dimm_devs.c
index b59032e0859b7f3..d6835f127d83055 100644
--- a/drivers/nvdimm/dimm_devs.c
+++ b/drivers/nvdimm/dimm_devs.c
@@ -347,10 +347,9 @@ static ssize_t available_slots_show(struct device *dev,
 
 	nvdimm_bus_lock(dev);
 	nfree = nd_label_nfree(ndd);
-	if (nfree - 1 > nfree) {
+	if (nfree == 0)
 		dev_WARN_ONCE(dev, 1, "we ate our last label?\n");
-		nfree = 0;
-	} else
+	else
 		nfree--;
 	rc = sprintf(buf, "%d\n", nfree);
 	nvdimm_bus_unlock(dev);
-- 
1.8.3


