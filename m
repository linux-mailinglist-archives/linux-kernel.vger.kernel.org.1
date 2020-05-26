Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F19211BD77B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Apr 2020 10:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgD2IpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Apr 2020 04:45:13 -0400
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:48392 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbgD2IpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 04:45:13 -0400
Received: from localhost.localdomain ([92.148.159.11])
        by mwinf5d03 with ME
        id YYl72200G0F2omL03Yl75P; Wed, 29 Apr 2020 10:45:11 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 29 Apr 2020 10:45:11 +0200
X-ME-IP: 92.148.159.11
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     b.zolnierkie@samsung.com, sumit.semwal@linaro.org,
        rafael.j.wysocki@intel.com, corbet@lwn.net,
        viresh.kumar@linaro.org, jani.nikula@intel.com,
        mchehab+samsung@kernel.org, eric.miao@marvell.com
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] video: pxafb: Fix the function used to balance a 'dma_alloc_coherent()' call
Date:   Wed, 29 Apr 2020 10:45:05 +0200
Message-Id: <20200429084505.108897-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'dma_alloc_coherent()' must be balanced by a call to 'dma_free_coherent()'
not 'dma_free_wc()'.
The correct dma_free_ function is already used in the error handling path
of the probe function.

Fixes: 77e196752bdd ("[ARM] pxafb: allow video memory size to be configurable")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/video/fbdev/pxafb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/pxafb.c b/drivers/video/fbdev/pxafb.c
index 00b96a78676e..6f972bed410a 100644
--- a/drivers/video/fbdev/pxafb.c
+++ b/drivers/video/fbdev/pxafb.c
@@ -2417,8 +2417,8 @@ static int pxafb_remove(struct platform_device *dev)
 
 	free_pages_exact(fbi->video_mem, fbi->video_mem_size);
 
-	dma_free_wc(&dev->dev, fbi->dma_buff_size, fbi->dma_buff,
-		    fbi->dma_buff_phys);
+	dma_free_coherent(&dev->dev, fbi->dma_buff_size, fbi->dma_buff,
+			  fbi->dma_buff_phys);
 
 	return 0;
 }
-- 
2.25.1

