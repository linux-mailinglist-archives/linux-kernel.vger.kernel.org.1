Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A69902CB445
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 06:17:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbgLBFRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 00:17:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbgLBFRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 00:17:18 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C2FC0613D4
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 21:16:38 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id o9so482280pfd.10
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 21:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GtGtPbg6S6XKVKh82wVhGzyfNnkNiglHRZS762Gp8h4=;
        b=yTpjg/5vPTATnfoFO0GOcxyy/yiYUUXJjKNzERHukSH6utLlTGRfyx+S6UzT+cjg/w
         dMsSOI1zz34tfE41k1LH54QkIrFch4/QcoSX9q8OjO+ZB2v6IYNlm9h/vZWTmSGwdsT9
         faB/m05s9Qd7W6/Yj19PbFZ6zjGW7M8YZf/uUg2moJK7CqACQcttFkT+sLX/R31RYMhF
         2AKsgEtIVsziuT7sP8wXy2wwhhBYQBCQ+noQ9hamWAQ5DWXuXxg9N/B2EZa4nuJbUQrE
         oqtAK+AplMNwesTPNluXQQQ4Ql03xXST8AI4a8pGLOWaS637KyHNBmddECETWDuxIrnO
         74Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GtGtPbg6S6XKVKh82wVhGzyfNnkNiglHRZS762Gp8h4=;
        b=ZeMpTI+vRVbQ/FV9rq+XJc6oM/5OMV/U3/oucVB3aRZNERnDKRAg2ou4IZyxzdGCCR
         nHDlMIp3qNcCmEDIu/tjU6Z1Vk3Cb6N7smc3kvvJgBn0xdJpTZ8KiyVVkYGEjwBLFQFF
         YhJ/KAM5KwQn5MLhFernk7C4NA2a27slHDxqUBeCHY3Z8wCV5Y6whBZlm0rY++e/9Inx
         gy1wAOe0Re0h8HMgVLVUKotsjTlQBUKYrLq4XJYSANdodQcW1xbO9Gsw+Ybn99qDBQ5H
         Z+KN43Wpd2Evf3lzJIVzngHCOurXKFF0HXqBqADDTeyJ1HxHTFTn707KpR0mVErJKOQP
         WK4A==
X-Gm-Message-State: AOAM531dVYE37OzieTJY/YeD3tdXDW+7z9xQG8sA6A6Vyg93XdisBA2R
        xP0iw3+ynnmO0bC9RHnfznTf6g==
X-Google-Smtp-Source: ABdhPJyH6g/iSiIYweoziem2Du7RUZljIo6zCrG1kBxujGXUB4xR1hWqzfOw+ZznapK4sq/NdHd3bw==
X-Received: by 2002:a63:d45:: with SMTP id 5mr1154561pgn.0.1606886198037;
        Tue, 01 Dec 2020 21:16:38 -0800 (PST)
Received: from localhost ([61.120.150.72])
        by smtp.gmail.com with ESMTPSA id d4sm457523pjz.28.2020.12.01.21.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 21:16:37 -0800 (PST)
From:   John Wang <wangzhiqiang.bj@bytedance.com>
To:     xuxiaohan@bytedance.com, yulei.sh@bytedance.com
Cc:     Jae Hyun Yoo <jae.hyun.yoo@intel.com>,
        Vernon Mauery <vernon.mauery@linux.intel.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/ASPEED MACHINE
        SUPPORT),
        linux-aspeed@lists.ozlabs.org (moderated list:ARM/ASPEED MACHINE
        SUPPORT), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] misc: Add clock control logic into Aspeed LPC SNOOP driver
Date:   Wed,  2 Dec 2020 13:16:33 +0800
Message-Id: <20201202051634.490-1-wangzhiqiang.bj@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jae Hyun Yoo <jae.hyun.yoo@intel.com>

If LPC SNOOP driver is registered ahead of lpc-ctrl module, LPC
SNOOP block will be enabled without heart beating of LCLK until
lpc-ctrl enables the LCLK. This issue causes improper handling on
host interrupts when the host sends interrupt in that time frame.
Then kernel eventually forcibly disables the interrupt with
dumping stack and printing a 'nobody cared this irq' message out.

To prevent this issue, all LPC sub-nodes should enable LCLK
individually so this patch adds clock control logic into the LPC
SNOOP driver.

Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@intel.com>
Signed-off-by: Vernon Mauery <vernon.mauery@linux.intel.com>
Signed-off-by: John Wang <wangzhiqiang.bj@bytedance.com>
---
 drivers/soc/aspeed/aspeed-lpc-snoop.c | 30 ++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/aspeed/aspeed-lpc-snoop.c b/drivers/soc/aspeed/aspeed-lpc-snoop.c
index 682ba0eb4eba..20acac6342ef 100644
--- a/drivers/soc/aspeed/aspeed-lpc-snoop.c
+++ b/drivers/soc/aspeed/aspeed-lpc-snoop.c
@@ -11,6 +11,7 @@
  */
 
 #include <linux/bitops.h>
+#include <linux/clk.h>
 #include <linux/interrupt.h>
 #include <linux/fs.h>
 #include <linux/kfifo.h>
@@ -67,6 +68,7 @@ struct aspeed_lpc_snoop_channel {
 struct aspeed_lpc_snoop {
 	struct regmap		*regmap;
 	int			irq;
+	struct clk		*clk;
 	struct aspeed_lpc_snoop_channel chan[NUM_SNOOP_CHANNELS];
 };
 
@@ -282,22 +284,42 @@ static int aspeed_lpc_snoop_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	lpc_snoop->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(lpc_snoop->clk)) {
+		rc = PTR_ERR(lpc_snoop->clk);
+		if (rc != -EPROBE_DEFER)
+			dev_err(dev, "couldn't get clock\n");
+		return rc;
+	}
+	rc = clk_prepare_enable(lpc_snoop->clk);
+	if (rc) {
+		dev_err(dev, "couldn't enable clock\n");
+		return rc;
+	}
+
 	rc = aspeed_lpc_snoop_config_irq(lpc_snoop, pdev);
 	if (rc)
-		return rc;
+		goto err;
 
 	rc = aspeed_lpc_enable_snoop(lpc_snoop, dev, 0, port);
 	if (rc)
-		return rc;
+		goto err;
 
 	/* Configuration of 2nd snoop channel port is optional */
 	if (of_property_read_u32_index(dev->of_node, "snoop-ports",
 				       1, &port) == 0) {
 		rc = aspeed_lpc_enable_snoop(lpc_snoop, dev, 1, port);
-		if (rc)
+		if (rc) {
 			aspeed_lpc_disable_snoop(lpc_snoop, 0);
+			goto err;
+		}
 	}
 
+	return 0;
+
+err:
+	clk_disable_unprepare(lpc_snoop->clk);
+
 	return rc;
 }
 
@@ -309,6 +331,8 @@ static int aspeed_lpc_snoop_remove(struct platform_device *pdev)
 	aspeed_lpc_disable_snoop(lpc_snoop, 0);
 	aspeed_lpc_disable_snoop(lpc_snoop, 1);
 
+	clk_disable_unprepare(lpc_snoop->clk);
+
 	return 0;
 }
 
-- 
2.25.1

