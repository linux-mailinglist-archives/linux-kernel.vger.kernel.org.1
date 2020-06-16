Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 855781FA9BE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jun 2020 09:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbgFPHKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jun 2020 03:10:47 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:33294 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726891AbgFPHKp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 03:10:45 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C4488A028FD2A23B8667;
        Tue, 16 Jun 2020 15:10:43 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Tue, 16 Jun 2020
 15:10:34 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <richard@nod.at>, <yi.zhang@huawei.com>, <liu.song11@zte.com.cn>
Subject: [PATCH RFC 5/5] ubifs: ubifs_dump_node: Dump all branches of the index node
Date:   Tue, 16 Jun 2020 15:11:46 +0800
Message-ID: <20200616071146.2607061-6-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200616071146.2607061-1-chengzhihao1@huawei.com>
References: <20200616071146.2607061-1-chengzhihao1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An index node can have up to c->fanout branches, all branches should be
displayed while dumping index node.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 fs/ubifs/debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ubifs/debug.c b/fs/ubifs/debug.c
index 2d07615369f9..a65f73e91b4f 100644
--- a/fs/ubifs/debug.c
+++ b/fs/ubifs/debug.c
@@ -537,7 +537,7 @@ void ubifs_dump_node(const struct ubifs_info *c, const void *node, int node_len)
 		pr_err("\tlevel          %d\n", (int)le16_to_cpu(idx->level));
 		pr_err("\tBranches:\n");
 
-		for (i = 0; i < n && i < c->fanout - 1; i++) {
+		for (i = 0; i < n && i < c->fanout; i++) {
 			const struct ubifs_branch *br;
 
 			br = ubifs_idx_branch(c, idx, i);
-- 
2.25.4

