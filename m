Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 924EC28657E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 19:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbgJGRLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 13:11:05 -0400
Received: from m12-11.163.com ([220.181.12.11]:37401 "EHLO m12-11.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726168AbgJGRLF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 13:11:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=j4REq
        kCE4oCWuH/+jqK40t4uMno65/8VwgwA63qY9qQ=; b=WeXddWzYE/Cd/LaNFkJY1
        FMUjHLGNePnhDOBwjLY5rjDFdRe0GP3iQ+MdyI+1iuK+a1AJHlQgYt6h1eg8Mj40
        Y2rIkIQUF1+0N4nZlfLayAsFWdDeXuDG75tzhBZT4qp9g83B/n3gpKoV+s/dD2pf
        zaUPo9yt2RsopNNg1k+Xhw=
Received: from localhost (unknown [101.228.30.83])
        by smtp7 (Coremail) with SMTP id C8CowAAX1tJe9n1fZAygBg--.18295S2;
        Thu, 08 Oct 2020 01:09:50 +0800 (CST)
Date:   Thu, 8 Oct 2020 01:09:49 +0800
From:   Hui Su <sh_def@163.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm/hugetlb.c: just use put_page_testzero() instead of
 page_count()
Message-ID: <20201007170949.GA6416@rlk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CM-TRANSID: C8CowAAX1tJe9n1fZAygBg--.18295S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrur4kJr15Jr17tr4xZw4fKrg_yoW3ZrX_W3
        WvyF10yw4UX3srZa1akw43JryfGasxurZ3Wr47Kry3tFy5KF4DX3WDGw1FyrZxW3y7WrW3
        Krn5C3W7Cry3KjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU04q2JUUUUU==
X-Originating-IP: [101.228.30.83]
X-CM-SenderInfo: xvkbvvri6rljoofrz/1tbiLgG2X1SIqUP2NwABsw
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

we test the page reference count is zero or not here,
it can be a bug here if page refercence count is not zero.
So we can just use put_page_testzero() instead of
page_count().

Signed-off-by: Hui Su <sh_def@163.com>
---
 mm/hugetlb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 67fc6383995b..a274b9ac466f 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2105,8 +2105,7 @@ static int gather_surplus_pages(struct hstate *h, int delta)
 		 * This page is now managed by the hugetlb allocator and has
 		 * no users -- drop the buddy allocator's reference.
 		 */
-		put_page_testzero(page);
-		VM_BUG_ON_PAGE(page_count(page), page);
+		VM_BUG_ON_PAGE(!put_page_testzero(page), page);
 		enqueue_huge_page(h, page);
 	}
 free:
-- 
2.25.1


