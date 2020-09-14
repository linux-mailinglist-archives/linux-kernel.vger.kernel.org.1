Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6761126912C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 18:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbgINQEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 12:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbgINPq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 11:46:28 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 655EDC06121C
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 08:46:10 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id c18so146842wrm.9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 08:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FWCrXT3ic7H+Af6cTpxRpL0fw/Z0w8+0CYapT6XgXZU=;
        b=eh1+Yea2XxQSbKFYRW0h2lj8RW7m3xsGJw5fPiRKTwSRZKDJfKYZUReq2wFEJ8hREp
         9j6lgmNVXYZecYDsLI+0SsccB+5LMlUp5tCO0WceGQGlLQvhX+zZp5ZQNMbf6GbCi8z4
         IK8tUKbJhwVW+pGG/P2PTIVJvAfVWL/9G8qEFGs/yfLb/lm66PuRlSa9h7rHUoP/6rKr
         QLu2fS7bhJeaCVxOyOuYg1LIAgw+gZPrBT62XYLudh77+u2HFMRZohkLQHJht3jlKsLp
         I+DUgisc766PIwuQ9YCWJsSoHGMYDp5REek+vbL9Z52I9Fyww/KFrsCldjDLAUM/3dnm
         61PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FWCrXT3ic7H+Af6cTpxRpL0fw/Z0w8+0CYapT6XgXZU=;
        b=pCszXUEdizqM6BReibV5ERU1FYRL8cs9N6hfQfuEZ5YhQ9z8X6uld1id2lhdoynkzb
         /j8ec66L2RBT9ORbZsxeuW4NZVfAnjpHrRQAcaEiwfNwrfGvkSUQRuXg/+EJ0/AWO5uw
         B6ADGG7NDO85/1Z3GHkFTdc5lOpDEGwPKHG0pjYXF5ksgCfNMdMb4toyhBKTtruynGHf
         6olhgGGg0VfsG6d6rngVyGBPGvyaCzHn71/dUoY8FpQVgH+K0Zwz6+jgv+UMohFJbDLX
         jWZVMuLMBSHuJjURb9SNRtmi+7BOk/KIXA5sg+Jo9bdph/xgFmt4kCZB1vbmbQnsgVzy
         FIwA==
X-Gm-Message-State: AOAM532E0lYZQtD0rOmii7zAPQwdZc17gKBiOezyOlBvPbAH88s8fcXd
        kuOh19GABuf26mhT26Qcw6SWYg==
X-Google-Smtp-Source: ABdhPJy+HZ7AVqx1LVJRdx0N+IrTlRkl15KXkCMfRbI0MTq5mfEHn0fthqXdQhxP39k8TPWH3fWtLQ==
X-Received: by 2002:a5d:4591:: with SMTP id p17mr16427572wrq.408.1600098369081;
        Mon, 14 Sep 2020 08:46:09 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id l19sm19510448wmi.8.2020.09.14.08.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 08:46:08 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 05/14] rtc: rx8010: use tabs instead of spaces for code formatting
Date:   Mon, 14 Sep 2020 17:45:52 +0200
Message-Id: <20200914154601.32245-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200914154601.32245-1-brgl@bgdev.pl>
References: <20200914154601.32245-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The define values in this driver are close to their names and they are
separated by spaces. Use tabs instead and align all defines.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/rtc/rtc-rx8010.c | 58 ++++++++++++++++++++--------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/drivers/rtc/rtc-rx8010.c b/drivers/rtc/rtc-rx8010.c
index 153fa58f0365..51ac4fac8f19 100644
--- a/drivers/rtc/rtc-rx8010.c
+++ b/drivers/rtc/rtc-rx8010.c
@@ -13,40 +13,40 @@
 #include <linux/module.h>
 #include <linux/rtc.h>
 
-#define RX8010_SEC     0x10
-#define RX8010_MIN     0x11
-#define RX8010_HOUR    0x12
-#define RX8010_WDAY    0x13
-#define RX8010_MDAY    0x14
-#define RX8010_MONTH   0x15
-#define RX8010_YEAR    0x16
-#define RX8010_RESV17  0x17
-#define RX8010_ALMIN   0x18
-#define RX8010_ALHOUR  0x19
-#define RX8010_ALWDAY  0x1A
-#define RX8010_TCOUNT0 0x1B
-#define RX8010_TCOUNT1 0x1C
-#define RX8010_EXT     0x1D
-#define RX8010_FLAG    0x1E
-#define RX8010_CTRL    0x1F
+#define RX8010_SEC		0x10
+#define RX8010_MIN		0x11
+#define RX8010_HOUR		0x12
+#define RX8010_WDAY		0x13
+#define RX8010_MDAY		0x14
+#define RX8010_MONTH		0x15
+#define RX8010_YEAR		0x16
+#define RX8010_RESV17		0x17
+#define RX8010_ALMIN		0x18
+#define RX8010_ALHOUR		0x19
+#define RX8010_ALWDAY		0x1A
+#define RX8010_TCOUNT0		0x1B
+#define RX8010_TCOUNT1		0x1C
+#define RX8010_EXT		0x1D
+#define RX8010_FLAG		0x1E
+#define RX8010_CTRL		0x1F
 /* 0x20 to 0x2F are user registers */
-#define RX8010_RESV30  0x30
-#define RX8010_RESV31  0x31
-#define RX8010_IRQ     0x32
+#define RX8010_RESV30		0x30
+#define RX8010_RESV31		0x31
+#define RX8010_IRQ		0x32
 
-#define RX8010_EXT_WADA  BIT(3)
+#define RX8010_EXT_WADA		BIT(3)
 
-#define RX8010_FLAG_VLF  BIT(1)
-#define RX8010_FLAG_AF   BIT(3)
-#define RX8010_FLAG_TF   BIT(4)
-#define RX8010_FLAG_UF   BIT(5)
+#define RX8010_FLAG_VLF		BIT(1)
+#define RX8010_FLAG_AF		BIT(3)
+#define RX8010_FLAG_TF		BIT(4)
+#define RX8010_FLAG_UF		BIT(5)
 
-#define RX8010_CTRL_AIE  BIT(3)
-#define RX8010_CTRL_UIE  BIT(5)
-#define RX8010_CTRL_STOP BIT(6)
-#define RX8010_CTRL_TEST BIT(7)
+#define RX8010_CTRL_AIE		BIT(3)
+#define RX8010_CTRL_UIE		BIT(5)
+#define RX8010_CTRL_STOP	BIT(6)
+#define RX8010_CTRL_TEST	BIT(7)
 
-#define RX8010_ALARM_AE  BIT(7)
+#define RX8010_ALARM_AE		BIT(7)
 
 static const struct i2c_device_id rx8010_id[] = {
 	{ "rx8010", 0 },
-- 
2.26.1

