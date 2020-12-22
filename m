Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3385B2DA107
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 21:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502967AbgLNUEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 15:04:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502955AbgLNUDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 15:03:36 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF27EC061793
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 12:02:56 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id i7so1686857pgc.8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 12:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IcIRwkZ8OZdNHBj5vIxvJw4vzDArIn2JvgviRxGrME0=;
        b=BxgQm4GOTVDXkX8er1nP7MnoFp1SSFm0fOFDppClgd5e+RfY2YSQO8U4xhDsZydL5y
         droFoRW+xtGGZFSuvMCLYmX8CUXDRlCQqvnTjQbUliug0cF4rTfHEYnIPQze9c0U0qus
         tklfphhmK4d0q+PrZmu183Z4Fg+pOj7XuHPJP9HynYRtzL8CLCXyGG5yB9T/OGtTLPjO
         sIcpoFFAeTtn1pdBu8NOzVT45MXxKguubd/z2WpkQIKwpJYS5stNxIAdadtDCvgD06/Y
         J/BAt2YVUv31WZakw51Gk24D5Yerypg62C2s3vKJH49JjF97nmlzCyoI28ezisy34xBN
         EGrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IcIRwkZ8OZdNHBj5vIxvJw4vzDArIn2JvgviRxGrME0=;
        b=UEQceakMkyrgmIlO8k9cU0e5ylIUkNIcQCr1yANWLsXVVlV+KBukIMJx6F9I1AZn2x
         CyCC6Q1qkDiijOyTjADQOQcdEcDaUEGdz5x0c1wbI+7XRmtyZe0+m2PFiFovWYf9uaM9
         Z9douDNFpzZ7L62jfCAxpTqDRmPUHnNiUEaa958PDuvf0uk4vgRcTkP3R1LtvMjSF/Ci
         M5ZfgPCWR9QenIVDdHEc+ufTblJjdimFssD0TJm4Wspg0/QdMMoXip5x2yO+B9j/4Hh7
         bfSWrrEdtb/2pN6zTY4sbJYUSdSpHqB5JiaemPhEFBnRYy4P4il+9aK/ApusBkoHkWOa
         jj7w==
X-Gm-Message-State: AOAM531FvX8QpJ7sgJaWo46xaDtnqDHVRwUV1712+wQCSYGP6l/Hpa2+
        YJT+mlqwSASEZoUCmYy5L/tJDQ==
X-Google-Smtp-Source: ABdhPJwO/V/z0sxQfPRx31wpvQ3CP7pHObiVAuAdG03+4tQ8oJkJX2O9uVVXDk6uzKgWyKip5r4pFQ==
X-Received: by 2002:a63:5849:: with SMTP id i9mr25981184pgm.271.1607976176314;
        Mon, 14 Dec 2020 12:02:56 -0800 (PST)
Received: from localhost.localdomain ([163.172.76.58])
        by smtp.googlemail.com with ESMTPSA id js9sm22434109pjb.2.2020.12.14.12.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 12:02:55 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     arnd@arndb.de, davem@davemloft.net, herbert@gondor.apana.org.au,
        jernej.skrabec@siol.net, mripard@kernel.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v4 1/8] crypto: sun4i-ss: linearize buffers content must be kept
Date:   Mon, 14 Dec 2020 20:02:25 +0000
Message-Id: <20201214200232.17357-2-clabbe@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201214200232.17357-1-clabbe@baylibre.com>
References: <20201214200232.17357-1-clabbe@baylibre.com>
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
index 5c291e4a6857..c242fccb2ab6 100644
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

