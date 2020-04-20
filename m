Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BBFB1B0CBF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Apr 2020 15:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbgDTNff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Apr 2020 09:35:35 -0400
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:10707 "EHLO
        cmccmta3.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgDTNfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 09:35:34 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.7]) by rmmx-syy-dmz-app11-12011 (RichMail) with SMTP id 2eeb5e9da511745-d6a09; Mon, 20 Apr 2020 21:35:15 +0800 (CST)
X-RM-TRANSID: 2eeb5e9da511745-d6a09
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.1.173.179])
        by rmsmtp-syy-appsvr04-12004 (RichMail) with SMTP id 2ee45e9da5102c1-7b0dc;
        Mon, 20 Apr 2020 21:35:14 +0800 (CST)
X-RM-TRANSID: 2ee45e9da5102c1-7b0dc
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     ssantosh@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>
Subject: [PATCH] memory: emif: omit superfluous error message in emif_probe()
Date:   Mon, 20 Apr 2020 21:37:04 +0800
Message-Id: <20200420133704.18364-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the function emif_probe(), when get irq failed,
the function platform_get_irq() logs an error message,
so remove redundant message here.

Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 drivers/memory/emif.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/memory/emif.c b/drivers/memory/emif.c
index 9d9127bf2..3ac9f355d 100644
--- a/drivers/memory/emif.c
+++ b/drivers/memory/emif.c
@@ -1563,11 +1563,8 @@ static int __init_or_module emif_probe(struct platform_device *pdev)
 		goto error;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(emif->dev, "%s: error getting IRQ resource - %d\n",
-			__func__, irq);
+	if (irq < 0)
 		goto error;
-	}
 
 	emif_onetime_settings(emif);
 	emif_debugfs_init(emif);
-- 
2.20.1.windows.1



