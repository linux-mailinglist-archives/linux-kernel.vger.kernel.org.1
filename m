Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E38202F2685
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 04:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387399AbhALDGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 22:06:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733259AbhALDG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 22:06:29 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82927C061795
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 19:05:48 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id j26so734811qtq.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 19:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U+6t2Ro0fRT+FUrbsbn2zgmBqk6HPbwcTPoVJfJrGfA=;
        b=qQVsREepuk6monN1RMMdMSpkfXgi+K/brCAbYu3BlJMQk0qtxhPxVuiYpxLR5GTtoQ
         Bn1PYR1L0Eo3+kJ+RTQjfCvCdm80Cf+dauF1l2G5LlBhySu27luCq6VL4BarBgcd2gKq
         eNdeCPuyDNlbTylh/BS5swkXupkAfMwd4UYz7ikEapPZLaw4OHg7vhiaGlbkObBKV2PT
         KaDuceLCzDxPlMbgE9oLaR9dqND7/To65UfiSzu3I4CUojkLdaqGTAuxlH1QF78OAYob
         mIFXo8xmxHIEKElAA10k8ILLA5vUT3G02qhSuj7/E4/RI/h+yraYiVVLSheyNO+Du3jZ
         LnhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U+6t2Ro0fRT+FUrbsbn2zgmBqk6HPbwcTPoVJfJrGfA=;
        b=R9CqXVb8JJBZ5u3SiEkK4Ih1r7L6bkDOoRo3teAxFB5TkJ5D+5JYORQBkeg0MNrXbt
         22lXfWe6PpNTL6csj/z9fYvq4/WaN64lWDp0rIRVWhnOyElT76Jfe31497huK87wzyQk
         jLtlSCDnpIEJ/Bynl/s+WC5fMrYV7Jg7XOZ6qoNeYM9DBJv/b8+3AnLjKXmAMHMQT9Pn
         4AARcvt5TMQpQ8WQxgyx6NAlkI10PhY2ZpYEdWwvdS6FC5m7kKGyZ4oJIYEiJk0TVTEn
         4rYgrLPneFidZl8jU4oCLbtjTJaSEsLHgyMOKI/ZUP7gibmYkJzrIIEPYVxIXUcIsZuW
         8LXg==
X-Gm-Message-State: AOAM531KPFa9eFY9xsSeg/28FirPzvIlj4l804FdvF58XO5+4TcxRSLM
        uK2veuMBfwnY11+qBjnimVewOA==
X-Google-Smtp-Source: ABdhPJzjD0mctef312d91ysSszKAxbZKpXIwFaCIgkVANeOg/DNvf0ONAVu/WOPJOuNMXJpsm9pbog==
X-Received: by 2002:ac8:37f4:: with SMTP id e49mr2678821qtc.193.1610420747715;
        Mon, 11 Jan 2021 19:05:47 -0800 (PST)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id c7sm814235qkm.99.2021.01.11.19.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 19:05:46 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        bjorn.andersson@linaro.org
Cc:     ebiggers@google.com, ardb@kernel.org, sivaprak@codeaurora.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/6] drivers: crypto: qce: sha: Restore/save ahash state with custom struct in export/import
Date:   Mon, 11 Jan 2021 22:05:40 -0500
Message-Id: <20210112030545.669480-2-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210112030545.669480-1-thara.gopinath@linaro.org>
References: <20210112030545.669480-1-thara.gopinath@linaro.org>
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

To fix these issues, save and restore the partial transformation state
using the newly introduced qce_sha_saved_state struct. This ensures that
all the pieces required to properly restart the transformation is captured
and restored back

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---

v1->v2:
	- Introduced custom struct qce_sha_saved_state to store and
	  restore partial sha transformation. v1 was re-using
	  qce_sha_reqctx to save and restore partial states and this
	  could lead to potential memcpy issues around pointer copying.

 drivers/crypto/qce/sha.c | 122 +++++++++++----------------------------
 1 file changed, 34 insertions(+), 88 deletions(-)

diff --git a/drivers/crypto/qce/sha.c b/drivers/crypto/qce/sha.c
index 61c418c12345..08aed03e2b59 100644
--- a/drivers/crypto/qce/sha.c
+++ b/drivers/crypto/qce/sha.c
@@ -12,9 +12,15 @@
 #include "core.h"
 #include "sha.h"
 
