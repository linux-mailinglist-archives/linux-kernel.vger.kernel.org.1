Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FEE929D8CF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:36:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388446AbgJ1Wgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388439AbgJ1Wgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:36:32 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E160C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:36:32 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id r186so726194pgr.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HOLVJZragnogI83AL7H7xsw1FRW50J26vaXwlw6VSvU=;
        b=wAW/Rjf4En10sBEiY4jdkSvsj0xci8ukot36BnsZw/HtdrZJfLGQq3I/1tEqnlGtLy
         YCjdYHuEa9i/IDF7Wh1+XVhCwxwMr4sMHTL5yMsgzJV+0eDJ6pWYVLH20Yr5xX4AlLzM
         bClcW1MTKolJaQ15A2uPD9zA2SJo+dG7lB3+SMeX3F/l0Aephv7jEf7L+ghfWCyAgEWI
         Kt3GqycLa+0BxJIcTG8ZYvJEOZpjhuqWLzKLlLhkTbSrXOjX/XIy1Nhb8RiVDSYx2den
         CqKsxAZeGekYMWnCfZjR6DX6i7h0xzalwXjYfOkdKBrkTvlvWF3D/IjW4ENfA1t9JpcY
         Yctw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HOLVJZragnogI83AL7H7xsw1FRW50J26vaXwlw6VSvU=;
        b=OXW5Lia+PLOflEi0eSxXxIPlo1w3h222+VrxB5W7YAE6jcR+AjQLVB+v+YhZ/3JJ50
         CGkP8U6iuHCMXiU93WOPGER03/a6StNB0YXb166E/zeKgq/yFT2yQF3W1aVdWzoNg2nz
         i2rVcVeL2qwrkZuGfjt5iMn6XY2JKCalPtY8kTCphx2UTLR1e9C8QprBZjKkBR+xZvTg
         Gy3Z4yKix44IWqFsvmwcLrn1pBYoO7QH4rZXr8iS7uiMx5+VRv3YZoU/t+ZaAdk2MROH
         m2p2XwChgLb0qJqdwX5yLbwcN94MOn6YrHOkd+n3rdW+TyZ+HiKzDd9vehWJTegs+C1m
         6x1Q==
X-Gm-Message-State: AOAM531Q3iNmcORBwuVqtIr9qM1alfmDgIR1Db2+t2ggWY7vq+IKCE7W
        NCgphMkpgo7JGvRYpJL8vHHk7IjZ/5SLfA==
X-Google-Smtp-Source: ABdhPJx2eljw7UcU0BCI0KQNkHipnmVzz2C1K9PAWVmK+t/4Y9zrp3nrvO1yv7RFXzMNRpax0Rcj1A==
X-Received: by 2002:a63:4086:: with SMTP id n128mr4829611pga.387.1603865325897;
        Tue, 27 Oct 2020 23:08:45 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id ge6sm3868281pjb.29.2020.10.27.23.08.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Oct 2020 23:08:45 -0700 (PDT)
Date:   Wed, 28 Oct 2020 11:38:43 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Fabien Parent <fparent@baylibre.com>
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, matthias.bgg@gmail.com, rjw@rjwysocki.net
Subject: Re: [PATCH 1/2] cpufreq: mediatek: Add support for mt8167
Message-ID: <20201028060843.wlfjuyk5nnou7pfb@vireshk-i7>
References: <20201013092709.3336709-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201013092709.3336709-1-fparent@baylibre.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-10-20, 11:27, Fabien Parent wrote:
> Add compatible string for mediatek mt8167
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
>  drivers/cpufreq/mediatek-cpufreq.c   | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index 7d01df7bfa6c..b8d48ed37156 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -119,6 +119,7 @@ static const struct of_device_id blacklist[] __initconst = {
>  	{ .compatible = "mediatek,mt2712", },
>  	{ .compatible = "mediatek,mt7622", },
>  	{ .compatible = "mediatek,mt7623", },
> +	{ .compatible = "mediatek,mt8167", },
>  	{ .compatible = "mediatek,mt817x", },
>  	{ .compatible = "mediatek,mt8173", },
>  	{ .compatible = "mediatek,mt8176", },
> diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
> index 7d1212c9b7c8..c09bff86bb9b 100644
> --- a/drivers/cpufreq/mediatek-cpufreq.c
> +++ b/drivers/cpufreq/mediatek-cpufreq.c
> @@ -532,6 +532,7 @@ static const struct of_device_id mtk_cpufreq_machines[] __initconst = {
>  	{ .compatible = "mediatek,mt2712", },
>  	{ .compatible = "mediatek,mt7622", },
>  	{ .compatible = "mediatek,mt7623", },
> +	{ .compatible = "mediatek,mt8167", },
>  	{ .compatible = "mediatek,mt817x", },
>  	{ .compatible = "mediatek,mt8173", },
>  	{ .compatible = "mediatek,mt8176", },

Applied. Thanks.

-- 
viresh
