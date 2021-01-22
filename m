Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5E530066E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 16:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728780AbhAVPBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 10:01:36 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:44633 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728985AbhAVOxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 09:53:20 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1l2xnf-0007DK-8A; Fri, 22 Jan 2021 14:52:35 +0000
From:   Colin King <colin.king@canonical.com>
To:     "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Parav Pandit <parav@nvidia.com>, Eli Cohen <elic@nvidia.com>,
        virtualization@lists.linux-foundation.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] vpda: Fix memory leaks of msg on error return paths
Date:   Fri, 22 Jan 2021 14:52:35 +0000
Message-Id: <20210122145235.209121-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are two error return paths that neglect to free the allocated
object msg that lead to memory leaks. Fix this by adding an error
exit path that frees msg.

Addresses-Coverity: ("Resource leak")
Fixes: 39502d042a70 ("vdpa: Enable user to query vdpa device info")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/vdpa/vdpa.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index 9700a0adcca0..eb1f5a514103 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -540,13 +540,15 @@ static int vdpa_nl_cmd_dev_get_doit(struct sk_buff *skb, struct genl_info *info)
 	if (!dev) {
 		mutex_unlock(&vdpa_dev_mutex);
 		NL_SET_ERR_MSG_MOD(info->extack, "device not found");
-		return -ENODEV;
+		err = -ENODEV;
+		goto err;
 	}
 	vdev = container_of(dev, struct vdpa_device, dev);
 	if (!vdev->mdev) {
 		mutex_unlock(&vdpa_dev_mutex);
 		put_device(dev);
-		return -EINVAL;
+		err = -EINVAL;
+		goto err;
 	}
 	err = vdpa_dev_fill(vdev, msg, info->snd_portid, info->snd_seq, 0, info->extack);
 	if (!err)
@@ -554,6 +556,7 @@ static int vdpa_nl_cmd_dev_get_doit(struct sk_buff *skb, struct genl_info *info)
 	put_device(dev);
 	mutex_unlock(&vdpa_dev_mutex);
 
+err:
 	if (err)
 		nlmsg_free(msg);
 	return err;
-- 
2.29.2

