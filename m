Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63DBA20FD1E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jun 2020 21:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728989AbgF3Ty7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jun 2020 15:54:59 -0400
Received: from winnie.ispras.ru ([83.149.199.91]:13904 "EHLO smtp.ispras.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728435AbgF3Ty4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 15:54:56 -0400
Received: from home.intra.ispras.ru (unknown [10.10.165.12])
        by smtp.ispras.ru (Postfix) with ESMTP id 7F98A201D0;
        Tue, 30 Jun 2020 22:54:53 +0300 (MSK)
From:   Evgeny Novikov <novikov@ispras.ru>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Evgeny Novikov <novikov@ispras.ru>,
        Jani Nikula <jani.nikula@intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Andrew Morton <akpm@linux-foundation.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
Subject: [PATCH] video: fbdev: neofb: fix memory leak in neo_scan_monitor()
Date:   Tue, 30 Jun 2020 22:54:51 +0300
Message-Id: <20200630195451.18675-1-novikov@ispras.ru>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

neofb_probe() calls neo_scan_monitor() that can successfully allocate a
memory for info->monspecs.modedb and proceed to case 0x03. There it does
not free the memory and returns -1. neofb_probe() goes to label
err_scan_monitor, thus, it does not free this memory through calling
fb_destroy_modedb() as well. We can not go to label err_init_hw since
neo_scan_monitor() can fail during memory allocation. So, the patch frees
the memory directly for case 0x03.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Evgeny Novikov <novikov@ispras.ru>
---
 drivers/video/fbdev/neofb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/neofb.c b/drivers/video/fbdev/neofb.c
index f5a676bfd67a..09a20d4ab35f 100644
--- a/drivers/video/fbdev/neofb.c
+++ b/drivers/video/fbdev/neofb.c
@@ -1819,6 +1819,7 @@ static int neo_scan_monitor(struct fb_info *info)
 #else
 		printk(KERN_ERR
 		       "neofb: Only 640x480, 800x600/480 and 1024x768 panels are currently supported\n");
+		kfree(info->monspecs.modedb);
 		return -1;
 #endif
 	default:
-- 
2.16.4

