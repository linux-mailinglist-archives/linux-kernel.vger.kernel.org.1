Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2D9E3027FC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 17:37:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730802AbhAYQfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 11:35:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730783AbhAYQfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 11:35:06 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C06C06178B
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 08:34:26 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id h192so15415395oib.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 08:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IzcX4KEe4k8MwWgjN00hmk2HbqHi/ERZ8/ypGsuqBDk=;
        b=jCrVnRF/Q9ht2J9+rWWhrEp1DmYm2wmHsI8fUBG5rkbxf5DIA05mLLazPfp+ntr71c
         u+EiOz1X/dn0Xvc8l1qYNLQMShek63SveoofT4JxP7KCg0Cr0NZCpJNO3WJtIChaDRq5
         HH6FSjuBC9JvZrZmmNAvAvHOHC4Gr2x1Paj2+KoUTmHexp2ggr2Sry7jfPCC9jO/KWkd
         Kb1KCYiBcpksswv7Kg9Vgi7jRlS0N3UPU7d851bxveDCJEnGSftzca8w/6aIr+yof1EK
         5a6CwkcIEiBW7l/5XMawgMlVzUsBoGR8VkByfYFyLBHD48QN2ewy8FiJOwoO4600/YCa
         fz9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IzcX4KEe4k8MwWgjN00hmk2HbqHi/ERZ8/ypGsuqBDk=;
        b=A6hYldpY2qEje7s3rBxLGbrtWgmJiWgF2mugecImAysy4p1ZO6LF6TjG1QN+yC3K2l
         e67ixWp+s5DjL6VWS4F1qFSm4yCVCqKy3G8WVqLpelPSLyQGuZp0dsO6W1y3COs3/+l8
         3B0z3E/9KHyP9wSFMG1w86q1y920cqouZH/DxdzQ8gFO3jKyEfR4pxKzoDpwxNP0st7n
         MHEsyw/J+u9j1O72GxIy0y7TKPvM9uKSnsmwmv7NUjIkeofGm9HxnPAd1NVGQESh4HOg
         gnWrsq2bY0QUxgamWOR6lHp0/KPPBhdEZhtossfPoyISgwQaHaGQhv1Fq/AHTZnzRRY5
         +UXQ==
X-Gm-Message-State: AOAM531CNn9EUXwMe+NbDbaokgRlpAs/U9G3/2F5f8XPbzPxbzxygbzR
        4hAAhI877R9Ae/9oF7HqQbksDg==
X-Google-Smtp-Source: ABdhPJyWrMJWD3mzNRrRqJiyDpFS3aKhsj5396TIk2Jgl1VojA+HGq4/m/VFgkJFZB/BgoVLv0eJ6w==
X-Received: by 2002:aca:add7:: with SMTP id w206mr643177oie.86.1611592465558;
        Mon, 25 Jan 2021 08:34:25 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id q26sm2389731otn.67.2021.01.25.08.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 08:34:24 -0800 (PST)
Date:   Mon, 25 Jan 2021 10:34:23 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        ebiggers@google.com, ardb@kernel.org, sivaprak@codeaurora.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/6] drivers: crypto: qce: Remove totallen and offset
 in qce_start
Message-ID: <YA7zD8EpiEUB+nLv@builder.lan>
References: <20210120184843.3217775-1-thara.gopinath@linaro.org>
 <20210120184843.3217775-7-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210120184843.3217775-7-thara.gopinath@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 20 Jan 12:48 CST 2021, Thara Gopinath wrote:

> totallen is used to get the size of the data to be transformed.
> This is also available via nbytes or cryptlen in the qce_sha_reqctx
> and qce_cipher_ctx. Similarly offset convey nothing for the supported
> encryption and authentication transformations and is always 0.
> Remove these two redundant parameters in qce_start.
> 

