Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22E7323BE1A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Aug 2020 18:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729956AbgHDQZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Aug 2020 12:25:13 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:43866 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729563AbgHDQU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 12:20:58 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from eli@mellanox.com)
        with SMTP; 4 Aug 2020 19:20:51 +0300
Received: from nps-server-21.mtl.labs.mlnx (nps-server-21.mtl.labs.mlnx [10.237.240.120])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 074GKpLO023990;
        Tue, 4 Aug 2020 19:20:51 +0300
Received: from nps-server-21.mtl.labs.mlnx (localhost [127.0.0.1])
        by nps-server-21.mtl.labs.mlnx (8.14.7/8.14.7) with ESMTP id 074GKpIx022634;
        Tue, 4 Aug 2020 19:20:51 +0300
Received: (from eli@localhost)
        by nps-server-21.mtl.labs.mlnx (8.14.7/8.14.7/Submit) id 074GKpvj022633;
        Tue, 4 Aug 2020 19:20:51 +0300
From:   Eli Cohen <eli@mellanox.com>
To:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     shahafs@mellanox.com, saeedm@mellanox.com, parav@mellanox.com
Subject: [PATCH V4 linux-next 01/12] vhost-vdpa: refine ioctl pre-processing
Date:   Tue,  4 Aug 2020 19:20:37 +0300
Message-Id: <20200804162048.22587-2-eli@mellanox.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200804162048.22587-1-eli@mellanox.com>
References: <20200804162048.22587-1-eli@mellanox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Wang <jasowang@redhat.com>

Switch to use 'switch' to make the codes more easier to be extended.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/vdpa.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 16e0ffb115be..563ae6204052 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -377,15 +377,16 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
 	idx = array_index_nospec(idx, v->nvqs);
 	vq = &v->vqs[idx];
 
-	if (cmd == VHOST_VDPA_SET_VRING_ENABLE) {
+	switch (cmd) {
+	case VHOST_VDPA_SET_VRING_ENABLE:
 		if (copy_from_user(&s, argp, sizeof(s)))
 			return -EFAULT;
 		ops->set_vq_ready(vdpa, idx, s.num);
 		return 0;
-	}
-
-	if (cmd == VHOST_GET_VRING_BASE)
+	case VHOST_GET_VRING_BASE:
 		vq->last_avail_idx = ops->get_vq_state(v->vdpa, idx);
+		break;
+	}
 
 	r = vhost_vring_ioctl(&v->vdev, cmd, argp);
 	if (r)
-- 
2.26.0