-/* crypto hw padding constant for first operation */
-#define SHA_PADDING		64
-#define SHA_PADDING_MASK	(SHA_PADDING - 1)
+struct qce_sha_saved_state {
+	u8 pending_buf[QCE_SHA_MAX_BLOCKSIZE];
+	u8 partial_digest[QCE_SHA_MAX_DIGESTSIZE];
+	__be32 byte_count[2];
+	unsigned int pending_buflen;
+	unsigned int flags;
+	u64 count;
+	bool first_blk;
+};
 
 static LIST_HEAD(ahash_algs);
 
@@ -139,97 +145,37 @@ static int qce_ahash_init(struct ahash_request *req)
 
 static int qce_ahash_export(struct ahash_request *req, void *out)
 {
-	struct crypto_ahash *ahash = crypto_ahash_reqtfm(req);
 	struct qce_sha_reqctx *rctx = ahash_request_ctx(req);
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
-	struct qce_sha_reqctx *rctx = ahash_request_ctx(req);
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
+	struct qce_sha_saved_state *export_state = out;
 
-	rctx->byte_count[0] = (__force __be32)(count & ~SHA_PADDING_MASK);
-	rctx->byte_count[1] = (__force __be32)(count >> 32);
-	qce_cpu_to_be32p_array((__be32 *)rctx->digest, (const u8 *)state,
-			       digestsize);
-	rctx->buflen = (unsigned int)(in_count & (blocksize - 1));
+	memcpy(export_state->pending_buf, rctx->buf, rctx->buflen);
+	memcpy(export_state->partial_digest, rctx->digest,
+	       sizeof(rctx->digest));
+	memcpy(export_state->byte_count, rctx->byte_count, 2);
+	export_state->pending_buflen = rctx->buflen;
+	export_state->count = rctx->count;
+	export_state->first_blk = rctx->first_blk;
+	export_state->flags = rctx->flags;
 
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
-
-		ret = qce_import_common(req, state->count, state->state,
-					state->buffer, hmac);
-	} else if (IS_SHA256(flags) || IS_SHA256_HMAC(flags)) {
-		const struct sha256_state *state = in;
+	struct qce_sha_reqctx *rctx = ahash_request_ctx(req);
+	struct qce_sha_saved_state *import_state = in;
 
-		ret = qce_import_common(req, state->count, state->state,
-					state->buf, hmac);
-	}
+	memset(rctx, 0, sizeof(*rctx));
+	rctx->count = import_state->count;
+	rctx->buflen = import_state->pending_buflen;
+	rctx->first_blk = import_state->first_blk;
+	rctx->flags = import_state->flags;
+	memcpy(rctx->buf, import_state->pending_buf, rctx->buflen);
+	memcpy(rctx->digest, import_state->partial_digest,
+	       sizeof(rctx->digest));
+	memcpy(rctx->byte_count, import_state->byte_count, 2);
 
-	return ret;
+	return 0;
 }
 
 static int qce_ahash_update(struct ahash_request *req)
@@ -450,7 +396,7 @@ static const struct qce_ahash_def ahash_def[] = {
 		.drv_name	= "sha1-qce",
 		.digestsize	= SHA1_DIGEST_SIZE,
 		.blocksize	= SHA1_BLOCK_SIZE,
-		.statesize	= sizeof(struct sha1_state),
+		.statesize	= sizeof(struct qce_sha_saved_state),
 		.std_iv		= std_iv_sha1,
 	},
 	{
@@ -459,7 +405,7 @@ static const struct qce_ahash_def ahash_def[] = {
 		.drv_name	= "sha256-qce",
 		.digestsize	= SHA256_DIGEST_SIZE,
 		.blocksize	= SHA256_BLOCK_SIZE,
-		.statesize	= sizeof(struct sha256_state),
+		.statesize	= sizeof(struct qce_sha_saved_state),
 		.std_iv		= std_iv_sha256,
 	},
 	{
@@ -468,7 +414,7 @@ static const struct qce_ahash_def ahash_def[] = {
 		.drv_name	= "hmac-sha1-qce",
 		.digestsize	= SHA1_DIGEST_SIZE,
 		.blocksize	= SHA1_BLOCK_SIZE,
-		.statesize	= sizeof(struct sha1_state),
+		.statesize	= sizeof(struct qce_sha_saved_state),
 		.std_iv		= std_iv_sha1,
 	},
 	{
@@ -477,7 +423,7 @@ static const struct qce_ahash_def ahash_def[] = {
 		.drv_name	= "hmac-sha256-qce",
 		.digestsize	= SHA256_DIGEST_SIZE,
 		.blocksize	= SHA256_BLOCK_SIZE,
-		.statesize	= sizeof(struct sha256_state),
+		.statesize	= sizeof(struct qce_sha_saved_state),
 		.std_iv		= std_iv_sha256,
 	},
 };
-- 
2.25.1

