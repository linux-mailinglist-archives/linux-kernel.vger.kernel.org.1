Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9C0B3027E8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 17:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730647AbhAYQce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 11:32:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727840AbhAYQb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 11:31:56 -0500
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B60D3C061786
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 08:31:15 -0800 (PST)
Received: by mail-oo1-xc32.google.com with SMTP id u7so2794799ooq.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 08:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=40kUnDJvOmh5mDDNnYdWwiYEGd/OPR4RTz7rIN8oEbE=;
        b=XZ5hLoU7Gt6LqV97bM4MM0VSQMQ3a5EMjK+QSRvhR84Kb52hEeZWrMsybNPdnWX0Sk
         88Nqt/fDlA8Tc/UOdTVCuKqssUmGUWrlbNExFeI5QRa7MpNFgG+Pi1jZ9jUCDD34BT8M
         eLMTCfGsbyW0dJLWani4JdaOD9o0rdv0zmH57PnM5CmZJSN9Mv02mBYJI+fVGEtNPZCu
         Utd7QwG32ejzUqe0TTuZ0lr5fINVkYBVByLTFVlkm9MvTyIdlWbggyCpLv8bMAB61hKk
         vfBaDUWkAilTTOyTjMvpoUvkXDkpR8sB8gd9jBgI9DFY3ec0WpCzKtAEKidkY2rK4vX7
         rv9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=40kUnDJvOmh5mDDNnYdWwiYEGd/OPR4RTz7rIN8oEbE=;
        b=Wqt+LiU4oy15mQyDijXu4fUExXf1VlIg6bZrySKxyIyCJT280j68PEH/73WksqToBy
         Y8PrjsQA057iOu8+rUF9iAP+b2ChzS12DHEQLMaHdwOaxahxtE/YnKiKIlPFQHXDQRNe
         ScbBroRhZEjCifEJJHW7725jIp9iY7fBTi5d/gFCnDn1bTQn4/O1lvwQhSIsIq7CUhHP
         Pdm8XskDuHuNVA+Gmr4Lln8v04CPdezJGJjqBDy4fTtG0EFhXERLfg3QeZrM4IaoYP/x
         aifrbT83H55t5avaHP12Nv4uQn+Vuh0wbmnON5LVDxJr7PEMKunD3umNmlQKjztqEv4g
         jOKQ==
X-Gm-Message-State: AOAM533yiEyiIu+juLj5mdSli3heOzRrmUcg+B7tCZNooauL1fGDWNSB
        uYD2Lk8DcxUHpuPI5U5Ed23olw==
X-Google-Smtp-Source: ABdhPJx6u0GLpjr7JeuYgLHTAwAsm0aZo1oZtVpfh9nPhjg0TnmSZtnHo8yv6fVIqonJI5LU6elcSQ==
X-Received: by 2002:a4a:e746:: with SMTP id n6mr1024445oov.84.1611592275091;
        Mon, 25 Jan 2021 08:31:15 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id a22sm2869730otp.53.2021.01.25.08.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 08:31:14 -0800 (PST)
Date:   Mon, 25 Jan 2021 10:31:12 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        ebiggers@google.com, ardb@kernel.org, sivaprak@codeaurora.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/6] drivers: crypto: qce: common: Set data unit size
 to message length for AES XTS transformation
Message-ID: <YA7yUD7OqUKBFN83@builder.lan>
References: <20210120184843.3217775-1-thara.gopinath@linaro.org>
 <20210120184843.3217775-5-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210120184843.3217775-5-thara.gopinath@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 20 Jan 12:48 CST 2021, Thara Gopinath wrote:

> Set the register REG_ENCR_XTS_DU_SIZE to cryptlen for AES XTS
> transformation. Anything else causes the engine to return back
> wrong results.
> 
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> ---
>  drivers/crypto/qce/common.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/crypto/qce/common.c b/drivers/crypto/qce/common.c
> index a73db2a5637f..f7bc701a4aa2 100644
> --- a/drivers/crypto/qce/common.c
> +++ b/drivers/crypto/qce/common.c
> @@ -295,15 +295,15 @@ static void qce_xtskey(struct qce_device *qce, const u8 *enckey,
>  {
>  	u32 xtskey[QCE_MAX_CIPHER_KEY_SIZE / sizeof(u32)] = {0};
>  	unsigned int xtsklen = enckeylen / (2 * sizeof(u32));
> -	unsigned int xtsdusize;
>  
>  	qce_cpu_to_be32p_array((__be32 *)xtskey, enckey + enckeylen / 2,
>  			       enckeylen / 2);
>  	qce_write_array(qce, REG_ENCR_XTS_KEY0, xtskey, xtsklen);
>  
> -	/* xts du size 512B */
> -	xtsdusize = min_t(u32, QCE_SECTOR_SIZE, cryptlen);

I wonder if this is a hardware limitation that has gone away in the
newer chips. I am however not able to find anything about it, so I'm in
favor of merging this patch and if anyone actually uses the driver on
the older hardware we'd have to go back and quirk it somehow.

Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> -	qce_write(qce, REG_ENCR_XTS_DU_SIZE, xtsdusize);
> +	/* Set data unit size to cryptlen. Anything else causes
> +	 * crypto engine to return back incorrect results.
> +	 */
> +	qce_write(qce, REG_ENCR_XTS_DU_SIZE, cryptlen);
>  }
>  
>  static int qce_setup_regs_skcipher(struct crypto_async_request *async_req,
> -- 
> 2.25.1
> 
