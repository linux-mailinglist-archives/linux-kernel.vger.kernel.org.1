Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9844730277F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 17:10:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728538AbhAYQJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 11:09:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730606AbhAYQHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 11:07:54 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE956C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 08:07:13 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id a109so13236025otc.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 08:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Cx8G4NPjEb93rADBGGOwtfugNPL7pc68k4ImCw5jdpo=;
        b=Y6Nq5LMYotw0yvJM6E5vHF/u3N2hdP3fvDGEdFDjLEedbgVbg0bdwXRv6HqamnUGh/
         ieayTouXmqFTYIp1kD5GwoFuQzrtN0NzGPjxG36pir7D0/ueIqjrPMXGj1b9U8rYIVwJ
         oUzzroHVv8ZJC5YuYVTkXtwVUuRHX6ZubFPiNMupl4Udq6Kruye1NomHeFEHPb/M6Cc4
         Rl+N+dx9PfCUuBRaiBIvZrSP4ueEJBI83uJGRSq7v9ucVqADmPfW6vnQ3OUML+q6cz7S
         QvnHfDmt7BosrD0XCYuO8sCSp1C+pBaZaaQReB9h4lytZYwBGj9EYVSOoxDNNN6FSdyC
         seMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Cx8G4NPjEb93rADBGGOwtfugNPL7pc68k4ImCw5jdpo=;
        b=WndPO9ErDyxETRPe9XKzRTBqTij4gE8Z9D/tfaushJ/hlS5LwIGEvcfL8jXmCM24C8
         69LsieFPywDirFUY07K01l8QbyQzLcGJbRVNpFQOtG17pVLDLiBWAfV+47hKMjqcvnGw
         h9kDdgcIodqhK4nn+VDOOzZ7FfysM8PFhxFNEP7upicDSzhTEqfweIW9Ed1CHIbfxx/H
         mtoeG9qH3kehFsfiQRFob4eZz3P/p/25/ybFVyl2Lc4s3BY+fVLIs/rIXQG8Zuw8y1Zh
         hcvDmR5qg9cGgzSZ/YyU9OFibXN+F1yLKuLWQz6HQOQMLvTRRBAktp8GTwfXTgCK/g81
         +X7w==
X-Gm-Message-State: AOAM533B/Rg11Ysn+AK57/hRCuN5WMNqHKyqKKgalkgSTTEYFShsmejd
        nDUDNp+V4ul8Q4+0o3wGPLCOYg==
X-Google-Smtp-Source: ABdhPJxN8Km3clFPY8F7qmnZCT1ObUXRcvVc0ZqqwYKYczbgSASZQ0dKbfEqIztYGBY9EXVYDM5JmQ==
X-Received: by 2002:a9d:6353:: with SMTP id y19mr882993otk.48.1611590833210;
        Mon, 25 Jan 2021 08:07:13 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id 69sm3525797otc.76.2021.01.25.08.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 08:07:12 -0800 (PST)
Date:   Mon, 25 Jan 2021 10:07:10 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        ebiggers@google.com, ardb@kernel.org, sivaprak@codeaurora.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/6] drivers: crypto: qce: sha: Restore/save ahash
 state with custom struct in export/import
Message-ID: <YA7srll6wXlSDASq@builder.lan>
References: <20210120184843.3217775-1-thara.gopinath@linaro.org>
 <20210120184843.3217775-2-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210120184843.3217775-2-thara.gopinath@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 20 Jan 12:48 CST 2021, Thara Gopinath wrote:

Please drop "drivers: " from $subject.

