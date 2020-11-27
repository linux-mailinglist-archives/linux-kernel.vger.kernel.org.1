Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0E5D2C6DC2
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 00:45:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731906AbgK0Xox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 18:44:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732070AbgK0Xfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 18:35:37 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB5AC0613D4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 15:35:36 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id 10so6313508wml.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 15:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jVzhf/5meYw3rpw0SqzqfljLcT87jPxDXOiys7yFh2Q=;
        b=INXbcUXnvCOogsFpX6GkV6j4Qjs9GR5/ZV/ui7/R/F6iLXbJIp7Dn7ZbQWoKlMEz/1
         Ep4ijwz9l19P6hAp3utcfV0CzNStPymUpt5jGCYNWjzjqBU8xw/ce66aSGSe5bzpMLv6
         Z7ZkWjeRMHxcGQPukqzPLZGFSiyl9IvZ2JnrzsYy6vxEl/rQo4GyB7uwwo+H5kZ7p1n1
         4rZnuxJiTvAPyHZcK2eUhpy570UG/7FWd8QRpJEQIwP9gP/3tydCkuIOqDrRHdOwyMws
         Ud+KKLlcqJ++fer4lfbXhUkJEJkQlmNVy1QSS6UI+sHqwSx0QT7Ru/lbNVYkta0RNTPz
         7GvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jVzhf/5meYw3rpw0SqzqfljLcT87jPxDXOiys7yFh2Q=;
        b=A0KliNMNKw4wRs/BxyM7/Kv5eH3RDQztRv1y8DcwCcMS9e8rlWP4kKJxJ6DoADWDjp
         E4CWInO2Har8A3EewyhMguKRMAvWwfRX5069RrL7T9yDubyq4uGnvPvTlbNmh7/ByOUX
         21sc1ic4PXnESau6pTzWLR7W+1dbaUvwetRAgypv4JdHQ8WsQkqBF38Ujz+Gevh9HzxA
         mCRSuFoVWgC7LP860lQO+g7Y+gncNdwXYpphrn0v3NSjAJK7/vb/4ChvWdvBjdcy84m5
         R0nAgb1DMeq33UKGcMsBx720O2BmeCXlwO5g28wxoe5x6+0G//yeB/Q4Hb/VcuKlSGbS
         QX5Q==
X-Gm-Message-State: AOAM531KA6M5iTBg+fFA/9Ycq5E1KOeD7YugSKK0SGFgjMFkzwr2OD3t
        3ayjDHdHxDycnP7F7oowANw=
X-Google-Smtp-Source: ABdhPJxy+yLkwFNUsqIhZwIE0D69kMEePqUJFJh3gTpIXMyOQwY7iAM67O0D7S3/HIQtFqsy2GODFQ==
X-Received: by 2002:a1c:ba56:: with SMTP id k83mr4899024wmf.57.1606520135049;
        Fri, 27 Nov 2020 15:35:35 -0800 (PST)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id o5sm15036632wmh.8.2020.11.27.15.35.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2020 15:35:34 -0800 (PST)
Subject: Re: [PATCH 2/4] soc: mediatek: mmsys: Use
 devm_platform_ioremap_resource()
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>,
        yongqiang.niu@mediatek.com, drinkcat@chromium.org,
        hsinyi@chromium.org, chunkuang.hu@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20201006193320.405529-1-enric.balletbo@collabora.com>
 <20201006193320.405529-3-enric.balletbo@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <188d0079-1fa8-8d43-97f1-33480ffc5c8e@gmail.com>
Date:   Sat, 28 Nov 2020 00:35:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201006193320.405529-3-enric.balletbo@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/10/2020 21:33, Enric Balletbo i Serra wrote:
> For the common platform_get_resource()+devm_platform_ioremap() combination,
> there is a helper, so use it and make the code a bit more compact.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Applied to v5.10-next/soc

Thanks!

> ---
> 
>   drivers/soc/mediatek/mtk-mmsys.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-mmsys.c
> index 36ad66bb221b..18f93979e14a 100644
> --- a/drivers/soc/mediatek/mtk-mmsys.c
> +++ b/drivers/soc/mediatek/mtk-mmsys.c
> @@ -306,15 +306,12 @@ static int mtk_mmsys_probe(struct platform_device *pdev)
>   	struct platform_device *clks;
>   	struct platform_device *drm;
>   	void __iomem *config_regs;
> -	struct resource *mem;
>   	int ret;
>   
> -	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	config_regs = devm_ioremap_resource(dev, mem);
> +	config_regs = devm_platform_ioremap_resource(pdev, 0);
>   	if (IS_ERR(config_regs)) {
>   		ret = PTR_ERR(config_regs);
> -		dev_err(dev, "Failed to ioremap mmsys-config resource: %d\n",
> -			ret);
> +		dev_err(dev, "Failed to ioremap mmsys registers: %d\n", ret);
>   		return ret;
>   	}
>   
> 
