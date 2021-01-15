Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CAF42F7628
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 11:03:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731275AbhAOKBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 05:01:30 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:40688 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730285AbhAOKB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 05:01:29 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R471e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=abaci-bugfix@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0ULo6k2d_1610704830;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:abaci-bugfix@linux.alibaba.com fp:SMTPD_---0ULo6k2d_1610704830)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 15 Jan 2021 18:00:41 +0800
From:   Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
To:     mst@redhat.com
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
Subject: [PATCH] virtio_ring: boolean values to a bool variable
Date:   Fri, 15 Jan 2021 18:00:25 +0800
Message-Id: <1610704825-17724-1-git-send-email-abaci-bugfix@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warnings:

./drivers/virtio/virtio_ring.c:1637:1-29: WARNING: Assignment of
0/1 to bool variable.

./drivers/virtio/virtio_ring.c:1636:1-30: WARNING: Assignment of
0/1 to bool variable.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 71e16b5..5adb361 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1633,8 +1633,8 @@ static struct virtqueue *vring_create_virtqueue_packed(
 	vq->packed.vring.device = device;
 
 	vq->packed.next_avail_idx = 0;
-	vq->packed.avail_wrap_counter = 1;
-	vq->packed.used_wrap_counter = 1;
+	vq->packed.avail_wrap_counter = true;
+	vq->packed.used_wrap_counter = true;
 	vq->packed.event_flags_shadow = 0;
 	vq->packed.avail_used_flags = 1 << VRING_PACKED_DESC_F_AVAIL;
 
-- 
1.8.3.1

