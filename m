Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC062F9B09
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 09:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387612AbhARIMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 03:12:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387455AbhARIMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 03:12:34 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D542C061574
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 00:11:51 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id p15so8897050pjv.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 00:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QKcmKyiOriNv9CawnvLDegUn0IWwVGyV2JGDmEMB510=;
        b=fsf7zvodAzztsfzAYxfizNdjfBiH0V2dU3ZnZS924fbocq91Oy4ifO/hdCp9iHc9ik
         bEWEq4wBRN9oLh37aeJMb0GQvUJWCIJdHT9Y2GNdPua6Bo+r7Hhbfgg8tpNXGbd1tQv4
         69o+LxI+OSafI5PUqcomCVy72Zv4exlc/PdvLp2Vw1miy+4yusr3ovDoUMCgQKDRMtLz
         evFom4MSw3877mXseuu2p0cgDuuIRzs0GwJKmX0zEobet2p66F2o6Pjwg3o6Ri0mtNJ0
         wc1ntYnzih3qatinQAvMqHdIJqs+j0hHXybePeB3cevaCltSSkXD/QYeM/Ghd0iv8EfJ
         UMYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QKcmKyiOriNv9CawnvLDegUn0IWwVGyV2JGDmEMB510=;
        b=iX9Ur4n9kTNafcgdutNE190dbOU8NeJJD2EaPuq+BMpPP2gL/tAJdLC+QShY+cr9fq
         CVBK2+6EyclCzMNxIJsnziSqta5/VclB0/xNlT2Gjgb/JBD95iJ5xzkMbc6ex5QshImz
         U3ZFRnmzM3JdzxYhxHkCFk4NDHmR3ZdF7wV2o9luPQpglglqVsxAJZtPuBiYD0mGSmZA
         YZWgqvpMJvL/AsBk6OVfqmmRmRJnJiXa0dmt9MsXYxX/qU4ELCoqGELDgp+vLOd/dRQl
         fbQH5X5w6GvgiUFyuquQzrtupVQbDZI/2G9qTo8S72rhdGH7mzQ5rQEfpDr5rse8N4qI
         xP2A==
X-Gm-Message-State: AOAM533vPnonnJRKbgo6/muvcyy15p7OqrLm30XBm5UFjYK4hSjhNoqw
        zJf86oesIBzcXXZNsvqb6Pgftg==
X-Google-Smtp-Source: ABdhPJxFSgtpSYoL414526LkeAHMNoXzxaUVmksVJSVla/O6fWvtj19lRqgO+oAwdSstw1rOdo3QhQ==
X-Received: by 2002:a17:90a:d24a:: with SMTP id o10mr23597810pjw.160.1610957510970;
        Mon, 18 Jan 2021 00:11:50 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id 101sm15155588pjo.38.2021.01.18.00.11.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jan 2021 00:11:50 -0800 (PST)
Date:   Mon, 18 Jan 2021 13:41:47 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 02/12] opp: Filter out OPPs based on availability of a
 required-OPP
Message-ID: <20210118081147.bfk2wgu5rabqnvku@vireshk-i7>
References: <20210118005524.27787-1-digetx@gmail.com>
 <20210118005524.27787-3-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210118005524.27787-3-digetx@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-01-21, 03:55, Dmitry Osipenko wrote:
> A required OPP may not be available, and thus, all OPPs which are using
> this required OPP should be unavailable too.
> 
> Tested-by: Peter Geis <pgwipeout@gmail.com>
> Tested-by: Nicolas Chauvet <kwizart@gmail.com>
> Tested-by: Matt Merhar <mattmerhar@protonmail.com>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/opp/core.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 48618ff3e99e..7b4d07279638 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -1522,6 +1522,7 @@ int _opp_add(struct device *dev, struct dev_pm_opp *new_opp,
>  	     struct opp_table *opp_table, bool rate_not_available)
>  {
>  	struct list_head *head;
> +	unsigned int i;
>  	int ret;
>  
>  	mutex_lock(&opp_table->lock);
> @@ -1547,6 +1548,16 @@ int _opp_add(struct device *dev, struct dev_pm_opp *new_opp,
>  			 __func__, new_opp->rate);
>  	}
>  
> +	for (i = 0; i < opp_table->required_opp_count; i++) {
> +		if (new_opp->required_opps[i]->available)
> +			continue;
> +
> +		new_opp->available = false;
> +		dev_warn(dev, "%s: OPP not supported by required OPP %pOF (%lu)\n",
> +			 __func__, new_opp->required_opps[i]->np, new_opp->rate);
> +		break;
> +	}
> +
>  	return 0;
>  }

Applied. Thanks.

Though I am concerned about who will enable this back again if the
required-opp comes back. And I am not sure if we should even care
about that.

-- 
viresh
