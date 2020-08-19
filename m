Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC512492B4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Aug 2020 04:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbgHSCFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 22:05:49 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:53802 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726469AbgHSCFq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 22:05:46 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A92CA3F694DDC345A29A;
        Wed, 19 Aug 2020 10:05:44 +0800 (CST)
Received: from DESKTOP-C3MD9UG.china.huawei.com (10.174.177.253) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Wed, 19 Aug 2020 10:05:33 +0800
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
Subject: [PATCH v2 2/4] libnvdimm: add sanity check for provider_name in of_pmem_region_probe()
Date:   Wed, 19 Aug 2020 10:05:01 +0800
Message-ID: <20200819020503.3079-3-thunder.leizhen@huawei.com>
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

kstrdup() may return NULL because of no memory, check it.

Fixes: 49bddc73d15c ("libnvdimm/of_pmem: Provide a unique name for bus provider")
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/nvdimm/of_pmem.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/nvdimm/of_pmem.c b/drivers/nvdimm/of_pmem.c
index 1292ffca7b2ecc0..13c4c274ca6ea88 100644
--- a/drivers/nvdimm/of_pmem.c
+++ b/drivers/nvdimm/of_pmem.c
@@ -31,6 +31,11 @@ static int of_pmem_region_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	priv->bus_desc.provider_name = kstrdup(pdev->name, GFP_KERNEL);
+	if (!priv->bus_desc.provider_name) {
+		kfree(priv);
+		return -ENOMEM;
+	}
+
 	priv->bus_desc.module = THIS_MODULE;
 	priv->bus_desc.of_node = np;
 
-- 
1.8.3


