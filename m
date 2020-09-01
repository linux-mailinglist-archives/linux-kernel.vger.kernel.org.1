Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E04525854C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Sep 2020 03:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbgIABrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Aug 2020 21:47:06 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:38560 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726023AbgIABqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 21:46:47 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01358;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0U7UAs.E_1598924803;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U7UAs.E_1598924803)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 01 Sep 2020 09:46:43 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, bhe@redhat.com,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: [Patch v4 3/7] mm/hugetlb: use list_splice to merge two list at once
Date:   Tue,  1 Sep 2020 09:46:32 +0800
Message-Id: <20200901014636.29737-4-richard.weiyang@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20200901014636.29737-1-richard.weiyang@linux.alibaba.com>
References: <20200901014636.29737-1-richard.weiyang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of add allocated file_region one by one to region_cache, we
could use list_splice to merge two list at once.

Also we know the number of entries in the list, increase the number
directly.

Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
Reviewed-by: Baoquan He <bhe@redhat.com>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index fbaf49bc1d26..a02bf430de6f 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -443,11 +443,8 @@ static int allocate_file_region_entries(struct resv_map *resv,
 
 		spin_lock(&resv->lock);
 
-		list_for_each_entry_safe(rg, trg, &allocated_regions, link) {
-			list_del(&rg->link);
-			list_add(&rg->link, &resv->region_cache);
-			resv->region_cache_count++;
-		}
+		list_splice(&allocated_regions, &resv->region_cache);
+		resv->region_cache_count += to_allocate;
 	}
 
 	return 0;
-- 
2.20.1 (Apple Git-117)

