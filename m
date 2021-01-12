Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5502B2F2688
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 04:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387663AbhALDHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 22:07:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733213AbhALDHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 22:07:08 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A74C0617A4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 19:05:50 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id j26so734850qtq.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 19:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bZGjT91YJf1hHkSmJvXhKwaeMO0DjPBWpAMf7imhySA=;
        b=cPwO6Vqi8bJ6ngi3tQNcS7FR/RoeqKI0ckxNhL6vozsRBSr05BYbxgzRECpFY+Q7Ha
         H0uTRrE6fKzoowoOYaxkpzIeq9SljyaNIupkV1UD52Pi1nkDsMcfHMki8MU+j3kv1iFj
         RbMpplbw8kpWFtsHEjzb7xDPOK52OTJed5gIa8GkaQdmGj0h+Q8enu0SY6u3f+mHR8Fc
         ygSN4Ahl3Fssor7OkLo8NoAVWyY/eeRz5UOBHBHoI4bBOwAkwC7oP0eTA/z9xiFuK6lT
         ZXVF2zXyBkP99gqFOS37J2Ub8qcJXAHAYdLajHxbsisMcwUaCU7ruoAwlun2J1J352SW
         TiBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bZGjT91YJf1hHkSmJvXhKwaeMO0DjPBWpAMf7imhySA=;
        b=tLdgJO+iW685XIRr2n7aqqIVJqeLQjGHYUSKPmtmTtiD2jONLqdegUedidI6mkq7Jq
         R/rqH3fx/tyKdNfLICMDdevlq7Mu6Ze3gEsVW2c7Rrm8CLmwZZfjU2rgTzPycbwTgeJ5
         FRIF54m7tXU+WqrOm33JO6WV9/E/BUhDrvm2sVz35iHi2RP3J0fwcG4P+HUjX5DH9cyd
         F6sEb2DigpDYf1zGH9+h0mq/ZlvUqjSXWFE/4IsCQSEvbIKUfHFJvzU+RMAkqrdYd8rv
         hPwMD5BJlTu2ttaVE4K9CW/q4zFlWWAvr9z6ceGAVQiai1IpHTdnwUSmNbzdWQFaTHI7
         xRFA==
X-Gm-Message-State: AOAM5326Mef61GLZFZpMFV3CrBfZ1F8ZeE3BqNcyKHOWF1PMrH8BZNLm
        cWRKTx9q7qGXzzsU3MGOByKJcZZPRhVEGw==
X-Google-Smtp-Source: ABdhPJxm6+KxRPJbvE5SM0Aoei44xN8ipyNJmdoDl9H7SxlJC1wnpI/qgX2QxpM1yZzGY6D924v4Vg==
X-Received: by 2002:ac8:6bc6:: with SMTP id b6mr2626921qtt.232.1610420749843;
        Mon, 11 Jan 2021 19:05:49 -0800 (PST)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id c7sm814235qkm.99.2021.01.11.19.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 19:05:49 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        bjorn.andersson@linaro.org
Cc:     ebiggers@google.com, ardb@kernel.org, sivaprak@codeaurora.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/6] drivers: crypto: qce: skcipher: Fix regressions found during fuzz testing
Date:   Mon, 11 Jan 2021 22:05:42 -0500
Message-Id: <20210112030545.669480-4-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210112030545.669480-1-thara.gopinath@linaro.org>
References: <20210112030545.669480-1-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following fixes for the supported encryption
algorithms in the Qualcomm crypto engine(CE)
1. Return unsupported if key1 = key2 for AES XTS algorithm since CE
does not support this and the operation causes the engine to hang.
2. Return unsupprted if any three keys are same for DES3 algorithms
since CE does not support this and the operation causes the engine to
hang.
3. Return unsupported for 0 length plain texts since crypto engine BAM
dma does not support 0 length data.
4. ECB messages do not have an IV and hence set the ivsize to 0.
5. Ensure that the data passed for ECB/CBC encryption/decryption is
blocksize aligned. Otherwise the CE hangs on the operation.
6. Allow messages of length less that 512 bytes for all other encryption
algorithms other than AES XTS. The recommendation is only for AES XTS
to have data size greater than 512 bytes.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 drivers/crypto/qce/skcipher.c | 68 ++++++++++++++++++++++++++++++-----
 1 file changed, 60 insertions(+), 8 deletions(-)

