Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A00319C00F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Apr 2020 13:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388091AbgDBLUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Apr 2020 07:20:48 -0400
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:51843 "EHLO
        cmccmta3.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728803AbgDBLUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 07:20:48 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.17]) by rmmx-syy-dmz-app11-12011 (RichMail) with SMTP id 2eeb5e85ca68e3a-5df00; Thu, 02 Apr 2020 19:20:08 +0800 (CST)
X-RM-TRANSID: 2eeb5e85ca68e3a-5df00
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.25.154.146])
        by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee95e85ca66ca8-bc65c;
        Thu, 02 Apr 2020 19:20:08 +0800 (CST)
X-RM-TRANSID: 2ee95e85ca66ca8-bc65c
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     perex@perex.cz, tiwai@suse.com, nicolas.ferre@microchip.com
Cc:     alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>
Subject: [PATCH] ALSA:atmel:Use platform_get_irq_optional()
Date:   Thu,  2 Apr 2020 19:21:35 +0800
Message-Id: <20200402112135.18604-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to simply code,because platform_get_irq() already has
dev_err() message.

Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 sound/atmel/ac97c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/atmel/ac97c.c b/sound/atmel/ac97c.c
index a1dce9725..25cfd5710 100644
--- a/sound/atmel/ac97c.c
+++ b/sound/atmel/ac97c.c
@@ -715,7 +715,7 @@ static int atmel_ac97c_probe(struct platform_device *pdev)
 		return -ENXIO;
 	}
 
-	irq = platform_get_irq(pdev, 0);
+	irq = platform_get_irq_optional(pdev, 0);
 	if (irq < 0) {
 		dev_dbg(&pdev->dev, "could not get irq: %d\n", irq);
 		return irq;
-- 
2.20.1.windows.1



