Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F17A1FC195
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jun 2020 00:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbgFPWdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jun 2020 18:33:43 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:37304 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726025AbgFPWdm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 18:33:42 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 538AE8A8B1807A1B4389;
        Wed, 17 Jun 2020 06:33:39 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.203.10) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Wed, 17 Jun 2020 06:33:29 +0800
From:   Barry Song <song.bao.hua@hisilicon.com>
To:     <akpm@linux-foundation.org>, <mike.kravetz@oracle.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Barry Song <song.bao.hua@hisilicon.com>,
        "Roman Gushchin" <guro@fb.com>
Subject: [PATCH v2 2/2] mm: hugetlb: fix the name of hugetlb CMA
Date:   Wed, 17 Jun 2020 10:31:31 +1200
Message-ID: <20200616223131.33828-3-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20200616223131.33828-1-song.bao.hua@hisilicon.com>
References: <20200616223131.33828-1-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.126.203.10]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

once we enable CMA_DEBUGFS, we will get the below errors:
directory 'cma-hugetlb' with parent 'cma' already present

we should have different names for different CMA areas.

Acked-by: Roman Gushchin <guro@fb.com>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 -v2:
  rebase to 5.8-rc1
  add acked-by and reviewed-by

 mm/hugetlb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 57ece74e3aae..d54bb7e35005 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5692,12 +5692,14 @@ void __init hugetlb_cma_reserve(int order)
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


