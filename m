Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD271B77D3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Apr 2020 16:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728460AbgDXOCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Apr 2020 10:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728430AbgDXOCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 10:02:40 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC29C09B046
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 07:02:39 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id x18so10950746wrq.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 07:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KSaVCb5R/kfhdtt9sMjPgwUadZUPmANMPo71JtvUH48=;
        b=hfEgjRlgfqwbgWyRrhSpvI5ha5kVX4iHWOFubZqCzrfx0E3F12y1YVq7TClcep2p6l
         epWSoc0Tw0RBpuFAuKW42UPZEmrIDLHRsSpewOVv10a2HFNKbx2sARcJRFoZl3NjjNgD
         wBr0OBqKGhWLfn1XJ3uBsflwGYGcrj0V7paonVBf34oTXq1Q79/ZDSp6k5kVC7pMO9ij
         5J7Gn3xF6cS7A6/Eqqok3mn+bPlZ0CwRLHBQgJSFR/nPGKGS70ZhosHXE2d/zY/v9tgM
         s/JgpJ5AkFGDT4k/u1OqqvpvxbcxcatAZpNiJoNSCXH2E713U5RdtWlPk+CrbIOTj8E6
         BVIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KSaVCb5R/kfhdtt9sMjPgwUadZUPmANMPo71JtvUH48=;
        b=T44G2VcRvSnVB0X6a2CsjviwwBugOuAtCviaoIv7RnC6yM5SQEdLRdwgrq5cdZd5dr
         qCMI5z66FBBXGUFnXke79p1daO6GJU08jALATlwskx4zUQ8gtVMuKTMbzXRWkQvULYTC
         QP4WWnRTdPk7XqW0Qb5nCCrdxlZNfnbp3aw3NrNIraDp50Uw8ipKbtyKX2QdMuMWLtuM
         EZyJ9nG0KsRcGMc8W1qci5un0x7SJ5LolrrLhj0QqziZQ0nsvzHd8fAzplYo5v/cAyXI
         VmUqZF94TaguU3BLCQxPMgifEUDxh/mpP8b/WnaFBL9hLta/Pl6pjG9Ipx2SQGvLDDdR
         tsHg==
X-Gm-Message-State: AGi0Pua04UsEnfZcOHQd58VxVW/dCuc4T+8wF/byfSExTzb4YaIjqkni
        0GPDQxOmFgLrPI/7H3ylB5I0lg==
X-Google-Smtp-Source: APiQypKjliH2Z7XVf4Dw38HCc4bn6hb7L6l2nq13sgfWRKj8wmf0jz5x4er0sb1X6URUOB1/r9z6Ug==
X-Received: by 2002:adf:9e08:: with SMTP id u8mr11239367wre.155.1587736958650;
        Fri, 24 Apr 2020 07:02:38 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id v131sm3061051wmb.19.2020.04.24.07.02.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Apr 2020 07:02:37 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        mripard@kernel.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v2 07/14] crypto: sun8i-ce: move iv data to request context
Date:   Fri, 24 Apr 2020 14:02:07 +0000
Message-Id: <1587736934-22801-8-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587736934-22801-1-git-send-email-clabbe@baylibre.com>
References: <1587736934-22801-1-git-send-email-clabbe@baylibre.com>
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
index a6abb701bfc6..7716fa2d3250 100644
--- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c
@@ -91,7 +91,6 @@ static int sun8i_ce_cipher(struct skcipher_request *areq)
 	struct scatterlist *sg;
 	unsigned int todo, len, offset, ivsize;
 	dma_addr_t addr_iv = 0, addr_key = 0;
-	void *backup_iv = NULL;
 	u32 common, sym;
 	int flow, i;
 	int nr_sgs = 0;
@@ -154,24 +153,24 @@ static int sun8i_ce_cipher(struct skcipher_request *areq)
 
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
@@ -252,17 +251,17 @@ static int sun8i_ce_cipher(struct skcipher_request *areq)
 theend_iv:
 	if (areq->iv && ivsize > 0) {
 		if (addr_iv)
-			dma_unmap_single(ce->dev, addr_iv, chan->ivlen,
+			dma_unmap_single(ce->dev, addr_iv, rctx->ivlen,
 					 DMA_TO_DEVICE);
 		offset = areq->cryptlen - ivsize;
 		if (rctx->op_dir & CE_DECRYPTION) {
-			memcpy(areq->iv, backup_iv, ivsize);
-			kzfree(backup_iv);
+			memcpy(areq->iv, rctx->backup_iv, ivsize);
+			kzfree(rctx->backup_iv);
 		} else {
 			scatterwalk_map_and_copy(areq->iv, areq->dst, offset,
 						 ivsize, 0);
 		}
-		kfree(chan->bounce_iv);
+		kfree(rctx->bounce_iv);
 	}
 
 theend_key:
diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h
index 0e9eac397e1b..c9c7ef8299e2 100644
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
@@ -183,10 +179,16 @@ struct sun8i_ce_dev {
  * struct sun8i_cipher_req_ctx - context for a skcipher request
  * @op_dir:	direction (encrypt vs decrypt) for this request
  * @flow:	the flow to use for this request
+ * @backup_iv:	buffer which contain the next IV to store
+ * @bounce_iv:	buffer which contain a copy of IV
+ * @ivlen:	size of bounce_iv
  */
 struct sun8i_cipher_req_ctx {
 	u32 op_dir;
 	int flow;
+	void *backup_iv;
+	void *bounce_iv;
+	unsigned int ivlen;
 };
 
 /*
-- 
2.26.2

