Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7612F96CC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 01:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729673AbhARAvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 19:51:12 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11168 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729469AbhARAvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 19:51:06 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DJtT852zmzl6FP;
        Mon, 18 Jan 2021 08:49:00 +0800 (CST)
Received: from huawei.com (10.175.112.125) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.498.0; Mon, 18 Jan 2021
 08:50:16 +0800
From:   Yue Zou <zouyue3@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] mmzone: Remove unneeded semicolon
Date:   Mon, 18 Jan 2021 00:55:59 +0000
Message-ID: <20210118005559.214288-1-zouyue3@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove a superfluous semicolon after function definition.

Signed-off-by: Yue Zou <zouyue3@huawei.com>
---
 include/linux/mmzone.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index b593316bff3d..f15d3aea5984 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -877,7 +877,7 @@ extern unsigned long lruvec_lru_size(struct lruvec *lruvec, enum lru_list lru, i
 #ifdef CONFIG_HAVE_MEMORYLESS_NODES
 int local_memory_node(int node_id);
 #else
-static inline int local_memory_node(int node_id) { return node_id; };
+static inline int local_memory_node(int node_id) { return node_id; }
 #endif
 
 /*
-- 
2.25.1

