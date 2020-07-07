Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD06216B2F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jul 2020 13:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbgGGLNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jul 2020 07:13:42 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7817 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725944AbgGGLNm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 07:13:42 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 380C099C154655064D94;
        Tue,  7 Jul 2020 19:13:40 +0800 (CST)
Received: from kernelci-master.huawei.com (10.175.101.6) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Tue, 7 Jul 2020 19:13:31 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Hulk Robot <hulkci@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
CC:     Wei Yongjun <weiyongjun1@huawei.com>, <linux-nvdimm@lists.01.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] device-dax: make dev_dax_kmem_probe() static
Date:   Tue, 7 Jul 2020 19:23:40 +0800
Message-ID: <20200707112340.9178-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sparse report warning as follows:

drivers/dax/kmem.c:22:5: warning:
 symbol 'dev_dax_kmem_probe' was not declared. Should it be static?

dev_dax_kmem_probe() is not used outside of kmem.c, so marks
it static.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/dax/kmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index 275aa5f87399..87e271668170 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -19,7 +19,7 @@ static const char *kmem_name;
 /* Set if any memory will remain added when the driver will be unloaded. */
 static bool any_hotremove_failed;
 
-int dev_dax_kmem_probe(struct device *dev)
+static int dev_dax_kmem_probe(struct device *dev)
 {
 	struct dev_dax *dev_dax = to_dev_dax(dev);
 	struct resource *res = &dev_dax->region->res;