Please drop "drivers: " from $subject.

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> ---
>  drivers/crypto/qce/common.c   | 17 +++++++----------
>  drivers/crypto/qce/common.h   |  3 +--
>  drivers/crypto/qce/sha.c      |  2 +-
>  drivers/crypto/qce/skcipher.c |  2 +-
>  4 files changed, 10 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/crypto/qce/common.c b/drivers/crypto/qce/common.c
> index f7bc701a4aa2..dceb9579d87a 100644
> --- a/drivers/crypto/qce/common.c
> +++ b/drivers/crypto/qce/common.c
> @@ -140,8 +140,7 @@ static u32 qce_auth_cfg(unsigned long flags, u32 key_size)
>  	return cfg;
>  }
>  
> -static int qce_setup_regs_ahash(struct crypto_async_request *async_req,
> -				u32 totallen, u32 offset)
> +static int qce_setup_regs_ahash(struct crypto_async_request *async_req)
>  {
>  	struct ahash_request *req = ahash_request_cast(async_req);
>  	struct crypto_ahash *ahash = __crypto_ahash_cast(async_req->tfm);
> @@ -306,8 +305,7 @@ static void qce_xtskey(struct qce_device *qce, const u8 *enckey,
>  	qce_write(qce, REG_ENCR_XTS_DU_SIZE, cryptlen);
>  }
>  
> -static int qce_setup_regs_skcipher(struct crypto_async_request *async_req,
> -				     u32 totallen, u32 offset)
> +static int qce_setup_regs_skcipher(struct crypto_async_request *async_req)
>  {
>  	struct skcipher_request *req = skcipher_request_cast(async_req);
>  	struct qce_cipher_reqctx *rctx = skcipher_request_ctx(req);
> @@ -367,7 +365,7 @@ static int qce_setup_regs_skcipher(struct crypto_async_request *async_req,
>  
>  	qce_write(qce, REG_ENCR_SEG_CFG, encr_cfg);
>  	qce_write(qce, REG_ENCR_SEG_SIZE, rctx->cryptlen);
> -	qce_write(qce, REG_ENCR_SEG_START, offset & 0xffff);
> +	qce_write(qce, REG_ENCR_SEG_START, 0);
>  
>  	if (IS_CTR(flags)) {
>  		qce_write(qce, REG_CNTR_MASK, ~0);
> @@ -376,7 +374,7 @@ static int qce_setup_regs_skcipher(struct crypto_async_request *async_req,
>  		qce_write(qce, REG_CNTR_MASK2, ~0);
>  	}
>  
> -	qce_write(qce, REG_SEG_SIZE, totallen);
> +	qce_write(qce, REG_SEG_SIZE, rctx->cryptlen);
>  
>  	/* get little endianness */
>  	config = qce_config_reg(qce, 1);
> @@ -388,17 +386,16 @@ static int qce_setup_regs_skcipher(struct crypto_async_request *async_req,
>  }
>  #endif
>  
> -int qce_start(struct crypto_async_request *async_req, u32 type, u32 totallen,
> -	      u32 offset)
> +int qce_start(struct crypto_async_request *async_req, u32 type)
>  {
>  	switch (type) {
>  #ifdef CONFIG_CRYPTO_DEV_QCE_SKCIPHER
>  	case CRYPTO_ALG_TYPE_SKCIPHER:
> -		return qce_setup_regs_skcipher(async_req, totallen, offset);
> +		return qce_setup_regs_skcipher(async_req);
>  #endif
>  #ifdef CONFIG_CRYPTO_DEV_QCE_SHA
>  	case CRYPTO_ALG_TYPE_AHASH:
> -		return qce_setup_regs_ahash(async_req, totallen, offset);
> +		return qce_setup_regs_ahash(async_req);
>  #endif
>  	default:
>  		return -EINVAL;
> diff --git a/drivers/crypto/qce/common.h b/drivers/crypto/qce/common.h
> index 85ba16418a04..3bc244bcca2d 100644
> --- a/drivers/crypto/qce/common.h
> +++ b/drivers/crypto/qce/common.h
> @@ -94,7 +94,6 @@ struct qce_alg_template {
>  void qce_cpu_to_be32p_array(__be32 *dst, const u8 *src, unsigned int len);
>  int qce_check_status(struct qce_device *qce, u32 *status);
>  void qce_get_version(struct qce_device *qce, u32 *major, u32 *minor, u32 *step);
> -int qce_start(struct crypto_async_request *async_req, u32 type, u32 totallen,
> -	      u32 offset);
> +int qce_start(struct crypto_async_request *async_req, u32 type);
>  
>  #endif /* _COMMON_H_ */
> diff --git a/drivers/crypto/qce/sha.c b/drivers/crypto/qce/sha.c
> index dd263c5e4dd8..a079e92b4e75 100644
> --- a/drivers/crypto/qce/sha.c
> +++ b/drivers/crypto/qce/sha.c
> @@ -113,7 +113,7 @@ static int qce_ahash_async_req_handle(struct crypto_async_request *async_req)
>  
>  	qce_dma_issue_pending(&qce->dma);
>  
> -	ret = qce_start(async_req, tmpl->crypto_alg_type, 0, 0);
> +	ret = qce_start(async_req, tmpl->crypto_alg_type);
>  	if (ret)
>  		goto error_terminate;
>  
> diff --git a/drivers/crypto/qce/skcipher.c b/drivers/crypto/qce/skcipher.c
> index d78b932441ab..a93fd3fd5f1a 100644
> --- a/drivers/crypto/qce/skcipher.c
> +++ b/drivers/crypto/qce/skcipher.c
> @@ -143,7 +143,7 @@ qce_skcipher_async_req_handle(struct crypto_async_request *async_req)
>  
>  	qce_dma_issue_pending(&qce->dma);
>  
> -	ret = qce_start(async_req, tmpl->crypto_alg_type, req->cryptlen, 0);
> +	ret = qce_start(async_req, tmpl->crypto_alg_type);
>  	if (ret)
>  		goto error_terminate;
>  
> -- 
> 2.25.1
> 
