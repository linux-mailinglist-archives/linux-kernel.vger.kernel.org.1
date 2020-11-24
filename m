Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F63E2C1C16
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 04:34:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729152AbgKXDdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 22:33:55 -0500
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:55849 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727781AbgKXDdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 22:33:53 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UGN4rt._1606188830;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0UGN4rt._1606188830)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 24 Nov 2020 11:33:50 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     axboe@kernel.dk, tj@kernel.org
Cc:     baolin.wang@linux.alibaba.com, baolin.wang7@gmail.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] blk-iocost: Add a flag to indicate if need update hwi
Date:   Tue, 24 Nov 2020 11:33:33 +0800
Message-Id: <beb9ab5875427431b58e1001e481b7a43e9188eb.1606186717.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1606186717.git.baolin.wang@linux.alibaba.com>
References: <cover.1606186717.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1606186717.git.baolin.wang@linux.alibaba.com>
References: <cover.1606186717.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can get the hwa and hwi at one time if no debt need to pay off,
thus add a flag to indicate if the hw_inuse has been changed and
need to update, which can avoid calling current_hweight() twice
for no debt iocgs.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 block/blk-iocost.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 089f3fe..5305afd 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -1405,10 +1405,11 @@ static void iocg_kick_waitq(struct ioc_gq *iocg, bool pay_debt,
 	u64 vshortage, expires, oexpires;
 	s64 vbudget;
 	u32 hwa;
+	bool need_update_hwi = false;
 
 	lockdep_assert_held(&iocg->waitq.lock);
 
-	current_hweight(iocg, &hwa, NULL);
+	current_hweight(iocg, &hwa, &ctx.hw_inuse);
 	vbudget = now->vnow - atomic64_read(&iocg->vtime);
 
 	/* pay off debt */
@@ -1423,6 +1424,7 @@ static void iocg_kick_waitq(struct ioc_gq *iocg, bool pay_debt,
 		atomic64_add(vpay, &iocg->done_vtime);
 		iocg_pay_debt(iocg, abs_vpay, now);
 		vbudget -= vpay;
+		need_update_hwi = true;
 	}
 
 	if (iocg->abs_vdebt || iocg->delay)
@@ -1445,7 +1447,8 @@ static void iocg_kick_waitq(struct ioc_gq *iocg, bool pay_debt,
 	 * after the above debt payment.
 	 */
 	ctx.vbudget = vbudget;
-	current_hweight(iocg, NULL, &ctx.hw_inuse);
+	if (need_update_hwi)
+		current_hweight(iocg, NULL, &ctx.hw_inuse);
 
 	__wake_up_locked_key(&iocg->waitq, TASK_NORMAL, &ctx);
 
-- 
1.8.3.1

