Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3BB2B4533
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 14:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729714AbgKPNyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 08:54:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728717AbgKPNyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 08:54:18 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695BFC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 05:54:17 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id v12so14158865pfm.13
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 05:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9KimMFHuJMnM9grT5G3KxuUOgh3PH0P48I8p4U+udaQ=;
        b=Ic5PMkRXlhVdSn1pWSmS1kPdU/KqAU1PUu1PX3YtldYe+Sw12gskyReuGYmw6982BL
         h3IUS/2dQ5DOb4jgGf0L/9FmfAkNhg6w+MXRznImvmZlRbWDeYLX16b5hhcJtBVTyp35
         an1y3QibWAPeRLmxXPV61hNeNpKixqczEROZ1WIhOPukNVFOUD+zjgmShh8Oml8bO5ez
         BLKrrkl6bUcHWBrGb/kF9ML1NNdaL53IAZAaAi5v57ZLvM7UnX0nD/antZWiZzK4kV3b
         kO67GdiNCqmHYFUFb1qlHlxKKwCW/X7OcbMEPJZWSrvWFcZHXCdSEb6q7ula/jvqvAu/
         v+oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9KimMFHuJMnM9grT5G3KxuUOgh3PH0P48I8p4U+udaQ=;
        b=tIXMx1hU+BjDqrYkc/EzbJA6Y2yC4G++hsZ9axCq3qayFS7gTIEWFhdw5KfmVa7+lY
         r1RyHxdIFXMHAPovxaSsJALmm4frs9CA7BoeRd4Q2vPWa54CgihBuWFJ3mD0gjY8VKYA
         TRbMShIkMr45bgS7GCh7NZHLhvYFZqe/cXTPI0q1MostlhH58RJvNSbqRya6QKAThbqI
         LwJ5+AsnIPjGOOVdJPeMVMh9H5PogsDNEFQ1Ip7Z/iqvCBP71VaZL/VIFmID+v/75yRn
         IQP4BiVAU8/lqK9s17XOBaxACpWjdvDf172VAOztbukhX+ZwBQpQIAqrnjvjjgxqebSV
         VRlA==
X-Gm-Message-State: AOAM533WwImhsO1YljMFwZmwM/GK7bFNJiQop8OSlhTSu0PItf5UD6Fd
        rS6jY1PVG2be+W5ysd7Waqvn1A==
X-Google-Smtp-Source: ABdhPJwLmogq1AEKcuBJffxz+FZsXEOnjKY5VgObBdJzLoVsYhFPTClW06qKFMqUsrtUFUhBgorTuQ==
X-Received: by 2002:a63:154e:: with SMTP id 14mr13036618pgv.49.1605534857019;
        Mon, 16 Nov 2020 05:54:17 -0800 (PST)
Received: from localhost.localdomain ([163.172.76.58])
        by smtp.googlemail.com with ESMTPSA id u22sm15864031pgf.24.2020.11.16.05.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 05:54:16 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     arnd@arndb.de, davem@davemloft.net, herbert@gondor.apana.org.au,
        jernej.skrabec@siol.net, mripard@kernel.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v3 1/7] crypto: sun4i-ss: linearize buffers content must be kept
Date:   Mon, 16 Nov 2020 13:53:39 +0000
Message-Id: <20201116135345.11834-2-clabbe@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201116135345.11834-1-clabbe@baylibre.com>
References: <20201116135345.11834-1-clabbe@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When running the non-optimized cipher function, SS produce partial random
output.
This is due to linearize buffers being reseted after each loop.

For preserving stack, instead of moving them back to start of function,
I move them in sun4i_ss_ctx.

Fixes: 8d3bcb9900ca ("crypto: sun4i-ss - reduce stack usage")
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/allwinner/sun4i-ss/sun4i-ss-cipher.c | 12 ++++--------
 drivers/crypto/allwinner/sun4i-ss/sun4i-ss.h        |  2 ++
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-cipher.c b/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-cipher.c
index b72de8939497..19f1aa577ed4 100644
--- a/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-cipher.c
+++ b/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-cipher.c
@@ -233,8 +233,6 @@ static int sun4i_ss_cipher_poll(struct skcipher_request *areq)
 
 	while (oleft) {
 		if (ileft) {
-			char buf[4 * SS_RX_MAX];/* buffer for linearize SG src */
-
 			/*
 			 * todo is the number of consecutive 4byte word that we
 			 * can read from current SG
@@ -256,12 +254,12 @@ static int sun4i_ss_cipher_poll(struct skcipher_request *areq)
 				 */
 				todo = min(rx_cnt * 4 - ob, ileft);
 				todo = min_t(size_t, todo, mi.length - oi);
-				memcpy(buf + ob, mi.addr + oi, todo);
+				memcpy(ss->buf + ob, mi.addr + oi, todo);
 				ileft -= todo;
 				oi += todo;
 				ob += todo;
 				if (!(ob % 4)) {
-					writesl(ss->base + SS_RXFIFO, buf,
+					writesl(ss->base + SS_RXFIFO, ss->buf,
 						ob / 4);
 					ob = 0;
 				}
@@ -295,13 +293,11 @@ static int sun4i_ss_cipher_poll(struct skcipher_request *areq)
 				oo = 0;
 			}
 		} else {
-			char bufo[4 * SS_TX_MAX]; /* buffer for linearize SG dst */
-
 			/*
 			 * read obl bytes in bufo, we read at maximum for
 			 * emptying the device
 			 */
-			readsl(ss->base + SS_TXFIFO, bufo, tx_cnt);
+			readsl(ss->base + SS_TXFIFO, ss->bufo, tx_cnt);
 			obl = tx_cnt * 4;
 			obo = 0;
 			do {
@@ -313,7 +309,7 @@ static int sun4i_ss_cipher_poll(struct skcipher_request *areq)
 				 */
 				todo = min_t(size_t,
 					     mo.length - oo, obl - obo);
-				memcpy(mo.addr + oo, bufo + obo, todo);
+				memcpy(mo.addr + oo, ss->bufo + obo, todo);
 				oleft -= todo;
 				obo += todo;
 				oo += todo;
diff --git a/drivers/crypto/allwinner/sun4i-ss/sun4i-ss.h b/drivers/crypto/allwinner/sun4i-ss/sun4i-ss.h
index 163962f9e284..02105b39fbfe 100644
--- a/drivers/crypto/allwinner/sun4i-ss/sun4i-ss.h
+++ b/drivers/crypto/allwinner/sun4i-ss/sun4i-ss.h
@@ -148,6 +148,8 @@ struct sun4i_ss_ctx {
 	struct reset_control *reset;
 	struct device *dev;
 	struct resource *res;
+	char buf[4 * SS_RX_MAX];/* buffer for linearize SG src */
+	char bufo[4 * SS_TX_MAX]; /* buffer for linearize SG dst */
 	spinlock_t slock; /* control the use of the device */
 #ifdef CONFIG_CRYPTO_DEV_SUN4I_SS_PRNG
 	u32 seed[SS_SEED_LEN / BITS_PER_LONG];
-- 
2.26.2

