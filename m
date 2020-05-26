Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDA641AEB8C
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Apr 2020 12:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725950AbgDRKBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Apr 2020 06:01:33 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:49501 "EHLO
        cmccmta2.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbgDRKBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 06:01:32 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.1]) by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee65e9acfe6ae8-acb89; Sat, 18 Apr 2020 18:01:13 +0800 (CST)
X-RM-TRANSID: 2ee65e9acfe6ae8-acb89
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.1.172.61])
        by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee15e9acfe69d5-6ed96;
        Sat, 18 Apr 2020 18:01:12 +0800 (CST)
X-RM-TRANSID: 2ee15e9acfe69d5-6ed96
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     l.stach@pengutronix.de, linux+etnaviv@armlinux.org.uk,
        christian.gmeiner@gmail.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>
Subject: [PATCH] drm/etnaviv: Omit superfluous error message in etnaviv_gpu_platform_probe()
Date:   Sat, 18 Apr 2020 18:02:48 +0800
Message-Id: <20200418100248.4552-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the function etnaviv_gpu_platform_probe(), when get irq failed,
the function platform_get_irq() logs an error message, so remove
redundant message here.

Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
index a31eeff2b..6dbe0c45b 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
@@ -1770,10 +1770,8 @@ static int etnaviv_gpu_platform_probe(struct platform_device *pdev)
 
 	/* Get Interrupt: */
 	gpu->irq = platform_get_irq(pdev, 0);
-	if (gpu->irq < 0) {
-		dev_err(dev, "failed to get irq: %d\n", gpu->irq);
+	if (gpu->irq < 0)
 		return gpu->irq;
-	}
 
 	err = devm_request_irq(&pdev->dev, gpu->irq, irq_handler, 0,
 			       dev_name(gpu->dev), gpu);
-- 
2.20.1.windows.1



