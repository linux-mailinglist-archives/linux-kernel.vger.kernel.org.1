Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75C59269F18
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 09:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726035AbgIOHGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 03:06:50 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:38132 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726192AbgIOHGN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 03:06:13 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 984C68240D951E8B1533;
        Tue, 15 Sep 2020 15:05:41 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Tue, 15 Sep 2020 15:05:31 +0800
From:   Jing Xiangfeng <jingxiangfeng@huawei.com>
To:     <dan.j.williams@intel.com>, <vishal.l.verma@intel.com>,
        <dave.jiang@intel.com>, <ira.weiny@intel.com>
CC:     <linux-nvdimm@lists.01.org>, <linux-kernel@vger.kernel.org>,
        <jingxiangfeng@huawei.com>
Subject: [PATCH] libnvdimm: Fix dereference of pointer ndns before it is null checked
Date:   Tue, 15 Sep 2020 15:06:09 +0800
Message-ID: <20200915070609.123591-1-jingxiangfeng@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In current code, the pointer ndns is being dereferenced on the
initialization of pointer parent_uuid before ndns is null check. This
could lead to a potential null pointer dereference. Fix this by
dereferencing ndns after ndns has been null pointer sanity checked.

Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
---
 drivers/nvdimm/pfn_devs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvdimm/pfn_devs.c b/drivers/nvdimm/pfn_devs.c
index 3e11ef8d3f5b..c443994f81f3 100644
--- a/drivers/nvdimm/pfn_devs.c
+++ b/drivers/nvdimm/pfn_devs.c
@@ -452,7 +452,7 @@ int nd_pfn_validate(struct nd_pfn *nd_pfn, const char *sig)
 	unsigned long align, start_pad;
 	struct nd_pfn_sb *pfn_sb = nd_pfn->pfn_sb;
 	struct nd_namespace_common *ndns = nd_pfn->ndns;
-	const u8 *parent_uuid = nd_dev_to_uuid(&ndns->dev);
+	const u8 *parent_uuid;
 
 	if (!pfn_sb || !ndns)
 		return -ENODEV;
@@ -472,6 +472,7 @@ int nd_pfn_validate(struct nd_pfn *nd_pfn, const char *sig)
 		return -ENODEV;
 	pfn_sb->checksum = cpu_to_le64(checksum);
 
+	parent_uuid = nd_dev_to_uuid(&ndns->dev);
 	if (memcmp(pfn_sb->parent_uuid, parent_uuid, 16) != 0)
 		return -ENODEV;
 
-- 
2.17.1

