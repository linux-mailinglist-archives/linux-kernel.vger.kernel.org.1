Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8E02D2A19
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 12:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbgLHL6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 06:58:46 -0500
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:48939 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725877AbgLHL6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 06:58:45 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1759569|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0458837-0.00184451-0.952272;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047212;MF=liush@allwinnertech.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.J4bVZGu_1607428673;
Received: from localhost.localdomain(mailfrom:liush@allwinnertech.com fp:SMTPD_---.J4bVZGu_1607428673)
          by smtp.aliyun-inc.com(10.147.41.143);
          Tue, 08 Dec 2020 19:58:00 +0800
From:   liush <liush@allwinnertech.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, liush <liush@allwinnertech.com>
Subject: [PATCH] virtio: replace constant parameter '1' with num
Date:   Tue,  8 Dec 2020 19:57:51 +0800
Message-Id: <1607428671-4802-1-git-send-email-liush@allwinnertech.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'num' can represent the value of out_sgs(in_sags), no need to pass 
in constant parameters in 'virtqueue_add'.

Signed-off-by: liush <liush@allwinnertech.com>
---
 drivers/virtio/virtio_ring.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index becc776..7583f8b 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1760,7 +1760,7 @@ int virtqueue_add_outbuf(struct virtqueue *vq,
 			 void *data,
 			 gfp_t gfp)
 {
-	return virtqueue_add(vq, &sg, num, 1, 0, data, NULL, gfp);
+	return virtqueue_add(vq, &sg, num, num, 0, data, NULL, gfp);
 }
 EXPORT_SYMBOL_GPL(virtqueue_add_outbuf);
 
@@ -1782,7 +1782,7 @@ int virtqueue_add_inbuf(struct virtqueue *vq,
 			void *data,
 			gfp_t gfp)
 {
-	return virtqueue_add(vq, &sg, num, 0, 1, data, NULL, gfp);
+	return virtqueue_add(vq, &sg, num, 0, num, data, NULL, gfp);
 }
 EXPORT_SYMBOL_GPL(virtqueue_add_inbuf);
 
-- 
2.7.4

