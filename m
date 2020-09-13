Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3626F267FAE
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 15:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbgIMNg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Sep 2020 09:36:59 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:59970 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725931AbgIMNgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 09:36:40 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0U8mKYn3_1600004196;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U8mKYn3_1600004196)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 13 Sep 2020 21:36:37 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: [PATCH 1/2] mm/mmap: not necessary to check mapping separately
Date:   Sun, 13 Sep 2020 21:36:30 +0800
Message-Id: <20200913133631.37781-1-richard.weiyang@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

*root* with type of struct rb_root_cached is an element of *mapping*
with type of struct address_space. This implies when we have a valid
*root* it must be a part of valid *mapping*.

So we can merge these two checks together to make the code more easy to
read and to save some cpu cycles.

Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
---
 mm/mmap.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 1922e6fce9e7..30b155098606 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -895,10 +895,9 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
 			anon_vma_interval_tree_post_update_vma(next);
 		anon_vma_unlock_write(anon_vma);
 	}
-	if (mapping)
-		i_mmap_unlock_write(mapping);
 
 	if (root) {
+		i_mmap_unlock_write(mapping);
 		uprobe_mmap(vma);
 
 		if (adjust_next)
-- 
2.20.1 (Apple Git-117)

