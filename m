Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA7E2D26CB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 10:03:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728583AbgLHJCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 04:02:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728541AbgLHJCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 04:02:50 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6779FC061749
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 01:02:10 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id w4so11585625pgg.13
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 01:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ktRqOqDmJZswMN706Fqn/i+gbaCD0WDj/K5Tumy5pf8=;
        b=NWnhwpibR5l4P5IScpYTB21X+9074Of4fyghAHH0dkZ8YXTWavMFYG4+VZMOqOeV+e
         s1niy07dMKNB7E3xa3ndMTjOlbU7/j/gXMI0KNWgztNn1ZduvhJY+Ag5UC2mYyeJC8Ov
         2zb2mJ0CwYh+PmnaHlHpfc2GgwuXVAvKbkUlh2nP2IrQvfUCRRh/SAWnLdESghZIXPWE
         wwvGa9Ea8EVPl04r701B9PG9wsrIqlxSfppnJxzDkyaC7lLsVVkDSu5sHS+++D8DnKUd
         UxTI+tH356NuzlPk82gWgJxdiWwQadGoU92NGuW+xh3iHvL4pXq6ugac+OhJ/5q2IsTk
         Q8ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ktRqOqDmJZswMN706Fqn/i+gbaCD0WDj/K5Tumy5pf8=;
        b=Tt1PtdPG2cr0xD6TcQ3u8HEsiXcbnsQNlAMzphnpUtuMw2/o+GGeh5lxuDdiTVTaOG
         eNjHooKI8p+fFQ0hk0jptRXW1yItnJ03ExlTpzxX5RWbB89cUJKfUUhQk0V8aWjIMQSb
         n3MdsVNfEUbofQHTzn6Lpa1mDo33hZ/7QMNyqaUv8NY52937DHNuUbrZAsV6EZQQtLV7
         kxHjyVBq0taEk8uTdeUZykB4SbKhLd9/Ir7zv1X3zrqwX429q5emoFGvpTpO90rozfDV
         Yx+31UwFJvXjpXV6aPv4u9HF9RtmIC91P/O3b38XNS+ooGOXCDHKlyL5yMM8WxCq8w74
         q4pQ==
X-Gm-Message-State: AOAM533WQ5N6ZkqNW6WPTsMC0bgEW8d0LwZsjt9BlKEnuzqgMoRevQyw
        3hQjOUAvK1uWqCQ4xtDiWotqbpca/Rdrmw==
X-Google-Smtp-Source: ABdhPJz4zNaqsYPi7XOZsSgbeITk3JB4g2aYMPeb9a30/v9bhbdzVU1Gl7ovAbSejPTH6lhi16Hxng==
X-Received: by 2002:a63:f915:: with SMTP id h21mr21970041pgi.389.1607418129919;
        Tue, 08 Dec 2020 01:02:09 -0800 (PST)
Received: from localhost ([122.172.136.109])
        by smtp.gmail.com with ESMTPSA id u198sm1120430pgc.84.2020.12.08.01.02.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Dec 2020 01:02:09 -0800 (PST)
Date:   Tue, 8 Dec 2020 14:32:07 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Doug Smythies <dsmythies@telus.net>,
        Giovanni Gherdovich <ggherdovich@suse.com>
Subject: Re: [PATCH v1 3/4] cpufreq: Add special-purpose fast-switching
 callback for drivers
Message-ID: <20201208090207.sz4v43bwvm7yugrb@vireshk-i7>
References: <20360841.iInq7taT2Z@kreacher>
 <146138074.tjdImvNTH2@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <146138074.tjdImvNTH2@kreacher>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-12-20, 17:35, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> First off, some cpufreq drivers (eg. intel_pstate) can pass hints
> beyond the current target frequency to the hardware and there are no
> provisions for doing that in the cpufreq framework.  In particular,
> today the driver has to assume that it should not allow the frequency
> to fall below the one requested by the governor (or the required
> capacity may not be provided) which may not be the case and which may
> lead to excessive energy usage in some scenarios.
> 
> Second, the hints passed by these drivers to the hardware need not be
> in terms of the frequency, so representing the utilization numbers
> coming from the scheduler as frequency before passing them to those
> drivers is not really useful.
> 
> Address the two points above by adding a special-purpose replacement
> for the ->fast_switch callback, called ->adjust_perf, allowing the
> governor to pass abstract performance level (rather than frequency)
> values for the minimum (required) and target (desired) performance
> along with the CPU capacity to compare them to.
> 
> Also update the schedutil governor to use the new callback instead
> of ->fast_switch if present.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> Changes with respect to the RFC:
>  - Don't pass "busy" to ->adjust_perf().
>  - Use a special 'update_util' hook for the ->adjust_perf() case in
>    schedutil (this still requires an additional branch because of the
>    shared common code between this case and the "frequency" one, but
>    IMV this version is cleaner nevertheless).
> 
> ---
>  drivers/cpufreq/cpufreq.c        |   40 ++++++++++++++++++++++++++++++++
>  include/linux/cpufreq.h          |   14 +++++++++++
>  include/linux/sched/cpufreq.h    |    5 ++++
>  kernel/sched/cpufreq_schedutil.c |   48 +++++++++++++++++++++++++++++++--------
>  4 files changed, 98 insertions(+), 9 deletions(-)
> 
> Index: linux-pm/include/linux/cpufreq.h
> ===================================================================
> --- linux-pm.orig/include/linux/cpufreq.h
> +++ linux-pm/include/linux/cpufreq.h
> @@ -320,6 +320,15 @@ struct cpufreq_driver {
>  					unsigned int index);
>  	unsigned int	(*fast_switch)(struct cpufreq_policy *policy,
>  				       unsigned int target_freq);
> +	/*
> +	 * ->fast_switch() replacement for drivers that use an internal
> +	 * representation of performance levels and can pass hints other than
> +	 * the target performance level to the hardware.
> +	 */
> +	void		(*adjust_perf)(unsigned int cpu,
> +				       unsigned long min_perf,
> +				       unsigned long target_perf,
> +				       unsigned long capacity);

With this callback in place, do we still need to keep the other stuff we
introduced recently, like CPUFREQ_NEED_UPDATE_LIMITS ?

-- 
viresh
