Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41B1B2B8C62
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 08:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726123AbgKSHaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 02:30:10 -0500
Received: from m17618.mail.qiye.163.com ([59.111.176.18]:56879 "EHLO
        m17618.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbgKSHaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 02:30:10 -0500
Received: from ubuntu.localdomain (unknown [157.0.31.125])
        by m17618.mail.qiye.163.com (Hmail) with ESMTPA id C68FB4E17D8;
        Thu, 19 Nov 2020 15:30:05 +0800 (CST)
From:   Bernard Zhao <bernard@vivo.com>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Bernard Zhao <bernard@vivo.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com
Subject: [PATCH] via/via_irq: use __func__ to replace string function name
Date:   Wed, 18 Nov 2020 23:29:55 -0800
Message-Id: <20201119072957.108941-1-bernard@vivo.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZHhlJHUxJQhlDQ0hNVkpNS05MTEpLS05CQ0lVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS09ISFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NDo6OQw6Sz8tPw0xPkg2Vk8q
        ThMwFENVSlVKTUtOTExKS0tNSEJKVTMWGhIXVRkeCRUaCR87DRINFFUYFBZFWVdZEgtZQVlKTkxV
        S1VISlVKSU5ZV1kIAVlBSkxITjcG
X-HM-Tid: 0a75df690fd89376kuwsc68fb4e17d8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change also fix checkpatch.pl warning:
WARNING: Prefer using '"%s...", __func__' to using
'via_driver_irq_postinstall', this function's name, in a string
+	DRM_DEBUG("via_driver_irq_postinstall\n");

Signed-off-by: Bernard Zhao <bernard@vivo.com>
---
 drivers/gpu/drm/via/via_irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/via/via_irq.c b/drivers/gpu/drm/via/via_irq.c
index 24cc445169e2..56ce5d4ee24a 100644
--- a/drivers/gpu/drm/via/via_irq.c
+++ b/drivers/gpu/drm/via/via_irq.c
@@ -308,7 +308,7 @@ int via_driver_irq_postinstall(struct drm_device *dev)
 	drm_via_private_t *dev_priv = (drm_via_private_t *) dev->dev_private;
 	u32 status;
 
-	DRM_DEBUG("via_driver_irq_postinstall\n");
+	DRM_DEBUG("fun: %s\n", __func__);
 	if (!dev_priv)
 		return -EINVAL;
 
-- 
2.29.0

