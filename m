Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8437926E3F8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 20:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbgIQSj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 14:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbgIQSgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 14:36:12 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D107C061351
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 11:36:12 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id t10so3135796wrv.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 11:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=huiz4hWuEDAzBaczeTBJaesBVDz4VU4ls/AvOgJWeOk=;
        b=JpjCYv5upp6XL8vZw/alieu2cpaOwfleOy/rzX2ojjNYlwSuBLG2jlL+2+UQAk3mmW
         3RfiYgv/kFFoG5lvbTqzYR7dY+MluotdcWjF7R3w9c7ozyM/dT0nt1blyP8CO3TpOa70
         YyeoWH8e58UflQPQN7VnSizaeKpooddmUBw9cyMgRv8FYllSdvtaXEPjBrL7rv4dWnun
         f7exonzOVT/cBza580v3FOwbMcsktLa7oH+dRP3FPi4TKZhKxpyL+3vPJjHI2xzSD6f5
         +YK+k97R2D7oMjJprQDPx5Jim0oq1XgwUTSlJAfX7bzURWSOTisdaEHtzm6HnJYb4uzR
         6ing==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=huiz4hWuEDAzBaczeTBJaesBVDz4VU4ls/AvOgJWeOk=;
        b=tCrGnH3HABwgS50sloU9ZKUe1wYiHoRH5StPLxto3Z8VlbNAhgzp0fa/vIWe4F0I9o
         wljnG7uzSSlnForA07vZQdTXICjcrVNp5skhCXrEvtIYXHWTZ4Fx9vMY9Kr7xPHy2s6I
         3gPIgJi/pH98SXxEyTCCvHWu+LwkMNJtQWD1UHZ29Nm7shdy0DGS4fu6SBq8//0iFfrP
         CPm3Stzvc2Kni+7s9h05+XygLmo+WCLxm/Q2YnIygsbfvWR3yNegudGv4zA8y8yGHiVQ
         dfrilMrQAfjzYEOkuCoTVb0zjz1FKHtnPSOxpV4m6n7uOoQDhBazjnOfR9SgvCvscaHp
         lPzw==
X-Gm-Message-State: AOAM531cSsGBC2kGEfsgiLGx6K3iz0T/rEgxL4JB43C9YRhFvAOHKngS
        40Mt8rJ1UZVXuHKhx0C7NsCgVw==
X-Google-Smtp-Source: ABdhPJwEutMPermMhwz6o/ZA8isTCX7M2dtJokNUsR8uKvWZb3baKmYr/Mdbwerfm2Ba1S7xHFnLLQ==
X-Received: by 2002:adf:a3d4:: with SMTP id m20mr30378089wrb.29.1600367770621;
        Thu, 17 Sep 2020 11:36:10 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id x16sm571901wrq.62.2020.09.17.11.36.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Sep 2020 11:36:10 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     arnd@arndb.de, davem@davemloft.net, herbert@gondor.apana.org.au,
        mripard@kernel.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Corentin Labbe <clabbe@baylibre.com>, stable@vger.kernel.org
Subject: [PATCH 3/7] crypto: sun4i-ss: IV register does not work on A10 and A13
Date:   Thu, 17 Sep 2020 18:35:54 +0000
Message-Id: <1600367758-28589-4-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1600367758-28589-1-git-send-email-clabbe@baylibre.com>
References: <1600367758-28589-1-git-send-email-clabbe@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner A10 and A13 SoC have a version of the SS which produce
invalid IV in IVx register.

Instead of adding a variant for those, let's convert SS to produce IV
directly from data.
Fixes: 6298e948215f2 ("crypto: sunxi-ss - Add Allwinner Security System crypto accelerator")
Cc: <stable@vger.kernel.org>
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 .../allwinner/sun4i-ss/sun4i-ss-cipher.c      | 34 +++++++++++++++----
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-cipher.c b/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-cipher.c
index 2614640231dc..c6c25204780d 100644
--- a/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-cipher.c
+++ b/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-cipher.c
@@ -20,6 +20,7 @@ static int noinline_for_stack sun4i_ss_opti_poll(struct skcipher_request *areq)
 	unsigned int ivsize = crypto_skcipher_ivsize(tfm);
 	struct sun4i_cipher_req_ctx *ctx = skcipher_request_ctx(areq);
 	u32 mode = ctx->mode;
