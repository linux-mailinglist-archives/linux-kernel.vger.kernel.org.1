Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3A526D684
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 10:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbgIQI1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 04:27:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:47690 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726185AbgIQI1s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 04:27:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2A772B134;
        Thu, 17 Sep 2020 08:28:18 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     akpm@linux-foundation.org
Cc:     aris@ruivo.org, naoya.horiguchi@nec.com, mhocko@kernel.org,
        tony.luck@intel.com, cai@lca.pw, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v4 3/7] mm,hwpoison: Try to narrow window race for free pages
Date:   Thu, 17 Sep 2020 10:10:45 +0200
Message-Id: <20200917081049.27428-4-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20200917081049.27428-1-osalvador@suse.de>
References: <20200917081049.27428-1-osalvador@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Aristeu Rozanski reported that a customer test case started
to report -EBUSY after the hwpoison report patchset.

There is a race window between spotting a free page and taking it off
its buddy freelist, so it might be that by the time we try to take it off,
the page has been already allocated.

This patch tries to handle such race window by trying to handle the new
type of page again if the page was allocated under us.

After this patch, Aristeu said the test cases work properly.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
Reported-by: Aristeu Rozanski <aris@ruivo.org>
---
 mm/memory-failure.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index db61bdee9734..a2ccd3ba4015 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1917,6 +1917,7 @@ int soft_offline_page(unsigned long pfn, int flags)
 {
 	int ret;
 	struct page *page;
+	bool try_again = true;
 
 	if (!pfn_valid(pfn))
 		return -ENXIO;
@@ -1932,6 +1933,7 @@ int soft_offline_page(unsigned long pfn, int flags)
 		return 0;
 	}
 
+retry:
 	get_online_mems();
 	ret = get_any_page(page, pfn, flags);
 	put_online_mems();
@@ -1939,7 +1941,10 @@ int soft_offline_page(unsigned long pfn, int flags)
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

