Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0E14304253
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 16:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392728AbhAZPXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 10:23:32 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:47680 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389115AbhAZJdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 04:33:49 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R701e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=abaci-bugfix@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UMyJmYd_1611653554;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:abaci-bugfix@linux.alibaba.com fp:SMTPD_---0UMyJmYd_1611653554)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 26 Jan 2021 17:32:51 +0800
From:   Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
To:     agk@redhat.com
Cc:     snitzer@redhat.com, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org,
        Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
Subject: [PATCH] dm writecache: remove redundant NULL check
Date:   Tue, 26 Jan 2021 17:32:32 +0800
Message-Id: <1611653552-84056-1-git-send-email-abaci-bugfix@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix below warnings reported by coccicheck:
./drivers/md/dm-writecache.c:2008:2-7: WARNING: NULL check before some
freeing functions is not needed.
./drivers/md/dm-writecache.c:2024:2-7: WARNING: NULL check before some
freeing functions is not needed.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
---
 drivers/md/dm-writecache.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
index d5223a0..8abf185 100644
--- a/drivers/md/dm-writecache.c
+++ b/drivers/md/dm-writecache.c
@@ -2004,8 +2004,7 @@ static void writecache_dtr(struct dm_target *ti)
 	if (wc->ssd_dev)
 		dm_put_device(ti, wc->ssd_dev);
 
-	if (wc->entries)
-		vfree(wc->entries);
+	vfree(wc->entries);
 
 	if (wc->memory_map) {
 		if (WC_MODE_PMEM(wc))
@@ -2020,8 +2019,7 @@ static void writecache_dtr(struct dm_target *ti)
 	if (wc->dm_io)
 		dm_io_client_destroy(wc->dm_io);
 
-	if (wc->dirty_bitmap)
-		vfree(wc->dirty_bitmap);
+	vfree(wc->dirty_bitmap);
 
 	kfree(wc);
 }
-- 
1.8.3.1

