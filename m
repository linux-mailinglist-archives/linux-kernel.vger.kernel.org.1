Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E64AC2DECE4
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Dec 2020 04:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbgLSDbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 22:31:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbgLSDbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 22:31:11 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4EAEC061285
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 19:30:30 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id p14so4150043qke.6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 19:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NWmBSI3rgfXH89T9/wbJKTlTi6fOQblntPYf8aTknog=;
        b=fdfkMeEbIF/ogIka6MkRNPRsKkbNsk6RNyKoC4E4EK6Nef87HL3SvZ7TgxCXWBP2yc
         yZqRgWMBsiixbHchFzD4Y/ifoUdwXPGH+5IPVRF7T7J7t8uuBXj7g3c0shCyXZB3qtoU
         2wv1RxWdOJnN8vjm3R175fy/bk3vw3oHbyJSfNiZBJZrFdMzEtApq90hBagEr7LJOrgT
         orC8CHJK3Mbj7A5+dlp/Cyt+0f82X4Wvz7Ouv0FRJM+w3rY1TTyzaRskZQz9FuRk2YyC
         h90sq2e22Kwmy3ORYOYADjYI58Vy0M9JEgleHoaPkpIUbRJnM94f6sXl10eZosgXb4rX
         5Jng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NWmBSI3rgfXH89T9/wbJKTlTi6fOQblntPYf8aTknog=;
        b=QUOs/Dn7McrA70Tjx0ciOEPXE6Up9JFUwY2XoD2hmo3+xn/MaUMVIo4v0SOyiAPhPY
         +PLtCWnu+R+OYJeA8BAabamwCoVHJOQO/Dhu/1JfrNp2xpUEDYsxr/2f0lgpE4/qtIj3
         ysO/qzRd80cAFk/vBXj8qPTTULSF9BGc4hm2iXelFmnobQs/l8XAl92w+1inAkpC5Zvc
         Aw4LW7Ts7LgCcWqlbt8e2bu698hZ/S8N1CiDkGEomEFHBauRXPaSvIdeXttqRGZCm5Dk
         TP5bSIqop/AMqqvTVVwcy+zkVRTrxn6hnbtZIUGT4q71IT4MM6qgZIM16swT88wC5DR1
         HiEw==
X-Gm-Message-State: AOAM530VYA6KllQFQ28kQTmetOlbLjNm94OdjMApABD367gacTbG+dOP
        D0+zzzOr5C9d674GWkWpKstEnA==
X-Google-Smtp-Source: ABdhPJwqrzhtWR/fF+LZ85HIC3SEtTYkAcu3bnzvh5Q+ZsMVSAhyFnQ8Ud6fpuQB8Z6mjCm5+/2BIg==
X-Received: by 2002:a05:620a:13a6:: with SMTP id m6mr7935004qki.319.1608348629959;
        Fri, 18 Dec 2020 19:30:29 -0800 (PST)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id y16sm4376045qki.132.2020.12.18.19.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 19:30:29 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        bjorn.andersson@linaro.org
Cc:     ebiggers@google.com, ardb@kernel.org, sivaprak@codeaurora.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] drivers: crypto: qce: sha: Restore/save sha1_state/sha256_state with qce_sha_reqctx in export/import
Date:   Fri, 18 Dec 2020 22:30:22 -0500
Message-Id: <20201219033027.3066042-2-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201219033027.3066042-1-thara.gopinath@linaro.org>
References: <20201219033027.3066042-1-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export and import interfaces save and restore partial transformation
states. The partial states were being stored and restored in struct
sha1_state for sha1/hmac(sha1) transformations and sha256_state for
sha256/hmac(sha256) transformations.This led to a bunch of corner cases
where improper state was being stored and restored. A few of the corner
cases that turned up during testing are:

- wrong byte_count restored if export/import is called twice without h/w
transaction in between
- wrong buflen restored back if the pending buffer
length is exactly the block size.
- wrong state restored if buffer length is 0.

To fix these issues, save and restore the entire qce_sha_rctx structure
instead of parts of it in sha1_state and sha256_state structures.
This in turn simplifies the export and import apis.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 drivers/crypto/qce/sha.c | 93 ++++------------------------------------
 1 file changed, 8 insertions(+), 85 deletions(-)

