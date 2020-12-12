Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AED092D8426
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Dec 2020 04:31:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438012AbgLLD1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 22:27:30 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:58081 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2438000AbgLLD1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 22:27:12 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UIIAwQ4_1607743587;
Received: from aliy80.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UIIAwQ4_1607743587)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 12 Dec 2020 11:26:28 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm/zsmalloc: replace if (cond) BUG() with BUG_ON()
Date:   Sat, 12 Dec 2020 11:26:25 +0800
Message-Id: <1607743586-80303-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

coccinelle reports some warning:
WARNING: Use BUG_ON instead of if condition followed by BUG.

It could be fixed by BUG_ON().

Reported-by: abaci@linux.alibaba.com
Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Nitin Gupta <ngupta@vflare.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 mm/zsmalloc.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 7289f502ffac..1ea0605dbe94 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1988,8 +1988,7 @@ static int zs_page_migrate(struct address_space *mapping, struct page *newpage,
 		head = obj_to_head(page, addr);
 		if (head & OBJ_ALLOCATED_TAG) {
 			handle = head & ~OBJ_ALLOCATED_TAG;
-			if (!testpin_tag(handle))
-				BUG();
+			BUG_ON(!testpin_tag(handle));
 
 			old_obj = handle_to_obj(handle);
 			obj_to_location(old_obj, &dummy, &obj_idx);
@@ -2036,8 +2035,8 @@ static int zs_page_migrate(struct address_space *mapping, struct page *newpage,
 		head = obj_to_head(page, addr);
 		if (head & OBJ_ALLOCATED_TAG) {
 			handle = head & ~OBJ_ALLOCATED_TAG;
-			if (!testpin_tag(handle))
-				BUG();
+			BUG_ON(!testpin_tag(handle));
+
 			unpin_tag(handle);
 		}
 	}
-- 
2.29.GIT

