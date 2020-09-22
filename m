Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B200F2743A0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 15:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgIVN53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 09:57:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:33494 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726732AbgIVN5S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 09:57:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 39B4BAFBC;
        Tue, 22 Sep 2020 13:57:49 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     akpm@linux-foundation.org
Cc:     aris@ruivo.org, naoya.horiguchi@nec.com, mhocko@kernel.org,
        tony.luck@intel.com, cai@lca.pw, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v7 14/14] mm,hwpoison: Try to narrow window race for free pages
Date:   Tue, 22 Sep 2020 15:56:50 +0200
Message-Id: <20200922135650.1634-15-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20200922135650.1634-1-osalvador@suse.de>
References: <20200922135650.1634-1-osalvador@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Aristeu Rozanski reported that a customer test case started
to report -EBUSY after the hwpoison rework patchset.

There is a race window between spotting a free page and taking it off
its buddy freelist, so it might be that by the time we try to take it off,
the page has been already allocated.

This patch tries to handle such race window by trying to handle the new
type of page again if the page was allocated under us.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
Reported-by: Aristeu Rozanski <aris@ruivo.org>
Tested-by: Aristeu Rozanski <aris@ruivo.org>
---
 mm/memory-failure.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 46b1821d2817..8f23d3c7a0a2 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1903,6 +1903,7 @@ int soft_offline_page(unsigned long pfn, int flags)
 {
 	int ret;
 	struct page *page;
+	bool try_again = true;
 
 	if (!pfn_valid(pfn))
 		return -ENXIO;
@@ -1918,6 +1919,7 @@ int soft_offline_page(unsigned long pfn, int flags)
 		return 0;
 	}
 
+retry:
 	get_online_mems();
 	ret = get_any_page(page, pfn, flags);
 	put_online_mems();
@@ -1925,7 +1927,10 @@ int soft_offline_page(unsigned long pfn, int flags)
 	if (ret > 0)
 		ret = soft_offline_in_use_page(page);
 	else if (ret == 0)
-		ret = soft_offline_free_page(page);
+		if (soft_offline_free_page(page) && try_again) {
+			try_again = false;
+			goto retry;
+		}
 
 	return ret;
 }
-- 
2.26.2

