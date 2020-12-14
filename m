Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 093AB2D9927
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 14:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440010AbgLNNpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 08:45:33 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:9883 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438047AbgLNNp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 08:45:27 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CvjKj1Xt5z7DCm;
        Mon, 14 Dec 2020 21:44:09 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Mon, 14 Dec 2020 21:44:35 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <linux-nvdimm@lists.01.org>, <linux-kernel@vger.kernel.org>
CC:     Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] dax: pmem: convert comma to semicolon
Date:   Mon, 14 Dec 2020 21:45:06 +0800
Message-ID: <20201214134506.4831-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.138.68]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace a comma between expression statements by a semicolon.

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 drivers/dax/pmem/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dax/pmem/core.c b/drivers/dax/pmem/core.c
index 62b26bfceab1..062e8bc14223 100644
--- a/drivers/dax/pmem/core.c
+++ b/drivers/dax/pmem/core.c
@@ -52,7 +52,7 @@ struct dev_dax *__dax_pmem_probe(struct device *dev, enum dev_dax_subsys subsys)
 
 	/* adjust the dax_region range to the start of data */
 	range = pgmap.range;
-	range.start += offset,
+	range.start += offset;
 	dax_region = alloc_dax_region(dev, region_id, &range,
 			nd_region->target_node, le32_to_cpu(pfn_sb->align),
 			IORESOURCE_DAX_STATIC);
-- 
2.22.0

