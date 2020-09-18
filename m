Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78A7426F6CD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 09:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbgIRHYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 03:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbgIRHXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 03:23:37 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5AACC061756
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 00:23:36 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id o5so4496745wrn.13
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 00:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bX5N0MaU40/dtati49/Cp2ME665tmNPSLIh7b6QRFxk=;
        b=nMEQPOKzikkPcpZJs50BdRp9Pk2PffhJaUATGoNHNyglr5A/A/NGvGaxyP7ptP7Pda
         HqEcCwVfPFQe1PrObWRBNj/avZMw9JSp/F/3XlIU5Wcrdct5O0M18C3WUEguVNbssMG3
         bOHWRUIDulMvYJFsMHXzN9XkJOfmMBiUx+XW5DD59txPZsldjtfWRnin0ls0fb3mUkOV
         P67lsBux2wmJE+0p6hOwhQnJ1bi2zQK0UsCzBb0bjLPs8ef35ezmkSzxPMB6mY3D9goz
         KGh6RZA4hi4apPATffZZhvvOy3uEVq91fYVXpL2Vc8blUiSr2Bq9NYZ/6jpX5fQ6oVqD
         tjdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bX5N0MaU40/dtati49/Cp2ME665tmNPSLIh7b6QRFxk=;
        b=Zn1b2lVsjreIr6ucTncqcnVXBWlxcF/VuDw+vU+sJgkNVQcNiRe6+QpcbrjPWmYAGS
         7IcZ2NzkvKGEjexkQRHNH55i/V2PVzBXgGtE3ll07N/ZiIhg4ZhJf3ZaC+dra5TBHyZx
         LXXNeJW+Ir5NfjGIFPiv4IiuXq3rsPA+iHOLv0yGi+e2OniOcby5kWJ5YAxPZrTMSuoY
         +7DbdGOKOovuXee+eGYwD88rpZK62X+/jkYRzSwAXixWHuyo9N1Y2rP6Kos08jXqiiWU
         RrAtLtNZMKA/P517Rp6Ff4BzWi1QjVYZxN1AWmicBg7AQW04BJnM3XyE4uOVrHmlKCok
         B6+A==
X-Gm-Message-State: AOAM530aEIedM3fAcUoYF1ALUUlI4EVhqBsKt4UOmdOimwoSUZV5L0lq
        QSxt9Yzrc6W9ElVUCx77lTtiQBTCP8YYow==
X-Google-Smtp-Source: ABdhPJy+FXn69yLCDZuq4HBTfwwfpQIOOzJEFDOAvcq3InIELhmS7zW6AvDMHOZ94OIXBRhITH8Dew==
X-Received: by 2002:a5d:4152:: with SMTP id c18mr38217711wrq.277.1600413815300;
        Fri, 18 Sep 2020 00:23:35 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id z19sm3349546wmi.3.2020.09.18.00.23.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Sep 2020 00:23:34 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        mripard@kernel.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v7 09/17] crypto: sun8i-ce: split into prepare/run/unprepare
Date:   Fri, 18 Sep 2020 07:23:07 +0000
Message-Id: <1600413795-39256-10-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1600413795-39256-1-git-send-email-clabbe@baylibre.com>
References: <1600413795-39256-1-git-send-email-clabbe@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch split the do_one_request into three.
Prepare will handle all DMA mapping and initialisation of the task
structure.
Unprepare will clean all DMA mapping.
And the do_one_request will be limited to just executing the task.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 .../allwinner/sun8i-ce/sun8i-ce-cipher.c      | 91 +++++++++++++++----
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h  |  8 ++
 2 files changed, 79 insertions(+), 20 deletions(-)

diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c
index f699b135de74..cae307e6bcac 100644
--- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c
@@ -75,8 +75,9 @@ static int sun8i_ce_cipher_fallback(struct skcipher_request *areq)
 	return err;
 }
 
