Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7DA201569
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jun 2020 18:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405617AbgFSQV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jun 2020 12:21:58 -0400
Received: from winnie.ispras.ru ([83.149.199.91]:27582 "EHLO smtp.ispras.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2394520AbgFSQV4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 12:21:56 -0400
Received: from home.intra.ispras.ru (unknown [10.10.165.12])
        by smtp.ispras.ru (Postfix) with ESMTP id 16300203C1;
        Fri, 19 Jun 2020 19:21:53 +0300 (MSK)
From:   Evgeny Novikov <novikov@ispras.ru>
To:     Antonino Daplas <adaplas@gmail.com>
Cc:     Evgeny Novikov <novikov@ispras.ru>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
Subject: [PATCH] video: fbdev: savage: fix memory leak on error handling path in probe
Date:   Fri, 19 Jun 2020 19:21:36 +0300
Message-Id: <20200619162136.9010-1-novikov@ispras.ru>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

savagefb_probe() calls savage_init_fb_info() that can successfully
allocate memory for info->pixmap.addr but then fail when
fb_alloc_cmap() fails. savagefb_probe() goes to label failed_init and
does not free allocated memory. It is not valid to go to label
failed_mmio since savage_init_fb_info() can fail during memory
allocation as well. So, the patch free allocated memory on the error
handling path in savage_init_fb_info() itself.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Evgeny Novikov <novikov@ispras.ru>
---
 drivers/video/fbdev/savage/savagefb_driver.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/fbdev/savage/savagefb_driver.c b/drivers/video/fbdev/savage/savagefb_driver.c
index 3c8ae87f0ea7..3fd87aeb6c79 100644
--- a/drivers/video/fbdev/savage/savagefb_driver.c
+++ b/drivers/video/fbdev/savage/savagefb_driver.c
@@ -2157,6 +2157,8 @@ static int savage_init_fb_info(struct fb_info *info, struct pci_dev *dev,
 			info->flags |= FBINFO_HWACCEL_COPYAREA |
 				       FBINFO_HWACCEL_FILLRECT |
 				       FBINFO_HWACCEL_IMAGEBLIT;
+		else
+			kfree(info->pixmap.addr);
 	}
 #endif
 	return err;
-- 
2.16.4

