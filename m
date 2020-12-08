Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3E32D2750
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 10:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728609AbgLHJSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 04:18:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgLHJSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 04:18:34 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD84C0613D6
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 01:17:54 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id b26so13340969pfi.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 01:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bCL72abh8RwsObGRTRo7uppPTyqxE0CC1s+FFsxo4Gg=;
        b=fg4koyxOioGekDoKsMY6yz1G6lyWSB/jYVaeMA0gg+MZylnvs+xLg7kXaBb0RH72wL
         //Wj9M193tOHo1TDD6dfoFUj/TV/x2gIhiq90Pz40uutrSIUqTAR3FtjwyjUr1dQnLdf
         ZOFEdTQLZYWyztsL6ZB2kDLiRAwphq1u+JJi+ESL2kXh/hvJnY+Sa80My2tNVAYtUBRL
         vE84hIoSr+HeTR1uDa2u7q+tBAzgy6N6oq36HvN9djE23/eKoXt0FG3q6lq+cZxc1ndq
         ieEE8uVhT48nRgpKOJ+TSGfX71JzgLCgfvP5k3c0rKQWaCkb/hnNUgCxZ8rHAtN/Ri/P
         JAsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bCL72abh8RwsObGRTRo7uppPTyqxE0CC1s+FFsxo4Gg=;
        b=FrfX9Dig+cVgykexuYbkZMTXOCWq69pGYqV6EnSp34aLeYqygjR24qYX/1Eafto2O8
         dihgg53RkEtWvdO+pG24Z+ky+/vOojIyIGxwGzj6oBWIalMa1zzY9oJnEypLuzQ32/yb
         SSZPkmEdeRFqSHhCHyGe6AmcTpiJbfKkzzArULpbf7IRJsjDvJkRidCwFJ/zIVacdEIz
         rVQlXlUCzJoWrsGt+PQVvuHZZZ1rZFLdjRGa3xmhSwsqVLAz7CQtjGjA7CCk2GA/fr9N
         5cr3DvjT6yXY5XdBHpdYCu7SxXGd0yG9bW6iF+knXzG5fIoSBWk0nw4x//uqTIK0Z0fP
         0nIA==
X-Gm-Message-State: AOAM531uOTWHUBBjt/gaDJ3+OA1y4tyCdyBcVBmCcKgv0K7R44WKy5HV
        83RTZ9DEibaqFIBXzlOvjEZHtg==
X-Google-Smtp-Source: ABdhPJxS1AxAvAht0AdTpuGZ1oYMyAx9+D6b38OJ6z2m146XBuq1py0oVaH8DU5HXECT1x4c9MqvSw==
X-Received: by 2002:a62:e901:0:b029:197:ca81:4bb9 with SMTP id j1-20020a62e9010000b0290197ca814bb9mr611916pfh.26.1607419073902;
        Tue, 08 Dec 2020 01:17:53 -0800 (PST)
Received: from localhost ([61.120.150.75])
        by smtp.gmail.com with ESMTPSA id 22sm2380816pjb.40.2020.12.08.01.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 01:17:53 -0800 (PST)
From:   John Wang <wangzhiqiang.bj@bytedance.com>
To:     xuxiaohan@bytedance.com, yulei.sh@bytedance.com
Cc:     Jae Hyun Yoo <jae.hyun.yoo@intel.com>,
        Vernon Mauery <vernon.mauery@linux.intel.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Patrick Venture <venture@google.com>,
        Robert Lippert <rlippert@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Benjamin Fair <benjaminfair@google.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/ASPEED MACHINE
        SUPPORT),
        linux-aspeed@lists.ozlabs.org (moderated list:ARM/ASPEED MACHINE
        SUPPORT), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 1/2] misc: Add clock control logic into Aspeed LPC SNOOP driver
Date:   Tue,  8 Dec 2020 17:17:47 +0800
Message-Id: <20201208091748.1920-1-wangzhiqiang.bj@bytedance.com>
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

Fixes: 3772e5da4454 ("drivers/misc: Aspeed LPC snoop output using misc
chardev")

Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@intel.com>
Signed-off-by: Vernon Mauery <vernon.mauery@linux.intel.com>
Signed-off-by: John Wang <wangzhiqiang.bj@bytedance.com>
---
v2:
  reword: Add fixes line
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

