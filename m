Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C75142B32E5
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Nov 2020 09:25:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgKOIYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 03:24:04 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7193 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbgKOIYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 03:24:04 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CYlbN17z3z15LFN;
        Sun, 15 Nov 2020 16:23:44 +0800 (CST)
Received: from huawei.com (10.175.124.27) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Sun, 15 Nov 2020
 16:23:47 +0800
From:   Wang ShaoBo <bobo.shaobowang@huawei.com>
To:     <richard@nod.at>
CC:     <s.hauer@pengutronix.de>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <huawei.libin@huawei.com>,
        <cj.chengjian@huawei.com>
Subject: [PATCH] bdi: Fix error return code in alloc_wbufs()
Date:   Sun, 15 Nov 2020 16:23:43 +0800
Message-ID: <20201115082343.35645-1-bobo.shaobowang@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.27]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix to return PTR_ERR() error code from the error handling case instead
fo 0 in function alloc_wbufs(), as done elsewhere in this function.

Fixes: 6a98bc4614de ("ubifs: Add authentication nodes to journal")
Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
---
 fs/ubifs/super.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
index cb3acfb7dd1f..dacbb999ae34 100644
--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -838,8 +838,10 @@ static int alloc_wbufs(struct ubifs_info *c)
 		c->jheads[i].wbuf.jhead = i;
 		c->jheads[i].grouped = 1;
 		c->jheads[i].log_hash = ubifs_hash_get_desc(c);
-		if (IS_ERR(c->jheads[i].log_hash))
+		if (IS_ERR(c->jheads[i].log_hash)) {
+			err = PTR_ERR(c->jheads[i].log_hash);
 			goto out;
+		}
 	}
 
 	/*
-- 
2.25.1

