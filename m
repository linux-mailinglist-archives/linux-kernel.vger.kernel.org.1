Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABD252288D7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jul 2020 21:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730799AbgGUTIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jul 2020 15:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730407AbgGUTGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 15:06:51 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 977B3C0619E3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 12:06:50 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id g10so2807549wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 12:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rIUFQhQ64oF2ROvS3z6Ch/i8dVROC3dNchz1WEDXahs=;
        b=NKluApAHGIDD+9KxKrpCW1o99dpLzC7z7DvSTPywPokDolv8CKQ9ItJP/26q+rF9MG
         rddpcnLZq2HKvpi1ngPo91+4wJroOW3Q34UxBtJFA/nRg1bQQNC9QjmX94Iwg2PV8uW6
         yNgqJPsr94CbYM6B7sbv96KqHxOJJYZ2MY411TSEtUIKTGFjG9x5s8cu6+5kwLdG2MSs
         WODwtcMbMA2477Za9zs+zj/zd9qafj5pkhLqtxvFdeLy/QS9rZ3bN1g36PK9P6FrjvgA
         szI4/zNDGq5/s81SP+9V4KEYeMkcFnhPcNoX4qOZ6S0IUer304gfPWV0WKY8G4UDLXvx
         ukFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rIUFQhQ64oF2ROvS3z6Ch/i8dVROC3dNchz1WEDXahs=;
        b=jMcTCnNwVhj8NTHUzl5B3P7AO5qdUEeuwSOQbtyzMpyKUDg5gxEWFJyNw5VD/5YROc
         25W8r7UMSIim7UI9a5U++tKOeVr0gig+9rtkeWlU+QRyLV2kigomOsb7h642n9ATNINb
         3FzeSwzQLCQBOyMp3VAd+l85kdOno58VTLWj/vQfpuR/6bm3jsPClLqcEGV6R2dz5bc/
         //MGe0R05Icw0V9fLcQMk7/cXJbSO5ryq/24BlHH7+LfjNST2dIRclZ18o1bbtP1Z5bD
         LFE96PbaC5TDps3epaw+FIW7estg+rTHTZWoneSZnMXHM0BZvSL4g1n0afrcFhYvLccF
         R6cA==
X-Gm-Message-State: AOAM532QFvTRVRWbwHJDKOAWemMclf9xMMEVd8YxtzwdZk3QslBAMCwX
        dfSAsZt6Ql5FqrZyR26IwxxTJQ==
X-Google-Smtp-Source: ABdhPJw1AsDsazTJox20rbpavAhDEGT6XH2HSuTMU2oYFRfpdtp8B+wR2Foyuwg5X/cUMj9cgLtwtw==
X-Received: by 2002:a1c:bb44:: with SMTP id l65mr5595191wmf.51.1595358409355;
        Tue, 21 Jul 2020 12:06:49 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id s14sm25794848wrv.24.2020.07.21.12.06.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Jul 2020 12:06:48 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        mripard@kernel.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v4 08/17] crypto: sun8i-ce: move iv data to request context
Date:   Tue, 21 Jul 2020 19:06:22 +0000
Message-Id: <1595358391-34525-9-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595358391-34525-1-git-send-email-clabbe@baylibre.com>
References: <1595358391-34525-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of storing IV data in the channel context, store them in the
request context.
Storing them in the channel structure was conceptualy wrong since they
are per request related.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 .../allwinner/sun8i-ce/sun8i-ce-cipher.c      | 27 +++++++++----------
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h  | 10 ++++---
 2 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c
index b4d5fea27d20..2252604d821b 100644
--- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c
@@ -88,7 +88,6 @@ static int sun8i_ce_cipher(struct skcipher_request *areq)
 	struct scatterlist *sg;
 	unsigned int todo, len, offset, ivsize;
 	dma_addr_t addr_iv = 0, addr_key = 0;
-	void *backup_iv = NULL;
 	u32 common, sym;
 	int flow, i;
 	int nr_sgs = 0;
