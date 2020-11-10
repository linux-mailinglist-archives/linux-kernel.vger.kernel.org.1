Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 806272ADD83
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 18:56:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730182AbgKJR4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 12:56:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbgKJR4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 12:56:21 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16244C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 09:56:20 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id e7so12099567pfn.12
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 09:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aT2oTuSuBnr5hPeNasmJ97IRMrjqfH1Ty2c1Lf95qcM=;
        b=czcNb2IMZu41tmZYfaxoPlbgB0yE8rsJsAZ8qNh43jaPyghLda16gi0yH8EFcp7NRG
         LzhBy/cBHVsX330agQ8oDXWvxDzTVAu0MJ63Od7lghBdN7fzB0FxvyyuAt9XI3iardkT
         6ty1w5LhXujGVPy2NISzJPARwTaZZk6h/cN7BCiNaui5NH+afV8NKLm4YscE598tx700
         sPgxfuyPUQmA+WNsdXRafzLLlcpKP6WcVvRXDaMSN1meCG5mkmLuImoPOPyj5J4XViPw
         Rnk6NN5XbxZGykJTroycfcK5DiU6SnarxFybcZ5ihI4EON48e1warBtLs2O0EgLud6FQ
         GJAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aT2oTuSuBnr5hPeNasmJ97IRMrjqfH1Ty2c1Lf95qcM=;
        b=T3Xtn5XWhIhK5brXLXgw16xw5++7WHIypPpMbBZjbHFfCt4Yp9evMo+sJoQvCseD1Z
         yux6fOgaIkyekxa+aNp60EqynsEwGGSLFr3j0CnA2c9yH0SDtt2ilNCRzBi5PsrePv2H
         UmN3oUBTh37C0uFZ+XuMj2Zv/mb/WOgaiXE30gAjvcTgtdRe7iWi60BTmXmL4drIeyTV
         Q+iOggCxa2PapOlRH1h7U/QrGKIu9z9rNNHElTPIMF+N+7kgNlIqD5SlrW4x0zDl0Gli
         0g2fKYFpLQq0cnY2Gnume2qWNaSutLMGA7Qt8abdgqlck/yDF0Lcyy0XE2dKxDhA1mXf
         bDjw==
X-Gm-Message-State: AOAM531NAEjEvCRoBlYANLFxtT3M+y7au3bC9hV9xB1vmiwlIg4ND2tp
        WS9nT4VTVrobS+TUDLPh2Suyxw==
X-Google-Smtp-Source: ABdhPJzz//EacLtqJ2Z1wWMm1JRKeHDIyZvEGi/TNANSMK5VSq48vTZW0C45gwr55UU+wH3h/qjAXA==
X-Received: by 2002:aa7:8c4f:0:b029:18b:f361:4aa3 with SMTP id e15-20020aa78c4f0000b029018bf3614aa3mr1965432pfd.73.1605030979487;
        Tue, 10 Nov 2020 09:56:19 -0800 (PST)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id j20sm13707321pgl.40.2020.11.10.09.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 09:56:18 -0800 (PST)
Date:   Tue, 10 Nov 2020 10:56:17 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     xiakaixu1987@gmail.com
Cc:     suzuki.poulose@arm.com, mike.leach@linaro.org,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org,
        Kaixu Xia <kaixuxia@tencent.com>
Subject: Re: [PATCH v2] coresight: tmc-etr: Assign boolean values to a bool
 variable
Message-ID: <20201110175617.GD3429138@xps15>
References: <1604979555-20619-1-git-send-email-kaixuxia@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1604979555-20619-1-git-send-email-kaixuxia@tencent.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 11:39:15AM +0800, xiakaixu1987@gmail.com wrote:
> From: Kaixu Xia <kaixuxia@tencent.com>
> 
> Fix the following coccinelle warnings:
> 
> ./drivers/hwtracing/coresight/coresight-tmc-etr.c:957:2-15: WARNING: Assignment of 0/1 to bool variable
> 
> Fix them by assigning boolean values.
> 
> Reported-by: Tosk Robot <tencent_os_robot@tencent.com>
> Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
> ---
>  drivers/hwtracing/coresight/coresight-tmc-etr.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

I have applied your patch.

Thanks,
Mathieu

> 
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> index 714f9e867e5f..525f0ecc129c 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> @@ -954,11 +954,11 @@ static void tmc_sync_etr_buf(struct tmc_drvdata *drvdata)
>  		dev_dbg(&drvdata->csdev->dev,
>  			"tmc memory error detected, truncating buffer\n");
>  		etr_buf->len = 0;
> -		etr_buf->full = 0;
> +		etr_buf->full = false;
>  		return;
>  	}
>  
> -	etr_buf->full = status & TMC_STS_FULL;
> +	etr_buf->full = !!(status & TMC_STS_FULL);
>  
>  	WARN_ON(!etr_buf->ops || !etr_buf->ops->sync);
>  
> -- 
> 2.20.0
> 
