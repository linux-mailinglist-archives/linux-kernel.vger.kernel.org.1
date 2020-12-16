Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7BEF2DC690
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 19:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731047AbgLPSdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 13:33:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731041AbgLPSdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 13:33:36 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D97BC06179C
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 10:32:56 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id 9so21466482oiq.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 10:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TOKrfljSwb0iquFcwhx16t0mlmb8z327F7siyfgd+Io=;
        b=yd2cqrPLfduV1Hea+fTiIe+/9IkIEb6MKlQIilXuDL4916KjY5zK/R3iTzbUDPdN6Y
         LRpSlA9st56gL6Hpw+u8O3sPlKB3aPyOu+Tghlrzn7j/4DOYqGl04UCbHqdMK2uLSxT4
         zyEt0D4fi6/beYoXjvEb/zDZxfQhTFOKvIvtowB7eJR5cdFUU58CN7uHi8VhlrTK2IwF
         da7AZZCsYZajEZ1Q9gV1DS4TMYLt1MwuFWJ6MdTtovrbdDiJON9cJY8fEFdmQISS2mpL
         2pHMd83p47SRJN0l95Nc3w6SFV76WZR9gnVQCx+IP1Thu++ADUU8fhlRCLtoxYZSa0bK
         VOfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TOKrfljSwb0iquFcwhx16t0mlmb8z327F7siyfgd+Io=;
        b=N5UqX6UVHSRw8EjKgdQKyhvzV1Y9qNnPR8wrDuoXRV+MN6+r8imUe0kLrY0YF1hGnj
         ZI03wS8kkSiOq+xBVBCFINj/UO1h+ALo3F8DzEI6n5XSU2hqLWbvjll4nKhH+9H62qNg
         Oe8Lllkn0c2m7IF7T90wdod7RpD3+7pVOTcNcpzL6ZWs03Sb2RS+nkGUmpIxYlNn1xOU
         A3JW9svNP+6VARVonyKRM/GDkOi1lPRR+d59bvbLfYFRoMi4ktQsiLutMMJphfJFcowC
         k4af+3dRpQz4+O+a+6tolj9Pv9oRRGpqOwrzKoiQtB0ZCk9nCJSXo83JsMxpxDpxzigj
         V73g==
X-Gm-Message-State: AOAM5328iKRWE4wqPjh6TnGZSwyYGIwbouNG5r27T0qXpbnZ9c4L0eQO
        UyqXmvNRke23a7XBDO3Yd7CjTg==
X-Google-Smtp-Source: ABdhPJwRU+MItydmtpCEjuBcCjGgBaYAvNj1wCz3tWiuHYbakckuOaLYeu9+147ay8nGxmUWevswhQ==
X-Received: by 2002:aca:c0c6:: with SMTP id q189mr2738473oif.178.1608143575260;
        Wed, 16 Dec 2020 10:32:55 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id z63sm615486otb.20.2020.12.16.10.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 10:32:54 -0800 (PST)
Date:   Wed, 16 Dec 2020 12:32:52 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Zheng Yongjun <zhengyongjun3@huawei.com>
Cc:     agross@kernel.org, dan.j.williams@intel.com, vkoul@kernel.org,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] qcom: bam_dma: Delete useless kfree code
Message-ID: <X9pS1F91OxYMCMpI@builder.lan>
References: <20201216130649.13979-1-zhengyongjun3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201216130649.13979-1-zhengyongjun3@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 16 Dec 07:06 CST 2020, Zheng Yongjun wrote:

> The parameter of kfree function is NULL, so kfree code is useless, delete it.
> Therefore, goto expression is no longer needed, so simplify it.
> 
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
>  drivers/dma/qcom/bam_dma.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
> index 4eeb8bb27279..78df217b3f6c 100644
> --- a/drivers/dma/qcom/bam_dma.c
> +++ b/drivers/dma/qcom/bam_dma.c
> @@ -630,7 +630,7 @@ static struct dma_async_tx_descriptor *bam_prep_slave_sg(struct dma_chan *chan,
>  			     GFP_NOWAIT);
>  
>  	if (!async_desc)
> -		goto err_out;
> +		return NULL;
>  
>  	if (flags & DMA_PREP_FENCE)
>  		async_desc->flags |= DESC_FLAG_NWD;
> @@ -670,10 +670,6 @@ static struct dma_async_tx_descriptor *bam_prep_slave_sg(struct dma_chan *chan,
>  	}
>  
>  	return vchan_tx_prep(&bchan->vc, &async_desc->vd, flags);
> -
> -err_out:
> -	kfree(async_desc);
> -	return NULL;
>  }
>  
>  /**
> -- 
> 2.22.0
> 
