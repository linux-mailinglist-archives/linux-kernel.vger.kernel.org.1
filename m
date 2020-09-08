Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE5D260CAD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Sep 2020 09:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729898AbgIHH5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Sep 2020 03:57:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:53180 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729629AbgIHH4h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 03:56:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8166FB6D7;
        Tue,  8 Sep 2020 07:56:37 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     akpm@linux-foundation.org
Cc:     naoya.horiguchi@nec.com, mhocko@kernel.org, tony.luck@intel.com,
        cai@lca.pw, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v2 4/5] mm,hwpoison: Drop unneeded pcplist draining
Date:   Tue,  8 Sep 2020 09:56:25 +0200
Message-Id: <20200908075626.11976-5-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20200908075626.11976-1-osalvador@suse.de>
References: <20200908075626.11976-1-osalvador@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

memory_failure and soft_offline_path paths now drain pcplists by calling
get_hwpoison_page.
memory_failure flags the page as HWPoison before, so that page cannot longer
go into a pcplist, and soft_offline_page only flags a page as HWPoison
if 1) we took the page off a buddy freelist 2) the page was in-use
and we migrated it 3) was a clean pagecache.

Because of that, a page cannot longer be poisoned and be in a pcplist.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 mm/madvise.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index e92e06890b08..e7cdfabd8aca 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -930,10 +930,6 @@ static int madvise_inject_error(int behavior,
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

