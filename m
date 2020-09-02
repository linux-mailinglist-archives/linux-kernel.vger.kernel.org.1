Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4495325A2AC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Sep 2020 03:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbgIBBgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Sep 2020 21:36:41 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:53403 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726122AbgIBBgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 21:36:40 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R861e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04427;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0U7fvbPz_1599010597;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0U7fvbPz_1599010597)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 02 Sep 2020 09:36:37 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     axboe@kernel.dk
Cc:     ming.lei@redhat.com, hch@lst.de, baolin.wang@linux.alibaba.com,
        baolin.wang7@gmail.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] block: Fix building error
Date:   Wed,  2 Sep 2020 09:36:27 +0800
Message-Id: <b5d0ed52eeeac60906d36cb17b5344063cfa4197.1599010452.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The disk argument has been removed by commit 3b843c0bda28
("block: remove the disk argument to delete_partition"), thus
fix a building error caused by an incorrect argument.

Fixes: 3b843c0bda28 ("block: remove the disk argument to delete_partition")
Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 block/partitions/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/partitions/core.c b/block/partitions/core.c
index cf6229b..dd68114 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -557,7 +557,7 @@ int bdev_del_partition(struct block_device *bdev, int partno)
 	sync_blockdev(bdevp);
 	invalidate_bdev(bdevp);
 
-	delete_partition(bdev->bd_disk);
+	delete_partition(part);
 	ret = 0;
 out_unlock:
 	mutex_unlock(&bdev->bd_mutex);
-- 
1.8.3.1