diff --git a/drivers/crypto/qce/skcipher.c b/drivers/crypto/qce/skcipher.c
index a2d3da0ad95f..936bfb7c769b 100644
--- a/drivers/crypto/qce/skcipher.c
+++ b/drivers/crypto/qce/skcipher.c
@@ -167,16 +167,32 @@ static int qce_skcipher_setkey(struct crypto_skcipher *ablk, const u8 *key,
 	struct crypto_tfm *tfm = crypto_skcipher_tfm(ablk);
 	struct qce_cipher_ctx *ctx = crypto_tfm_ctx(tfm);
 	unsigned long flags = to_cipher_tmpl(ablk)->alg_flags;
+	unsigned int __keylen;
 	int ret;
 
 	if (!key || !keylen)
 		return -EINVAL;
 
-	switch (IS_XTS(flags) ? keylen >> 1 : keylen) {
+	/*
+	 * AES XTS key1 = key2 not supported by crypto engine.
+	 * Revisit to request a fallback cipher in this case.
+	 */
+	if (IS_XTS(flags)) {
+		__keylen = keylen >> 1;
+		if (!memcmp(key, key + __keylen, __keylen))
+			return -EINVAL;
+	} else {
+		__keylen = keylen;
+	}
+	switch (__keylen) {
 	case AES_KEYSIZE_128:
 	case AES_KEYSIZE_256:
 		memcpy(ctx->enc_key, key, keylen);
 		break;
+	case AES_KEYSIZE_192:
+		break;
+	default:
+		return -EINVAL;
 	}
 
 	ret = crypto_skcipher_setkey(ctx->fallback, key, keylen);
@@ -204,12 +220,27 @@ static int qce_des3_setkey(struct crypto_skcipher *ablk, const u8 *key,
 			   unsigned int keylen)
 {
 	struct qce_cipher_ctx *ctx = crypto_skcipher_ctx(ablk);
+	u32 _key[6];
 	int err;
 
 	err = verify_skcipher_des3_key(ablk, key);
 	if (err)
 		return err;
 
+	/*
+	 * The crypto engine does not support any two keys
+	 * being the same for triple des algorithms. The
+	 * verify_skcipher_des3_key does not check for all the
+	 * below conditions. Return -ENOKEY in case any two keys
+	 * are the same. Revisit to see if a fallback cipher
+	 * is needed to handle this condition.
+	 */
+	memcpy(_key, key, DES3_EDE_KEY_SIZE);
+	if (!((_key[0] ^ _key[2]) | (_key[1] ^ _key[3])) ||
+	    !((_key[2] ^ _key[4]) | (_key[3] ^ _key[5])) ||
+	    !((_key[0] ^ _key[4]) | (_key[1] ^ _key[5])))
+		return -ENOKEY;
+
 	ctx->enc_keylen = keylen;
 	memcpy(ctx->enc_key, key, keylen);
 	return 0;
@@ -221,6 +252,7 @@ static int qce_skcipher_crypt(struct skcipher_request *req, int encrypt)
 	struct qce_cipher_ctx *ctx = crypto_skcipher_ctx(tfm);
 	struct qce_cipher_reqctx *rctx = skcipher_request_ctx(req);
 	struct qce_alg_template *tmpl = to_cipher_tmpl(tfm);
+	unsigned int blocksize = crypto_skcipher_blocksize(tfm);
 	int keylen;
 	int ret;
 
@@ -228,14 +260,34 @@ static int qce_skcipher_crypt(struct skcipher_request *req, int encrypt)
 	rctx->flags |= encrypt ? QCE_ENCRYPT : QCE_DECRYPT;
 	keylen = IS_XTS(rctx->flags) ? ctx->enc_keylen >> 1 : ctx->enc_keylen;
 
-	/* qce is hanging when AES-XTS request len > QCE_SECTOR_SIZE and
-	 * is not a multiple of it; pass such requests to the fallback
+	/* CE does not handle 0 length messages */
+	if (!req->cryptlen)
+		return -EINVAL;
+
+	/*
+	 * ECB and CBC algorithms require message lengths to be
+	 * multiples of block size.
+	 * TODO: The spec says AES CBC mode for certain versions
+	 * of crypto engine can handle partial blocks as well.
+	 * Test and enable such messages.
+	 */
+	if (IS_ECB(rctx->flags) || IS_CBC(rctx->flags))
+		if (!IS_ALIGNED(req->cryptlen, blocksize))
+			return -EINVAL;
+
+	/*
+	 * Conditions for requesting a fallback cipher
+	 * AES-192 (not supported by crypto engine (CE))
+	 * AES-XTS request with len <= 512 byte (not recommended to use CE)
+	 * AES-XTS request with len > QCE_SECTOR_SIZE and
+	 * is not a multiple of it.(Revisit this condition to check if it is
+	 * needed in all versions of CE)
 	 */
 	if (IS_AES(rctx->flags) &&
-	    (((keylen != AES_KEYSIZE_128 && keylen != AES_KEYSIZE_256) ||
-	      req->cryptlen <= aes_sw_max_len) ||
-	     (IS_XTS(rctx->flags) && req->cryptlen > QCE_SECTOR_SIZE &&
-	      req->cryptlen % QCE_SECTOR_SIZE))) {
+	    ((keylen != AES_KEYSIZE_128 && keylen != AES_KEYSIZE_256) ||
+	    (IS_XTS(rctx->flags) && ((req->cryptlen <= aes_sw_max_len) ||
+	    (req->cryptlen > QCE_SECTOR_SIZE &&
+	    req->cryptlen % QCE_SECTOR_SIZE))))) {
 		skcipher_request_set_tfm(&rctx->fallback_req, ctx->fallback);
 		skcipher_request_set_callback(&rctx->fallback_req,
 					      req->base.flags,
@@ -307,7 +359,7 @@ static const struct qce_skcipher_def skcipher_def[] = {
 		.name		= "ecb(aes)",
 		.drv_name	= "ecb-aes-qce",
 		.blocksize	= AES_BLOCK_SIZE,
-		.ivsize		= AES_BLOCK_SIZE,
+		.ivsize		= 0,
 		.min_keysize	= AES_MIN_KEY_SIZE,
 		.max_keysize	= AES_MAX_KEY_SIZE,
 	},
-- 
2.25.1