@@ -151,24 +150,24 @@ static int sun8i_ce_cipher(struct skcipher_request *areq)
 
 	ivsize = crypto_skcipher_ivsize(tfm);
 	if (areq->iv && crypto_skcipher_ivsize(tfm) > 0) {
-		chan->ivlen = ivsize;
-		chan->bounce_iv = kzalloc(ivsize, GFP_KERNEL | GFP_DMA);
-		if (!chan->bounce_iv) {
+		rctx->ivlen = ivsize;
+		rctx->bounce_iv = kzalloc(ivsize, GFP_KERNEL | GFP_DMA);
+		if (!rctx->bounce_iv) {
 			err = -ENOMEM;
 			goto theend_key;
 		}
 		if (rctx->op_dir & CE_DECRYPTION) {
-			backup_iv = kzalloc(ivsize, GFP_KERNEL);
-			if (!backup_iv) {
+			rctx->backup_iv = kzalloc(ivsize, GFP_KERNEL);
+			if (!rctx->backup_iv) {
 				err = -ENOMEM;
 				goto theend_key;
 			}
 			offset = areq->cryptlen - ivsize;
-			scatterwalk_map_and_copy(backup_iv, areq->src, offset,
-						 ivsize, 0);
+			scatterwalk_map_and_copy(rctx->backup_iv, areq->src,
+						 offset, ivsize, 0);
 		}
-		memcpy(chan->bounce_iv, areq->iv, ivsize);
-		addr_iv = dma_map_single(ce->dev, chan->bounce_iv, chan->ivlen,
+		memcpy(rctx->bounce_iv, areq->iv, ivsize);
+		addr_iv = dma_map_single(ce->dev, rctx->bounce_iv, rctx->ivlen,
 					 DMA_TO_DEVICE);
 		cet->t_iv = cpu_to_le32(addr_iv);
 		if (dma_mapping_error(ce->dev, addr_iv)) {
@@ -249,17 +248,17 @@ static int sun8i_ce_cipher(struct skcipher_request *areq)
 theend_iv:
 	if (areq->iv && ivsize > 0) {
 		if (addr_iv)
-			dma_unmap_single(ce->dev, addr_iv, chan->ivlen,
+			dma_unmap_single(ce->dev, addr_iv, rctx->ivlen,
 					 DMA_TO_DEVICE);
 		offset = areq->cryptlen - ivsize;
 		if (rctx->op_dir & CE_DECRYPTION) {
-			memcpy(areq->iv, backup_iv, ivsize);
-			kfree_sensitive(backup_iv);
+			memcpy(areq->iv, rctx->backup_iv, ivsize);
+			kfree_sensitive(rctx->backup_iv);
 		} else {
 			scatterwalk_map_and_copy(areq->iv, areq->dst, offset,
 						 ivsize, 0);
 		}
-		kfree(chan->bounce_iv);
+		kfree(rctx->bounce_iv);
 	}
 
 theend_key:
diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h
index 963645fe4adb..f5555c4800e8 100644
--- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h
@@ -129,8 +129,6 @@ struct ce_task {
 /*
  * struct sun8i_ce_flow - Information used by each flow
  * @engine:	ptr to the crypto_engine for this flow
- * @bounce_iv:	buffer which contain the IV
- * @ivlen:	size of bounce_iv
  * @complete:	completion for the current task on this flow
  * @status:	set to 1 by interrupt if task is done
  * @t_phy:	Physical address of task
@@ -139,8 +137,6 @@ struct ce_task {
  */
 struct sun8i_ce_flow {
 	struct crypto_engine *engine;
-	void *bounce_iv;
-	unsigned int ivlen;
 	struct completion complete;
 	int status;
 	dma_addr_t t_phy;
@@ -183,11 +179,17 @@ struct sun8i_ce_dev {
  * struct sun8i_cipher_req_ctx - context for a skcipher request
  * @op_dir:		direction (encrypt vs decrypt) for this request
  * @flow:		the flow to use for this request
+ * @backup_iv:		buffer which contain the next IV to store
+ * @bounce_iv:		buffer which contain the IV
+ * @ivlen:		size of bounce_iv
  * @fallback_req:	request struct for invoking the fallback skcipher TFM
  */
 struct sun8i_cipher_req_ctx {
 	u32 op_dir;
 	int flow;
+	void *backup_iv;
+	void *bounce_iv;
+	unsigned int ivlen;
 	struct skcipher_request fallback_req;   // keep at the end
 };
 
-- 
2.26.2

