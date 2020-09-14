Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 852E0268913
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 12:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgINKQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 06:16:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:44850 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726417AbgINKQH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 06:16:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9869AB080;
        Mon, 14 Sep 2020 10:16:21 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     akpm@linux-foundation.org
Cc:     naoya.horiguchi@nec.com, mhocko@kernel.org, tony.luck@intel.com,
        cai@lca.pw, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Oscar Salvador <osalvador@suse.de>,
        Oscar Salvador <osalvador@suse.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH v3 5/5] mm,hwpoison: remove stale code
Date:   Mon, 14 Sep 2020 12:15:59 +0200
Message-Id: <20200914101559.17103-6-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20200914101559.17103-1-osalvador@suse.de>
References: <20200914101559.17103-1-osalvador@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we call shake_page and then check whether the page is Buddy
because shake_page calls drain_all_pages, which sends pcp-pages back to
the buddy freelists, so we could have a chance to handle free pages.

get_hwpoison_page already calls drain_all_pages, and we do call
get_hwpoison_page right before coming here, so we should be on the safe
side.

Link: https://lkml.kernel.org/r/20200908075626.11976-6-osalvador@suse.de
Signed-off-by: Oscar Salvador <osalvador@suse.de>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Naoya Horiguchi <naoya.horiguchi@nec.com>
Cc: Oscar Salvador <osalvador@suse.com>
Cc: Qian Cai <cai@lca.pw>
Cc: Tony Luck <tony.luck@intel.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 mm/memory-failure.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 4468c1eb5027..fbe174d54fad 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1421,18 +1421,6 @@ int memory_failure(unsigned long pfn, int flags)
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

