Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3781F67DA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jun 2020 14:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbgFKMaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jun 2020 08:30:13 -0400
Received: from m17617.mail.qiye.163.com ([59.111.176.17]:5184 "EHLO
        m17617.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbgFKMaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 08:30:12 -0400
X-Greylist: delayed 409 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Jun 2020 08:30:11 EDT
Received: from njvxl5505.vivo.xyz (unknown [157.0.31.125])
        by m17617.mail.qiye.163.com (Hmail) with ESMTPA id 1C94826190E;
        Thu, 11 Jun 2020 20:23:20 +0800 (CST)
From:   Bernard Zhao <bernard@vivo.com>
To:     Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Bernard Zhao <bernard@vivo.com>
Subject: [PATCH] drm/mxsfb: miss err handle in probe
Date:   Thu, 11 Jun 2020 20:23:11 +0800
Message-Id: <20200611122311.20847-1-bernard@vivo.com>
X-Mailer: git-send-email 2.17.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZTx8ZQkwZHklPGE4ZVkpOQkpDTENJS0tISElVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVKS0tZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MCI6Hio*GjgzIxQqLEwcMFZN
        AjUKFCpVSlVKTkJKQ0xDSUtLTE5MVTMWGhIXVRkeCRUaCR87DRINFFUYFBZFWVdZEgtZQVlKTkxV
        S1VISlVKSU5ZV1kIAVlBSUlLQjcG
X-HM-Tid: 0a72a355abf49375kuws1c94826190e
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are three err return values in drm_fbdev_generic_setup.
In mxsfb_probe we called this function, but didn`t handle the
return value, this change is to add err handle, maybe make code
a bit more readable.

Signed-off-by: Bernard Zhao <bernard@vivo.com>
---
 drivers/gpu/drm/mxsfb/mxsfb_drv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.c b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
index 497cf443a9af..a45f3b85f725 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
@@ -415,7 +415,9 @@ static int mxsfb_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_unload;
 
-	drm_fbdev_generic_setup(drm, 32);
+	ret = drm_fbdev_generic_setup(drm, 32);
+	if (ret)
+		goto err_unload;
 
 	return 0;
 
-- 
2.17.1

