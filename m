Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4F852B907D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 11:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgKSK5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 05:57:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:35730 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726480AbgKSK5a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 05:57:30 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 61A7EAD18;
        Thu, 19 Nov 2020 10:57:29 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     akpm@linux-foundation.org
Cc:     n-horiguchi@ah.jp.nec.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH 3/7] mm,madvise: call soft_offline_page() without MF_COUNT_INCREASED
Date:   Thu, 19 Nov 2020 11:57:12 +0100
Message-Id: <20201119105716.5962-4-osalvador@suse.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201119105716.5962-1-osalvador@suse.de>
References: <20201119105716.5962-1-osalvador@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naoya Horiguchi <naoya.horiguchi@nec.com>

The call to get_user_pages_fast is only to get the pointer to a struct
page of a given address, pinning it is memory-poisoning handler's job,
so drop the refcount grabbed by get_user_pages_fast().

Note that the target page is still pinned after this put_page() because
the current process should have refcount from mapping.

Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 mm/madvise.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index c6b5524add58..7a0f64b93635 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -900,20 +900,23 @@ static int madvise_inject_error(int behavior,
 		 */
 		size = page_size(compound_head(page));
 
+		/*
+		 * The get_user_pages_fast() is just to get the pfn of the
+		 * given address, and the refcount has nothing to do with
+		 * what we try to test, so it should be released immediately.
+		 * This is racy but it's intended because the real hardware
+		 * errors could happen at any moment and memory error handlers
+		 * must properly handle the race.
+		 */
+		put_page(page);
+
 		if (behavior == MADV_SOFT_OFFLINE) {
 			pr_info("Soft offlining pfn %#lx at process virtual address %#lx\n",
 				 pfn, start);
-			ret = soft_offline_page(pfn, MF_COUNT_INCREASED);
+			ret = soft_offline_page(pfn, 0);
 		} else {
 			pr_info("Injecting memory failure for pfn %#lx at process virtual address %#lx\n",
 				 pfn, start);
-			/*
-			 * Drop the page reference taken by get_user_pages_fast(). In
-			 * the absence of MF_COUNT_INCREASED the memory_failure()
-			 * routine is responsible for pinning the page to prevent it
-			 * from being released back to the page allocator.
-			 */
-			put_page(page);
 			ret = memory_failure(pfn, 0);
 		}
 
-- 
2.26.2

