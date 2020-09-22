Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E80742743AE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 15:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgIVN6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 09:58:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:33470 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726683AbgIVN5H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 09:57:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8F4B4AF26;
        Tue, 22 Sep 2020 13:57:43 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     akpm@linux-foundation.org
Cc:     aris@ruivo.org, naoya.horiguchi@nec.com, mhocko@kernel.org,
        tony.luck@intel.com, cai@lca.pw, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v7 04/14] mm,hwpoison: unexport get_hwpoison_page and make it static
Date:   Tue, 22 Sep 2020 15:56:40 +0200
Message-Id: <20200922135650.1634-5-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20200922135650.1634-1-osalvador@suse.de>
References: <20200922135650.1634-1-osalvador@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since get_hwpoison_page is only used in memory-failure code now, let us
un-export it and make it private to that code.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 include/linux/mm.h  | 1 -
 mm/memory-failure.c | 3 +--
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 185fcef0deb6..20ac1653fb81 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3015,7 +3015,6 @@ extern int memory_failure(unsigned long pfn, int flags);
 extern void memory_failure_queue(unsigned long pfn, int flags);
 extern void memory_failure_queue_kick(int cpu);
 extern int unpoison_memory(unsigned long pfn);
-extern int get_hwpoison_page(struct page *page);
 #define put_hwpoison_page(page)	put_page(page)
 extern int sysctl_memory_failure_early_kill;
 extern int sysctl_memory_failure_recovery;
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 0e6edffa91a9..f8cff387451e 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -924,7 +924,7 @@ static int page_action(struct page_state *ps, struct page *p,
  * Return: return 0 if failed to grab the refcount, otherwise true (some
  * non-zero value.)
  */
-int get_hwpoison_page(struct page *page)
+static int get_hwpoison_page(struct page *page)
 {
 	struct page *head = compound_head(page);
 
@@ -953,7 +953,6 @@ int get_hwpoison_page(struct page *page)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(get_hwpoison_page);
 
 /*
  * Do all that is necessary to remove user space mappings. Unmap
-- 
2.26.2

