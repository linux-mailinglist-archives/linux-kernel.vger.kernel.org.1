Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4617D3027EE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 17:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730775AbhAYQdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 11:33:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730763AbhAYQc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 11:32:57 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B0CC06178C
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 08:32:16 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id i20so13312116otl.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 08:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7wM9j0NmA+4NCioKAFo7iToU4fViUTFlRLMQnGMrXNk=;
        b=KsGUFXVFxfjbbXtXhs0lhCDVXgarAmZ4nMCt1BNDjKBtjhVtgaRYXX7+phfMlOjjUh
         SpNSW7SUWGZpc11eF4KT1ZT8OZCoWmlzYzs2xFQxzNzNDswA9ysPbRVVbEuHxg+FXjx0
         1Rz+N9cl/cvoQONSrXWps4vCjks3ImqzBdh5LD8ulBjtn0wlMtijSFQ+IbY2zCZonhvD
         NVI8R8yj+ROhiZ5wAo9sX18AYmeTtRkaixRhqF80YwlvKQgOfOQd4pF9osxBOWsh8XLE
         X4NgTnWfOFteeI4lSFPzA96B+TxxBVPVrshFfdIljSQmOTXv0cNBgRN8ZQvq4b2QXtv4
         T+sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7wM9j0NmA+4NCioKAFo7iToU4fViUTFlRLMQnGMrXNk=;
        b=HmBJfQsky0PlVYsmC66Gi71J5KE/eyNSZJ7UdDT4Umk47Z+XHF0lFowunLSoq37T+g
         uOxnxPAQGlmQP3TtLY6WoJnz2C4aJWi+4zYrXHRwv0fsDBQsM6jFP16EhFVoEesoPsIM
         bezHqQu652dX3gUfE8wPEjd65IdheFb+v7HoeMOeB+tIS9XUG34OS1CCYHH2tLIeY8tI
         4fscyOi2ioO6vaQZzJCrcl0uVsxo+YPkdED1gnyc5axBa50gWbp9SWgWjEG66yOdqbFO
         1QYT9eBkf2Q6HKyCp7gNjmGxHcibc5tL9Pw92RAFok6zx3WHM6f7AojaB8gvDF2oOK4f
         oa1g==
X-Gm-Message-State: AOAM532H6Sd2gFIyGlrCLmUf8JdEcjN2RQjdvGheY09XAAWcn163a6R6
        qvlu64fx+UteUbXjgAiGark2JA==
X-Google-Smtp-Source: ABdhPJweEWp9FLUDyOiNygFsnpmUpVHPjSLC6uPkcAYJUzp0nqWKZ4rzsEErke2GCAyw3KqLnS3uAg==
X-Received: by 2002:a9d:7ccd:: with SMTP id r13mr1003348otn.253.1611592335446;
        Mon, 25 Jan 2021 08:32:15 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id h30sm3252354ooi.12.2021.01.25.08.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 08:32:14 -0800 (PST)
Date:   Mon, 25 Jan 2021 10:32:13 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        ebiggers@google.com, ardb@kernel.org, sivaprak@codeaurora.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/6] drivers: crypto: qce: Remover src_tbl from
 qce_cipher_reqctx
Message-ID: <YA7yjaz6kxxs8eTl@builder.lan>
References: <20210120184843.3217775-1-thara.gopinath@linaro.org>
 <20210120184843.3217775-6-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210120184843.3217775-6-thara.gopinath@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 20 Jan 12:48 CST 2021, Thara Gopinath wrote:

> src_table is unused and hence remove it from struct qce_cipher_reqctx
> 
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> ---
>  drivers/crypto/qce/cipher.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/crypto/qce/cipher.h b/drivers/crypto/qce/cipher.h
> index cffa9fc628ff..850f257d00f3 100644
> --- a/drivers/crypto/qce/cipher.h
> +++ b/drivers/crypto/qce/cipher.h
> @@ -40,7 +40,6 @@ struct qce_cipher_reqctx {
>  	struct scatterlist result_sg;
>  	struct sg_table dst_tbl;
>  	struct scatterlist *dst_sg;
> -	struct sg_table src_tbl;

Please also remove the associated kerneldoc entry.

Regards,
Bjorn

>  	struct scatterlist *src_sg;
>  	unsigned int cryptlen;
>  	struct skcipher_request fallback_req;	// keep at the end
> -- 
> 2.25.1
> 
