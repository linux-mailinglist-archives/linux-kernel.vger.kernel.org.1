Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 518A42730A7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 19:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728713AbgIURHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 13:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727556AbgIURHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 13:07:53 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF52C061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 10:07:53 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id c18so13596195wrm.9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 10:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vFl858TYcn55xzrXdnmQ+FomaH6JEvpw1AWdFvODVLA=;
        b=nUT8tZNW20LCjfug52XrALM6AHptZk5DSf/DVG9fbq0EVKsLRSxg0oETXGkEEbWO94
         rwqX2+6amxcZa3iHnBNo+EGT9yUIfyOKYXMvpdlVLrGQpqO2Jbb7RJOQ6iXVdvfMj1pY
         4VXQpBqvQgz0qz31FhYcNaHEeaLoIsVJHJaWy0qvac/yL5VopDv+sX6vG2RmPQbWm17Y
         f1fX++CQeEl6TG8NCt+VqMd8cpNycaoAvvbxOQS0LRxk4/6K1ThOkhDa0n6OqTdSOquk
         7PRTzlsw5awF1jW24Rcbl4Vn2Es8o5Eion8f1mVya5vDQAFclt48l8Csn2q03RXQFS/R
         qbXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vFl858TYcn55xzrXdnmQ+FomaH6JEvpw1AWdFvODVLA=;
        b=bllGpkCP/z2elt5iNra/gtljLZXGjSL4AhS3HD8149PX4C/kXsl8Y1293t9Y6cU+NH
         e2bY8kEiOiRqTaTxuNSlQtgNbMvEjrHK27uZcj+LKjoUKf/iduOVXESJLhtEinsc5/Ni
         4vi8bTA/AHt19dni4bUnWR/wJBsyDs+1vNMWRfGX/d77c33IWngJo5rnhHrKQ51uTbxP
         izIhbg712ULEykTaYuMfd4yIgifhyPP0+slgB6CyNFeVl5rlr1H8Z/GA34KkUXMjk/Un
         8AKZWjD1CWY4JieDxahleVGCsluGxyktBwYkf4/j5QYAOKmtvBCcofR57EZrsA2jxtlW
         ZqJg==
X-Gm-Message-State: AOAM5300FzP/wbIntUYuLvP8Rep0DZ8t7lwqkLdzpnW/Od7StTli1YZJ
        ei40jIOREcCZfANwnLRhsjs=
X-Google-Smtp-Source: ABdhPJzczz1HhvIKMvZrQuCfXkwUWiaoGgbThUT9hwhaj19hdyCz9z7u/hB1x8rLtLX9FtfLx6Fj8A==
X-Received: by 2002:adf:e58b:: with SMTP id l11mr836947wrm.210.1600708072063;
        Mon, 21 Sep 2020 10:07:52 -0700 (PDT)
Received: from ziggy.stardust ([213.195.113.201])
        by smtp.gmail.com with ESMTPSA id b188sm873790wmb.2.2020.09.21.10.07.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2020 10:07:51 -0700 (PDT)
Subject: Re: [PATCH] soc: mediatek: Check if power domains can be powered on
 at boot time
To:     Nicolas Boichat <drinkcat@chromium.org>
Cc:     Daniel Kurtz <djkurtz@chromium.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20200730120054.1.I5e6f8c262031d0451fe7241b744f4f3111c1ce71@changeid>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <6549429e-bd3c-5249-2fbd-cd1c45b5b2c1@gmail.com>
Date:   Mon, 21 Sep 2020 19:07:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200730120054.1.I5e6f8c262031d0451fe7241b744f4f3111c1ce71@changeid>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas,

Thanks for the patch.

On 30/07/2020 06:01, Nicolas Boichat wrote:
> In the error case, where a power domain cannot be powered on
> successfully at boot time (in mtk_register_power_domains),
> pm_genpd_init would still be called with is_off=false, and the
> system would later try to disable the power domain again, triggering
> warnings as disabled clocks are disabled again (and other potential
> issues).
> 
> Fixes: c84e358718a66f7 ("soc: Mediatek: Add SCPSYS power domain driver")
> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> 
> ---
> 
>   drivers/soc/mediatek/mtk-scpsys.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
> index f669d3754627dad..0055a52a49733d5 100644
> --- a/drivers/soc/mediatek/mtk-scpsys.c
> +++ b/drivers/soc/mediatek/mtk-scpsys.c
> @@ -524,6 +524,7 @@ static void mtk_register_power_domains(struct platform_device *pdev,
>   	for (i = 0; i < num; i++) {
>   		struct scp_domain *scpd = &scp->domains[i];
>   		struct generic_pm_domain *genpd = &scpd->genpd;
> +		bool on;
>   
>   		/*
>   		 * Initially turn on all domains to make the domains usable
> @@ -531,9 +532,9 @@ static void mtk_register_power_domains(struct platform_device *pdev,
>   		 * software.  The unused domains will be switched off during
>   		 * late_init time.
>   		 */
> -		genpd->power_on(genpd);
> +		on = genpd->power_on(genpd) >= 0;

Is this something we expect? On probing we realize that some domains can't be 
turned on?

I understand that this would be a bug in the driver. Therefore we should at most 
provide a warning instead of working around the bug, hiding it. Or do I got this 
wrong?

Regards,
Matthias

>   
> -		pm_genpd_init(genpd, NULL, false);
> +		pm_genpd_init(genpd, NULL, !on);
>   	}
>   
>   	/*
> 
