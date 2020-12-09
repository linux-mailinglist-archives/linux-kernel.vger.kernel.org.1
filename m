Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 876D62D3EC0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 10:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729258AbgLIJ3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 04:29:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:44638 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729010AbgLIJ3K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 04:29:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 58B22AB63;
        Wed,  9 Dec 2020 09:28:28 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     akpm@linux-foundation.org
Cc:     n-horiguchi@ah.jp.nec.com, vbabka@suse.cz, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH] mm,hwpoison: Return -EBUSY when migration fails
Date:   Wed,  9 Dec 2020 10:28:18 +0100
Message-Id: <20201209092818.30417-1-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, we return -EIO when we fail to migrate the page.

Migrations' failures are rather transient as they can happen due to
several reasons, e.g: high page refcount bump, mapping->migrate_page
failing etc.
All meaning that at that time the page could not be migrated, but
that has nothing to do with an EIO error.

Let us return -EBUSY instead, as we do in case we failed to isolate
the page.

While are it, let us remove the "ret" print as its value does not change.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 mm/memory-failure.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 428991e297e2..1942fb83ac64 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1849,11 +1849,11 @@ static int __soft_offline_page(struct page *page)
 			pr_info("soft offline: %#lx: %s migration failed %d, type %lx (%pGp)\n",
 				pfn, msg_page[huge], ret, page->flags, &page->flags);
 			if (ret > 0)
-				ret = -EIO;
+				ret = -EBUSY;
 		}
 	} else {
-		pr_info("soft offline: %#lx: %s isolation failed: %d, page count %d, type %lx (%pGp)\n",
-			pfn, msg_page[huge], ret, page_count(page), page->flags, &page->flags);
+		pr_info("soft offline: %#lx: %s isolation failed, page count %d, type %lx (%pGp)\n",
+			pfn, msg_page[huge], page_count(page), page->flags, &page->flags);
 		ret = -EBUSY;
 	}
 	return ret;
-- 
2.26.2

