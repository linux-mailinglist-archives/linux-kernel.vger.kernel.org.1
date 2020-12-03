Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14BBF2CE2A3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 00:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387519AbgLCX1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 18:27:15 -0500
Received: from m12-13.163.com ([220.181.12.13]:41791 "EHLO m12-13.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726721AbgLCX1O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 18:27:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=fY+azOiKFWCkO15i5K
        n8miYs1r6N7Ic8uWA89DDKIuM=; b=TEsJiKiz7XbYZjoMvNCk4J5pEpXEegDiSw
        1efyY+DfLSKpRebZy30UE040sBzEwYrRqYjSUleoViIK2kTIvvZDthex31y8JYjH
        f5bJYL3OogcwaC69HNjbeUOO6IyLugKNGCF5KfrRMGF9baeSeEfm33yElQbC940N
        eynB+A6LE=
Received: from localhost.localdomain (unknown [36.170.33.20])
        by smtp9 (Coremail) with SMTP id DcCowADX1IDuAslfnImRUA--.12606S2;
        Thu, 03 Dec 2020 23:23:27 +0800 (CST)
From:   carver4lio@163.com
To:     rppt@kernel.org
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Hailong Liu <liu.hailong6@zte.com.cn>
Subject: [PATCH] mm/memblock:use a more appropriate order calculation when free memblock pages
Date:   Thu,  3 Dec 2020 23:23:10 +0800
Message-Id: <20201203152311.5272-1-carver4lio@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: DcCowADX1IDuAslfnImRUA--.12606S2
X-Coremail-Antispam: 1Uf129KBjvdXoWruw1UXr4xuF15WryrCry5CFg_yoWDGwb_Ar
        4rtFZ7uFWFyrZ0ga12vFySqr4UK3yDZr1qvr1fGF1DKFyUJasxWr95GFsxXr1jgFWUtrZa
        vF1DWryFk3W2gjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8iID7UUUUU==
X-Originating-IP: [36.170.33.20]
X-CM-SenderInfo: xfdu4v3uuox0i6rwjhhfrp/1tbiKBjvnV7WDQeUIQABs0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hailong Liu <liu.hailong6@zte.com.cn>

When system in the booting stage, pages span from [start, end] of a memblock
are freed to buddy in a order as large as possible (less than MAX_ORDER) at
first, then decrease gradually to a proper order(less than end) in a loop.

However, *min(MAX_ORDER - 1UL, __ffs(start))* can not get the largest order
in some cases.
Instead, *__ffs(end - start)* may be more appropriate and meaningful.

Signed-off-by: Hailong Liu <liu.hailong6@zte.com.cn>
---
 mm/memblock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index b68ee8678..7c6d0dde7 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1931,7 +1931,7 @@ static void __init __free_pages_memory(unsigned long start, unsigned long end)
 	int order;
 
 	while (start < end) {
-		order = min(MAX_ORDER - 1UL, __ffs(start));
+		order = min(MAX_ORDER - 1UL, __ffs(end - start));
 
 		while (start + (1UL << order) > end)
 			order--;
-- 
2.17.1


