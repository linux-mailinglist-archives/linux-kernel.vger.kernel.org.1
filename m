Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0134E2DCAD2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 03:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbgLQCGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 21:06:52 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9536 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbgLQCGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 21:06:52 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CxFhC6YkdzhnJj;
        Thu, 17 Dec 2020 10:05:31 +0800 (CST)
Received: from huawei.com (10.175.112.227) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.498.0; Thu, 17 Dec 2020
 10:06:05 +0800
From:   Xiangyang Yu <yuxiangyang4@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] mm/filemap: Fix warning: no previous prototype
Date:   Thu, 17 Dec 2020 10:03:11 +0800
Message-ID: <20201217020311.491799-1-yuxiangyang4@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.112.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed the warning when building with warnings enabled (W=1),
This function is only used in filemap.c, so mark this function
with 'static'.

mm/filemap.c:830:14: warning: no previous prototype for ‘__add_to_page_cache_locked’ [-Wmissing-prototypes]

Signed-off-by: Xiangyang Yu <yuxiangyang4@huawei.com>
---
 mm/filemap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index c178022d7893..edaba5251bec 100644
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
2.23.0

