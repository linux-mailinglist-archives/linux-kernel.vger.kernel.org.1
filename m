Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72E4E2571D0
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Aug 2020 04:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgHaCYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Aug 2020 22:24:07 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:39061 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726712AbgHaCYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 22:24:02 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01353;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0U7IrQXx_1598840638;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U7IrQXx_1598840638)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 31 Aug 2020 10:23:58 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, bhe@redhat.com,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: [Patch v3 2/7] mm/hugetlb: remove VM_BUG_ON(!nrg) in get_file_region_entry_from_cache()
Date:   Mon, 31 Aug 2020 10:23:46 +0800
Message-Id: <20200831022351.20916-3-richard.weiyang@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20200831022351.20916-1-richard.weiyang@linux.alibaba.com>
References: <20200831022351.20916-1-richard.weiyang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are sure to get a valid file_region, otherwise the
VM_BUG_ON(resv->region_cache_count <= 0) at the very beginning would be
triggered.

Let's remove the redundant one.

Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index db6af2654f12..fbaf49bc1d26 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -240,7 +240,6 @@ get_file_region_entry_from_cache(struct resv_map *resv, long from, long to)
 
 	resv->region_cache_count--;
 	nrg = list_first_entry(&resv->region_cache, struct file_region, link);
-	VM_BUG_ON(!nrg);
 	list_del(&nrg->link);
 
 	nrg->from = from;
-- 
2.20.1 (Apple Git-117)

