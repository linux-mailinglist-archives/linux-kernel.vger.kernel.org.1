Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF0B526D690
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 10:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbgIQI2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 04:28:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:52826 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726493AbgIQI2T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 04:28:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 78355B244;
        Thu, 17 Sep 2020 08:28:45 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     akpm@linux-foundation.org
Cc:     aris@ruivo.org, naoya.horiguchi@nec.com, mhocko@kernel.org,
        tony.luck@intel.com, cai@lca.pw, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v4 2/7] mm,hwpoison: Do not set hugepage_or_freepage unconditionally
Date:   Thu, 17 Sep 2020 10:10:44 +0200
Message-Id: <20200917081049.27428-3-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20200917081049.27428-1-osalvador@suse.de>
References: <20200917081049.27428-1-osalvador@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Aristeu Rozanski reported that some hwpoison tests
were returning -EBUSY while before the rework they succeed [1] [2].

The root case is that during a rebase, the call to page_handle_poison was
setting hugepage_or_freepage = true unconditionally from __soft_offline_page.

Aristeu said that after this fix, everything works.

[1] https://patchwork.kernel.org/comment/23617301/
[2] https://patchwork.kernel.org/comment/23619535/

Signed-off-by: Oscar Salvador <osalvador@suse.de>
Reported-by: Aristeu Rozanski <aris@ruivo.org>
---
 mm/memory-failure.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 74a53881f94b..db61bdee9734 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1852,7 +1852,7 @@ static int __soft_offline_page(struct page *page)
 		if (!ret) {
 			bool release = !huge;
 
-			if (!page_handle_poison(page, true, release))
+			if (!page_handle_poison(page, huge, release))
 				ret = -EBUSY;
 		} else {
 			if (!list_empty(&pagelist))
-- 
2.26.2

