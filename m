Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8507327430A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 15:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgIVNaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 09:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbgIVNaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 09:30:16 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92903C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 06:30:16 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id g29so11973348pgl.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 06:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2/R/oDUGducvjUOkFGRB4yHjl6PPO14jUmeK6ANox9c=;
        b=pMS+IJOMEVM9wkUeCUQ1ARmiLkLho6MwK7z6PAdSVm+TqtQAR622t1mK6t/zi0eMOP
         yDaQr9hk60zS1p1coEY0s6h3984Yy47jdtvszbK5b8t0u0T/NTMXRq/oZRvfcPF8e5s9
         z3XFllg9bMJmiduYsMqg/ZhpHjM9LR+w91qZMosBYNMsc2fxZ/admwEArurwX1vz8N15
         VtDmckxoBktSQWV2/etOeUtEgXbeTbqATNDHZgNa6WDwqvK0NeC5qPvuUAJg5OxeCdmZ
         Ke1AjRfowIKM88pYdvIA0BYe5wNWTCcojxzq2+EhjBMOS7soU2Fc/WrUMxOA6DZCi4SJ
         /AAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2/R/oDUGducvjUOkFGRB4yHjl6PPO14jUmeK6ANox9c=;
        b=M+rTk1qnRxDYMZINrteV9ZGf0i/1ZkaEa1MW9BFjIGIIEIoD5CSU47gJumSgnrnSAZ
         aFyfOO2yEwh1xYedudktkXO4GlgeuNcKu7eio/07h1abis2nTp8O7pYjN0gEcAvn4B2k
         qINTVNo6NI/PpDuoukqqUyWG2YbEwyds4w7N8O9Hts1HTR8FFZg6MfgHBok8/y3kTSrr
         yylTXyM4GV+dtu6KVqDKhO4MooY3pqrZUCLij8vNhhjb+cPLOPN6Je74Tx+95ndeoQpi
         zbdg/jWgXztdLagQzJyGFRVx4jG52t3oOrs5bJ21XHSW03/drEOfWCj37ZngTL7z+//y
         ZGmw==
X-Gm-Message-State: AOAM531ebLmphcJ/Fh0C+RcYSsipm1retvifthYlhLXxryV5FSt/NqL8
        L60kP/iuW87qeF5ppcqO0XWQJA==
X-Google-Smtp-Source: ABdhPJy0Pb6z6+/Dt/u2tAJWB6aDaKpho6z3MqyTTGnzm6s9IKTCkUx7ZF9GcYA/G55EBG+QElXtXQ==
X-Received: by 2002:a63:1a21:: with SMTP id a33mr3545043pga.305.1600781415892;
        Tue, 22 Sep 2020 06:30:15 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id w185sm16583239pfc.36.2020.09.22.06.30.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Sep 2020 06:30:15 -0700 (PDT)
Date:   Tue, 22 Sep 2020 19:00:07 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Viresh Kumar <vireshk@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] pinctrl: spear: simplify the return expression of
 spear310_pinctrl_probe
Message-ID: <20200922133007.dx46iszynpjcm6oq@vireshk-i7>
References: <20200921082448.2591929-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921082448.2591929-1-liushixin2@huawei.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-09-20, 16:24, Liu Shixin wrote:
> Simplify the return expression.
> 
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> ---
>  drivers/pinctrl/spear/pinctrl-spear310.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/pinctrl/spear/pinctrl-spear310.c b/drivers/pinctrl/spear/pinctrl-spear310.c
> index 393b2b97d527..9d9facc4a6e4 100644
> --- a/drivers/pinctrl/spear/pinctrl-spear310.c
> +++ b/drivers/pinctrl/spear/pinctrl-spear310.c
> @@ -379,8 +379,6 @@ static const struct of_device_id spear310_pinctrl_of_match[] = {
>  
>  static int spear310_pinctrl_probe(struct platform_device *pdev)
>  {
> -	int ret;
> -
>  	spear3xx_machdata.groups = spear310_pingroups;
>  	spear3xx_machdata.ngroups = ARRAY_SIZE(spear310_pingroups);
>  	spear3xx_machdata.functions = spear310_functions;
> @@ -392,11 +390,7 @@ static int spear310_pinctrl_probe(struct platform_device *pdev)
>  
>  	spear3xx_machdata.modes_supported = false;
>  
> -	ret = spear_pinctrl_probe(pdev, &spear3xx_machdata);
> -	if (ret)
> -		return ret;
> -
> -	return 0;
> +	return spear_pinctrl_probe(pdev, &spear3xx_machdata);
>  }
>  
>  static struct platform_driver spear310_pinctrl_driver = {

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
