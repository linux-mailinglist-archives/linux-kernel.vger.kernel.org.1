Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74D30219588
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jul 2020 03:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbgGIBQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jul 2020 21:16:38 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7823 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726082AbgGIBQi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 21:16:38 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0779F59593B19B965EFF;
        Thu,  9 Jul 2020 09:16:36 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Thu, 9 Jul 2020 09:16:28 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linuxarm@huawei.com>
Subject: [PATCH v2] vmalloc: Removing incorrect logs when vmalloc failed
Date:   Thu, 9 Jul 2020 09:14:48 +0800
Message-ID: <1594257288-58269-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is not possible to increase size with vmalloc=<size> in arm64
architecture and it will mislead.however vmalloc return failure
is a rare occurrence in 'many architectures including arm64'.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>

v2:
Add appropriate hints and let users decide if they can increase
the size of the vmalloc by vmalloc=<size> depending on their platform
---
 mm/vmalloc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 89e83d3..c6ae7e6 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1238,8 +1238,8 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 	}
 
 	if (!(gfp_mask & __GFP_NOWARN) && printk_ratelimit())
-		pr_warn("vmap allocation for size %lu failed: use vmalloc=<size> to increase size\n",
-			size);
+		pr_warn("vmap allocation for size %lu failed: use vmalloc=<size> to increase size,
+			if your ARCH supports it\n", size);
 
 	kmem_cache_free(vmap_area_cachep, va);
 	return ERR_PTR(-EBUSY);
-- 
2.7.4

