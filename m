Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3FB27A1B6
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 17:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbgI0PzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 11:55:06 -0400
Received: from m12-15.163.com ([220.181.12.15]:44488 "EHLO m12-15.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbgI0PzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 11:55:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=pG63W
        AIEWEv02mN1QskUD2ps4J6DXNeNTnmehPAR9hc=; b=Un1iQ2GWXonB47Um3bq5q
        HVX1Xd6wNesBC9jiXEyQen3v48jqMhq70BwiqrHpbo8mlxG3Xe8BVt7mRqx6FXAY
        daF0+WSyxlDiMbIafTc5dDPk8P0aYVLIXBcgUhpWUH/Q3W39OMxE8QMwQvo9lDGn
        Q4ZkOL2Jw8A6zmfBXMs2xo=
Received: from localhost (unknown [101.86.214.224])
        by smtp11 (Coremail) with SMTP id D8CowACnVquhtXBfXPyOEA--.16416S2;
        Sun, 27 Sep 2020 23:54:09 +0800 (CST)
Date:   Sun, 27 Sep 2020 23:54:09 +0800
From:   Hui Su <sh_def@163.com>
To:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm/vmalloc.c: update the comment in __vmalloc_area_node()
Message-ID: <20200927155409.GA3315@rlk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CM-TRANSID: D8CowACnVquhtXBfXPyOEA--.16416S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZrW8Zw4kXrWrWF18Kr1Utrb_yoW3Arc_uF
        1rtr4xu395Jay0ywn7uanayF18K3yrCrsYqrnIqa9xJa43Xa1rJ39rJry5JFsrWr42ka4D
        WayDAryUArZxGjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8ymh7UUUUU==
X-Originating-IP: [101.86.214.224]
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbBywmsX1PAPCmabAAAsB
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

since c67dc624757 commit, the __vunmap() have been
changed to __vfree(), so update the confusing comment().

Signed-off-by: Hui Su <sh_def@163.com>
---
 mm/vmalloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index be4724b916b3..689e7ef08a5d 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2447,7 +2447,7 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 			page = alloc_pages_node(node, alloc_mask|highmem_mask, 0);
 
 		if (unlikely(!page)) {
-			/* Successfully allocated i pages, free them in __vunmap() */
+			/* Successfully allocated i pages, free them in __vfree() */
 			area->nr_pages = i;
 			atomic_long_add(area->nr_pages, &nr_vmalloc_pages);
 			goto fail;
-- 
2.25.1


