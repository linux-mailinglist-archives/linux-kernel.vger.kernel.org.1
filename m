Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0E373013C8
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 08:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbhAWHj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jan 2021 02:39:28 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11133 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbhAWHjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jan 2021 02:39:19 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DN7J76lzQz15rwr;
        Sat, 23 Jan 2021 15:37:27 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.498.0; Sat, 23 Jan 2021
 15:38:31 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] mm/workingset.c: avoid unnecessary max_nodes estimation in count_shadow_nodes()
Date:   Sat, 23 Jan 2021 02:38:25 -0500
Message-ID: <20210123073825.46709-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If list_lru_shrink_count is 0, we always return SHRINK_EMPTY regardless of
the value of max_nodes. So we can return early if nodes == 0 to save some
cpu cycles of approximating a reasonable limit for the nodes.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/workingset.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/mm/workingset.c b/mm/workingset.c
index 10e96de945b3..7db8f3dad13c 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -461,6 +461,8 @@ static unsigned long count_shadow_nodes(struct shrinker *shrinker,
 	unsigned long pages;
 
 	nodes = list_lru_shrink_count(&shadow_nodes, sc);
+	if (!nodes)
+		return SHRINK_EMPTY;
 
 	/*
 	 * Approximate a reasonable limit for the nodes
@@ -503,9 +505,6 @@ static unsigned long count_shadow_nodes(struct shrinker *shrinker,
 
 	max_nodes = pages >> (XA_CHUNK_SHIFT - 3);
 
-	if (!nodes)
-		return SHRINK_EMPTY;
-
 	if (nodes <= max_nodes)
 		return 0;
 	return nodes - max_nodes;
-- 
2.19.1

