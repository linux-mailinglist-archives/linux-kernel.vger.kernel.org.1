Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4543A21965D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jul 2020 04:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbgGICz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jul 2020 22:55:27 -0400
Received: from mail.synology.com ([211.23.38.101]:55132 "EHLO synology.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726117AbgGICz0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 22:55:26 -0400
X-Greylist: delayed 425 seconds by postgrey-1.27 at vger.kernel.org; Wed, 08 Jul 2020 22:55:26 EDT
Received: from localhost.localdomain (unknown [10.17.32.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by synology.com (Postfix) with ESMTPSA id 652BACE78121;
        Thu,  9 Jul 2020 10:48:20 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1594262900; bh=joCChp/WKfH+meqYEh6O1+n19ugnHJTEgLQjLh1PDfc=;
        h=From:To:Cc:Subject:Date;
        b=ZLuZ8aCT+6gGFY+ohMiEojJ4oOV2pBw2sne/+6IJlx0EL4ZmJHpU/xKVOgKCV3xCD
         iuYYZqB7D2QpybkJmhU/zjgVvroAWAdjJ6dP6jPd9FlEMXDQEAwCSVuh2YH5bYFGGS
         vS2c4ageUbB6vN5dJg3a169n7maNQL06LE06niYo=
From:   robbieko <robbieko@synology.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, Robbie Ko <robbieko@synology.com>
Subject: [PATCH] mm : fix pte _PAGE_DIRTY bit when fallback migrate page
Date:   Thu,  9 Jul 2020 10:48:08 +0800
Message-Id: <20200709024808.18466-1-robbieko@synology.com>
X-Mailer: git-send-email 2.17.1
X-Synology-MCP-Status: no
X-Synology-Spam-Flag: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Virus-Status: no
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robbie Ko <robbieko@synology.com>

When a migrate page occurs, we first create a migration entry
to replace the original pte, and then go to fallback_migrate_page
to execute a writeout if the migratepage is not supported.

In the writeout, we will clear the dirty bit of the page and use
page_mkclean to clear the dirty bit along with the corresponding pte,
but page_mkclean does not support migration entry.

The page ditry bit is cleared, but the dirty bit of the pte still exists,
so if mmap continues to write, it will result in data loss.

We fix the by first remove the migration entry and then clearing
the dirty bits of the page, which also clears the pte's dirty bits.

Signed-off-by: Robbie Ko <robbieko@synology.com>
---
 mm/migrate.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index f37729673558..5c407434b9ba 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -875,10 +875,6 @@ static int writeout(struct address_space *mapping, struct page *page)
 		/* No write method for the address space */
 		return -EINVAL;
 
-	if (!clear_page_dirty_for_io(page))
-		/* Someone else already triggered a write */
-		return -EAGAIN;
-
 	/*
 	 * A dirty page may imply that the underlying filesystem has
 	 * the page on some queue. So the page must be clean for
@@ -889,6 +885,10 @@ static int writeout(struct address_space *mapping, struct page *page)
 	 */
 	remove_migration_ptes(page, page, false);
 
+	if (!clear_page_dirty_for_io(page))
+		/* Someone else already triggered a write */
+		return -EAGAIN;
+
 	rc = mapping->a_ops->writepage(page, &wbc);
 
 	if (rc != AOP_WRITEPAGE_ACTIVATE)
-- 
2.17.1

