Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 521D72A9532
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 12:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbgKFLZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 06:25:14 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:41564 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727177AbgKFLZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 06:25:13 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0UEQbtYd_1604661901;
Received: from aliy80.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UEQbtYd_1604661901)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 06 Nov 2020 19:25:01 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm/filemap: add static for function __add_to_page_cache_locked
Date:   Fri,  6 Nov 2020 19:24:55 +0800
Message-Id: <1604661895-5495-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Otherwise it cause gcc warning:
          ^~~~~~~~~~~~~~~
../mm/filemap.c:830:14: warning: no previous prototype for
‘__add_to_page_cache_locked’ [-Wmissing-prototypes]
 noinline int __add_to_page_cache_locked(struct page *page,
              ^~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org> 
Cc: linux-mm@kvack.org 
Cc: linux-kernel@vger.kernel.org 
---
 mm/filemap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index d90614f501da..249cf489f5df 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -827,7 +827,7 @@ int replace_page_cache_page(struct page *old, struct page *new, gfp_t gfp_mask)
 }
 EXPORT_SYMBOL_GPL(replace_page_cache_page);
 
-noinline int __add_to_page_cache_locked(struct page *page,
+static noinline int __add_to_page_cache_locked(struct page *page,
 					struct address_space *mapping,
 					pgoff_t offset, gfp_t gfp,
 					void **shadowp)
-- 
1.8.3.1

