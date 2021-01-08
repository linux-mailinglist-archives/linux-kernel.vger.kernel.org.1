Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 433A42EF12B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 12:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727934AbhAHLR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 06:17:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbhAHLR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 06:17:57 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 058E7C0612F9
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 03:17:17 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id l23so5980566pjg.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 03:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=60IPrgLP9DNyIjeE8/ep+aH89e2lCgfu8wXdZP7pVsY=;
        b=bJK34TK+e6uLhDhDCKnWY5gOlkRXQMlfdm8EJ9bZg+e9qmHslagjZpm4Iu9zlolDb4
         D/aj6/cXx4tl9b04libafiNE3cSW7KxIqt4ciM7bPhqEEJDNJoFx/MvJsLCE6V+CnUg7
         fYBvDQKLLW6mXh7W0q37yC2tnVX8A/LLY/4aC3V8cvkA0H9GH5m0lEJ5UvHhaAhTSJy8
         P1SWhUaC9IbdUrkcmsdbOlZR5zcAAvbt25lJ+aXYQGaofD6Lat4vQv8fhnuPArwFmka1
         kuQmgllZAQ1lthpGgMg9FnjCnuOEUtB2VDUJsaDPCFlIqH6bz/Qbntyrg1vZojuJvCJ0
         8swQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=60IPrgLP9DNyIjeE8/ep+aH89e2lCgfu8wXdZP7pVsY=;
        b=RLHzj+BeYVD9+LxffbD3W2E6rPuyDQgNBS5h2qp7+D4SKdNk3CaFzXMPvhpwx/q3Pk
         XIuQmsHqYgHYCU5EPMFTS2Ys9dbCQ/oU25PGTe/jBj/cIfB0L4d0aAT78J9YhuGDqJRO
         8rAfvNa8RkPBARBXNX4PMOjszBCjIRkDeubV7gUcZYWdKX0WuxxmFnB+N08LpqvotOQ2
         yb143hsZKBlSy4AARt7MSXXc3pxCdwkLawjAfHI73tf6r9fPtkSRAXz4Ki9dF1G9/qE+
         9U8FeVRFrEzdUsuidoXB2KmIXkB6A2KEziwjtwsIf6CkaQw/d26homzyw7T2EQh519Op
         3jnw==
X-Gm-Message-State: AOAM531rBc7aBDWlNUCxkQA4ZTDnjwg6iwtJo08ddvywilQmJpuKNZaa
        rTRc9ixZ8XU46O7/BtHAF2BC6A==
X-Google-Smtp-Source: ABdhPJzMsoD7L+O53FGc9pbfts+/b7aVNLzW1qlK6R6WWWeSftPvEiks/rUiDbH12s+IpFWTjFMVcw==
X-Received: by 2002:a17:90a:fb8a:: with SMTP id cp10mr3224054pjb.136.1610104636600;
        Fri, 08 Jan 2021 03:17:16 -0800 (PST)
Received: from always-libai.bytedance.net ([61.120.150.71])
        by smtp.gmail.com with ESMTPSA id x23sm10504011pge.47.2021.01.08.03.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 03:17:16 -0800 (PST)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     pbonzini@redhat.com, linux-kernel@vger.kernel.org,
        pizhenwei@bytedance.com
Subject: [PATCH v2] misc: pvpanic: introduce device capability
Date:   Fri,  8 Jan 2021 19:17:10 +0800
Message-Id: <20210108111710.2665279-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to pvpanic spec:
https://git.qemu.org/?p=qemu.git;a=blob_plain;f=docs/specs/pvpanic.txt

The guest should determine pvpanic capability by RDPT, so initialize
capability during device probing. There is no need to register panic
notifier callback function if no events supported.

Before sending event to host side, check capability firstly.
Suggested by Paolo, export capability of pvpanic device by read-only
module parameter.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 drivers/misc/pvpanic.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/pvpanic.c b/drivers/misc/pvpanic.c
index 951b37da5e3c..c55a9d2fd001 100644
--- a/drivers/misc/pvpanic.c
+++ b/drivers/misc/pvpanic.c
@@ -19,6 +19,9 @@
 #include <uapi/misc/pvpanic.h>
 
 static void __iomem *base;
+static unsigned int capability = PVPANIC_PANICKED | PVPANIC_CRASH_LOADED;
+module_param(capability, uint, 0444);
+MODULE_PARM_DESC(capability, "capability of pvpanic device");
 
 MODULE_AUTHOR("Hu Tao <hutao@cn.fujitsu.com>");
 MODULE_DESCRIPTION("pvpanic device driver");
@@ -27,7 +30,8 @@ MODULE_LICENSE("GPL");
 static void
 pvpanic_send_event(unsigned int event)
 {
-	iowrite8(event, base);
+	if (event & capability)
+		iowrite8(event, base);
 }
 
 static int
@@ -62,8 +66,12 @@ static int pvpanic_mmio_probe(struct platform_device *pdev)
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-	atomic_notifier_chain_register(&panic_notifier_list,
-				       &pvpanic_panic_nb);
+	/* initlize capability by RDPT */
+	capability &= ioread8(base);
+
+	if (capability)
+		atomic_notifier_chain_register(&panic_notifier_list,
+					       &pvpanic_panic_nb);
 
 	return 0;
 }
@@ -71,8 +79,9 @@ static int pvpanic_mmio_probe(struct platform_device *pdev)
 static int pvpanic_mmio_remove(struct platform_device *pdev)
 {
 
-	atomic_notifier_chain_unregister(&panic_notifier_list,
-					 &pvpanic_panic_nb);
+	if (capability)
+		atomic_notifier_chain_unregister(&panic_notifier_list,
+						 &pvpanic_panic_nb);
 
 	return 0;
 }
-- 
2.25.1

