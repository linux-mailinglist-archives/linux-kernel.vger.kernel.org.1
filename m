Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ADEF26F6D6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 09:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbgIRHYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 03:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbgIRHX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 03:23:28 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9F9C06178A
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 00:23:27 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id q9so4293041wmj.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 00:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=an/ZItpIvdsXZ+dkCGTRBp4WyvhqN2ZXif9hZg0TSV0=;
        b=aS4oaZpGgF5Yx/SjMNO4D1dl1r2QPritaZqtlULED7sRG0zDx0BocoRRJiEl6ArjM2
         y3Whw2VQSIreWxm7uQES/cw4FoZJpkVTJMZIDUjU0plhB6fDQ/qR9vcKVBO2x0TCY3dk
         3O310FYCGDJH1Og8IcSuHlugHCPjYWEpE3dO7PY+a6B1aKionlSIJ+urdFjock0pW3+4
         iw5KDDqDvzV1umXS9x4+GSGkBv0MOgiNn6FKjZRkAL162npzPHTyH3fktrTpV7Tx2K13
         n3FBPE2tl9G8h71rL0VXAR76J77g1Ns0SkxiDHhrAW4iFhwEcyvQFwWZQ0pmVfOFo8DZ
         MIJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=an/ZItpIvdsXZ+dkCGTRBp4WyvhqN2ZXif9hZg0TSV0=;
        b=PJokMIQJoOlsXr0IyeqXeajS1IdMgf5qGStZyzwhf6ukqMqSJK9mawKwsW0mO/LBs5
         Aw+2PNsXs9ptMRW2ugAl4ulRzeYPPEqa1X/WDbygh/1BFHkccb9VKge+P3v8vvB9kBUX
         wfVAxgByfPI6QMHtOLucewuTBHNBaIGxB5Vk+P3L8Y+unSVfF11wxCZI4bnWidmRA9ut
         B39vrSzBD+GqouAugZo7eHFHEavDkUggwkK8gyFZhCxpcUN5FL+ickxFufv8AnWpIKRZ
         vbWew67cppDBPlrYNYYAq0IorSpefbOfdryaXfwW4WY2bkrgv++Tg0gPinTAMRFhqf7m
         DJYw==
X-Gm-Message-State: AOAM531I5ZBkbXc57JmsgIf3P4Vd4lUHkW3uFe8b9peiZ1jMkEytaJhG
        EPZZcwdD3OMzQD+DXt2u931yOw==
X-Google-Smtp-Source: ABdhPJzDdfjoN4lKQgPDS0TV0at1cUlFXtL5wmDVSacIiOJLSNjIUz+GXZ+jG0BdRCNzSSojhweMjQ==
X-Received: by 2002:a1c:6445:: with SMTP id y66mr14714398wmb.12.1600413806507;
        Fri, 18 Sep 2020 00:23:26 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id z19sm3349546wmi.3.2020.09.18.00.23.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Sep 2020 00:23:25 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        mripard@kernel.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v7 01/17] crypto: sun8i-ss: Add SS_START define
Date:   Fri, 18 Sep 2020 07:22:59 +0000
Message-Id: <1600413795-39256-2-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1600413795-39256-1-git-send-email-clabbe@baylibre.com>
References: <1600413795-39256-1-git-send-email-clabbe@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of using an hardcoded value, let's use a defined value for
SS_START.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c | 2 +-
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h      | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c
index 9a23515783a6..97012128385f 100644
--- a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c
+++ b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c
@@ -61,7 +61,7 @@ int sun8i_ss_run_task(struct sun8i_ss_dev *ss, struct sun8i_cipher_req_ctx *rctx
 		      const char *name)
 {
 	int flow = rctx->flow;
-	u32 v = 1;
+	u32 v = SS_START;
 	int i;
 
 #ifdef CONFIG_CRYPTO_DEV_SUN8I_SS_DEBUG
diff --git a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h
index 0405767f1f7e..f3ffaea3a59f 100644
--- a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h
+++ b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h
@@ -13,6 +13,8 @@
 #include <linux/debugfs.h>
 #include <linux/crypto.h>
 
+#define SS_START	1
+
 #define SS_ENCRYPTION		0
 #define SS_DECRYPTION		BIT(6)
 
-- 
2.26.2

