Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE572FCA0D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 05:42:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729878AbhATElg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 23:41:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727122AbhATEkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 23:40:19 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76BDAC061575
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 20:39:39 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id b5so1378411pjl.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 20:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3Mw9kpTWYLs3GYeFCfv2XLbWScki4E8QbYrJLATCMOM=;
        b=NSOrtz9JoqUpYLUCCHjbFEdlVTD56bqaffClcuXWTCrFL897Lom+Qbl/QZRG8jUavo
         3BVHucGwNpSvG0TN0uzfs/15kOixsoGwr8cAkkZLHw1iKT1Fd/re6YcN3qoWaR4RSryj
         X5cI35dcMrlx6A+1XOsn10yQZuQ+JvIwix4AF9qhS4cpacFOSXlaol/YjhXX32T+kMLd
         WcknRbRNUX85FbG4GwK36nACqMC3Jc0LCvtv7cFCZCKK1+jL4ieziZFp8Vfi20lCTTbN
         Dt8QtG7YTyV/mN0q68LmIAzplQu6gYW0MGfJmEzp+44ebL/CksaqbgtbMJ1+DX9F8TlH
         8lLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3Mw9kpTWYLs3GYeFCfv2XLbWScki4E8QbYrJLATCMOM=;
        b=Jvn52C41cU+uXfsQw4Cjb9/Y7s9UCB+9JgD8Uy5ZrJL2Mt0OvkFdLYx02lRxYEiU7h
         amGxtwNeC6GOtgOvQPiQ/mGdBV9SXja9K3TOBoELGjjyZFCSMeXYwZUJS9i/D/1DxnkS
         N1PmH4xOZBZLAaGZTgs4sf3eq9ls5Bws2bsMLFmgv6UWl32STbkwh86/WWTS11sVyKy5
         E/CcvrFMERbtF3QagnGf/XXsBHR3JpjhdwW67r8tg4gw4TaLC3sqq55dkyOGlA2SeiFO
         6cxPhyACfwDlFdbPGrWR+CWGttR7BMRukn75/8zZEInKbcJPx6lguSTMPQLeeef0Et+s
         DIhA==
X-Gm-Message-State: AOAM531RvI1hfe3VCkiR2UFzIg3gnh4T58fm7NggRpwM4ImqLm3tJzJo
        czArJ/WyxVzM+H+Beqjd9F7EKOeEwiUSYw==
X-Google-Smtp-Source: ABdhPJxWrwGkrMAt216utAgHlcqTJR4nbRCrGF/RIvEBvOStwKqO/SPw4ZkPZWTjLIEYXgSFndBaEA==
X-Received: by 2002:a17:902:b692:b029:de:43aa:6537 with SMTP id c18-20020a170902b692b02900de43aa6537mr8177507pls.65.1611117578969;
        Tue, 19 Jan 2021 20:39:38 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id u68sm620672pfb.70.2021.01.19.20.39.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jan 2021 20:39:38 -0800 (PST)
Date:   Wed, 20 Jan 2021 10:09:33 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matt Merhar <mattmerhar@protonmail.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 1/3] PM: domains: Make set_performance_state()
 callback optional
Message-ID: <20210120043933.6ilryvgkhvnsrei7@vireshk-i7>
References: <20210120015010.14191-1-digetx@gmail.com>
 <20210120015010.14191-2-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210120015010.14191-2-digetx@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-01-21, 04:50, Dmitry Osipenko wrote:
> Make set_performance_state() callback optional in order to remove the
> need from power domain drivers to implement a dummy callback. If callback
> isn't implemented by a GENPD driver, then the performance state is passed
> to the parent domain.
> 
> Tested-by: Peter Geis <pgwipeout@gmail.com>
> Tested-by: Nicolas Chauvet <kwizart@gmail.com>
> Tested-by: Matt Merhar <mattmerhar@protonmail.com>
> [tested on NVIDIA Tegra20/30/124 SoCs]
> Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/base/power/domain.c | 33 ++++++++++++++++++---------------
>  1 file changed, 18 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 9a14eedacb92..0bd0cdc30393 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -297,6 +297,18 @@ static int _genpd_reeval_performance_state(struct generic_pm_domain *genpd,
>  	return state;
>  }
>  
> +static int _genpd_xlate_performance_state(struct generic_pm_domain *src_genpd,
> +					  struct generic_pm_domain *dst_genpd,
> +					  unsigned int pstate)

I would name them as genpd and parent, that makes it more readable for it.

-- 
viresh
