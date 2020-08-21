Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA4A24D65D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Aug 2020 15:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbgHUNp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Aug 2020 09:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728827AbgHUNoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 09:44:03 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B14C0617A0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 06:43:53 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id u18so1914901wmc.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 06:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rIUFQhQ64oF2ROvS3z6Ch/i8dVROC3dNchz1WEDXahs=;
        b=JIMfNJbLBDBVprbj6hP+YwDOiktdi54ddXQtHQd4TxEeZisRo1G12DAW24cJRlAWpM
         uUQ+KDBh55tNG74uHOOdi8W6HHorpZyiOiIDN2PsCQiYn9Azuxd90KK2jmtB1XnWI83f
         fnqB+nLr8mMdIv4nZmBQ3qCgfbXMpGvV/20fM4YIEI5Se+Qf2LgHJHu974ZwG83DnO+l
         yhSdrIdB9+qRrSDBTXjfpEUhXBk0I8SYfRIcU2n4+Gc5PmYxaNji5+ReAj510BmlfDS7
         p/8Z6nBgfDMDuEHRayRfQy+gFxavldymdpUHftK2SK4l7IB9jbk/n95OtSGq4o6BscKn
         LMlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rIUFQhQ64oF2ROvS3z6Ch/i8dVROC3dNchz1WEDXahs=;
        b=pnlkBoBheCULkhaG4gMdgeKzp9SswgrAdVkYak3R2k5AJ2AniJGxIkKcBdPEATBrp7
         LzHG24joVOFq5fcqdhpijQqK/sumJM0ovx9STiq3urrkZ8yC765zUbSxSMnXAUg+KbpY
         a8Iv6wRJjyf3BovsUiDtRH1csHT5XvPEQ2MMoH65HAUX1Rnwz6EGwLNQ45U5UU9ZUlZ+
         H1r1zSzYvI0Afy3SZLcotyzFtRqhKOdHI3EvpW2hJ6f/DWjEnCIpVQ7P3YyvleNPs20P
         g5LnGcozbxDZ7b3NRYuNW70Ur3XNhHuU2O9fKfUvqDqQQX79BWCdqnpkeCEfH2LVk06Q
         6cXQ==
X-Gm-Message-State: AOAM530+Go/FSrzUkDTPTn4J+9BkD8iOF904wD5Tzmx3mEj3d777/XeE
        DdYudVco+pGfA8reavjuk7dslQ==
X-Google-Smtp-Source: ABdhPJzLYENLHHG7IqE/Az+G+6seNxLLHOnS2ZRPPr6iHUKvJdHKYaTvvjzeHRy4+lVUuwatf4jLEw==
X-Received: by 2002:a1c:f416:: with SMTP id z22mr3182547wma.62.1598017431660;
        Fri, 21 Aug 2020 06:43:51 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id 202sm5971179wmb.10.2020.08.21.06.43.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Aug 2020 06:43:51 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        mripard@kernel.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v5 08/18] crypto: sun8i-ce: move iv data to request context
Date:   Fri, 21 Aug 2020 13:43:25 +0000
Message-Id: <1598017415-39059-9-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598017415-39059-1-git-send-email-clabbe@baylibre.com>
References: <1598017415-39059-1-git-send-email-clabbe@baylibre.com>
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

