Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 645D72FE407
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 08:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbhAUHdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 02:33:44 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:53231 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726320AbhAUHbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 02:31:43 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=abaci-bugfix@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UMPU06O_1611214231;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:abaci-bugfix@linux.alibaba.com fp:SMTPD_---0UMPU06O_1611214231)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 21 Jan 2021 15:30:54 +0800
From:   Yang Li <abaci-bugfix@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yang Li <abaci-bugfix@linux.alibaba.com>
Subject: [PATCH] mm/swap_slots.c: remove redundant NULL check
Date:   Thu, 21 Jan 2021 15:30:29 +0800
Message-Id: <1611214229-11225-1-git-send-email-abaci-bugfix@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix below warnings reported by coccicheck:
./mm/swap_slots.c:197:3-9: WARNING: NULL check before some freeing
functions is not needed.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <abaci-bugfix@linux.alibaba.com>
---
 mm/swap_slots.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/swap_slots.c b/mm/swap_slots.c
index 0357fbe..be9de6d 100644
--- a/mm/swap_slots.c
+++ b/mm/swap_slots.c
@@ -193,8 +193,7 @@ static void drain_slots_cache_cpu(unsigned int cpu, unsigned int type,
 			cache->slots_ret = NULL;
 		}
 		spin_unlock_irq(&cache->free_lock);
-		if (slots)
-			kvfree(slots);
+		kvfree(slots);
 	}
 }
 
-- 
1.8.3.1

