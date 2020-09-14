Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F617268911
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 12:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbgINKQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 06:16:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:44812 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726406AbgINKQG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 06:16:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0F233B266;
        Mon, 14 Sep 2020 10:16:21 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     akpm@linux-foundation.org
Cc:     naoya.horiguchi@nec.com, mhocko@kernel.org, tony.luck@intel.com,
        cai@lca.pw, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Oscar Salvador <osalvador@suse.de>,
        Oscar Salvador <osalvador@suse.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH v3 4/5] mm,hwpoison: drop unneeded pcplist draining
Date:   Mon, 14 Sep 2020 12:15:58 +0200
Message-Id: <20200914101559.17103-5-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20200914101559.17103-1-osalvador@suse.de>
References: <20200914101559.17103-1-osalvador@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

memory_failure and soft_offline_path paths now drain pcplists by calling
get_hwpoison_page.

memory_failure flags the page as HWPoison before, so that page cannot
longer go into a pcplist, and soft_offline_page only flags a page as
HWPoison if 1) we took the page off a buddy freelist 2) the page was
in-use and we migrated it 3) was a clean pagecache.

Because of that, a page cannot longer be poisoned and be in a pcplist.

Link: https://lkml.kernel.org/r/20200908075626.11976-5-osalvador@suse.de
Signed-off-by: Oscar Salvador <osalvador@suse.de>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Naoya Horiguchi <naoya.horiguchi@nec.com>
Cc: Oscar Salvador <osalvador@suse.com>
Cc: Qian Cai <cai@lca.pw>
Cc: Tony Luck <tony.luck@intel.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 mm/madvise.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 4ce66bab53dd..4bac8e85497a 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -917,10 +917,6 @@ static int madvise_inject_error(int behavior,
 			return ret;
 	}
 
-	/* Ensure that all poisoned pages are removed from per-cpu lists */
-	for_each_populated_zone(zone)
-		drain_all_pages(zone);
-
 	return 0;
 }
 #endif
-- 
2.26.2

