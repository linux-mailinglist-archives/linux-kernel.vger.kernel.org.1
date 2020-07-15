Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCE16220286
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jul 2020 04:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbgGOCw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jul 2020 22:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727942AbgGOCwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 22:52:55 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679C7C061794
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 19:52:53 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id d1so1228587plr.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 19:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0glwH8EcqSXFTX4S1OVt6no4ymJBSG2idjiGE4hkLiM=;
        b=fNlgkfmDwYPu+1TiJmpDeFF7yvT0rvgUsFCO2nrvBJaQERLj46VXGKvjkn30DcvkQx
         zv2oZ4Tn09R9NJe9ZBdZXwZBwzH3GOIUYa8BpGzc6ce9ukSog16/HMFN2UseUIs6V3lA
         jjDePlp2R50dpqk6z08fu2ddB3kYIAjl3tnVaEiTudbKk4ilWGqHvC4JDmZTlHzZhMYG
         /YfaLq9Zom+2U+6CZgKLQl+T598KbR/cG3WDcXYudSy3hQJiKILRH5MgMksYh5rzQ+Be
         cqW32qVqKgrBPU4LvKh2fbjg0enYvkU0AB5/NJQPnxLlkSq40vK4wZSAgNe6uCcLoYnv
         EaCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0glwH8EcqSXFTX4S1OVt6no4ymJBSG2idjiGE4hkLiM=;
        b=rAX0VddV+sHGLJtwNiR0F6qcrMkLSDK2LdMfJUIDEdD0cxjX+KQS/jhlGySckEtEd7
         Fu9u4N5N32MHWQNdTl4yBcKtz0JESWovgJiPq4Ix3tMKuBRHx9CMynL9/Ddk8Bw4RvgR
         tdyggTHqFekACWEkwn/+aIcOoK4m6MMNyAwdspTZCPa6UKM2dJEvoOrTNqwfu0VEXLRM
         O+QPo2DI6AIh0WzgHCJmVedO4/aH4PCdJMni7TJlIYm1DamgDuQ5hXw9eGEnH6euz+Eb
         Ngals2RqE2EpWnnqZIox+PtNx84KLNsv7NyA+rs6OvTgZMy9wVaenfjx+3WVFKsULnLx
         u4Ew==
X-Gm-Message-State: AOAM532B9rSFrunivtAjWwmz/vtnLk7TN5Opj++8TmwSUp304OYPkgaW
        v6E39kyHCZUGTCY7Cy5IaJ79ow==
X-Google-Smtp-Source: ABdhPJywnJogb+vLoV2wTh6Hylf/9jv+Y4yT1XFZa3VwwHYObsWDA0rKozjggr2ARVQoMr/+ykEg3Q==
X-Received: by 2002:a17:902:7790:: with SMTP id o16mr5915781pll.299.1594781572913;
        Tue, 14 Jul 2020 19:52:52 -0700 (PDT)
Received: from localhost ([122.172.34.142])
        by smtp.gmail.com with ESMTPSA id r9sm360441pje.12.2020.07.14.19.52.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Jul 2020 19:52:52 -0700 (PDT)
Date:   Wed, 15 Jul 2020 08:22:49 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     rjw@rjwysocki.net, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
        Jun Nakajima <jun.nakajima@intel.com>,
        Alexander Clouter <alex@digriz.org.uk>
Subject: Re: [PATCH 03/13] cpufreq: cpufreq_governor: Demote
 store_sampling_rate() header to standard comment block
Message-ID: <20200715025249.ukoqup4piqiz5lim@vireshk-i7>
References: <20200714145049.2496163-1-lee.jones@linaro.org>
 <20200714145049.2496163-4-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714145049.2496163-4-lee.jones@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-07-20, 15:50, Lee Jones wrote:
> There is no need for this to be denoted as kerneldoc.
> 
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/cpufreq/cpufreq_governor.c:46: warning: Function parameter or member 'attr_set' not described in 'store_sampling_rate'
>  drivers/cpufreq/cpufreq_governor.c:46: warning: Function parameter or member 'buf' not described in 'store_sampling_rate'
>  drivers/cpufreq/cpufreq_governor.c:46: warning: Function parameter or member 'count' not described in 'store_sampling_rate'
> 
> Cc: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
> Cc: Jun Nakajima <jun.nakajima@intel.com>
> Cc: Alexander Clouter <alex@digriz.org.uk>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/cpufreq/cpufreq_governor.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
> index f99ae45efaea7..63f7c219062b9 100644
> --- a/drivers/cpufreq/cpufreq_governor.c
> +++ b/drivers/cpufreq/cpufreq_governor.c
> @@ -26,7 +26,7 @@ static DEFINE_PER_CPU(struct cpu_dbs_info, cpu_dbs);
>  static DEFINE_MUTEX(gov_dbs_data_mutex);
>  
>  /* Common sysfs tunables */
> -/**
> +/*

This is an important routine with good documentation details already
there, though internal to governors and so I would rather keep it.

>   * store_sampling_rate - update sampling rate effective immediately if needed.
>   *
>   * If new rate is smaller than the old, simply updating
> -- 
> 2.25.1

-- 
viresh
