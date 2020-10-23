Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FDC2296986
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 08:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S372149AbgJWGKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 02:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S372091AbgJWGKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 02:10:22 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F70C0613D2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 23:10:22 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id 19so371677pge.12
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 23:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6UEn5uQoN4tJhlwF5ab2tVEcFvdTfAmRUHva/rE0Zjg=;
        b=M7gPdb+hguPe44SEUlDoDlStAqPFEbcVqaMJ5bChIX4Pxy+NjdIEjO1s8MlDngH7dP
         0qe5JVVTxBIblOauNqW+rkh93FNU2LrfGHgTaAecOoyiAaBrisLbDz+8suOaJIK10hOO
         ifj0/17nqUEsmS0aO0Yht6VcYDlI7uTRwvhvSStMrnG27EAFZ+MYLgcYHEFDCPDJri+v
         bXxS84qIzuG/DNbIVNCNAlsZ6fUr2a6oT+b82ejX1ueUqvjZhTZucc8T7lA0aDlce3ht
         5GnHxEXIiJBxWkAym5/hf84TZoTbixmcslk4xbJu5Ica/x+ClE1oPsA6d3cLg9yOKsqL
         ndCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6UEn5uQoN4tJhlwF5ab2tVEcFvdTfAmRUHva/rE0Zjg=;
        b=kayNVuMcqw40HUTLZB+mHVFWMP+MwDuEneNmZzz5mjlNPfmvCeoq7AqVvdn+ur2twU
         Ql2tnFOBdd2DyaI7t4QpQcy18Sfxh8jWZjBh1HaOmZpgLfq/cb/qIgto0AfsNXyqX8V5
         NkeWBqoG2hevSadwbcytaVTtNH+164pm6fb1N0B7ybT8LmIawGl1c/2UAckKXKxx3tv0
         1WIQs9mGWwLgglJTGJ4hFxX3Syd/S9A6kG3rCLrqTxpcKUo+ZQmC5TW6mEBlrudBSMDz
         QdMaUsldRKp6dGhv8gpirU0dhA9QHDZptVpgvK+3qj/wi6KDgOhlUj+xUsj0falcMsPO
         YyrQ==
X-Gm-Message-State: AOAM533iwQFMjGuhB5p+7o6UjOYKf/AJ1a+ozLfqbci6dFJ6ajwO2dLm
        /sKEm2aI2mmCuv2c71Qc2EN7uA==
X-Google-Smtp-Source: ABdhPJwi5s1RMTwKdoTVcsIJ1GH7YJq0cwGcE3g0iWUU100kbuphJYvJ35WaYmTINEM6acQeDfHc2w==
X-Received: by 2002:a17:90a:a898:: with SMTP id h24mr728011pjq.179.1603433421947;
        Thu, 22 Oct 2020 23:10:21 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id e23sm631470pfi.191.2020.10.22.23.10.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Oct 2020 23:10:20 -0700 (PDT)
Date:   Fri, 23 Oct 2020 11:40:18 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 1/2] cpufreq: intel_pstate: Avoid missing HWP max updates
 in passive mode
Message-ID: <20201023061018.euom3sfxw7uvtmya@vireshk-i7>
References: <1666263.spd1I39WAV@kreacher>
 <76352140.UXiy1LajID@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76352140.UXiy1LajID@kreacher>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-10-20, 13:57, Rafael J. Wysocki wrote:
> Index: linux-pm/drivers/cpufreq/cpufreq.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/cpufreq.c
> +++ linux-pm/drivers/cpufreq/cpufreq.c
> @@ -2182,6 +2182,9 @@ int __cpufreq_driver_target(struct cpufr
>  	pr_debug("target for CPU %u: %u kHz, relation %u, requested %u kHz\n",
>  		 policy->cpu, target_freq, relation, old_target_freq);
>  
> +	if (cpufreq_driver->target)
> +		return cpufreq_driver->target(policy, target_freq, relation);
> +
>  	/*
>  	 * This might look like a redundant call as we are checking it again
>  	 * after finding index. But it is left intentionally for cases where
> @@ -2194,9 +2197,6 @@ int __cpufreq_driver_target(struct cpufr
>  	/* Save last value to restore later on errors */
>  	policy->restore_freq = policy->cur;
>  
> -	if (cpufreq_driver->target)
> -		return cpufreq_driver->target(policy, target_freq, relation);
> -
>  	if (!cpufreq_driver->target_index)
>  		return -EINVAL;

From what I understood, you want your driver to get notified about
policy->min/max changes and right now they are making it work from
within the target() callback. Your commit log talks about policy->max
and powersave combination, I think the same will be true in case of
policy->min and performance ? And also with any other governor (like
schedutil) if the target_freq doesn't change for a while.

And IMHO, this change is more like a band-aid which is going to remove
the check of target != cur for all target() type drivers (which aren't
many) and it feels like a penalty on them (which is also there for
intel-cpufreq without hwp), and that we will get into the same problem
for target_index() drivers as well if they want to do something
similar in future, i.e. skip checking for same-freq.

Maybe adding a new flag for the cpufreq-driver for force-updates would
be a better solution ? Which will make this very much driver
dependent.

-- 
viresh
