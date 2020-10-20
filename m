Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA5622937E2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 11:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392742AbgJTJT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 05:19:58 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:49716 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2391233AbgJTJT6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 05:19:58 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7FA95BE8207F01AD4A2F;
        Tue, 20 Oct 2020 17:19:55 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Tue, 20 Oct 2020
 17:19:52 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH] block: remove unused members for io_context
Date:   Tue, 20 Oct 2020 05:22:56 -0400
Message-ID: <20201020092256.4095621-1-yuyufen@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After removing blk-sq code, there is no user of nr_batch_requests
and last_waited in kernel.

Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 include/linux/iocontext.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/linux/iocontext.h b/include/linux/iocontext.h
index 1dcd9198beb7..0a9dc40b7be8 100644
--- a/include/linux/iocontext.h
+++ b/include/linux/iocontext.h
@@ -106,12 +106,6 @@ struct io_context {
 
 	unsigned short ioprio;
 
-	/*
-	 * For request batching
-	 */
-	int nr_batch_requests;     /* Number of requests left in the batch */
-	unsigned long last_waited; /* Time last woken after wait for request */
-
 	struct radix_tree_root	icq_tree;
 	struct io_cq __rcu	*icq_hint;
 	struct hlist_head	icq_list;
-- 
2.25.4

