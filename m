Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE8C27DE3D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 04:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729782AbgI3CHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 22:07:17 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:59918 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729322AbgI3CHR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 22:07:17 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 4AD38A032FA2821EFCA6;
        Wed, 30 Sep 2020 10:07:12 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Wed, 30 Sep 2020 10:07:04 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Chunxin Zang <zangchunxin@bytedance.com>
Subject: [PATCH -next] mm/vmscan: Drop duplicated code in drop_slab_node
Date:   Wed, 30 Sep 2020 10:06:59 +0800
Message-ID: <20200930020659.139283-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following patches fix same issue and both add fatal
signal check in drop_slab_node, kill a duplicated check.

  "mm/vmscan: add a fatal signals check in drop_slab_node"
  "mm/vmscan: fix infinite loop in drop_slab_node"

Cc: Chunxin Zang <zangchunxin@bytedance.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/vmscan.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index eae57d092931..980155e257bf 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -699,9 +699,6 @@ void drop_slab_node(int nid)
 	do {
 		struct mem_cgroup *memcg = NULL;
 
-		if (fatal_signal_pending(current))
-			return;
-
 		if (fatal_signal_pending(current))
 			return;
 
-- 
2.26.2

