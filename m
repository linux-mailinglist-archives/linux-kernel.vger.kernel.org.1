Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B65112B9076
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 11:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbgKSK5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 05:57:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:35680 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726052AbgKSK5a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 05:57:30 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1F77AACB0;
        Thu, 19 Nov 2020 10:57:29 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     akpm@linux-foundation.org
Cc:     n-horiguchi@ah.jp.nec.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH 2/7] mm,hwpoison: Drop pfn parameter
Date:   Thu, 19 Nov 2020 11:57:11 +0100
Message-Id: <20201119105716.5962-3-osalvador@suse.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201119105716.5962-1-osalvador@suse.de>
References: <20201119105716.5962-1-osalvador@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pfn parameter is no longer needed, drop it.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 mm/memory-failure.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 0d2323ba4b8e..04237fc04a00 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1712,7 +1712,7 @@ EXPORT_SYMBOL(unpoison_memory);
  * We only incremented refcount in case the page was already in-use and it is
  * a known type we can handle.
  */
-static int get_any_page(struct page *p, unsigned long pfn, int flags)
+static int get_any_page(struct page *p, int flags)
 {
 	int ret = 0, pass = 0;
 
@@ -1926,7 +1926,7 @@ int soft_offline_page(unsigned long pfn, int flags)
 
 retry:
 	get_online_mems();
-	ret = get_any_page(page, pfn, flags);
+	ret = get_any_page(page, flags);
 	put_online_mems();
 
 	if (ret > 0) {
-- 
2.26.2

