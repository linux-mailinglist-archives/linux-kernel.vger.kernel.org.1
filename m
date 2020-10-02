Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10E13280F70
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 11:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387635AbgJBJEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 05:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbgJBJEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 05:04:53 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F947C0613D0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 02:04:53 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id k18so902836wmj.5
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 02:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qFbZVEFOo9elK0nsgeUP///LqF9DZa97QUZx/Et/nCQ=;
        b=eoDYuhXS4JXmAa8VaGf28tPEEvCrCfFFL5oNJ8c2sq3ZxLvCo/wJko+AQjUTxctibx
         d/4Ze8SUgEz1x5F/tKz1bAZ0G9Y9KZ/IGBdeUTtNeWabgBJFkGhOd4ksLZTczM/BkR7y
         kZVmS04orPgCzeRl1BB2igsDgz0+sTAcEwHv/qc1Y+XjWjJVnR9wDRyN4mKwgzPlcapy
         uFGgOFBGiPGzs7qfrLk96sWC4ml1Sk7+hPBqqCjdBdoebUQ4uxOOCIGIo9XRyKP5xw0r
         C5VEbni8QUd3ZglNfISRyiG2ejQnIFPajEWRv5O7tLKg0Qt5xqfwajmSq90VS1TgqJ0x
         cfTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qFbZVEFOo9elK0nsgeUP///LqF9DZa97QUZx/Et/nCQ=;
        b=OSHz0jidGjPCk3DFlgFnYZOczQdeH4FOgBiJakafJVPwPLZ0V2uHmIJgkKUnOZqc10
         H3llQapJ59AzT7K9dyQovaFO8SJXeHwZxL+91vHBBHyyUih0njvgIq7kpLuCInAFyU+b
         gh3gU82HtxCneCg4i8Rkv0glDQPTevwJXkD8Vo8cZ2LSXbcuu70JKUBj7K+89DI4T4Xu
         Id0+U4JuwIR1z6lgyeh5hH8NimBtGfZ47SkYN8GBmUIYNbASAaj2uQCvZRnrMbq1dJU1
         KzRw/q0R3H8ZYNP4uLQfIYhtZEj9OQful7aNfpz+hFMIiFWc4r0eXf9XfNlNnjpoaYuX
         DHPQ==
X-Gm-Message-State: AOAM530yjcNuwzq9eFdSPVpVJrUPKJwNUplMR8hnpG6uU1iYiT+yTOQN
        U/dbe4jhNbA51wfkKTHZkRU=
X-Google-Smtp-Source: ABdhPJxdJUJFUkdUk83/VZEqiiRbaw+nZR16/sLO/3+w3JdtUO61nqVxdUrwv69Anzp3QXIIOHhOSA==
X-Received: by 2002:a05:600c:2215:: with SMTP id z21mr1673883wml.176.1601629492205;
        Fri, 02 Oct 2020 02:04:52 -0700 (PDT)
Received: from ziggy.stardust ([213.195.119.110])
        by smtp.gmail.com with ESMTPSA id g12sm991740wro.89.2020.10.02.02.04.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2020 02:04:51 -0700 (PDT)
Subject: Re: [PATCH v2 08/12] soc: mediatek: pm-domains: Add subsystem clocks
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>, fparent@baylibre.com,
        drinkcat@chromium.org, hsinyi@chromium.org, weiyi.lu@mediatek.com,
        Matthias Brugger <mbrugger@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20201001160154.3587848-1-enric.balletbo@collabora.com>
 <20201001160154.3587848-9-enric.balletbo@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <d6d132ba-1ce1-f537-57ba-4b6bed784b48@gmail.com>
Date:   Fri, 2 Oct 2020 11:04:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201001160154.3587848-9-enric.balletbo@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/10/2020 18:01, Enric Balletbo i Serra wrote:
> From: Matthias Brugger <mbrugger@suse.com>
> 
> For the bus protection operations, some subsystem clocks need to be enabled
> before releasing the protection. This patch identifies the subsystem clocks
> by it's name.
> 
> Suggested-by: Weiyi Lu <weiyi.lu@mediatek.com>
> [Adapted the patch to the mtk-pm-domains driver]
> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
> Changes in v2:
> - Use dev_err_probe if getting clocks fails, so an error is not printed
>    if is deferred.
> 
>   drivers/soc/mediatek/mtk-pm-domains.c | 89 ++++++++++++++++++++++-----
>   1 file changed, 75 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
> index e0a52d489fea..2075072f16da 100644
> --- a/drivers/soc/mediatek/mtk-pm-domains.c
> +++ b/drivers/soc/mediatek/mtk-pm-domains.c
[...]
>   
> +	for (i = 0; i < pd->num_subsys_clks; i++) {
> +		struct clk *clk = of_clk_get(node, i + clk_ind);
> +
> +		if (IS_ERR(clk)) {
> +			ret = PTR_ERR(clk);
> +			dev_err_probe(scpsys->dev, PTR_ERR(clk),
> +				      "%pOFn: failed to get clk at index %d: %d\n",
> +				      node, i + clk_ind, ret);
> +			goto err_put_subsys_clocks;
> +		}
> +
> +		pd->subsys_clks[i].clk = clk;
> +	}
> +
> +	ret = clk_bulk_prepare(pd->num_subsys_clks, pd->subsys_clks);
> +	if (ret)
> +		goto err_put_subsys_clocks;
> +

Not sure if it really matters, but logically we should prepare the basic clocks 
before we prepare the subsystem clocks. And fix the error handling accordingly.

Regards,
Matthias

>   	ret = clk_bulk_prepare(pd->num_clks, pd->clks);
>   	if (ret)
> -		goto err_put_clocks;
> +		goto err_unprepare_subsys_clocks;
>   
>   	/*
>   	 * Initially turn on all domains to make the domains usable
> @@ -462,6 +513,12 @@ static int scpsys_add_one_domain(struct scpsys *scpsys, struct device_node *node
>   
>   err_unprepare_clocks:
>   	clk_bulk_unprepare(pd->num_clks, pd->clks);
> +err_unprepare_subsys_clocks:
> +	clk_bulk_unprepare(pd->num_subsys_clks, pd->subsys_clks);
> +err_put_subsys_clocks:
> +	clk_bulk_put(pd->num_subsys_clks, pd->subsys_clks);
> +	devm_kfree(scpsys->dev, pd->subsys_clks);
> +	pd->num_subsys_clks = 0;
>   err_put_clocks:
>   	clk_bulk_put(pd->num_clks, pd->clks);
>   	devm_kfree(scpsys->dev, pd->clks);
> @@ -541,6 +598,10 @@ static void scpsys_remove_one_domain(struct scpsys_domain *pd)
>   	clk_bulk_unprepare(pd->num_clks, pd->clks);
>   	clk_bulk_put(pd->num_clks, pd->clks);
>   	pd->num_clks = 0;
> +
> +	clk_bulk_unprepare(pd->num_subsys_clks, pd->subsys_clks);
> +	clk_bulk_put(pd->num_subsys_clks, pd->subsys_clks);
> +	pd->num_subsys_clks = 0;
>   }
>   
>   static void scpsys_domain_cleanup(struct scpsys *scpsys)
> 
