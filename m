Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77A00220278
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jul 2020 04:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728329AbgGOCoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jul 2020 22:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727071AbgGOCoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 22:44:37 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F985C061794
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 19:44:37 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id a14so1054067pfi.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 19:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=utvICfuCuFlpiRHbwei80u9bDXZsdPiuf5g3t7ZMbnw=;
        b=q9VDXdFxBzmlMiYI3UsBHH3betTklXyYxBHHqFrQ6SgA8JyMP1H+mDPADCjVosU175
         bnhS5f4vcP3eqm6d90YE2DOYNk0da4OTbHSOc+gFy4W9F7r+LBTM6z0IqOMjWGyRfVVy
         SjE+QoJg/fdyEh2XmKlmYcF0jaXvxJ10BM43abBoK6Rhcvza+1A07hHChN9CXp0pkkpa
         HaavUTGRheQoo3BNJNnv1ttuyYK2vlXsGMCiplQODLfs62C4FpoL3nqYWIfpZ3OWZ522
         9sCA4UKf09ZTnVhaVqsAYXQbgPw0KCqnzARdx1kHy2B4ONjo/Jk+SKmXW9Vfr4xZMHvn
         x1+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=utvICfuCuFlpiRHbwei80u9bDXZsdPiuf5g3t7ZMbnw=;
        b=VvnnifwQyXHttfkbYskosAy0vnEG1AW/lp8ah9o4EBgEvotaBm56l69QVoklxslOmT
         7BJVMfTwTv6dLgNCqlonPmeTLOboeVIqbbi+h1DdD1JOWKDjimbgSw0kPWdEulGmu2Jp
         V8rMPlN1er8wA/AWmJ+cz35bUaBJpa342AOgv9AOltLPpFs+1VUsBuCVTJFYYh+fbeJn
         wiegjgJDo2Tzyspe6oRA7IPKKG/MtapEk8bU5JYBQrj/PZC86ywGFHLoMoHfjWKocAce
         aMB6u78mXRuo0oaMnchfFZMYz8y/2Taa0kdpWWoZ+gPrzPSRBNKSWH3arx4PKcuF6XG2
         aoTw==
X-Gm-Message-State: AOAM531Vih6EHHoi0GW5cc+I52KfzWEwIiYnvoVLRf0nftwRBFZudWob
        yY2pehg8LqT3aOzBgHYKngU8Vtn257k=
X-Google-Smtp-Source: ABdhPJyRJ0HV5M9ZKqN55OluXspx9XGOP93G5a6RQoMdeI3te8Tt8fRFF+88f39xp71NRuYXVUzQTA==
X-Received: by 2002:aa7:9424:: with SMTP id y4mr644985pfo.287.1594781076764;
        Tue, 14 Jul 2020 19:44:36 -0700 (PDT)
Received: from localhost ([122.172.34.142])
        by smtp.gmail.com with ESMTPSA id s194sm408224pgs.24.2020.07.14.19.44.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Jul 2020 19:44:36 -0700 (PDT)
Date:   Wed, 15 Jul 2020 08:14:34 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     rjw@rjwysocki.net, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Dominik Brodowski <linux@brodo.de>
Subject: Re: [PATCH 01/13] cpufreq: freq_table: Demote obvious misuse of
 kerneldoc to standard comment blocks
Message-ID: <20200715024434.ttnkq7mfwylgkiec@vireshk-i7>
References: <20200714145049.2496163-1-lee.jones@linaro.org>
 <20200714145049.2496163-2-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714145049.2496163-2-lee.jones@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-07-20, 15:50, Lee Jones wrote:
> No attempt has been made to document any of the demoted functions here.
> 
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/cpufreq/freq_table.c:229: warning: Function parameter or member 'policy' not described in 'show_available_freqs'
>  drivers/cpufreq/freq_table.c:229: warning: Function parameter or member 'buf' not described in 'show_available_freqs'
>  drivers/cpufreq/freq_table.c:229: warning: Function parameter or member 'show_boost' not described in 'show_available_freqs'
>  drivers/cpufreq/freq_table.c:269: warning: Function parameter or member 'policy' not described in 'scaling_available_frequencies_show'
>  drivers/cpufreq/freq_table.c:269: warning: Function parameter or member 'buf' not described in 'scaling_available_frequencies_show'
>  drivers/cpufreq/freq_table.c:281: warning: Function parameter or member 'policy' not described in 'scaling_boost_frequencies_show'
>  drivers/cpufreq/freq_table.c:281: warning: Function parameter or member 'buf' not described in 'scaling_boost_frequencies_show'
> 
> Cc: Dominik Brodowski <linux@brodo.de>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/cpufreq/freq_table.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
> index e117b0059123e..f839dc9852c08 100644
> --- a/drivers/cpufreq/freq_table.c
> +++ b/drivers/cpufreq/freq_table.c
> @@ -221,7 +221,7 @@ int cpufreq_frequency_table_get_index(struct cpufreq_policy *policy,
>  }
>  EXPORT_SYMBOL_GPL(cpufreq_frequency_table_get_index);
>  
> -/**
> +/*
>   * show_available_freqs - show available frequencies for the specified CPU
>   */
>  static ssize_t show_available_freqs(struct cpufreq_policy *policy, char *buf,
> @@ -260,7 +260,7 @@ static ssize_t show_available_freqs(struct cpufreq_policy *policy, char *buf,
>  struct freq_attr cpufreq_freq_attr_##_name##_freqs =     \
>  __ATTR_RO(_name##_frequencies)
>  
> -/**
> +/*
>   * show_scaling_available_frequencies - show available normal frequencies for
>   * the specified CPU
>   */
> @@ -272,7 +272,7 @@ static ssize_t scaling_available_frequencies_show(struct cpufreq_policy *policy,
>  cpufreq_attr_available_freq(scaling_available);
>  EXPORT_SYMBOL_GPL(cpufreq_freq_attr_scaling_available_freqs);
>  
> -/**
> +/*
>   * show_available_boost_freqs - show available boost frequencies for
>   * the specified CPU
>   */

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
