Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60E212935FB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 09:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405341AbgJTHmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 03:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727226AbgJTHmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 03:42:45 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE5DC061755
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 00:42:44 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id j7so579705pgk.5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 00:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KP7TO4IqJs2R6VQkkfsXXAMpoJtd3P3We64dmLRZJCY=;
        b=gYhhlBYuG5dxeeCxQ3KKWcxYK2CKCEO+HlA60wyby2cM7UwcBEcE44b7yo6tKoq1Kw
         Z2vepaTJb+1YnmCsegFajb8NsSElZbO9K0DLJeuidKx96r7fZm3Ftz9xo5jWSZFiuqp+
         zQiFjRAfk0xa7R/yiM26thD0wbp+lOy2qZAxyZaI9HDK4u/kunlcj64rXkuJmcCzyfq/
         4a/aobS9oEPlY+TG6+v11hAu33RWwPKEJZ6jAau00pvVDkVsphuLbcqDz4SCdtpFmO2E
         5UieukcmFpcwZ+JzLgpUD8N1JZzQB5eMLgtYCuXSmFT2llHxsA+2fTl7HPR6+Bn8Ee0F
         fiag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KP7TO4IqJs2R6VQkkfsXXAMpoJtd3P3We64dmLRZJCY=;
        b=XBbQ8TTMVfH+Hj1NwB1PA8ytCP9iIy/PLMvvoWgLvmdGZswSso+Nhph5xiiFctnvQp
         3qrdS6QgYiquRmvfXCQwuGF73PSwhrF28FbpebZCNmQtCiaQ2bjJqCI7JyiRe2sP4o+Y
         ISeRA/0Ib9JTg566bDY/1NsbDjHQMenzGN2C4dbhsBKD/TEWLl+oWr1847r0LKVVU7Tp
         DbFgu7pTR55A/DeD8fiLsxtQfGmtKpWYBeQZOOAdccRJWuxd70th0GjS33R0GXNhkRM6
         gEfPhaYuxD0JsRco7MYm/skBR4OPCWsMN+kDgknSXgUVxb8fwaHMHeWmepWvdsGVfGCI
         7Ozw==
X-Gm-Message-State: AOAM5329hyVdVgGbIsNQYFSa1Q4g7GszbtjS0S5H2P3hgnWe41o4ew4n
        nm3HJJbthVLm4urlmnWmePXLeg==
X-Google-Smtp-Source: ABdhPJylUfKQEed6xGiGgP22ggEP0jO91vz907NqWzyJo1lCZax5hOvdSlNlX6AUWBeYqJE3a7niEA==
X-Received: by 2002:aa7:96f8:0:b029:152:94c0:7e5 with SMTP id i24-20020aa796f80000b029015294c007e5mr1619215pfq.76.1603179764068;
        Tue, 20 Oct 2020 00:42:44 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id z26sm1407060pfq.131.2020.10.20.00.42.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Oct 2020 00:42:43 -0700 (PDT)
Date:   Tue, 20 Oct 2020 13:12:40 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Defang Bo <bodefang@126.com>
Cc:     rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: ti-cpufreq: fix memory leak in
 ti_cpufreq_probe()
Message-ID: <20201020074240.p2d3fhirer4sflom@vireshk-i7>
References: <1603113151-5219-1-git-send-email-bodefang@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1603113151-5219-1-git-send-email-bodefang@126.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-10-20, 21:12, Defang Bo wrote:
> Similar to commit<05829d9431df>("cpufreq: ti-cpufreq: kfree opp_data when failure"), opp_data needs to be freed when failure, including fail_put_node.

This is allocated using devm_kzalloc() and so we don't need to free it
explicitly.

> Signed-off-by: Defang Bo <bodefang@126.com>
> ---
>  drivers/cpufreq/ti-cpufreq.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
> index ab0de27..f23be8f 100644
> --- a/drivers/cpufreq/ti-cpufreq.c
> +++ b/drivers/cpufreq/ti-cpufreq.c
> @@ -342,7 +342,8 @@ static int ti_cpufreq_probe(struct platform_device *pdev)
>  	opp_data->cpu_dev = get_cpu_device(0);
>  	if (!opp_data->cpu_dev) {
>  		pr_err("%s: Failed to get device for CPU0\n", __func__);
> -		return -ENODEV;
> +		ret = ENODEV;
> +		goto free_opp_data;
>  	}
>  
>  	opp_data->opp_node = dev_pm_opp_of_get_opp_desc_node(opp_data->cpu_dev);
> @@ -404,7 +405,8 @@ static int ti_cpufreq_probe(struct platform_device *pdev)
>  
>  fail_put_node:
>  	of_node_put(opp_data->opp_node);
> -
> +free_opp_data:
> +	kfree(opp_data)

Did you even try to compile this code ?

>  	return ret;
>  }
>  
> -- 
> 1.9.1

-- 
viresh