-static int sun8i_ce_cipher(struct skcipher_request *areq)
+static int sun8i_ce_cipher_prepare(struct crypto_engine *engine, void *async_req)
 {
+	struct skcipher_request *areq = container_of(async_req, struct skcipher_request, base);
 	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(areq);
 	struct sun8i_cipher_tfm_ctx *op = crypto_skcipher_ctx(tfm);
 	struct sun8i_ce_dev *ce = op->ce;
@@ -87,7 +88,6 @@ static int sun8i_ce_cipher(struct skcipher_request *areq)
 	struct ce_task *cet;
 	struct scatterlist *sg;
 	unsigned int todo, len, offset, ivsize;
-	dma_addr_t addr_iv = 0, addr_key = 0;
 	u32 common, sym;
 	int flow, i;
 	int nr_sgs = 0;
@@ -140,13 +140,13 @@ static int sun8i_ce_cipher(struct skcipher_request *areq)
 	cet->t_sym_ctl = cpu_to_le32(sym);
 	cet->t_asym_ctl = 0;
 
-	addr_key = dma_map_single(ce->dev, op->key, op->keylen, DMA_TO_DEVICE);
-	cet->t_key = cpu_to_le32(addr_key);
-	if (dma_mapping_error(ce->dev, addr_key)) {
+	rctx->addr_key = dma_map_single(ce->dev, op->key, op->keylen, DMA_TO_DEVICE);
+	if (dma_mapping_error(ce->dev, rctx->addr_key)) {
 		dev_err(ce->dev, "Cannot DMA MAP KEY\n");
 		err = -EFAULT;
 		goto theend;
 	}
+	cet->t_key = cpu_to_le32(rctx->addr_key);
 
 	ivsize = crypto_skcipher_ivsize(tfm);
 	if (areq->iv && crypto_skcipher_ivsize(tfm) > 0) {
@@ -167,14 +167,14 @@ static int sun8i_ce_cipher(struct skcipher_request *areq)
 						 offset, ivsize, 0);
 		}
 		memcpy(rctx->bounce_iv, areq->iv, ivsize);
-		addr_iv = dma_map_single(ce->dev, rctx->bounce_iv, rctx->ivlen,
-					 DMA_TO_DEVICE);
-		cet->t_iv = cpu_to_le32(addr_iv);
-		if (dma_mapping_error(ce->dev, addr_iv)) {
+		rctx->addr_iv = dma_map_single(ce->dev, rctx->bounce_iv, rctx->ivlen,
+					       DMA_TO_DEVICE);
+		if (dma_mapping_error(ce->dev, rctx->addr_iv)) {
 			dev_err(ce->dev, "Cannot DMA MAP IV\n");
 			err = -ENOMEM;
 			goto theend_iv;
 		}
+		cet->t_iv = cpu_to_le32(rctx->addr_iv);
 	}
 
 	if (areq->src == areq->dst) {
@@ -234,7 +234,9 @@ static int sun8i_ce_cipher(struct skcipher_request *areq)
 	}
 
 	chan->timeout = areq->cryptlen;
-	err = sun8i_ce_run_task(ce, flow, crypto_tfm_alg_name(areq->base.tfm));
+	rctx->nr_sgs = nr_sgs;
+	rctx->nr_sgd = nr_sgd;
+	return 0;
 
 theend_sgs:
 	if (areq->src == areq->dst) {
@@ -247,9 +249,8 @@ static int sun8i_ce_cipher(struct skcipher_request *areq)
 
 theend_iv:
 	if (areq->iv && ivsize > 0) {
-		if (addr_iv)
-			dma_unmap_single(ce->dev, addr_iv, rctx->ivlen,
-					 DMA_TO_DEVICE);
+		if (rctx->addr_iv)
+			dma_unmap_single(ce->dev, rctx->addr_iv, rctx->ivlen, DMA_TO_DEVICE);
 		offset = areq->cryptlen - ivsize;
 		if (rctx->op_dir & CE_DECRYPTION) {
 			memcpy(areq->iv, rctx->backup_iv, ivsize);
@@ -262,19 +263,69 @@ static int sun8i_ce_cipher(struct skcipher_request *areq)
 	}
 
 theend_key:
-	dma_unmap_single(ce->dev, addr_key, op->keylen, DMA_TO_DEVICE);
+	dma_unmap_single(ce->dev, rctx->addr_key, op->keylen, DMA_TO_DEVICE);
 
 theend:
 	return err;
 }
 
-static int sun8i_ce_handle_cipher_request(struct crypto_engine *engine, void *areq)
+static int sun8i_ce_cipher_run(struct crypto_engine *engine, void *areq)
 {
-	int err;
 	struct skcipher_request *breq = container_of(areq, struct skcipher_request, base);
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(breq);
+	struct sun8i_cipher_tfm_ctx *op = crypto_skcipher_ctx(tfm);
+	struct sun8i_ce_dev *ce = op->ce;
+	struct sun8i_cipher_req_ctx *rctx = skcipher_request_ctx(breq);
+	int flow, err;
 
-	err = sun8i_ce_cipher(breq);
+	flow = rctx->flow;
+	err = sun8i_ce_run_task(ce, flow, crypto_tfm_alg_name(breq->base.tfm));
 	crypto_finalize_skcipher_request(engine, breq, err);
+	return 0;
+}
+
+static int sun8i_ce_cipher_unprepare(struct crypto_engine *engine, void *async_req)
+{
+	struct skcipher_request *areq = container_of(async_req, struct skcipher_request, base);
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(areq);
+	struct sun8i_cipher_tfm_ctx *op = crypto_skcipher_ctx(tfm);
+	struct sun8i_ce_dev *ce = op->ce;
+	struct sun8i_cipher_req_ctx *rctx = skcipher_request_ctx(areq);
+	struct sun8i_ce_flow *chan;
+	struct ce_task *cet;
+	unsigned int ivsize, offset;
+	int nr_sgs = rctx->nr_sgs;
+	int nr_sgd = rctx->nr_sgd;
+	int flow;
+
+	flow = rctx->flow;
+	chan = &ce->chanlist[flow];
+	cet = chan->tl;
+	ivsize = crypto_skcipher_ivsize(tfm);
+
+	if (areq->src == areq->dst) {
+		dma_unmap_sg(ce->dev, areq->src, nr_sgs, DMA_BIDIRECTIONAL);
+	} else {
+		if (nr_sgs > 0)
+			dma_unmap_sg(ce->dev, areq->src, nr_sgs, DMA_TO_DEVICE);
+		dma_unmap_sg(ce->dev, areq->dst, nr_sgd, DMA_FROM_DEVICE);
+	}
+
+	if (areq->iv && ivsize > 0) {
+		if (cet->t_iv)
+			dma_unmap_single(ce->dev, rctx->addr_iv, rctx->ivlen, DMA_TO_DEVICE);
+		offset = areq->cryptlen - ivsize;
+		if (rctx->op_dir & CE_DECRYPTION) {
+			memcpy(areq->iv, rctx->backup_iv, ivsize);
+			kfree_sensitive(rctx->backup_iv);
+		} else {
+			scatterwalk_map_and_copy(areq->iv, areq->dst, offset,
+						 ivsize, 0);
+		}
+		kfree(rctx->bounce_iv);
+	}
+
+	dma_unmap_single(ce->dev, rctx->addr_key, op->keylen, DMA_TO_DEVICE);
 
 	return 0;
 }
@@ -346,9 +397,9 @@ int sun8i_ce_cipher_init(struct crypto_tfm *tfm)
 		 crypto_tfm_alg_driver_name(&sktfm->base),
 		 crypto_tfm_alg_driver_name(crypto_skcipher_tfm(op->fallback_tfm)));
 
-	op->enginectx.op.do_one_request = sun8i_ce_handle_cipher_request;
-	op->enginectx.op.prepare_request = NULL;
-	op->enginectx.op.unprepare_request = NULL;
+	op->enginectx.op.do_one_request = sun8i_ce_cipher_run;
+	op->enginectx.op.prepare_request = sun8i_ce_cipher_prepare;
+	op->enginectx.op.unprepare_request = sun8i_ce_cipher_unprepare;
 
 	err = pm_runtime_get_sync(op->ce->dev);
 	if (err < 0)
diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h
index f5555c4800e8..c3053326afe9 100644
--- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h
@@ -182,6 +182,10 @@ struct sun8i_ce_dev {
  * @backup_iv:		buffer which contain the next IV to store
  * @bounce_iv:		buffer which contain the IV
  * @ivlen:		size of bounce_iv
+ * @nr_sgs:		The number of source SG (as given by dma_map_sg())
+ * @nr_sgd:		The number of destination SG (as given by dma_map_sg())
+ * @addr_iv:		The IV addr returned by dma_map_single, need to unmap later
+ * @addr_key:		The key addr returned by dma_map_single, need to unmap later
  * @fallback_req:	request struct for invoking the fallback skcipher TFM
  */
 struct sun8i_cipher_req_ctx {
@@ -190,6 +194,10 @@ struct sun8i_cipher_req_ctx {
 	void *backup_iv;
 	void *bounce_iv;
 	unsigned int ivlen;
+	int nr_sgs;
+	int nr_sgd;
+	dma_addr_t addr_iv;
+	dma_addr_t addr_key;
 	struct skcipher_request fallback_req;   // keep at the end
 };
 
-- 
2.26.2

