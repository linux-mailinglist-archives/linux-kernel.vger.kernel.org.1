Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB092A2614
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 09:28:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbgKBI1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 03:27:54 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:7006 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727806AbgKBI1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 03:27:54 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4CPmJ82Ymrzhf1C;
        Mon,  2 Nov 2020 16:27:52 +0800 (CST)
Received: from DESKTOP-2DH7KI2.china.huawei.com (10.67.101.108) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Mon, 2 Nov 2020 16:27:43 +0800
From:   Chengsong Ke <kechengsong@huawei.com>
To:     <richard@nod.at>, <s.hauer@pengutronix.de>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <wangfangpeng1@huawei.com>
Subject: [PATCH] ubifs: Remove the redundant return in dbg_check_nondata_nodes_order
Date:   Mon, 2 Nov 2020 16:27:43 +0800
Message-ID: <20201102082743.34172-1-kechengsong@huawei.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.101.108]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a redundant return in dbg_check_nondata_nodes_order,
which will be never reached. In addition, error code should be
returned instead of zero in this branch.

Signed-off-by: Chengsong Ke <kechengsong@huawei.com>
---
 fs/ubifs/debug.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/ubifs/debug.c b/fs/ubifs/debug.c
index ebff43f8009c..b2db518056cb 100644
--- a/fs/ubifs/debug.c
+++ b/fs/ubifs/debug.c
@@ -2442,7 +2442,6 @@ int dbg_check_nondata_nodes_order(struct ubifs_info *c, struct list_head *head)
 	ubifs_msg(c, "dumping second node");
 	ubifs_dump_node(c, sb->node);
 	return -EINVAL;
-	return 0;
 }
 
 static inline int chance(unsigned int n, unsigned int out_of)
-- 
2.12.3

