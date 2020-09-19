Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFBC7270A5D
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 05:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbgISDQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 23:16:53 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:41126 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726119AbgISDQx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 23:16:53 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3E32B30318231580C927;
        Sat, 19 Sep 2020 11:16:51 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Sat, 19 Sep 2020 11:16:41 +0800
From:   Jing Xiangfeng <jingxiangfeng@huawei.com>
To:     <boris.ostrovsky@oracle.com>, <jgross@suse.com>,
        <sstabellini@kernel.org>
CC:     <xen-devel@lists.xenproject.org>, <linux-kernel@vger.kernel.org>,
        <jingxiangfeng@huawei.com>
Subject: [PATCH] xen: remove redundant initialization of variable ret
Date:   Sat, 19 Sep 2020 11:17:02 +0800
Message-ID: <20200919031702.32192-1-jingxiangfeng@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit 9f51c05dc41a ("pvcalls-front: Avoid
get_free_pages(GFP_KERNEL) under spinlock"), the variable ret is being
initialized with '-ENOMEM' that is meaningless. So remove it.

Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
---
 drivers/xen/pvcalls-front.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/xen/pvcalls-front.c b/drivers/xen/pvcalls-front.c
index 72d725a0ab5c..7984645b5956 100644
--- a/drivers/xen/pvcalls-front.c
+++ b/drivers/xen/pvcalls-front.c
@@ -371,7 +371,7 @@ static int alloc_active_ring(struct sock_mapping *map)
 static int create_active(struct sock_mapping *map, evtchn_port_t *evtchn)
 {
 	void *bytes;
-	int ret = -ENOMEM, irq = -1, i;
+	int ret, irq = -1, i;
 
 	*evtchn = 0;
 	init_waitqueue_head(&map->active.inflight_conn_req);
-- 
2.17.1

