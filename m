Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A10D62128F9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jul 2020 18:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbgGBQFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jul 2020 12:05:45 -0400
Received: from winnie.ispras.ru ([83.149.199.91]:16121 "EHLO smtp.ispras.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726119AbgGBQFp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 12:05:45 -0400
Received: from home.intra.ispras.ru (unknown [10.10.165.12])
        by smtp.ispras.ru (Postfix) with ESMTP id C2875201D0;
        Thu,  2 Jul 2020 19:05:41 +0300 (MSK)
From:   Evgeny Novikov <novikov@ispras.ru>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Evgeny Novikov <novikov@ispras.ru>, Sekhar Nori <nsekhar@ti.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jani Nikula <jani.nikula@intel.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
Subject: [PATCH] fbdev: da8xx-fb: go to proper label on error handling paths in probe
Date:   Thu,  2 Jul 2020 19:05:40 +0300
Message-Id: <20200702160540.24546-1-novikov@ispras.ru>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fb_probe() can successfully allocate a new frame buffer, but then fail
to perform some operations with regulator. In these cases fb_probe()
goes to label err_pm_runtime_disable where the frame buffer is not
released. The patch makes fb_probe() to go to label err_release_fb on
corresponding error handling paths.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Evgeny Novikov <novikov@ispras.ru>
---
 drivers/video/fbdev/da8xx-fb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/da8xx-fb.c b/drivers/video/fbdev/da8xx-fb.c
index 73c3c4c8cc12..e38c0e3f9c61 100644
--- a/drivers/video/fbdev/da8xx-fb.c
+++ b/drivers/video/fbdev/da8xx-fb.c
@@ -1402,14 +1402,14 @@ static int fb_probe(struct platform_device *device)
 	if (IS_ERR(par->lcd_supply)) {
 		if (PTR_ERR(par->lcd_supply) == -EPROBE_DEFER) {
 			ret = -EPROBE_DEFER;
-			goto err_pm_runtime_disable;
+			goto err_release_fb;
 		}
 
 		par->lcd_supply = NULL;
 	} else {
 		ret = regulator_enable(par->lcd_supply);
 		if (ret)
-			goto err_pm_runtime_disable;
+			goto err_release_fb;
 	}
 
 	fb_videomode_to_var(&da8xx_fb_var, lcdc_info);
-- 
2.16.4

