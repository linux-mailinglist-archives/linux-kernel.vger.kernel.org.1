Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15F4821B4E2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jul 2020 14:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbgGJMTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jul 2020 08:19:53 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:42402 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726774AbgGJMTw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 08:19:52 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id F3E97AD97076D32284B8;
        Fri, 10 Jul 2020 20:19:39 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Fri, 10 Jul 2020 20:19:33 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linuxarm@huawei.com>
Subject: [PATCH v3] vmalloc: Add the right hint when vmalloc failed
Date:   Fri, 10 Jul 2020 20:17:52 +0800
Message-ID: <1594383472-52983-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In fact "vmalloc=<size>" cmdline option is not available on many
platforms.When the user encounters this error, add the correct
hint to prevent misleading.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>

v2:
Add appropriate hints and let users decide if they can increase
the size of the vmalloc by vmalloc=<size> depending on their platform

v3:
change the patch name and commit messages.
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