+	void *backup_iv = NULL;
 	/* when activating SS, the default FIFO space is SS_RX_DEFAULT(32) */
 	u32 rx_cnt = SS_RX_DEFAULT;
 	u32 tx_cnt = 0;
@@ -42,6 +43,13 @@ static int noinline_for_stack sun4i_ss_opti_poll(struct skcipher_request *areq)
 		return -EINVAL;
 	}
 
+	if (areq->iv && ivsize > 0 && mode & SS_DECRYPTION) {
+		backup_iv = kzalloc(ivsize, GFP_KERNEL);
+		if (!backup_iv)
+			return -ENOMEM;
+		scatterwalk_map_and_copy(backup_iv, areq->src, areq->cryptlen - ivsize, ivsize, 0);
+	}
+
 	spin_lock_irqsave(&ss->slock, flags);
 
 	for (i = 0; i < op->keylen; i += 4)
@@ -102,9 +110,12 @@ static int noinline_for_stack sun4i_ss_opti_poll(struct skcipher_request *areq)
 	} while (oleft);
 
 	if (areq->iv) {
-		for (i = 0; i < 4 && i < ivsize / 4; i++) {
-			v = readl(ss->base + SS_IV0 + i * 4);
-			*(u32 *)(areq->iv + i * 4) = v;
+		if (mode & SS_DECRYPTION) {
+			memcpy(areq->iv, backup_iv, ivsize);
+			kfree_sensitive(backup_iv);
+		} else {
+			scatterwalk_map_and_copy(areq->iv, areq->dst, areq->cryptlen - ivsize,
+						 ivsize, 0);
 		}
 	}
 
@@ -161,6 +172,7 @@ static int sun4i_ss_cipher_poll(struct skcipher_request *areq)
 	unsigned int ileft = areq->cryptlen;
 	unsigned int oleft = areq->cryptlen;
 	unsigned int todo;
+	void *backup_iv = NULL;
 	struct sg_mapping_iter mi, mo;
 	unsigned int oi, oo;	/* offset for in and out */
 	char buf[4 * SS_RX_MAX];/* buffer for linearize SG src */
@@ -204,6 +216,13 @@ static int sun4i_ss_cipher_poll(struct skcipher_request *areq)
 	if (need_fallback)
 		return sun4i_ss_cipher_poll_fallback(areq);
 
+	if (areq->iv && ivsize > 0 && mode & SS_DECRYPTION) {
+		backup_iv = kzalloc(ivsize, GFP_KERNEL);
+		if (!backup_iv)
+			return -ENOMEM;
+		scatterwalk_map_and_copy(backup_iv, areq->src, areq->cryptlen - ivsize, ivsize, 0);
+	}
+
 	spin_lock_irqsave(&ss->slock, flags);
 
 	for (i = 0; i < op->keylen; i += 4)
@@ -324,9 +343,12 @@ static int sun4i_ss_cipher_poll(struct skcipher_request *areq)
 		}
 	}
 	if (areq->iv) {
-		for (i = 0; i < 4 && i < ivsize / 4; i++) {
-			v = readl(ss->base + SS_IV0 + i * 4);
-			*(u32 *)(areq->iv + i * 4) = v;
+		if (mode & SS_DECRYPTION) {
+			memcpy(areq->iv, backup_iv, ivsize);
+			kfree_sensitive(backup_iv);
+		} else {
+			scatterwalk_map_and_copy(areq->iv, areq->dst, areq->cryptlen - ivsize,
+						 ivsize, 0);
 		}
 	}
 
-- 
2.26.2

