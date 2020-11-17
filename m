Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C30052B5797
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 04:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727475AbgKQC7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 21:59:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726854AbgKQCzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 21:55:39 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A08DC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 18:55:39 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id c137so6775615ybf.21
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 18:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=vsK84Ng+Z4z4Uq7LdUN/Nr2gJYEHbnenP5+by4dnRzk=;
        b=qSrzyW9nLdh9bU+bPUOYF/5Q4aN8fANryQkOSHHLcw2ofOoVR+SwnF0ipnFzRphAXP
         UGT4Qc8ABYEZ+uxjoqDP2vY/w8JXHr5qC6TQM/F+ZqdsHSE6qmHpTJjnwHIgT+b3K3c1
         EgH5uycjdZIfX77aTSSPgRTi3KwNogNoJcO7uJB3IhbIvSLQEXsltgNL2p1sGHXzSu8o
         Ma2wRIyH1566PrAyVkFgU2cNspRg5y3a9ZRQa2oSa4xuNZd3og//5wln7vz9qyxyqOjm
         TaMqPy/hvRNSj7z3Whn7YE7FnLXNWLo1sW9eGHzmJPVDTyaY44w+INn0pegKoUU1jwKd
         wSAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=vsK84Ng+Z4z4Uq7LdUN/Nr2gJYEHbnenP5+by4dnRzk=;
        b=b/d4Ldq/ZhqeT1FUUOR7Lo3TLyYjyAsJEzA9j/9Ee2lCtC9ktIIuBwWumXxNdzEf2q
         QbfxnKE1qWgWMoax+6cTc+QJ1r3adHH+Hz3X4l4coAabiW2rk/USnKwys5aBrMaWqVvM
         xqfH32qfnoY01WjrPrRnB4iietvq9G+2Q2Z+mcW2p/DY1pBS3rFvVyo/HGeFEkUwn3bO
         tSzT7fyuM0igEnae23mhLVK3mrzblBBinKWv+kG/xbD224rkWI6GemjvrOYiUXSOjKN5
         ZcK3uYXixgh1SE3Or5GmAEsFpibbg8tKk0oMn0EgbQM3VoXkJeZnirF/AJaTsJg+IhNt
         IgBQ==
X-Gm-Message-State: AOAM532yPiDVg4LyPffTjkeH+4tb8ezGL0yXi8CE7+J22DBCBq+ZXLe7
        rdD1CJX/ZCbDyNBuj7TCYfp4W+0+
X-Google-Smtp-Source: ABdhPJxq7FoafmMJ37cwrScaa9fL85uvDt3+7HUyrD5C7ncM4/DsdLAS/c4Pezj14hOhYyGIveghQXhb
Sender: "rkir via sendgmr" <rkir@rkir.kir.corp.google.com>
X-Received: from rkir.kir.corp.google.com ([2620:15c:29:200:3e52:82ff:fe5f:f95])
 (user=rkir job=sendgmr) by 2002:a25:a86:: with SMTP id 128mr21027336ybk.370.1605581738797;
 Mon, 16 Nov 2020 18:55:38 -0800 (PST)
Date:   Mon, 16 Nov 2020 18:55:22 -0800
Message-Id: <20201117025522.1874864-1-rkir@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [PATCH] arch: x86: platform: retire arch/x86/platform/goldfish
From:   rkir@google.com
To:     dvhart@infradead.org, andy@infradead.org
Cc:     linux-kernel@vger.kernel.org, lfy@google.com,
        Roman Kiryanov <rkir@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Kiryanov <rkir@google.com>

The Android Studio Emulator (aka goldfish) does not
use arch/x86/platform/goldfish since 5.4 kernel.

Signed-off-by: Roman Kiryanov <rkir@google.com>
---
 arch/x86/platform/Makefile            |  1 -
 arch/x86/platform/goldfish/Makefile   |  2 -
 arch/x86/platform/goldfish/goldfish.c | 54 ---------------------------
 3 files changed, 57 deletions(-)
 delete mode 100644 arch/x86/platform/goldfish/Makefile
 delete mode 100644 arch/x86/platform/goldfish/goldfish.c

diff --git a/arch/x86/platform/Makefile b/arch/x86/platform/Makefile
index d0e835470d01..b2f90a1a89f1 100644
--- a/arch/x86/platform/Makefile
+++ b/arch/x86/platform/Makefile
@@ -4,7 +4,6 @@ obj-y	+= atom/
 obj-y	+= ce4100/
 obj-y	+= efi/
 obj-y	+= geode/
-obj-y	+= goldfish/
 obj-y	+= iris/
 obj-y	+= intel/
 obj-y	+= intel-mid/
diff --git a/arch/x86/platform/goldfish/Makefile b/arch/x86/platform/goldfish/Makefile
deleted file mode 100644
index 072c395379ac..000000000000
--- a/arch/x86/platform/goldfish/Makefile
+++ /dev/null
@@ -1,2 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-obj-$(CONFIG_GOLDFISH)	+= goldfish.o
diff --git a/arch/x86/platform/goldfish/goldfish.c b/arch/x86/platform/goldfish/goldfish.c
deleted file mode 100644
index 6b6f8b4360dd..000000000000
--- a/arch/x86/platform/goldfish/goldfish.c
+++ /dev/null
@@ -1,54 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright (C) 2007 Google, Inc.
- * Copyright (C) 2011 Intel, Inc.
- * Copyright (C) 2013 Intel, Inc.
- */
-
-#include <linux/kernel.h>
-#include <linux/irq.h>
-#include <linux/platform_device.h>
-
-/*
- * Where in virtual device memory the IO devices (timers, system controllers
- * and so on)
- */
-
-#define GOLDFISH_PDEV_BUS_BASE	(0xff001000)
-#define GOLDFISH_PDEV_BUS_END	(0xff7fffff)
-#define GOLDFISH_PDEV_BUS_IRQ	(4)
-
-#define GOLDFISH_TTY_BASE	(0x2000)
-
-static struct resource goldfish_pdev_bus_resources[] = {
-	{
-		.start  = GOLDFISH_PDEV_BUS_BASE,
-		.end    = GOLDFISH_PDEV_BUS_END,
-		.flags  = IORESOURCE_MEM,
-	},
-	{
-		.start	= GOLDFISH_PDEV_BUS_IRQ,
-		.end	= GOLDFISH_PDEV_BUS_IRQ,
-		.flags	= IORESOURCE_IRQ,
-	}
-};
-
-static bool goldfish_enable __initdata;
-
-static int __init goldfish_setup(char *str)
-{
-	goldfish_enable = true;
-	return 0;
-}
-__setup("goldfish", goldfish_setup);
-
-static int __init goldfish_init(void)
-{
-	if (!goldfish_enable)
-		return -ENODEV;
-
-	platform_device_register_simple("goldfish_pdev_bus", -1,
-					goldfish_pdev_bus_resources, 2);
-	return 0;
-}
-device_initcall(goldfish_init);
-- 
2.29.2.299.gdc1121823c-goog

