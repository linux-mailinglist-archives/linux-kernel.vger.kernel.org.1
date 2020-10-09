Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B189288F14
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 18:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389663AbgJIQlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 12:41:24 -0400
Received: from m12-15.163.com ([220.181.12.15]:33763 "EHLO m12-15.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388719AbgJIQlY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 12:41:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=2byyL
        nKxYgPT+XyJAD6P28t8tHpF/zddvKxXFMS2dXg=; b=VtTEGxPGFawE3sA8ZUp6t
        ztdP5oqU1h6gpD9mxX+exjxbnTb5cuCdSTLRSLGJNRBP1ItyT0OZAQ99MN2Lpt/q
        Au6cDgMr6edRcddlMxNjUJPmCcuxlUMB7mijPxqPJg0ZBFb0bxRhxYGgCcrmGv7G
        AcPi0ghHR3bQX8VbWy8dEo=
Received: from localhost (unknown [101.228.30.83])
        by smtp11 (Coremail) with SMTP id D8CowAC3x_OfjoBfxqi5Bw--.15623S2;
        Sat, 10 Oct 2020 00:23:59 +0800 (CST)
Date:   Sat, 10 Oct 2020 00:23:59 +0800
From:   Hui Su <sh_def@163.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org,
        mike.kravetz@oracle.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH] mm/hugetable.c: align some prints
Message-ID: <20201009162359.GA19686@rlk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CM-TRANSID: D8CowAC3x_OfjoBfxqi5Bw--.15623S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uryfGr1kCF4rZFyDZw4xJFb_yoW8Wr1DpF
        98KFy3C34UJr93CFs2qan3uFnrG3Wjq3yfJry09w4fZ3s8AF98KayjvryrWr1rXr4fJFZr
        Zayaqry2va1UJaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j0FALUUUUU=
X-Originating-IP: [101.228.30.83]
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbBywC4X1PAPL3ymwAAsX
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

in old code, it shows like:
Node 0 ShmemHugePages:        0 kB
Node 0 ShmemPmdMapped:        0 kB
Node 0 FileHugePages:        0 kB
Node 0 FilePmdMapped:        0 kB
Node 0 HugePages_Total:     0
Node 0 HugePages_Free:      0
Node 0 HugePages_Surp:      0

which is not align. So we align it.

Signed-off-by: Hui Su <sh_def@163.com>
---
 drivers/base/node.c | 4 ++--
 mm/hugetlb.c        | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index 50af16e68d98..b5453c372c5b 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -430,8 +430,8 @@ static ssize_t node_read_meminfo(struct device *dev,
 		       "Node %d AnonHugePages:  %8lu kB\n"
 		       "Node %d ShmemHugePages: %8lu kB\n"
 		       "Node %d ShmemPmdMapped: %8lu kB\n"
-		       "Node %d FileHugePages: %8lu kB\n"
-		       "Node %d FilePmdMapped: %8lu kB\n"
+		       "Node %d FileHugePages:  %8lu kB\n"
+		       "Node %d FilePmdMapped:  %8lu kB\n"
 #endif
 			,
 		       nid, K(node_page_state(pgdat, NR_FILE_DIRTY)),
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 67fc6383995b..077860ea2452 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3588,9 +3588,9 @@ int hugetlb_report_node_meminfo(int nid, char *buf)
 	if (!hugepages_supported())
 		return 0;
 	return sprintf(buf,
-		"Node %d HugePages_Total: %5u\n"
-		"Node %d HugePages_Free:  %5u\n"
-		"Node %d HugePages_Surp:  %5u\n",
+		"Node %d HugePages_Total:%8u\n"
+		"Node %d HugePages_Free: %8u\n"
+		"Node %d HugePages_Surp: %8u\n",
 		nid, h->nr_huge_pages_node[nid],
 		nid, h->free_huge_pages_node[nid],
 		nid, h->surplus_huge_pages_node[nid]);
-- 
2.25.1


