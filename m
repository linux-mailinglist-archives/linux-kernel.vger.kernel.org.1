Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3572713FF
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Sep 2020 13:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgITLih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 07:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbgITLih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 07:38:37 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBAD7C061755
        for <linux-kernel@vger.kernel.org>; Sun, 20 Sep 2020 04:38:36 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id o25so1427870pgm.0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Sep 2020 04:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ANleZeOYhNX2PwcGe2hR4y8/iDJy+Siy+8LNKjoAFWM=;
        b=TDYwtJdoXExlobJAwY1B1EwfjhYRYAljmbB7f+aSrKc/M+z6ArjPGi7u6bjxJF+bkQ
         WRgxcXRUiGHhZo8mghxgAUIQ1bX3qEAG3asMhsPr4Y1oMH66zsA9N3nmtaXfOnEKgDvE
         TAgfMZOAkgD2cjcaqxjj+y4gW3a7PWwZPyeyz51JILuKb+w33xX2NqplnB4K52IiGAab
         pMDGmsibuZ+goC8Hcdp+cxfpxZNYEoMjOOOynPuTRzbOz6LeqRN4ETxRjlW/Ge1c3qNU
         SASm7pgKnLMVZgICreGQGQZy2o5yGuta5YZaFJgjRxzpBpslv5iGjy4xWlLekAiiPetg
         5/BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ANleZeOYhNX2PwcGe2hR4y8/iDJy+Siy+8LNKjoAFWM=;
        b=YylxUyH2O7qr71Lzc5p7T9G+BjsTkUc2HL3j6cvzN2W2oTw+l1/ltPRErsvmNVdzD2
         KbtRR5S4Si1jQAVj1fBxudWGf9wwf6q7M0/6j5LTuoTq9WKTlgnXewvdNVH2o067kNgw
         uy2rwSTNk/VJN+VjvXHOcfSHmuX8D2laPxVeXgg/bmA7NCRwpojdLLMAov6ajoGeBouR
         9eXdkCQU8uQ0LcjJNQ3Y9IHmYnbLt/OFAymGmIf4MINWzQY2XnWuZgOw2PjwyLgSo59V
         mLZmDo15nOtkeq5nopqjft9BVq7cfP0Z3pdLRieV04r+Dec3Yms8uiz2oN13tzScCxIC
         poZQ==
X-Gm-Message-State: AOAM531xTxe8OievA4cPmabrfPZ7RNmgL+zYuY26YLEbUOQWvEUMHEIQ
        Ey4AefGoSb4j2ZRdHMhtCzlZDKiEyugQqA==
X-Google-Smtp-Source: ABdhPJwakNs6Ce+sbgXL1qHBM/2PTjBFbBoIiwoJomVZs5eLEAIyG92+wXFgH5oirXSHxDMjrowgUQ==
X-Received: by 2002:a63:490d:: with SMTP id w13mr13064818pga.24.1600601916537;
        Sun, 20 Sep 2020 04:38:36 -0700 (PDT)
Received: from localhost.localdomain ([1.200.101.36])
        by smtp.gmail.com with ESMTPSA id y24sm9041702pfn.161.2020.09.20.04.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2020 04:38:35 -0700 (PDT)
From:   pierre Kuo <vichy.kuo@gmail.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, pierre Kuo <vichy.kuo@gmail.com>
Subject: [PATCH 2/2] driver core: platform: provide devm_platform_iounremap_resource
Date:   Sun, 20 Sep 2020 19:38:08 +0800
Message-Id: <20200920113808.22223-2-vichy.kuo@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200920113808.22223-1-vichy.kuo@gmail.com>
References: <20200920113808.22223-1-vichy.kuo@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Combine platform_get_resource() and devm_iounremap_resource() to release
the iomem allocated by devm_platform_get_and_ioremap_resource().

Signed-off-by: pierre Kuo <vichy.kuo@gmail.com>
---
 drivers/base/platform.c         | 24 ++++++++++++++++++++++++
 include/linux/platform_device.h |  4 ++++
 2 files changed, 28 insertions(+)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index e5d8a0503b4f..e2655c00873f 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -84,6 +84,30 @@ devm_platform_get_and_ioremap_resource(struct platform_device *pdev,
 }
 EXPORT_SYMBOL_GPL(devm_platform_get_and_ioremap_resource);
 
+/**
+ * devm_platform_iounremap_resource - call devm_iounremap_resource() for a
+ *				      platform device with memory that addr points to.
+ *
+ * @pdev: platform device to use both for memory resource lookup as well as
+ *        resource management
+ * @index: resource index
+ * @addr: address to be unmap.
+ */
+void
+devm_platform_iounremap_resource(struct platform_device *pdev,
+				 unsigned int index, void __iomem *addr)
+{
+	struct resource *r;
+
+	r = platform_get_resource(pdev, IORESOURCE_MEM, index);
+	if (!r)
+		dev_err(&pdev->dev,
+			"MEM resource index %d not found\n", index);
+	else
+		devm_iounremap_resource(&pdev->dev, r, addr);
+}
+EXPORT_SYMBOL_GPL(devm_platform_iounremap_resource);
+
 /**
  * devm_platform_ioremap_resource - call devm_ioremap_resource() for a platform
  *				    device
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 77a2aada106d..75da15937679 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -67,6 +67,10 @@ devm_platform_ioremap_resource_wc(struct platform_device *pdev,
 extern void __iomem *
 devm_platform_ioremap_resource_byname(struct platform_device *pdev,
 				      const char *name);
+extern void
+devm_platform_iounremap_resource(struct platform_device *pdev,
+				 unsigned int index,
+				 void __iomem *addr);
 extern int platform_get_irq(struct platform_device *, unsigned int);
 extern int platform_get_irq_optional(struct platform_device *, unsigned int);
 extern int platform_irq_count(struct platform_device *);
-- 
2.17.1

