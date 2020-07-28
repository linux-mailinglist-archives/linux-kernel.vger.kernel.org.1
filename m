Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E952B23024A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jul 2020 08:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgG1GGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jul 2020 02:06:13 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:34873 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727801AbgG1GGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 02:06:11 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from eli@mellanox.com)
        with SMTP; 28 Jul 2020 09:06:06 +0300
Received: from nps-server-21.mtl.labs.mlnx (nps-server-21.mtl.labs.mlnx [10.237.240.120])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 06S666Yu016782;
        Tue, 28 Jul 2020 09:06:06 +0300
Received: from nps-server-21.mtl.labs.mlnx (localhost [127.0.0.1])
        by nps-server-21.mtl.labs.mlnx (8.14.7/8.14.7) with ESMTP id 06S666Mx004231;
        Tue, 28 Jul 2020 09:06:06 +0300
Received: (from eli@localhost)
        by nps-server-21.mtl.labs.mlnx (8.14.7/8.14.7/Submit) id 06S6654E004230;
        Tue, 28 Jul 2020 09:06:05 +0300
From:   Eli Cohen <eli@mellanox.com>
To:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     shahafs@mellanox.com, saeedm@mellanox.com, parav@mellanox.com,
        Eli Cohen <eli@mellanox.com>
Subject: [PATCH V3 vhost next 05/10] vhost: Fix documentation
Date:   Tue, 28 Jul 2020 09:05:34 +0300
Message-Id: <20200728060539.4163-6-eli@mellanox.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200728060539.4163-1-eli@mellanox.com>
References: <20200728060539.4163-1-eli@mellanox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix documentation to match actual function prototypes.

Reviewed-by: Parav Pandit <parav@mellanox.com>
Signed-off-by: Eli Cohen <eli@mellanox.com>
---
 drivers/vhost/iotlb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/iotlb.c b/drivers/vhost/iotlb.c
index 1f0ca6e44410..0d4213a54a88 100644
--- a/drivers/vhost/iotlb.c
+++ b/drivers/vhost/iotlb.c
@@ -149,7 +149,7 @@ EXPORT_SYMBOL_GPL(vhost_iotlb_free);
  * vhost_iotlb_itree_first - return the first overlapped range
  * @iotlb: the IOTLB
  * @start: start of IOVA range
- * @end: end of IOVA range
+ * @last: last byte in IOVA range
  */
 struct vhost_iotlb_map *
 vhost_iotlb_itree_first(struct vhost_iotlb *iotlb, u64 start, u64 last)
@@ -162,7 +162,7 @@ EXPORT_SYMBOL_GPL(vhost_iotlb_itree_first);
  * vhost_iotlb_itree_first - return the next overlapped range
  * @iotlb: the IOTLB
  * @start: start of IOVA range
- * @end: end of IOVA range
+ * @last: last byte IOVA range
  */
 struct vhost_iotlb_map *
 vhost_iotlb_itree_next(struct vhost_iotlb_map *map, u64 start, u64 last)
-- 
2.26.0

