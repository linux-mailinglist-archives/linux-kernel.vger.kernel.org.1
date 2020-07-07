Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7615521647A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jul 2020 05:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbgGGDN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jul 2020 23:13:59 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:44428 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726933AbgGGDN7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 23:13:59 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 05D4362912129E933CDC;
        Tue,  7 Jul 2020 11:13:57 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.201.228) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Tue, 7 Jul 2020 11:13:48 +0800
From:   Barry Song <song.bao.hua@hisilicon.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Barry Song <song.bao.hua@hisilicon.com>,
        "Roman Gushchin" <guro@fb.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Jonathan Cameron" <jonathan.cameron@huawei.com>
Subject: [PATCH v2] mm/hugetlb: avoid hardcoding while checking if cma is enable
Date:   Tue, 7 Jul 2020 15:11:56 +1200
Message-ID: <20200707031156.29932-1-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.126.201.228]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hugetlb_cma[0] can be NULL due to various reasons, for example, node0 has
no memory. so NULL hugetlb_cma[0] doesn't necessarily mean cma is not
enabled. gigantic pages might have been reserved on other nodes.

Fixes: cf11e85fc08c ("mm: hugetlb: optionally allocate gigantic hugepages using cma")
Cc: Roman Gushchin <guro@fb.com>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 -v2: add hugetlb_cma_enabled() helper to improve readability according to Roman

 mm/hugetlb.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 57ece74e3aae..d5e98ed86bb9 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2546,6 +2546,20 @@ static void __init gather_bootmem_prealloc(void)
 	}
 }
 
+bool __init hugetlb_cma_enabled(void)
+{
+	if (IS_ENABLED(CONFIG_CMA)) {
+		int node;
+
+		for_each_online_node(node) {
+			if (hugetlb_cma[node])
+				return true;
+		}
+	}
+
+	return false;
+}
+
 static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
 {
 	unsigned long i;
@@ -2571,7 +2585,7 @@ static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
 
 	for (i = 0; i < h->max_huge_pages; ++i) {
 		if (hstate_is_gigantic(h)) {
-			if (IS_ENABLED(CONFIG_CMA) && hugetlb_cma[0]) {
+			if (hugetlb_cma_enabled()) {
 				pr_warn_once("HugeTLB: hugetlb_cma is enabled, skip boot time allocation\n");
 				break;
 			}
-- 
2.27.0


