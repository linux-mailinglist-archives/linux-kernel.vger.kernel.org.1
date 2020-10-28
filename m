Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 791FF29D68C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731370AbgJ1WP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731352AbgJ1WPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:15:54 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95905C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:15:54 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id g7so1044875ilr.12
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wFPNpfscYErShEvirkWLIggeFX3qqltgvUGRMyDt6NY=;
        b=zFtm9F4SgKfsz25tFNW39l2gYgywrmYErkJeKvUe0IiBChHLju8mK7smQzTBwwKSt0
         lqf/BQDJzyeFB8iNcf2WO+D+IbQYaygVL6XYgNpc8H3nxS/VxC7njFvuopiWQ5HNMjqt
         OUuAH/q6Tc28GZ7fDrGanjPOKTfYya10QYBA3VOffpeMvrHMQlceypPZgFqoFN0jglFf
         J4/EZLbT84CW8hNEm3p4Ah6s6vAE5siHE1JLHJdc/nRhwgScyjoBZwJrlexEFFzwK/go
         7H9hOXOSJjsyxKyJMjaodOSF1IuKa3Zhr6oYyNhTBi4CS1Ce5LeXVxGO6KBAI0nf6kB0
         2yFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wFPNpfscYErShEvirkWLIggeFX3qqltgvUGRMyDt6NY=;
        b=DZnvg3TArdNCqZ1ImnNaRcdTRvx3GVuIR8lGEx/pG6O/0RSuAd8hx2LlVg9tYexep0
         3fmr0IE4zwDbNO/0I+oOofrDKTX7CnB1kh9AHcHOYbvkjrBFMTptMXprLDgiHM/k5zuE
         HZOU8eFcbW5s8TNCBtG2lZzAAxBs8I7ht2qLrgXwPzO6GhlL11dg7RZGNUy+b6du7DUs
         444eU0+EzkMk0W58vCn7y4DkXZ2Gv9olzNaEIvAVWzoM3QRjZRDHaQqtNiZFENjclsBc
         OC9FU6EVDs5l9sPLJyNya13naUFgWkBfOJ8rviGxtbr8KDDgx7viEjegHPORkoHC3UPV
         n1cQ==
X-Gm-Message-State: AOAM531KNrGXA4AIOEn7NZ9BBL7hNLXR32P4Wxlks5hsuMYOqZ0X2A+S
        aJa/AKxsk2jhLVkvmpbanbNzlrv+edZ+dA==
X-Google-Smtp-Source: ABdhPJxEtVm6sHDHKlwNoyZe+9lfdQoWx1RkjPgXUHFGpIrwVIAVS/n+ItZm0AaFjxkrdOmQfYMrzQ==
X-Received: by 2002:a63:1543:: with SMTP id 3mr4941667pgv.158.1603865284490;
        Tue, 27 Oct 2020 23:08:04 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id e184sm2107988pfe.146.2020.10.27.23.08.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Oct 2020 23:08:03 -0700 (PDT)
Date:   Wed, 28 Oct 2020 11:38:01 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Frank Lee <frank@allwinnertech.com>
Cc:     patrice.chotard@st.com, rjw@rjwysocki.net, tiny.windzz@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: sti-cpufreq: fix mem leak in
 sti_cpufreq_set_opp_info()
Message-ID: <20201028060801.4s5ujmbhiej2uzn7@vireshk-i7>
References: <20201012140141.20296-1-frank@allwinnertech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201012140141.20296-1-frank@allwinnertech.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-10-20, 22:01, Frank Lee wrote:
> From: Yangtao Li <tiny.windzz@gmail.com>
> 
> Use dev_pm_opp_put_prop_name() to avoid mem leak, which free opp_table.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> Signed-off-by: Yangtao Li <frank@allwinnertech.com>
> ---
>  drivers/cpufreq/sti-cpufreq.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/sti-cpufreq.c b/drivers/cpufreq/sti-cpufreq.c
> index a5ad96d29adc..9668a48dad33 100644
> --- a/drivers/cpufreq/sti-cpufreq.c
> +++ b/drivers/cpufreq/sti-cpufreq.c
> @@ -222,7 +222,8 @@ static int sti_cpufreq_set_opp_info(void)
>  	opp_table = dev_pm_opp_set_supported_hw(dev, version, VERSION_ELEMENTS);
>  	if (IS_ERR(opp_table)) {
>  		dev_err(dev, "Failed to set supported hardware\n");
> -		return PTR_ERR(opp_table);
> +		ret = PTR_ERR(opp_table);
> +		goto err_put_prop_name;
>  	}
>  
>  	dev_dbg(dev, "pcode: %d major: %d minor: %d substrate: %d\n",
> @@ -231,6 +232,10 @@ static int sti_cpufreq_set_opp_info(void)
>  		version[0], version[1], version[2]);
>  
>  	return 0;
> +
> +err_put_prop_name:
> +	dev_pm_opp_put_prop_name(opp_table);
> +	return ret;
>  }
>  
>  static int sti_cpufreq_fetch_syscon_registers(void)

Applied. Thanks.

-- 
viresh
