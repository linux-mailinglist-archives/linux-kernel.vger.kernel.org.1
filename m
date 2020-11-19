Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8EA2B907C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 11:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgKSK5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 05:57:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:35744 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726485AbgKSK5b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 05:57:31 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6151EAD12;
        Thu, 19 Nov 2020 10:57:29 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     akpm@linux-foundation.org
Cc:     n-horiguchi@ah.jp.nec.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH 4/7] mm,hwpoison: remove MF_COUNT_INCREASED
Date:   Thu, 19 Nov 2020 11:57:13 +0100
Message-Id: <20201119105716.5962-5-osalvador@suse.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201119105716.5962-1-osalvador@suse.de>
References: <20201119105716.5962-1-osalvador@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naoya Horiguchi <naoya.horiguchi@nec.com>

Now there's no user of MF_COUNT_INCREASED, so we can safely remove
it from all calling points.

Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 include/linux/mm.h  | 7 +++----
 mm/memory-failure.c | 9 ++-------
 2 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index db6ae4d3fb4e..e2341d445ecb 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3025,10 +3025,9 @@ void register_page_bootmem_memmap(unsigned long section_nr, struct page *map,
 				  unsigned long nr_pages);
 
 enum mf_flags {
-	MF_COUNT_INCREASED = 1 << 0,
-	MF_ACTION_REQUIRED = 1 << 1,
-	MF_MUST_KILL = 1 << 2,
-	MF_SOFT_OFFLINE = 1 << 3,
+	MF_ACTION_REQUIRED = 1 << 0,
+	MF_MUST_KILL = 1 << 1,
+	MF_SOFT_OFFLINE = 1 << 2,
 };
 extern int memory_failure(unsigned long pfn, int flags);
 extern void memory_failure_queue(unsigned long pfn, int flags);
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 04237fc04a00..37f4bb5a49d5 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1185,7 +1185,7 @@ static int memory_failure_hugetlb(unsigned long pfn, int flags)
 
 	num_poisoned_pages_inc();
 
-	if (!(flags & MF_COUNT_INCREASED) && !get_hwpoison_page(p)) {
+	if (!get_hwpoison_page(p)) {
 		/*
 		 * Check "filter hit" and "race with other subpage."
 		 */
@@ -1387,7 +1387,7 @@ int memory_failure(unsigned long pfn, int flags)
 	 * In fact it's dangerous to directly bump up page count from 0,
 	 * that may make page_ref_freeze()/page_ref_unfreeze() mismatch.
 	 */
-	if (!(flags & MF_COUNT_INCREASED) && !get_hwpoison_page(p)) {
+	if (!get_hwpoison_page(p)) {
 		if (is_free_buddy_page(p)) {
 			if (take_page_off_buddy(p)) {
 				page_ref_inc(p);
@@ -1716,9 +1716,6 @@ static int get_any_page(struct page *p, int flags)
 {
 	int ret = 0, pass = 0;
 
-	if (flags & MF_COUNT_INCREASED)
-		return 1;
-
 try_again:
 	if (!get_hwpoison_page(p)) {
 		if (page_count(p)) {
@@ -1919,8 +1916,6 @@ int soft_offline_page(unsigned long pfn, int flags)
 
 	if (PageHWPoison(page)) {
 		pr_info("%s: %#lx page already poisoned\n", __func__, pfn);
-		if (flags & MF_COUNT_INCREASED)
-			put_page(page);
 		return 0;
 	}
 
-- 
2.26.2

