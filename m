Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0833C1BEC3D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Apr 2020 00:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbgD2W4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Apr 2020 18:56:34 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:34527 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726164AbgD2W4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 18:56:34 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R631e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Tx2iHl3_1588200982;
Received: from localhost(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0Tx2iHl3_1588200982)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 30 Apr 2020 06:56:30 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     kirill.shutemov@linux.intel.com, hughd@google.com,
        aarcange@redhat.com, akpm@linux-foundation.org
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [linux-next PATCH 1/2] mm: khugepaged: add exceed_max_ptes_* helpers
Date:   Thu, 30 Apr 2020 06:56:21 +0800
Message-Id: <1588200982-69492-1-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The max_ptes_{swap|none|shared} are defined to tune the behavior of
khugepaged.  The are checked at a couple of places with open coding.
Replace the opencoding to exceed_pax_ptes_{swap|none_shared} helpers to
improve the readability.

Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
 mm/khugepaged.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index a02a4c5..0c8d30b 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -339,6 +339,21 @@ struct attribute_group khugepaged_attr_group = {
 };
 #endif /* CONFIG_SYSFS */
 
+static inline bool exceed_max_ptes_none(unsigned int *nr_ptes)
+{
+	return (++(*nr_ptes) > khugepaged_max_ptes_none);
+}
+
+static inline bool exceed_max_ptes_swap(unsigned int *nr_ptes)
+{
+	return (++(*nr_ptes) > khugepaged_max_ptes_swap);
+}
+
+static inline bool exceed_max_ptes_shared(unsigned int *nr_ptes)
+{
+	return (++(*nr_ptes) > khugepaged_max_ptes_shared);
+}
+
 int hugepage_madvise(struct vm_area_struct *vma,
 		     unsigned long *vm_flags, int advice)
 {
@@ -604,7 +619,7 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
 		if (pte_none(pteval) || (pte_present(pteval) &&
 				is_zero_pfn(pte_pfn(pteval)))) {
 			if (!userfaultfd_armed(vma) &&
-			    ++none_or_zero <= khugepaged_max_ptes_none) {
+			    !exceed_max_ptes_none(&none_or_zero)) {
 				continue;
 			} else {
 				result = SCAN_EXCEED_NONE_PTE;
@@ -624,7 +639,7 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
 		VM_BUG_ON_PAGE(!PageAnon(page), page);
 
 		if (page_mapcount(page) > 1 &&
-				++shared > khugepaged_max_ptes_shared) {
+				exceed_max_ptes_shared(&shared)) {
 			result = SCAN_EXCEED_SHARED_PTE;
 			goto out;
 		}
@@ -1234,7 +1249,7 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
 	     _pte++, _address += PAGE_SIZE) {
 		pte_t pteval = *_pte;
 		if (is_swap_pte(pteval)) {
-			if (++unmapped <= khugepaged_max_ptes_swap) {
+			if (!exceed_max_ptes_swap(&unmapped)) {
 				/*
 				 * Always be strict with uffd-wp
 				 * enabled swap entries.  Please see
@@ -1252,7 +1267,7 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
 		}
 		if (pte_none(pteval) || is_zero_pfn(pte_pfn(pteval))) {
 			if (!userfaultfd_armed(vma) &&
-			    ++none_or_zero <= khugepaged_max_ptes_none) {
+			    !exceed_max_ptes_none(&none_or_zero)) {
 				continue;
 			} else {
 				result = SCAN_EXCEED_NONE_PTE;
@@ -1286,7 +1301,7 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
 		}
 
 		if (page_mapcount(page) > 1 &&
-				++shared > khugepaged_max_ptes_shared) {
+				exceed_max_ptes_shared(&shared)) {
 			result = SCAN_EXCEED_SHARED_PTE;
 			goto out_unmap;
 		}
@@ -1961,7 +1976,7 @@ static void khugepaged_scan_file(struct mm_struct *mm,
 			continue;
 
 		if (xa_is_value(page)) {
-			if (++swap > khugepaged_max_ptes_swap) {
+			if (exceed_max_ptes_swap(&swap)) {
 				result = SCAN_EXCEED_SWAP_PTE;
 				break;
 			}
-- 
1.8.3.1

