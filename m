Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47C9A215428
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jul 2020 10:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728646AbgGFIqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jul 2020 04:46:08 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7374 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728321AbgGFIqH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 04:46:07 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 49988AEF19DB153FA8A5;
        Mon,  6 Jul 2020 16:46:05 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.203.241) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Mon, 6 Jul 2020 16:45:55 +0800
From:   Barry Song <song.bao.hua@hisilicon.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Barry Song <song.bao.hua@hisilicon.com>,
        "Roman Gushchin" <guro@fb.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Jonathan Cameron" <jonathan.cameron@huawei.com>
Subject: [PATCH] mm/hugetlb: avoid hardcoding while checking if cma is reserved
Date:   Mon, 6 Jul 2020 20:44:05 +1200
Message-ID: <20200706084405.14236-1-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.126.203.241]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hugetlb_cma[0] can be NULL due to various reasons, for example, node0 has
no memory. Thus, NULL hugetlb_cma[0] doesn't necessarily mean cma is not
enabled. gigantic pages might have been reserved on other nodes.

Fixes: cf11e85fc08c ("mm: hugetlb: optionally allocate gigantic hugepages using cma")
Cc: Roman Gushchin <guro@fb.com>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 mm/hugetlb.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 57ece74e3aae..603aa854aa89 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2571,9 +2571,21 @@ static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
 
 	for (i = 0; i < h->max_huge_pages; ++i) {
 		if (hstate_is_gigantic(h)) {
-			if (IS_ENABLED(CONFIG_CMA) && hugetlb_cma[0]) {
-				pr_warn_once("HugeTLB: hugetlb_cma is enabled, skip boot time allocation\n");
-				break;
+			if (IS_ENABLED(CONFIG_CMA)) {
+				int nid;
+				bool cma_reserved = false;
+
+				for_each_node_state(nid, N_ONLINE) {
+					if (hugetlb_cma[nid]) {
+						pr_warn_once("HugeTLB: hugetlb_cma is reserved,"
+								"skip boot time allocation\n");
+						cma_reserved = true;
+						break;
+					}
+				}
+
+				if (cma_reserved)
+					break;
 			}
 			if (!alloc_bootmem_huge_page(h))
 				break;
-- 
2.27.0


