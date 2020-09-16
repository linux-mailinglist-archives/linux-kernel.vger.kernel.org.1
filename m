Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8534626CC3F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 22:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728532AbgIPUlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 16:41:24 -0400
Received: from smtprelay0205.hostedemail.com ([216.40.44.205]:54144 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728388AbgIPUlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 16:41:11 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 1CCB7182CED5B;
        Wed, 16 Sep 2020 20:41:10 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:541:800:960:966:973:988:989:1260:1311:1314:1345:1359:1437:1515:1534:1542:1711:1730:1747:1777:1792:2196:2199:2393:2559:2562:3138:3139:3140:3141:3142:3353:3865:3866:3867:3870:3874:4321:4385:4605:5007:6261:8957:10004:10848:11026:11473:11658:11914:12043:12048:12114:12296:12297:12438:12555:12895:12986:13255:13894:14181:14394:14721:21080:21433:21627:21990:30054,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: legs41_3c0f7312711c
X-Filterd-Recvd-Size: 3782
Received: from joe-laptop.perches.com (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Wed, 16 Sep 2020 20:41:08 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Denis Efremov <efremov@linux.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        Alex Dewar <alex.dewar90@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH V3 6/8] mm: and drivers core: Convert hugetlb_report_node_meminfo to sysfs_emit
Date:   Wed, 16 Sep 2020 13:40:43 -0700
Message-Id: <894b351b82da6013cde7f36ff4b5493cd0ec30d0.1600285923.git.joe@perches.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.1600285923.git.joe@perches.com>
References: <cover.1600285923.git.joe@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the unbound sprintf in hugetlb_report_node_meminfo to use
sysfs_emit_at so that no possible overrun of a PAGE_SIZE buf can occur.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/base/node.c     |  2 +-
 include/linux/hugetlb.h |  4 ++--
 mm/hugetlb.c            | 18 ++++++++++--------
 3 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index b33526a9fcfc..dafe03e82e7c 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -473,7 +473,7 @@ static ssize_t node_read_meminfo(struct device *dev,
 				    HPAGE_PMD_NR)
 #endif
 			    );
-	len += hugetlb_report_node_meminfo(nid, buf + len);
+	len += hugetlb_report_node_meminfo(buf, len, nid);
 	return len;
 }
 
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index d5cc5f802dd4..ebca2ef02212 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -129,7 +129,7 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 				unsigned long start, unsigned long end,
 				struct page *ref_page);
 void hugetlb_report_meminfo(struct seq_file *);
-int hugetlb_report_node_meminfo(int, char *);
+int hugetlb_report_node_meminfo(char *buf, int len, int nid);
 void hugetlb_show_meminfo(void);
 unsigned long hugetlb_total_pages(void);
 vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
@@ -245,7 +245,7 @@ static inline void hugetlb_report_meminfo(struct seq_file *m)
 {
 }
 
-static inline int hugetlb_report_node_meminfo(int nid, char *buf)
+static inline int hugetlb_report_node_meminfo(char *buf, int len, int nid)
 {
 	return 0;
 }
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 61469fd3ad92..fe76f8fd5a73 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3571,18 +3571,20 @@ void hugetlb_report_meminfo(struct seq_file *m)
 	seq_printf(m, "Hugetlb:        %8lu kB\n", total / 1024);
 }
 
-int hugetlb_report_node_meminfo(int nid, char *buf)
+int hugetlb_report_node_meminfo(char *buf, int len, int nid)
 {
 	struct hstate *h = &default_hstate;
+
 	if (!hugepages_supported())
 		return 0;
-	return sprintf(buf,
-		"Node %d HugePages_Total: %5u\n"
-		"Node %d HugePages_Free:  %5u\n"
-		"Node %d HugePages_Surp:  %5u\n",
-		nid, h->nr_huge_pages_node[nid],
-		nid, h->free_huge_pages_node[nid],
-		nid, h->surplus_huge_pages_node[nid]);
+
+	return sysfs_emit_at(buf, len,
+			     "Node %d HugePages_Total: %5u\n"
+			     "Node %d HugePages_Free:  %5u\n"
+			     "Node %d HugePages_Surp:  %5u\n",
+			     nid, h->nr_huge_pages_node[nid],
+			     nid, h->free_huge_pages_node[nid],
+			     nid, h->surplus_huge_pages_node[nid]);
 }
 
 void hugetlb_show_meminfo(void)
-- 
2.26.0

