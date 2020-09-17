Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F20326D693
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 10:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbgIQI2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 04:28:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:51864 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726234AbgIQI2L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 04:28:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BAF28B146;
        Thu, 17 Sep 2020 08:28:40 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     akpm@linux-foundation.org
Cc:     aris@ruivo.org, naoya.horiguchi@nec.com, mhocko@kernel.org,
        tony.luck@intel.com, cai@lca.pw, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v4 7/7] mm,hwpoison: remove stale code
Date:   Thu, 17 Sep 2020 10:10:49 +0200
Message-Id: <20200917081049.27428-8-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20200917081049.27428-1-osalvador@suse.de>
References: <20200917081049.27428-1-osalvador@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we call shake_page and then check whether the page is Buddy
because shake_page calls drain_all_pages, which sends pcp-pages back to
the buddy freelists, so we could have a chance to handle free pages.

get_hwpoison_page already calls drain_all_pages, and we do call
get_hwpoison_page right before coming here, so we should be on the safe
side.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 mm/memory-failure.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 7fba4ba201d5..f68cb5e3b320 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1423,18 +1423,6 @@ int memory_failure(unsigned long pfn, int flags)
 	 * walked by the page reclaim code, however that's not a big loss.
 	 */
 	shake_page(p, 0);
-	/* shake_page could have turned it free. */
-	if (!PageLRU(p) && is_free_buddy_page(p)) {
-		if (!take_page_off_buddy(p))
-			res = -EBUSY;
-
-		if (flags & MF_COUNT_INCREASED)
-			action_result(pfn, MF_MSG_BUDDY, res ? MF_FAILED : MF_RECOVERED);
-		else
-			action_result(pfn, MF_MSG_BUDDY_2ND, res ? MF_FAILED : MF_RECOVERED);
-
-		return res;
-	}
 
 	lock_page(p);
 
-- 
2.26.2

