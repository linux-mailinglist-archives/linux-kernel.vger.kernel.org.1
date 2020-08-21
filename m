Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 979F024D64F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Aug 2020 15:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728813AbgHUNoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Aug 2020 09:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728736AbgHUNnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 09:43:46 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D4DC061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 06:43:45 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id c15so1961704wrs.11
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 06:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=an/ZItpIvdsXZ+dkCGTRBp4WyvhqN2ZXif9hZg0TSV0=;
        b=VupcTfHvtOM3OqYqFKTzWoJX6b0VQKA/XU+uQbm++069aCLbi5DJj0dk82uanW01lL
         N5AzLXKz69tzblUHvIByN4Sybc6lxZOY6s4zz4LVZIV7GKTQwT680oaAmhrsiExqQsT0
         pt7/4Vf5zUoahz8FsEV6e7ixBc35Ur6erUqifHvnhQTFiIrxeiba6VacQQ+1OysEkYau
         W0cEzV391BlTlhd0HjV4OApkPsRiklKBosJTD2SEqQyay1SSENtQzy0ItYtrGb3fQvFW
         Hpt3vKCtofcR2a9jCC5W14LbNmqXNh9IYLqs725tHNSiDdcq9HvbDOeIzo1El1TTvZ4+
         Bv+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=an/ZItpIvdsXZ+dkCGTRBp4WyvhqN2ZXif9hZg0TSV0=;
        b=Q8tUMxYxZJxT+r97eAMgCpgY4g0AKdowzWyvgqZ0mdSYFke0uiSK9ra0cUrrlmRXgS
         hPQWvzcjcfep35JUUvV3R4nick5+Bf8EpKIIBmr5mx0J0ytNb36H9tkJfptAw0cX64TP
         ip2w2FUzsY+MPHkVzgX1OQC212WmTzfW+AqjRp10Y3My8JMsJP9F2G/vrDh+hZ1seFsq
         5JHbH6N4ptRNkkBykjQuDVYzPWIm7w1taHCYijt1fsRX0R29TwiVaeRj7FJcdrU1I37/
         fUQM7v3sfzy3CdAzCg/KcnMxgfTVLZ5Y/49McdDjSMu5IzGjBYuRJUbcjZyo1GHpISOt
         MiAw==
X-Gm-Message-State: AOAM531wbV07P7aDu2nbAMWMlokLIeZHqPxPbcelg4NafXDyow7rT+Vd
        ThKYZB5FAOu8O8HzhckJNtQoDA==
X-Google-Smtp-Source: ABdhPJw6tis5ZR2fR5im6CyO9RyII+xiyyyVuOWW8nErWFZhdZ2AurjWD9xmeY8mAvJx8ACVUr6LVQ==
X-Received: by 2002:adf:ec10:: with SMTP id x16mr2704963wrn.74.1598017424244;
        Fri, 21 Aug 2020 06:43:44 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id 202sm5971179wmb.10.2020.08.21.06.43.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Aug 2020 06:43:43 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        mripard@kernel.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v5 01/18] crypto: sun8i-ss: Add SS_START define
Date:   Fri, 21 Aug 2020 13:43:18 +0000
Message-Id: <1598017415-39059-2-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598017415-39059-1-git-send-email-clabbe@baylibre.com>
References: <1598017415-39059-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
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

