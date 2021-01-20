Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 456DA2FCC36
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 09:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729860AbhATH7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 02:59:43 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:55528 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730033AbhATH6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 02:58:52 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R321e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=abaci-bugfix@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UMJDEeW_1611129033;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:abaci-bugfix@linux.alibaba.com fp:SMTPD_---0UMJDEeW_1611129033)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 20 Jan 2021 15:50:36 +0800
From:   Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
To:     david@redhat.com
Cc:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
Subject: [PATCH] virtio-mem: Assign boolean values to a bool variable
Date:   Wed, 20 Jan 2021 15:50:31 +0800
Message-Id: <1611129031-82818-1-git-send-email-abaci-bugfix@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warnings:

./drivers/virtio/virtio_mem.c:2580:2-25: WARNING: Assignment
of 0/1 to bool variable.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
---
 drivers/virtio/virtio_mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 9fc9ec4..85a272c 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -2577,7 +2577,7 @@ static int virtio_mem_probe(struct virtio_device *vdev)
 	 * actually in use (e.g., trying to reload the driver).
 	 */
 	if (vm->plugged_size) {
-		vm->unplug_all_required = 1;
+		vm->unplug_all_required = true;
 		dev_info(&vm->vdev->dev, "unplugging all memory is required\n");
 	}
 
-- 
1.8.3.1

