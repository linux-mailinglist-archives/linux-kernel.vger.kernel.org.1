Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2478F25D719
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Sep 2020 13:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729584AbgIDLXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Sep 2020 07:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730014AbgIDLK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 07:10:29 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA63C061244
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 04:10:22 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id o21so5724988wmc.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 04:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gu2nO542K4ougfxaUDiK4mdQGGUo4JdtK15CmsafJKs=;
        b=Vu5ioh0klmNo7o2wGxhVP0QMRnfN3VTaca0aSclNR/LTNwNMgFmYiBxDZN2C5vq0wn
         +wI3KB69h7vHas1Zg4paLboUKMzGoRyaNvq0PnorJTz7Ig+zs9jB7zgyDXofaBZqX1Q4
         Kf6/CHNbBMq2OIAENLX9oHHX/koESO85fjs8EkzFoNI2YcsfE1G8MT/uMGW9Q6LR4/Q3
         tlPXJWHXh0dqWqiGBrJx9BRBJiLA4Q6tft27hDuHEui3xjEEjPYDSfu4kTiJKUhiJOal
         CxZxTnv6gKM3ArSKfEWFncEy1R5n7nAJX/dCJnJQ+sgxR8hzn/PMELn560ivvc2e7KY3
         WyUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gu2nO542K4ougfxaUDiK4mdQGGUo4JdtK15CmsafJKs=;
        b=Ur86prf1E3EGFdDSFiIlHA0UZImiDQhiNuAlv9ieb942v07Dh997pYASlPJph3OBPt
         lWz6zHmuXJYj9D2vSX34QXyETS4uPBfTP2xyZ5MNwgdmcyIo1lqH/gLQ8plryX/f529k
         I//uZX07I9xjtqIs+a6JIDz+YFWsmfFGLKMVFOpXdIFMb2GIXXp8bPQwFe7OjSmCc2AA
         eNXPh+903OkDoZEsAetFTTiJzUiIp5OZJlD8NnuAsP9nNi39tHg8adK06Lzko2jJ3Gdj
         D6lK77Y0J874JH7LN9e4p4QiDQCg9XMI5I7eSIAL9AA6Vm/94mC2bssvssvGHwHknBs3
         lZxA==
X-Gm-Message-State: AOAM531YaoS/aLqj3pzOisBqGfXrSg8Nyi77wbtcOh/28SmX/FD8Utzf
        7UEGpUE50kIK5+zZE5Xf6j5rTA==
X-Google-Smtp-Source: ABdhPJw2ELro4Er3ptRLd3h8O/IAXW8W7MJm6tR1+NIlHOnpaPE3B2lZRQANqQhqTYEkS9uKdDudqw==
X-Received: by 2002:a1c:4d14:: with SMTP id o20mr6945443wmh.74.1599217820886;
        Fri, 04 Sep 2020 04:10:20 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id m3sm10622743wmb.26.2020.09.04.04.10.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Sep 2020 04:10:19 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        mripard@kernel.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v6 09/18] crypto: sun8i-ce: split into prepare/run/unprepare
Date:   Fri,  4 Sep 2020 11:09:54 +0000
Message-Id: <1599217803-29755-10-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1599217803-29755-1-git-send-email-clabbe@baylibre.com>
References: <1599217803-29755-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
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
 .../allwinner/sun8i-ce/sun8i-ce-cipher.c      | 70 ++++++++++++++++---
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h  |  4 ++
 2 files changed, 66 insertions(+), 8 deletions(-)

diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c
index 2252604d821b..fa12c966c45f 100644
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
@@ -234,7 +235,9 @@ static int sun8i_ce_cipher(struct skcipher_request *areq)
 	}
 
 	chan->timeout = areq->cryptlen;
-	err = sun8i_ce_run_task(ce, flow, crypto_tfm_alg_name(areq->base.tfm));
+	rctx->nr_sgs = nr_sgs;
+	rctx->nr_sgd = nr_sgd;
+	return 0;
 
 theend_sgs:
 	if (areq->src == areq->dst) {
@@ -268,13 +271,64 @@ static int sun8i_ce_cipher(struct skcipher_request *areq)
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
+			dma_unmap_single(ce->dev, cet->t_iv, rctx->ivlen,
+					 DMA_TO_DEVICE);
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
+	dma_unmap_single(ce->dev, cet->t_key, op->keylen, DMA_TO_DEVICE);
 
 	return 0;
 }
@@ -346,9 +400,9 @@ int sun8i_ce_cipher_init(struct crypto_tfm *tfm)
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
index f5555c4800e8..084a962b8d4f 100644
--- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h
@@ -182,6 +182,8 @@ struct sun8i_ce_dev {
  * @backup_iv:		buffer which contain the next IV to store
  * @bounce_iv:		buffer which contain the IV
  * @ivlen:		size of bounce_iv
+ * @nr_sgs:		The number of source SG (as given by dma_map_sg())
+ * @nr_sgd:		The number of destination SG (as given by dma_map_sg())
  * @fallback_req:	request struct for invoking the fallback skcipher TFM
  */
 struct sun8i_cipher_req_ctx {
@@ -190,6 +192,8 @@ struct sun8i_cipher_req_ctx {
 	void *backup_iv;
 	void *bounce_iv;
 	unsigned int ivlen;
+	int nr_sgs;
+	int nr_sgd;
 	struct skcipher_request fallback_req;   // keep at the end
 };
 
-- 
2.26.2

