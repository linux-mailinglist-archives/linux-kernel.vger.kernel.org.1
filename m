Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD0E2B453E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 14:56:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729804AbgKPNyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 08:54:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729743AbgKPNyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 08:54:40 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F06CC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 05:54:40 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id w14so14184716pfd.7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 05:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oFmZrd7NE3HbQX/Lo8F4S5lrtb+Hwz8PmiBSdug9JUU=;
        b=pHOAjGIMcO3pLa2qipnYk3+0D2U6SBY246HUqsvNSSKyA64ULFAc9XPKYhAZ3LHVpx
         iPgKQZpjGbafyU9mGED3WvU93MWI/URKOqhaMClTUTIn5idMEr2WMSm3Pl8FknUgF1Lg
         CExg8xMsGbpFjRBHBoMMVdF/gYdSI0DhTuIVIWxDb2ey4h6sT2bdJGrK1DoRfgH6hQAA
         n3X7Amu4u+9on2FeaWIWIe5pqxXuhNMOQMaKqGkC3ZgzAZaPiCyNU020+uGezPvE0k5V
         0hgIf0Cai09dErI+/YhhtctQbKZt4QyLsudO4N1DSOMVF5Fc90speRF9uoGNgAk6DwaJ
         JUSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oFmZrd7NE3HbQX/Lo8F4S5lrtb+Hwz8PmiBSdug9JUU=;
        b=JDZUm/nkrHoeBc2DZgsZTm+mWYUnbmlMHBz+SgVM3rVF8dWin3mw75N2p089xez27I
         RNbF8qfVvbo65y+PvJvyEKn9/uwe0rrzhwzubI+97wK5VC43US7/5aCL6maWsVhx0aws
         J54XBlrySFMGAcM/XWIYJMjqWGmH15pXhw9TshCYvy7NUxuY2uni2ifYQ/EuqVtOTTUx
         lw6jJkNO2kqVZw+HX63vj6Posxm5lqysSB5GRr/vVZwIh7VlVZbs4e4lKAWKzIbaP/GT
         JKjKtHjUa21ex23VMF+gcJVbeEKqxftv9kFFOZ05laWStkTn8+DB3ktFvBb4nmPV9Y8t
         LfSg==
X-Gm-Message-State: AOAM531MSHtLgbSTheezThc7VyjW2VqWkgSzsSk9JGkdvlM2AwemfEdZ
        l9lIDQ3p3dWLDRO0f457AQUm5A==
X-Google-Smtp-Source: ABdhPJwG3dyo/34EnfPSLxxDmG2RWghKRkJ6P0GIJZkqnwDVqvPCn01dXaEjThZARmuMLjbRAn1Y7w==
X-Received: by 2002:a17:90b:78d:: with SMTP id l13mr16238310pjz.57.1605534879998;
        Mon, 16 Nov 2020 05:54:39 -0800 (PST)
Received: from localhost.localdomain ([163.172.76.58])
        by smtp.googlemail.com with ESMTPSA id u22sm15864031pgf.24.2020.11.16.05.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 05:54:39 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     arnd@arndb.de, davem@davemloft.net, herbert@gondor.apana.org.au,
        jernej.skrabec@siol.net, mripard@kernel.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Corentin Labbe <clabbe@baylibre.com>, stable@vger.kernel.org
Subject: [PATCH v3 4/7] crypto: sun4i-ss: handle BigEndian for cipher
Date:   Mon, 16 Nov 2020 13:53:42 +0000
Message-Id: <20201116135345.11834-5-clabbe@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201116135345.11834-1-clabbe@baylibre.com>
References: <20201116135345.11834-1-clabbe@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ciphers produce invalid results on BE.
Key and IV need to be written in LE.

Fixes: 6298e948215f2 ("crypto: sunxi-ss - Add Allwinner Security System crypto accelerator")
Cc: <stable@vger.kernel.org>
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/allwinner/sun4i-ss/sun4i-ss-cipher.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-cipher.c b/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-cipher.c
index 53478c3feca6..8f4621826330 100644
--- a/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-cipher.c
+++ b/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-cipher.c
@@ -52,13 +52,13 @@ static int noinline_for_stack sun4i_ss_opti_poll(struct skcipher_request *areq)
 
 	spin_lock_irqsave(&ss->slock, flags);
 
-	for (i = 0; i < op->keylen; i += 4)
-		writel(*(op->key + i / 4), ss->base + SS_KEY0 + i);
+	for (i = 0; i < op->keylen / 4; i++)
+		writesl(ss->base + SS_KEY0 + i * 4, &op->key[i], 1);
 
 	if (areq->iv) {
 		for (i = 0; i < 4 && i < ivsize / 4; i++) {
 			v = *(u32 *)(areq->iv + i * 4);
-			writel(v, ss->base + SS_IV0 + i * 4);
+			writesl(ss->base + SS_IV0 + i * 4, &v, 1);
 		}
 	}
 	writel(mode, ss->base + SS_CTL);
@@ -223,13 +223,13 @@ static int sun4i_ss_cipher_poll(struct skcipher_request *areq)
 
 	spin_lock_irqsave(&ss->slock, flags);
 
-	for (i = 0; i < op->keylen; i += 4)
-		writel(*(op->key + i / 4), ss->base + SS_KEY0 + i);
+	for (i = 0; i < op->keylen / 4; i++)
+		writesl(ss->base + SS_KEY0 + i * 4, &op->key[i], 1);
 
 	if (areq->iv) {
 		for (i = 0; i < 4 && i < ivsize / 4; i++) {
 			v = *(u32 *)(areq->iv + i * 4);
-			writel(v, ss->base + SS_IV0 + i * 4);
+			writesl(ss->base + SS_IV0 + i * 4, &v, 1);
 		}
 	}
 	writel(mode, ss->base + SS_CTL);
-- 
2.26.2

