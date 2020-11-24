Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26E402C1D46
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 06:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbgKXFOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 00:14:02 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:45122 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725306AbgKXFOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 00:14:02 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0UGO0B1K_1606194838;
Received: from aliy80.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UGO0B1K_1606194838)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 24 Nov 2020 13:13:58 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [REF PATCH] block/loop: remove unused range
Date:   Tue, 24 Nov 2020 13:13:56 +0800
Message-Id: <1606194836-14292-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable isn't used, so don't brother to set it.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Jens Axboe <axboe@kernel.dk> 
Cc: linux-block@vger.kernel.org 
Cc: linux-kernel@vger.kernel.org 
---
 drivers/block/loop.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 9a27d4f1c08a..ff8d25a379f7 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -2312,7 +2312,6 @@ MODULE_ALIAS("devname:loop-control");
 static int __init loop_init(void)
 {
 	int i, nr;
-	unsigned long range;
 	struct loop_device *lo;
 	int err;
 
@@ -2351,10 +2350,8 @@ static int __init loop_init(void)
 	 */
 	if (max_loop) {
 		nr = max_loop;
-		range = max_loop << part_shift;
 	} else {
 		nr = CONFIG_BLK_DEV_LOOP_MIN_COUNT;
-		range = 1UL << MINORBITS;
 	}
 
 	err = misc_register(&loop_misc);
-- 
2.29.GIT

