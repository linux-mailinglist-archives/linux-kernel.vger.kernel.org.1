Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A371D2AB1A4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 08:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729626AbgKIHKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 02:10:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728873AbgKIHKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 02:10:06 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387E7C0613CF
        for <linux-kernel@vger.kernel.org>; Sun,  8 Nov 2020 23:10:05 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id w4so6324218pgg.13
        for <linux-kernel@vger.kernel.org>; Sun, 08 Nov 2020 23:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eshRac5/MmHHShiRX7ctDUm71bdkmrovJAks2obZ/b4=;
        b=VBrl+3KUJgU0+gCP8koHfcudNuLo9tb5uwCbhpfLgMUfC0bSHdS3tg9vbLI/vElXdI
         ZXvrA9dAXmJJKEsgJP8DTgjr4EKVfgT8Oj8tkticKBq6NUUNm8H9EmKO3me28z+U27IG
         fgE7N0MSj8wwPbo6tQ2NimNjbkQaW2OFjUv5Ku21gb+9ohGkbZJQl/8w3UjXvKU7xQSf
         ENK4iFVR449My+b8c9GRCWqwE/5uvHsDIThnSUNYVTXZa0LL/+PQw7l8SZpG7iw88WV8
         xuqM8R2wMB2Qfdk8lIk5hHwvH4d1Y5+DO1K7LXvKqn42Y7MiKclbTGc+4ALa+F8w13SN
         pIAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eshRac5/MmHHShiRX7ctDUm71bdkmrovJAks2obZ/b4=;
        b=LeoDY6bXBAvAH3yf9UW14LSLk4/IwybHpls58xA6D828smh6H94cDmtnyGauLxV3yB
         acZlsEXaUO19v6cQPQQhbEE73riY5FC0/WqcHfOncdt19N6m3jWGciv+ij+A/QK2S7eJ
         AqcBxNm8cqLNy0RUf3TpaKP03/hTR7GX2vk8H58Bg/Lk2NiC/hM+Wa48jVlb2rTaEvSB
         aXnaFxLSY1ttK7M65F8XYtKrYMQmLkzNNQrfF6sXmALM9KjEwT29Ck+ZYQiUkg6NEa6+
         bMyCHB0CSDZ4AR5Jb8sCs7pcvQEJy8CawFoIq3CRozXDa9jayclR4t6Y9tKAglMEza1Z
         eYBw==
X-Gm-Message-State: AOAM533ap9mXeZzuosmaC7z15WCgD4dUghTluQXACiXgoj76cwFfsDBQ
        RylWRzvJ9LPzXp1PyvJ3JnYPZw==
X-Google-Smtp-Source: ABdhPJxP4JnqYKDDRIVWRFjXH6Mz6Q/UmQGkUp6hquzuURs5ilVhTwr/vCKSWwd4dRL/wMtsG0hE3A==
X-Received: by 2002:a17:90a:460b:: with SMTP id w11mr8596455pjg.12.1604905804835;
        Sun, 08 Nov 2020 23:10:04 -0800 (PST)
Received: from localhost ([122.172.12.172])
        by smtp.gmail.com with ESMTPSA id d11sm10472459pfo.198.2020.11.08.23.10.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Nov 2020 23:10:04 -0800 (PST)
Date:   Mon, 9 Nov 2020 12:40:02 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, sudeep.holla@arm.com,
        morten.rasmussen@arm.com, jeremy.linton@arm.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] acpi: fix NONE coordination for domain mapping
 failure
Message-ID: <20201109071002.s44db2o7silvc7fh@vireshk-i7>
References: <20201105125524.4409-1-ionela.voinescu@arm.com>
 <20201105125524.4409-9-ionela.voinescu@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105125524.4409-9-ionela.voinescu@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-11-20, 12:55, Ionela Voinescu wrote:
> For errors parsing the _PSD domains, a separate domain is returned for
> each CPU in the failed _PSD domain with no coordination (as per previous
> comment). But contrary to the intention, the code was setting
> CPUFREQ_SHARED_TYPE_ALL as coordination type.
> 
> Change shared_type to CPUFREQ_SHARED_TYPE_NONE in case of errors parsing
> the domain information. The function still return the error and the caller
> is free to bail out the domain initialisation altogether in that case.
> 
> Given that both functions return domains with a single CPU, this change
> does not affect the functionality, but clarifies the intention.
> 
> Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Len Brown <lenb@kernel.org>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/acpi/cppc_acpi.c         | 2 +-
>  drivers/acpi/processor_perflib.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 75e36b909ae6..e1e46cc66eeb 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -477,7 +477,7 @@ int acpi_get_psd_map(unsigned int cpu, struct psd_data *domain)
>  	/* Assume no coordination on any error parsing domain info */
>  	cpumask_clear(domain->shared_cpu_map);
>  	cpumask_set_cpu(cpu, domain->shared_cpu_map);
> -	domain->shared_type = CPUFREQ_SHARED_TYPE_ALL;
> +	domain->shared_type = CPUFREQ_SHARED_TYPE_NONE;
>  
>  	return -EFAULT;
>  }
> diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
> index 5909e8fa4013..5ce638537791 100644
> --- a/drivers/acpi/processor_perflib.c
> +++ b/drivers/acpi/processor_perflib.c
> @@ -710,7 +710,7 @@ int acpi_processor_preregister_performance(
>  		if (retval) {
>  			cpumask_clear(pr->performance->shared_cpu_map);
>  			cpumask_set_cpu(i, pr->performance->shared_cpu_map);
> -			pr->performance->shared_type = CPUFREQ_SHARED_TYPE_ALL;
> +			pr->performance->shared_type = CPUFREQ_SHARED_TYPE_NONE;
>  		}
>  		pr->performance = NULL; /* Will be set for real in register */
>  	}

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
