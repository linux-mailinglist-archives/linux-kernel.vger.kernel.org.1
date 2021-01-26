Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35909304502
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 18:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390171AbhAZRVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 12:21:05 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:39626 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389138AbhAZGp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 01:45:29 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=abaci-bugfix@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UMx8rEA_1611643469;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:abaci-bugfix@linux.alibaba.com fp:SMTPD_---0UMx8rEA_1611643469)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 26 Jan 2021 14:44:34 +0800
From:   Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
To:     mike.kravetz@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
Subject: [PATCH] mm/hugetlb: Simplify the calculation of variables
Date:   Tue, 26 Jan 2021 14:44:28 +0800
Message-Id: <1611643468-52233-1-git-send-email-abaci-bugfix@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warnings:

./mm/hugetlb.c:3372:20-22: WARNING !A || A && B is equivalent to
!A || B.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
---
 mm/hugetlb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index cbf32d2..5e6a6e7 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3367,8 +3367,7 @@ static unsigned int allowed_mems_nr(struct hstate *h)
 	mpol_allowed = policy_nodemask_current(gfp_mask);
 
 	for_each_node_mask(node, cpuset_current_mems_allowed) {
-		if (!mpol_allowed ||
-		    (mpol_allowed && node_isset(node, *mpol_allowed)))
+		if (!mpol_allowed || node_isset(node, *mpol_allowed))
 			nr += array[node];
 	}
 
-- 
1.8.3.1

