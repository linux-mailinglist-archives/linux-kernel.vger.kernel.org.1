Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DBA62B9079
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 11:59:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbgKSK5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 05:57:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:35784 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726052AbgKSK5c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 05:57:32 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0C0ACAE3A;
        Thu, 19 Nov 2020 10:57:30 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     akpm@linux-foundation.org
Cc:     n-horiguchi@ah.jp.nec.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH 5/7] mm,hwpoison: remove flag argument from soft offline functions
Date:   Thu, 19 Nov 2020 11:57:14 +0100
Message-Id: <20201119105716.5962-6-osalvador@suse.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201119105716.5962-1-osalvador@suse.de>
References: <20201119105716.5962-1-osalvador@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naoya Horiguchi <naoya.horiguchi@nec.com>

The argument @flag no longer affects the behavior of soft_offline_page()
and its variants, so let's remove them.

Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 drivers/base/memory.c | 2 +-
 include/linux/mm.h    | 2 +-
 mm/madvise.c          | 2 +-
 mm/memory-failure.c   | 9 ++++-----
 4 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index eef4ffb6122c..00a2f7191357 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -464,7 +464,7 @@ static ssize_t soft_offline_page_store(struct device *dev,
 	if (kstrtoull(buf, 0, &pfn) < 0)
 		return -EINVAL;
 	pfn >>= PAGE_SHIFT;
-	ret = soft_offline_page(pfn, 0);
+	ret = soft_offline_page(pfn);
 	return ret == 0 ? count : ret;
 }
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index e2341d445ecb..48ba7deec46b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3037,7 +3037,7 @@ extern int sysctl_memory_failure_early_kill;
 extern int sysctl_memory_failure_recovery;
 extern void shake_page(struct page *p, int access);
 extern atomic_long_t num_poisoned_pages __read_mostly;
-extern int soft_offline_page(unsigned long pfn, int flags);
+extern int soft_offline_page(unsigned long pfn);
 
 
 /*
diff --git a/mm/madvise.c b/mm/madvise.c
index 7a0f64b93635..2bae426b01d5 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -913,7 +913,7 @@ static int madvise_inject_error(int behavior,
 		if (behavior == MADV_SOFT_OFFLINE) {
 			pr_info("Soft offlining pfn %#lx at process virtual address %#lx\n",
 				 pfn, start);
-			ret = soft_offline_page(pfn, 0);
+			ret = soft_offline_page(pfn);
 		} else {
 			pr_info("Injecting memory failure for pfn %#lx at process virtual address %#lx\n",
 				 pfn, start);
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 37f4bb5a49d5..4abf5d5ffc96 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1572,7 +1572,7 @@ static void memory_failure_work_func(struct work_struct *work)
 		if (!gotten)
 			break;
 		if (entry.flags & MF_SOFT_OFFLINE)
-			soft_offline_page(entry.pfn, entry.flags);
+			soft_offline_page(entry.pfn);
 		else
 			memory_failure(entry.pfn, entry.flags);
 	}
@@ -1712,7 +1712,7 @@ EXPORT_SYMBOL(unpoison_memory);
  * We only incremented refcount in case the page was already in-use and it is
  * a known type we can handle.
  */
-static int get_any_page(struct page *p, int flags)
+static int get_any_page(struct page *p)
 {
 	int ret = 0, pass = 0;
 
@@ -1882,7 +1882,6 @@ static int soft_offline_free_page(struct page *page)
 /**
  * soft_offline_page - Soft offline a page.
  * @pfn: pfn to soft-offline
- * @flags: flags. Same as memory_failure().
  *
  * Returns 0 on success, otherwise negated errno.
  *
@@ -1901,7 +1900,7 @@ static int soft_offline_free_page(struct page *page)
  * This is not a 100% solution for all memory, but tries to be
  * ``good enough'' for the majority of memory.
  */
-int soft_offline_page(unsigned long pfn, int flags)
+int soft_offline_page(unsigned long pfn)
 {
 	int ret;
 	struct page *page;
@@ -1921,7 +1920,7 @@ int soft_offline_page(unsigned long pfn, int flags)
 
 retry:
 	get_online_mems();
-	ret = get_any_page(page, flags);
+	ret = get_any_page(page);
 	put_online_mems();
 
 	if (ret > 0) {
-- 
2.26.2