diff --git a/drivers/crypto/qce/sha.c b/drivers/crypto/qce/sha.c
index 61c418c12345..b8428da6716d 100644
--- a/drivers/crypto/qce/sha.c
+++ b/drivers/crypto/qce/sha.c
@@ -139,97 +139,20 @@ static int qce_ahash_init(struct ahash_request *req)
 
 static int qce_ahash_export(struct ahash_request *req, void *out)
 {
-	struct crypto_ahash *ahash = crypto_ahash_reqtfm(req);
-	struct qce_sha_reqctx *rctx = ahash_request_ctx(req);
-	unsigned long flags = rctx->flags;
-	unsigned int digestsize = crypto_ahash_digestsize(ahash);
-	unsigned int blocksize =
-			crypto_tfm_alg_blocksize(crypto_ahash_tfm(ahash));
-
-	if (IS_SHA1(flags) || IS_SHA1_HMAC(flags)) {
-		struct sha1_state *out_state = out;
-
-		out_state->count = rctx->count;
-		qce_cpu_to_be32p_array((__be32 *)out_state->state,
-				       rctx->digest, digestsize);
-		memcpy(out_state->buffer, rctx->buf, blocksize);
-	} else if (IS_SHA256(flags) || IS_SHA256_HMAC(flags)) {
-		struct sha256_state *out_state = out;
-
-		out_state->count = rctx->count;
-		qce_cpu_to_be32p_array((__be32 *)out_state->state,
-				       rctx->digest, digestsize);
-		memcpy(out_state->buf, rctx->buf, blocksize);
-	} else {
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-static int qce_import_common(struct ahash_request *req, u64 in_count,
-			     const u32 *state, const u8 *buffer, bool hmac)
-{
-	struct crypto_ahash *ahash = crypto_ahash_reqtfm(req);
 	struct qce_sha_reqctx *rctx = ahash_request_ctx(req);
-	unsigned int digestsize = crypto_ahash_digestsize(ahash);
-	unsigned int blocksize;
-	u64 count = in_count;
-
-	blocksize = crypto_tfm_alg_blocksize(crypto_ahash_tfm(ahash));
-	rctx->count = in_count;
-	memcpy(rctx->buf, buffer, blocksize);
-
-	if (in_count <= blocksize) {
-		rctx->first_blk = 1;
-	} else {
-		rctx->first_blk = 0;
-		/*
-		 * For HMAC, there is a hardware padding done when first block
-		 * is set. Therefore the byte_count must be incremened by 64
-		 * after the first block operation.
-		 */
-		if (hmac)
-			count += SHA_PADDING;
-	}
 
-	rctx->byte_count[0] = (__force __be32)(count & ~SHA_PADDING_MASK);
-	rctx->byte_count[1] = (__force __be32)(count >> 32);
-	qce_cpu_to_be32p_array((__be32 *)rctx->digest, (const u8 *)state,
-			       digestsize);
-	rctx->buflen = (unsigned int)(in_count & (blocksize - 1));
+	memcpy(out, rctx, sizeof(struct qce_sha_reqctx));
 
 	return 0;
 }
 
 static int qce_ahash_import(struct ahash_request *req, const void *in)
 {
-	struct qce_sha_reqctx *rctx;
-	unsigned long flags;
-	bool hmac;
-	int ret;
-
-	ret = qce_ahash_init(req);
-	if (ret)
-		return ret;
-
-	rctx = ahash_request_ctx(req);
-	flags = rctx->flags;
-	hmac = IS_SHA_HMAC(flags);
-
-	if (IS_SHA1(flags) || IS_SHA1_HMAC(flags)) {
-		const struct sha1_state *state = in;
+	struct qce_sha_reqctx *rctx = ahash_request_ctx(req);
 
-		ret = qce_import_common(req, state->count, state->state,
-					state->buffer, hmac);
-	} else if (IS_SHA256(flags) || IS_SHA256_HMAC(flags)) {
-		const struct sha256_state *state = in;
+	memcpy(rctx, in, sizeof(struct qce_sha_reqctx));
 
-		ret = qce_import_common(req, state->count, state->state,
-					state->buf, hmac);
-	}
-
-	return ret;
+	return 0;
 }
 
 static int qce_ahash_update(struct ahash_request *req)
@@ -450,7 +373,7 @@ static const struct qce_ahash_def ahash_def[] = {
 		.drv_name	= "sha1-qce",
 		.digestsize	= SHA1_DIGEST_SIZE,
 		.blocksize	= SHA1_BLOCK_SIZE,
-		.statesize	= sizeof(struct sha1_state),
+		.statesize	= sizeof(struct qce_sha_reqctx),
 		.std_iv		= std_iv_sha1,
 	},
 	{
@@ -459,7 +382,7 @@ static const struct qce_ahash_def ahash_def[] = {
 		.drv_name	= "sha256-qce",
 		.digestsize	= SHA256_DIGEST_SIZE,
 		.blocksize	= SHA256_BLOCK_SIZE,
-		.statesize	= sizeof(struct sha256_state),
+		.statesize	= sizeof(struct qce_sha_reqctx),
 		.std_iv		= std_iv_sha256,
 	},
 	{
@@ -468,7 +391,7 @@ static const struct qce_ahash_def ahash_def[] = {
 		.drv_name	= "hmac-sha1-qce",
 		.digestsize	= SHA1_DIGEST_SIZE,
 		.blocksize	= SHA1_BLOCK_SIZE,
-		.statesize	= sizeof(struct sha1_state),
+		.statesize	= sizeof(struct qce_sha_reqctx),
 		.std_iv		= std_iv_sha1,
 	},
 	{
@@ -477,7 +400,7 @@ static const struct qce_ahash_def ahash_def[] = {
 		.drv_name	= "hmac-sha256-qce",
 		.digestsize	= SHA256_DIGEST_SIZE,
 		.blocksize	= SHA256_BLOCK_SIZE,
-		.statesize	= sizeof(struct sha256_state),
+		.statesize	= sizeof(struct qce_sha_reqctx),
 		.std_iv		= std_iv_sha256,
 	},
 };
-- 
2.25.1

