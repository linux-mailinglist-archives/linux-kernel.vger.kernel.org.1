Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5142FA473
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 16:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405789AbhARPU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 10:20:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393387AbhARPQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 10:16:01 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27A7C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 07:15:06 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id g10so14087617wmh.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 07:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+LgLOgoxQPdA1AMT0ov7EcX09cf72C2lN0STusFJDqM=;
        b=Ex1oRD7zVhynMBLEins+ngs5G45eK6IJWiTE/rpKdfRPhgRl14eDCepmO6roLALEko
         RZ3euNPhiCnrnkEDLV1kyJ44ydZ4Hbg/TS8XpyhdCWnbdeXs5WrJyTo1bssTz1ZldS0k
         JPaq8NW11Ekd81/GsMft1go9Kh707bCvuT8u7cfkgHOYh75t9epHwfqiWfcy1CbDhFfY
         aave5sTlmcQv6NKxTFfwQO5gvpZQXNV4wD2UzKaJumtipFXqrwz0JiKG42sM1mCm6jsH
         gSRcpESOM7SK/ABopL6K1Mt6GmIszXylzXZXDKYCtsLMvOe0hGIl8QViX52dbt2jFcxY
         wBOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+LgLOgoxQPdA1AMT0ov7EcX09cf72C2lN0STusFJDqM=;
        b=HWjwf3UVB3YCkx2n3cvnWgnIoCUdwBv/9AWX0W/DsLM5wz3B0AIGJojCVLvwMc0yQa
         qeKfbTKWHwGlSSMH+6OvZkGm/q5AHGPzWTBFb6uhEeajDFG0zxFRjKmtnb6qK++PCf+j
         FgXZq+1sJojVopRqBCQUDdpNugq31DG6dpRhkULNiErWEFvADeW9fgVO75dPKvRJHZsq
         YDtB3rThlDEMI+q1g2518fldSi/brEyH86S6O3nbGKBJWenDN/oHVFzNHyx5HjBkXEb6
         pMgdP5anLqxoTmdaGulzMFuZZYzUeOWRHt3xFoRDcLrLcSacec+Khncs2SjFytwBIAXL
         6BeQ==
X-Gm-Message-State: AOAM533VLaBkHeWmUUqHofB5ph5AJzJP7UNCqKKwNQ5/m32mcneMVmxP
        d4IDOsTi8N9sb1G1iRzM/RBqQw==
X-Google-Smtp-Source: ABdhPJy3dvXpS+hdG387FWWQvuxQGvSJfQWwJ6sUJz1UzrPt65butwMz5vCFaAn5MhJcCzFFlTaUJA==
X-Received: by 2002:a05:600c:2903:: with SMTP id i3mr20973188wmd.41.1610982905313;
        Mon, 18 Jan 2021 07:15:05 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:2095:8614:d69:136f? ([2a01:e34:ed2f:f020:2095:8614:d69:136f])
        by smtp.googlemail.com with ESMTPSA id g5sm31550858wro.60.2021.01.18.07.15.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jan 2021 07:15:04 -0800 (PST)
Subject: Re: [PATCH] clocksource: mxs_timer: add missing semicolon when DEBUG
 is defined
To:     trix@redhat.com, tglx@linutronix.de, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, viresh.kumar@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20210118134926.613931-1-trix@redhat.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <830aea92-5ae4-6b04-80c5-349a45feabf9@linaro.org>
Date:   Mon, 18 Jan 2021 16:15:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210118134926.613931-1-trix@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/01/2021 14:49, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> When DEBUG is defined this error occurs
> 
> drivers/clocksource/mxs_timer.c:138:1: error:
>   expected ‘;’ before ‘}’ token
> 
> The preceding statement needs a semicolon.
> 
> Fixes: eb8703e2ef7c ("clockevents/drivers/mxs: Migrate to new 'set-state' interface")
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/clocksource/mxs_timer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clocksource/mxs_timer.c b/drivers/clocksource/mxs_timer.c
> index bc96a4cbf26c..55aa6b72d075 100644
> --- a/drivers/clocksource/mxs_timer.c
> +++ b/drivers/clocksource/mxs_timer.c
> @@ -133,7 +133,7 @@ static void mxs_irq_clear(char *state)
>  	timrot_irq_acknowledge();
>  
>  #ifdef DEBUG
> -	pr_info("%s: changing mode to %s\n", __func__, state)
> +	pr_info("%s: changing mode to %s\n", __func__, state);
>  #endif /* DEBUG */

Mind to replace by pr_debug and remove the #ifdef ?

>  }
>  
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
