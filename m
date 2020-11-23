Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C68012C034A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 11:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728528AbgKWK2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 05:28:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727724AbgKWK2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 05:28:44 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E7BC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 02:28:44 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id t4so5105657wrr.12
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 02:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QBOfASHnUxQQVj9menr9Mtl7PTogCDCPwt8mUyqvY2w=;
        b=B+0zRR24kTqIkPhwnR5Qa0Vhympvng3eNhuIlZ/qW5hLB08WEFvlO6zerKIOjWsDQA
         QBuwGjrFKeOSPbozTZyS/kR7JKMor1ghtfl3Y0qeUNQEUnUQcgCvskwoxmHpPZ+q0DpV
         WSP3ZW56JWRPKdd3W/iuT6n4gqavfGBFDtrt8ONBI0yEBv5bAWPOnxqVx+R5YMcqKPTf
         oBEcMk6Mh8D2pE1SpZSl9O0Aj+enhlsF6vBKCgtTRh89aWGgl/2/zTBapCJfXNVE/4bW
         E3Ydec1Yux3jMzdSUv6jkbOhT6/aJe43JaxPaudEvHYQf/2Nvtd5qQt3lr4JwSouuEsA
         moIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QBOfASHnUxQQVj9menr9Mtl7PTogCDCPwt8mUyqvY2w=;
        b=jFlL0l6mBIjI+DcIko7DYGKxQP/9ejOuZ1kVGAu1KfGuRU4+FbkLtS1Mc5F0xkHHYV
         QRrSnghqbAdLdT41NMPmojpOGufjBldoq2ulptArDsNzzdBwHbPQNKnZXk4iuwakEFi7
         SkiWmNCMApaLyYzJV3HGdvFc9O/3YKjHLJrsxf1eeVsudjF5VtR/cZ+ozGwuybpp2VK0
         xtWtZWofKG6IPb81CVLIfdr7QyMlCTELwfidT82K+eNqslXUhvAOhvU4IqcqBYomc7tY
         jDxJ7Kxt6saEt5yyXBOtKZkoeqnMEnpMw4jVVw9h9kfsVLgd++0gGzFGIfVrXnu6GJaz
         KL0g==
X-Gm-Message-State: AOAM532StqjPhv5VelzErttf0TIXjUl7iXmOYHAjSDbRCQMs1YWSpTfL
        nPIRljvM/yYK9HGlyfs9fSbJDQ==
X-Google-Smtp-Source: ABdhPJxvSSm1Sjl5XKtEfbyt391DU3UNmYWeAq7S48PJijXqxSNNebjWRljLT4p8e9T2euBfXEseVw==
X-Received: by 2002:adf:e80b:: with SMTP id o11mr30292104wrm.409.1606127322913;
        Mon, 23 Nov 2020 02:28:42 -0800 (PST)
Received: from google.com ([2a00:79e0:d:210:f693:9fff:fef4:a7ef])
        by smtp.gmail.com with ESMTPSA id g138sm15640157wme.39.2020.11.23.02.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 02:28:42 -0800 (PST)
Date:   Mon, 23 Nov 2020 10:28:39 +0000
From:   Quentin Perret <qperret@google.com>
To:     Pavankumar Kondeti <pkondeti@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] PM / EM: Micro optimization in em_pd_energy
Message-ID: <20201123102839.GB447993@google.com>
References: <1606126679-11799-1-git-send-email-pkondeti@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1606126679-11799-1-git-send-email-pkondeti@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavan,

On Monday 23 Nov 2020 at 15:47:57 (+0530), Pavankumar Kondeti wrote:
> When the sum of the utilization of CPUs in a power domain is zero,

s/power/performance

> return the energy as 0 without doing any computations.
> 
> Signed-off-by: Pavankumar Kondeti <pkondeti@codeaurora.org>
> ---
>  include/linux/energy_model.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
> index b67a51c..8810f1f 100644
> --- a/include/linux/energy_model.h
> +++ b/include/linux/energy_model.h
> @@ -103,6 +103,9 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
>  	struct em_perf_state *ps;
>  	int i, cpu;
>  
> +	if (!sum_util)
> +		return 0;
> +
>  	/*
>  	 * In order to predict the performance state, map the utilization of
>  	 * the most utilized CPU of the performance domain to a requested

Makes sense to me, so with nit above:

Acked-by: Quentin Perret <qperret@google.com>

Thanks!
Quentin
