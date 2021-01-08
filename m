Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 010002EEEC9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 09:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbhAHIxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 03:53:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:56808 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726631AbhAHIxA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 03:53:00 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E6934ACAF;
        Fri,  8 Jan 2021 08:52:18 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     akpm@linux-foundation.org
Cc:     n-horiguchi@ah.jp.nec.com, dan.carpenter@oracle.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH] mm,hwpoison: Fix printing of page flags
Date:   Fri,  8 Jan 2021 09:52:02 +0100
Message-Id: <20210108085202.4506-1-osalvador@suse.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Format %pG expects a lower case 'p' in order to print the flags.
Fix it.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Oscar Salvador <osalvador@suse.de>
Fixes: 8295d535e2aa ("mm,hwpoison: refactor get_any_page")
---
 mm/memory-failure.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 5a38e9eade94..04d9f154a130 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1940,7 +1940,7 @@ int soft_offline_page(unsigned long pfn, int flags)
 			goto retry;
 		}
 	} else if (ret == -EIO) {
-		pr_info("%s: %#lx: unknown page type: %lx (%pGP)\n",
+		pr_info("%s: %#lx: unknown page type: %lx (%pGp)\n",
 			 __func__, pfn, page->flags, &page->flags);
 	}
 
-- 
2.26.2

