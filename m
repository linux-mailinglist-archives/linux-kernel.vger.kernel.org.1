Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59A261ECBB4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jun 2020 10:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgFCImW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jun 2020 04:42:22 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:43530 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726150AbgFCImV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 04:42:21 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 3114677EA63A4D0DE41F;
        Wed,  3 Jun 2020 16:42:19 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.202.66) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Wed, 3 Jun 2020 16:42:07 +0800
From:   Barry Song <song.bao.hua@hisilicon.com>
To:     <akpm@linux-foundation.org>, <mike.kravetz@oracle.com>
CC:     <guro@fb.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        Barry Song <song.bao.hua@hisilicon.com>
Subject: [PATCH 2/2] mm: hugetlb: fix the name of hugetlb CMA
Date:   Wed, 3 Jun 2020 20:40:25 +1200
Message-ID: <20200603084025.62740-3-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20200603084025.62740-1-song.bao.hua@hisilicon.com>
References: <20200603084025.62740-1-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.126.202.66]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

once we enable CMA_DEBUGFS, we will get the below errors:
directory 'cma-hugetlb' with parent 'cma' already present

only the first numa node will get a directory in debugfs.
we should have different names for different CMA areas.

Cc: Roman Gushchin <guro@fb.com>
Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 mm/hugetlb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index bcabbe02192b..4ebc4edc3b40 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5586,12 +5586,14 @@ void __init hugetlb_cma_reserve(int order)
 	reserved = 0;
 	for_each_node_state(nid, N_ONLINE) {
 		int res;
+		char name[20];
 
 		size = min(per_node, hugetlb_cma_size - reserved);
 		size = round_up(size, PAGE_SIZE << order);
 
+		snprintf(name, 20, "hugetlb%d", nid);
 		res = cma_declare_contiguous_nid(0, size, 0, PAGE_SIZE << order,
-						 0, false, "hugetlb",
+						 0, false, name,
 						 &hugetlb_cma[nid], nid);
 		if (res) {
 			pr_warn("hugetlb_cma: reservation failed: err %d, node %d",
-- 
2.23.0


