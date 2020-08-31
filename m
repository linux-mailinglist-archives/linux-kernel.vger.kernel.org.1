Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2D152571CF
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Aug 2020 04:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbgHaCYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Aug 2020 22:24:01 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:54174 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726618AbgHaCYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 22:24:01 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R371e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01419;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0U7IVpvr_1598840637;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U7IVpvr_1598840637)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 31 Aug 2020 10:23:58 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, bhe@redhat.com,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: [Patch v3 1/7] mm/hugetlb: not necessary to coalesce regions recursively
Date:   Mon, 31 Aug 2020 10:23:45 +0800
Message-Id: <20200831022351.20916-2-richard.weiyang@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20200831022351.20916-1-richard.weiyang@linux.alibaba.com>
References: <20200831022351.20916-1-richard.weiyang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Per my understanding, we keep the regions ordered and would always
coalesce regions properly. So the task to keep this property is just
to coalesce its neighbour.

Let's simplify this.

Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
Reviewed-by: Baoquan He <bhe@redhat.com>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index a301c2d672bf..db6af2654f12 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -309,8 +309,7 @@ static void coalesce_file_region(struct resv_map *resv, struct file_region *rg)
 		list_del(&rg->link);
 		kfree(rg);
 
-		coalesce_file_region(resv, prg);
-		return;
+		rg = prg;
 	}
 
 	nrg = list_next_entry(rg, link);
@@ -320,9 +319,6 @@ static void coalesce_file_region(struct resv_map *resv, struct file_region *rg)
 
 		list_del(&rg->link);
 		kfree(rg);
-
-		coalesce_file_region(resv, nrg);
-		return;
 	}
 }
 
-- 
2.20.1 (Apple Git-117)

