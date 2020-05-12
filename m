Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9AB71CE9DE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 May 2020 02:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbgELA7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 May 2020 20:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbgELA7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 20:59:02 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECCC1C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 17:59:00 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id p25so5534994pfn.11
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 17:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TwHuRNxPbEy8mYDXf8pk2T6sofwkpEQ+jJn9FbtTcxo=;
        b=NkUiRxSigjraS3WE+8oP1tKZ4yDuE7jLtql0CgplLYHwttV6mLR1/TUF/Q1MVJOyTx
         UxGYseDgdk+LNCh585+Er7kyLZkE8zsu6X7k3+eTwZaCH201STrD7K1i2+NjEZyr9vk5
         tWPZ3TmtOZc4qkNquuYwFhJqmjxBNXmOdPccrB5ctoecAKHai7k+djHrlIgw2E0+jSBt
         dzKAsQ7DYHjnM3q6xEnD2TOGqr7IJviehlCQgKbI+ANsG7q2Jlv4oqRI46qRH6b+KNBK
         DikS9Vs3b65O426NyPg/Afxw+fOQBEiQ1jA6I+SYGTuDd8cepZRUCEhiIqM+W70h3o7g
         QZHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TwHuRNxPbEy8mYDXf8pk2T6sofwkpEQ+jJn9FbtTcxo=;
        b=jN35huBUJ7N9cTgmnLRHwhBxupzOYA0ZB3OBSwCfuCE35Z4ZF5B6NnATo6KAH0DVlr
         4UVfpUceWnaf1nO35dPpYGeN0Y6tgZrMet/CYUWcS/qXJoBYDHz9+atChG0yJ4kq8c8L
         MkqqGtmIOCM3gFYhdPacHsuyzelmgCxAeXTb4PPXKchW1pkWxJlIrMQDRyAC0rPrsP3I
         x6tFMLUMXgqXu70ChQjSHjdSJPWsD9WoW5Q4otFl7M/TS4FtFz0cpy9CuIJZlw1tGoML
         AMc6+D9+O3d0f954PJizK4Vhcv0NbO96jEQtKETwMFLHD6tpnriEuxqAkotXtPbc/VoN
         UVDA==
X-Gm-Message-State: AGi0PubBNpcX8w8Vv7t25rPoaB7BvXws6EnhntCA4wq5JJ6HlXt9z8uR
        hb7+zZUmYaRghiltxYidDlYqYLvXMz0=
X-Google-Smtp-Source: APiQypJwJEBcM1EmQHnk4doWfnyeHPF9R7zotlY5IVw07p+XqwIeBDN2yaOR9mnGmE7iw5z+kpmAOg==
X-Received: by 2002:a65:6497:: with SMTP id e23mr17093339pgv.347.1589245140297;
        Mon, 11 May 2020 17:59:00 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id e12sm8902034pgv.16.2020.05.11.17.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 17:58:59 -0700 (PDT)
Date:   Mon, 11 May 2020 17:57:25 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     gregkh@linuxfoundation.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, arnd@arndb.de
Subject: Re: [PATCH v2] misc: fastrpc: Fix an incomplete memory release in
 fastrpc_rpmsg_probe()
Message-ID: <20200512005725.GA57962@builder.lan>
References: <20200511162722.2552-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200511162722.2552-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 11 May 09:27 PDT 2020, Srinivas Kandagatla wrote:

> fastrpc_channel_ctx is not freed if misc_register() fails, this would
> lead to a memory leak. Fix this leak by adding kfree in misc_register()
> error path.
> 
> Fixes: 278d56f970ae ("misc: fastrpc: Reference count channel context")
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
> Changes since v1:
> 	- Update subject as suggested
> 	- added fixes tag
> 
>  drivers/misc/fastrpc.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index c562e285e0f4..07065728e39f 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -1615,8 +1615,10 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
>  					    domains[domain_id]);
>  	data->miscdev.fops = &fastrpc_fops;
>  	err = misc_register(&data->miscdev);
> -	if (err)
> +	if (err) {
> +		kfree(data);
>  		return err;
> +	}
>  
>  	kref_init(&data->refcount);
>  
> -- 
> 2.21.0
> 