> Export and import interfaces save and restore partial transformation
> states. The partial states were being stored and restored in struct
> sha1_state for sha1/hmac(sha1) transformations and sha256_state for
> sha256/hmac(sha256) transformations.This led to a bunch of corner cases
> where improper state was being stored and restored. A few of the corner
> cases that turned up during testing are:
> 
> - wrong byte_count restored if export/import is called twice without h/w
> transaction in between
> - wrong buflen restored back if the pending buffer
> length is exactly the block size.
> - wrong state restored if buffer length is 0.
> 
> To fix these issues, save and restore the partial transformation state
> using the newly introduced qce_sha_saved_state struct. This ensures that
> all the pieces required to properly restart the transformation is captured
> and restored back
> 
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> ---
> 
> v1->v2:
> 	- Introduced custom struct qce_sha_saved_state to store and
> 	  restore partial sha transformation. v1 was re-using
> 	  qce_sha_reqctx to save and restore partial states and this
> 	  could lead to potential memcpy issues around pointer copying.
> 
>  drivers/crypto/qce/sha.c | 122 +++++++++++----------------------------
>  1 file changed, 34 insertions(+), 88 deletions(-)
> 
> diff --git a/drivers/crypto/qce/sha.c b/drivers/crypto/qce/sha.c
> index 61c418c12345..08aed03e2b59 100644
> --- a/drivers/crypto/qce/sha.c
> +++ b/drivers/crypto/qce/sha.c
> @@ -12,9 +12,15 @@
>  #include "core.h"
>  #include "sha.h"
>  
> -/* crypto hw padding constant for first operation */
> -#define SHA_PADDING		64
> -#define SHA_PADDING_MASK	(SHA_PADDING - 1)
> +struct qce_sha_saved_state {
> +	u8 pending_buf[QCE_SHA_MAX_BLOCKSIZE];
> +	u8 partial_digest[QCE_SHA_MAX_DIGESTSIZE];
> +	__be32 byte_count[2];
> +	unsigned int pending_buflen;
> +	unsigned int flags;
> +	u64 count;
> +	bool first_blk;
> +};
>  
>  static LIST_HEAD(ahash_algs);
>  
> @@ -139,97 +145,37 @@ static int qce_ahash_init(struct ahash_request *req)
>  
>  static int qce_ahash_export(struct ahash_request *req, void *out)
>  {
> -	struct crypto_ahash *ahash = crypto_ahash_reqtfm(req);
>  	struct qce_sha_reqctx *rctx = ahash_request_ctx(req);
> -	unsigned long flags = rctx->flags;
> -	unsigned int digestsize = crypto_ahash_digestsize(ahash);
> -	unsigned int blocksize =
> -			crypto_tfm_alg_blocksize(crypto_ahash_tfm(ahash));
> -
> -	if (IS_SHA1(flags) || IS_SHA1_HMAC(flags)) {
> -		struct sha1_state *out_state = out;
> -
> -		out_state->count = rctx->count;
> -		qce_cpu_to_be32p_array((__be32 *)out_state->state,
> -				       rctx->digest, digestsize);
> -		memcpy(out_state->buffer, rctx->buf, blocksize);
> -	} else if (IS_SHA256(flags) || IS_SHA256_HMAC(flags)) {
> -		struct sha256_state *out_state = out;
> -
> -		out_state->count = rctx->count;
> -		qce_cpu_to_be32p_array((__be32 *)out_state->state,
> -				       rctx->digest, digestsize);
> -		memcpy(out_state->buf, rctx->buf, blocksize);
> -	} else {
> -		return -EINVAL;
> -	}
> -
> -	return 0;
> -}
> -
> -static int qce_import_common(struct ahash_request *req, u64 in_count,
> -			     const u32 *state, const u8 *buffer, bool hmac)
> -{
> -	struct crypto_ahash *ahash = crypto_ahash_reqtfm(req);
> -	struct qce_sha_reqctx *rctx = ahash_request_ctx(req);
> -	unsigned int digestsize = crypto_ahash_digestsize(ahash);
> -	unsigned int blocksize;
> -	u64 count = in_count;
> -
> -	blocksize = crypto_tfm_alg_blocksize(crypto_ahash_tfm(ahash));
> -	rctx->count = in_count;
> -	memcpy(rctx->buf, buffer, blocksize);
> -
> -	if (in_count <= blocksize) {
> -		rctx->first_blk = 1;
> -	} else {
> -		rctx->first_blk = 0;
> -		/*
> -		 * For HMAC, there is a hardware padding done when first block
> -		 * is set. Therefore the byte_count must be incremened by 64
> -		 * after the first block operation.
> -		 */
> -		if (hmac)
> -			count += SHA_PADDING;
> -	}
> +	struct qce_sha_saved_state *export_state = out;
>  
> -	rctx->byte_count[0] = (__force __be32)(count & ~SHA_PADDING_MASK);
> -	rctx->byte_count[1] = (__force __be32)(count >> 32);
> -	qce_cpu_to_be32p_array((__be32 *)rctx->digest, (const u8 *)state,
> -			       digestsize);
> -	rctx->buflen = (unsigned int)(in_count & (blocksize - 1));
> +	memcpy(export_state->pending_buf, rctx->buf, rctx->buflen);
> +	memcpy(export_state->partial_digest, rctx->digest,
> +	       sizeof(rctx->digest));

No need to wrap this line.

> +	memcpy(export_state->byte_count, rctx->byte_count, 2);

You're only stashing 2 of the 8 bytes here. So you should either copy
sizeof(byte_count) bytes, or perhaps it's more obvious if you just
assigned byte_count[0] and byte_count[1]?

> +	export_state->pending_buflen = rctx->buflen;
> +	export_state->count = rctx->count;
> +	export_state->first_blk = rctx->first_blk;
> +	export_state->flags = rctx->flags;
>  
>  	return 0;
>  }
>  
>  static int qce_ahash_import(struct ahash_request *req, const void *in)
>  {
> -	struct qce_sha_reqctx *rctx;
> -	unsigned long flags;
> -	bool hmac;
> -	int ret;
> -
> -	ret = qce_ahash_init(req);
> -	if (ret)
> -		return ret;
> -
> -	rctx = ahash_request_ctx(req);
> -	flags = rctx->flags;
> -	hmac = IS_SHA_HMAC(flags);
> -
> -	if (IS_SHA1(flags) || IS_SHA1_HMAC(flags)) {
> -		const struct sha1_state *state = in;
> -
> -		ret = qce_import_common(req, state->count, state->state,
> -					state->buffer, hmac);
> -	} else if (IS_SHA256(flags) || IS_SHA256_HMAC(flags)) {
> -		const struct sha256_state *state = in;
> +	struct qce_sha_reqctx *rctx = ahash_request_ctx(req);
> +	struct qce_sha_saved_state *import_state = in;
>  
> -		ret = qce_import_common(req, state->count, state->state,
> -					state->buf, hmac);
> -	}
> +	memset(rctx, 0, sizeof(*rctx));
> +	rctx->count = import_state->count;
> +	rctx->buflen = import_state->pending_buflen;
> +	rctx->first_blk = import_state->first_blk;
> +	rctx->flags = import_state->flags;
> +	memcpy(rctx->buf, import_state->pending_buf, rctx->buflen);
> +	memcpy(rctx->digest, import_state->partial_digest,
> +	       sizeof(rctx->digest));
> +	memcpy(rctx->byte_count, import_state->byte_count, 2);

Same as above, you're just restoring 2 of the 8 bytes.

Regards,
Bjorn

>  
> -	return ret;
> +	return 0;
>  }
>  
>  static int qce_ahash_update(struct ahash_request *req)
> @@ -450,7 +396,7 @@ static const struct qce_ahash_def ahash_def[] = {
>  		.drv_name	= "sha1-qce",
>  		.digestsize	= SHA1_DIGEST_SIZE,
>  		.blocksize	= SHA1_BLOCK_SIZE,
> -		.statesize	= sizeof(struct sha1_state),
> +		.statesize	= sizeof(struct qce_sha_saved_state),
>  		.std_iv		= std_iv_sha1,
>  	},
>  	{
> @@ -459,7 +405,7 @@ static const struct qce_ahash_def ahash_def[] = {
>  		.drv_name	= "sha256-qce",
>  		.digestsize	= SHA256_DIGEST_SIZE,
>  		.blocksize	= SHA256_BLOCK_SIZE,
> -		.statesize	= sizeof(struct sha256_state),
> +		.statesize	= sizeof(struct qce_sha_saved_state),
>  		.std_iv		= std_iv_sha256,
>  	},
>  	{
> @@ -468,7 +414,7 @@ static const struct qce_ahash_def ahash_def[] = {
>  		.drv_name	= "hmac-sha1-qce",
>  		.digestsize	= SHA1_DIGEST_SIZE,
>  		.blocksize	= SHA1_BLOCK_SIZE,
> -		.statesize	= sizeof(struct sha1_state),
> +		.statesize	= sizeof(struct qce_sha_saved_state),
>  		.std_iv		= std_iv_sha1,
>  	},
>  	{
> @@ -477,7 +423,7 @@ static const struct qce_ahash_def ahash_def[] = {
>  		.drv_name	= "hmac-sha256-qce",
>  		.digestsize	= SHA256_DIGEST_SIZE,
>  		.blocksize	= SHA256_BLOCK_SIZE,
> -		.statesize	= sizeof(struct sha256_state),
> +		.statesize	= sizeof(struct qce_sha_saved_state),
>  		.std_iv		= std_iv_sha256,
>  	},
>  };
> -- 
> 2.25.1
> 
