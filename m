Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2BE12719BF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 06:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbgIUEEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 00:04:20 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:56315 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726011AbgIUEEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 00:04:20 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R601e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0U9XRxlZ_1600661057;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U9XRxlZ_1600661057)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 21 Sep 2020 12:04:17 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: [PATCH] mm/mempolicy: remove or narrow the lock on current
Date:   Mon, 21 Sep 2020 12:04:16 +0800
Message-Id: <20200921040416.86185-1-richard.weiyang@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is not necessary to hold the lock of current when setting nodemask of
a new policy.

Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
---
 mm/mempolicy.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 906adc58d86f..3fde772ef5ef 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -875,13 +875,12 @@ static long do_set_mempolicy(unsigned short mode, unsigned short flags,
 		goto out;
 	}
 
-	task_lock(current);
 	ret = mpol_set_nodemask(new, nodes, scratch);
 	if (ret) {
-		task_unlock(current);
 		mpol_put(new);
 		goto out;
 	}
+	task_lock(current);
 	old = current->mempolicy;
 	current->mempolicy = new;
 	if (new && new->mode == MPOL_INTERLEAVE)
@@ -1324,9 +1323,7 @@ static long do_mbind(unsigned long start, unsigned long len,
 		NODEMASK_SCRATCH(scratch);
 		if (scratch) {
 			mmap_write_lock(mm);
-			task_lock(current);
 			err = mpol_set_nodemask(new, nmask, scratch);
-			task_unlock(current);
 			if (err)
 				mmap_write_unlock(mm);
 		} else
-- 
2.20.1 (Apple Git-117)

