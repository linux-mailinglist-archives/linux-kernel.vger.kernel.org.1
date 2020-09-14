Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F183268914
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 12:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbgINKQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 06:16:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:44774 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726398AbgINKQG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 06:16:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 73BECAD21;
        Mon, 14 Sep 2020 10:16:20 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     akpm@linux-foundation.org
Cc:     naoya.horiguchi@nec.com, mhocko@kernel.org, tony.luck@intel.com,
        cai@lca.pw, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Oscar Salvador <osalvador@suse.de>,
        Oscar Salvador <osalvador@suse.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH v3 3/5] mm,hwpoison: drain pcplists before bailing out for non-buddy zero-refcount page
Date:   Mon, 14 Sep 2020 12:15:57 +0200
Message-Id: <20200914101559.17103-4-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20200914101559.17103-1-osalvador@suse.de>
References: <20200914101559.17103-1-osalvador@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A page with 0-refcount and !PageBuddy could perfectly be a pcppage.
Currently, we bail out with an error if we encounter such a page, meaning
that we do not handle pcppages neither from hard-offline nor from
soft-offline path.

Fix this by draining pcplists whenever we find this kind of page and retry
the check again.  It might be that pcplists have been spilled into the
buddy allocator and so we can handle it.

Link: https://lkml.kernel.org/r/20200908075626.11976-4-osalvador@suse.de
Signed-off-by: Oscar Salvador <osalvador@suse.de>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Naoya Horiguchi <naoya.horiguchi@nec.com>
Cc: Oscar Salvador <osalvador@suse.com>
Cc: Qian Cai <cai@lca.pw>
Cc: Tony Luck <tony.luck@intel.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 mm/memory-failure.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 989fb3efdca6..4468c1eb5027 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -948,13 +948,13 @@ static int page_action(struct page_state *ps, struct page *p,
 }
 
 /**
- * get_hwpoison_page() - Get refcount for memory error handling:
+ * __get_hwpoison_page() - Get refcount for memory error handling:
  * @page:	raw error page (hit by memory error)
  *
  * Return: return 0 if failed to grab the refcount, otherwise true (some
  * non-zero value.)
  */
-static int get_hwpoison_page(struct page *page)
+static int __get_hwpoison_page(struct page *page)
 {
 	struct page *head = compound_head(page);
 
@@ -984,6 +984,26 @@ static int get_hwpoison_page(struct page *page)
 	return 0;
 }
 
+static int get_hwpoison_page(struct page *p)
+{
+	int ret;
+	bool drained = false;
+
+retry:
+	ret = __get_hwpoison_page(p);
+	if (!ret && !is_free_buddy_page(p) && !page_count(p) && !drained) {
+		/*
+		 * The page might be in a pcplist, so try to drain those
+		 * and see if we are lucky.
+		 */
+		drain_all_pages(page_zone(p));
+		drained = true;
+		goto retry;
+	}
+
+	return ret;
+}
+
 /*
  * Do all that is necessary to remove user space mappings. Unmap
  * the pages and send SIGBUS to the processes if the data was dirty.
-- 
2.26.2

