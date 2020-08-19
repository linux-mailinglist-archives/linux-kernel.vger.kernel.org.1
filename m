Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41A0A2492BA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Aug 2020 04:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbgHSCFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 22:05:50 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:53804 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726772AbgHSCFq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 22:05:46 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A1E71CAB0D9349564C39;
        Wed, 19 Aug 2020 10:05:44 +0800 (CST)
Received: from DESKTOP-C3MD9UG.china.huawei.com (10.174.177.253) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Wed, 19 Aug 2020 10:05:34 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Oliver O'Halloran <oohall@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Markus Elfring <Markus.Elfring@web.de>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v2 3/4] libnvdimm/bus: simplify walk_to_nvdimm_bus()
Date:   Wed, 19 Aug 2020 10:05:02 +0800
Message-ID: <20200819020503.3079-4-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20200819020503.3079-1-thunder.leizhen@huawei.com>
References: <20200819020503.3079-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I first want to move dev_WARN_ONCE() after "if (dev)" branch, but further
I find the "if (dev)" can only be true when is_nvdimm_bus(dev) successed.

No functional change. In fact, the compiler can optimize it correctly. I
run "size drivers/nvdimm/bus.o" and find nothing has changed. So it's
just source code level optimization, make us can read it faster.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/nvdimm/bus.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/nvdimm/bus.c b/drivers/nvdimm/bus.c
index 955265656b96c73..1d89114cb6ab93e 100644
--- a/drivers/nvdimm/bus.c
+++ b/drivers/nvdimm/bus.c
@@ -316,10 +316,9 @@ struct nvdimm_bus *walk_to_nvdimm_bus(struct device *nd_dev)
 
 	for (dev = nd_dev; dev; dev = dev->parent)
 		if (is_nvdimm_bus(dev))
-			break;
-	dev_WARN_ONCE(nd_dev, !dev, "invalid dev, not on nd bus\n");
-	if (dev)
-		return to_nvdimm_bus(dev);
+			return to_nvdimm_bus(dev);
+
+	dev_WARN_ONCE(nd_dev, 1, "invalid dev, not on nd bus\n");
 	return NULL;
 }
 
-- 
1.8.3


