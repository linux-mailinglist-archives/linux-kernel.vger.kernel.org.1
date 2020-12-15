Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB7032DA73D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 05:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725890AbgLOEuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 23:50:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbgLOEuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 23:50:04 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A05AAC061793
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 20:49:24 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id f17so14404001pge.6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 20:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hrohNicNevgDQPipTivJ45CN4SGBQeN8JaH8Zw8IYAc=;
        b=cYY755wbup7SyFUqyvm5Rm8VcR6Cx2tW3ZhbFQ4sdFlQ5s8FlHnE4Ex2CVIzntzIjP
         v2sJWiJ/hzO9XunO4t5OqxuVCaqBryfyYMeQonU4kZvoKJFBrXyKpVYjZ7Hlef7naXUa
         mQCax3d2iOp8OxDwRJNNF/41euULWhnuV7P8J2ojjrUQsZ3O87lnytWx8axCwskwtH3z
         EWDh/4bKmIpB7YSD30HFU+i49VR6uZThsWuy7ydZfsQnFml60qfaSYUtx0sPJerh/VIH
         bmLN73y7NaSL14RxYfL7BblV7sovVaqAMXWVYCzlSWZcaY/Zu9HDXk8hVhXmypI9qSTZ
         D2jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hrohNicNevgDQPipTivJ45CN4SGBQeN8JaH8Zw8IYAc=;
        b=i7I7twy7I03WXruMEis3dJLFWrmW8ZyloRNDeWjWGc4XV7uDfotbApHhuQ8FQcMMuk
         ssrwRKddOBZkTosR0mWGJmR9DZ6ykUcCqq0YIuZlmltfRHuI8pvlv0nLJaZ3Qy6TgsjL
         fxvorGSBBHAS/DYasCm3Cpl7k1kYkCrpDUjVuki5E0tqPp377q4fgTWx8uWYbZbNbYax
         m6WuOJwzhiuk5cHsibeWbxDo7iHm8pRAlegK0HFeK469xieuOW6ZYkfWnL++NxIvg9k5
         PDP9sW+rbzrq3KoguED8PUWz5KB2pvTmwC4g0Pa+Mq6R94I9wlbT10uuRnN9Kih9EIMR
         y39Q==
X-Gm-Message-State: AOAM530V7/oAN15eQOAhBKdkEszzS09Ha/QxOYekymizIxWEg/dYHvx2
        pNbyxyABUpCowj6dyHyGE1BLxw==
X-Google-Smtp-Source: ABdhPJw/xCwHiq/CsfzF1YNSS/89dg80UcllxJfiFt55z3SjPXdW5awC/CcT+05LhUgxwdwVHQlmMg==
X-Received: by 2002:a63:f919:: with SMTP id h25mr27642147pgi.440.1608007764194;
        Mon, 14 Dec 2020 20:49:24 -0800 (PST)
Received: from localhost ([122.172.20.109])
        by smtp.gmail.com with ESMTPSA id p15sm22401458pgi.40.2020.12.14.20.49.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Dec 2020 20:49:22 -0800 (PST)
Date:   Tue, 15 Dec 2020 10:19:20 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 2/2] arm64: topology: Reorder init_amu_fie() a bit
Message-ID: <20201215044920.fo2n2k5j2snk4pbn@vireshk-i7>
References: <5f85c2ddf7aa094d7d2ebebe8426f84fad0a99b7.1607617625.git.viresh.kumar@linaro.org>
 <202f775d57bd143602f9100ba3d9619d15d43409.1607617625.git.viresh.kumar@linaro.org>
 <20201214140038.GB15405@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201214140038.GB15405@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-12-20, 14:00, Ionela Voinescu wrote:
> I think there could be a potential problem here (it would be unlikely
> but why not fix it :) ). It was in the code before your changes.
> 
> When we enable amu_fie_key here, topology_scale_freq_tick() could be
> called for AMU CPUs, which will compute and set a scale factor. Later
> on, if we happen to find the system not invariant, we disable counter
> based invariance, but a scale factor might have been set already for a
> CPU, which would and should have returned 1024 otherwise (the
> initialisation value of freq_scale).
> 
> 
> Therefore, while here, you could instead do the following:
> 
> cpufreq_inv = cpufreq_supports_freq_invariance();
> 
> if (!cpufreq_inv &&
>     !cpumask_subset(cpu_online_mask, amu_fie_cpus))
>     goto free_valid_mask;
> 
> static_branch_enable(&amu_fie_key);
> 
> pr_info(..);
> 
> if (!cpufreq_inv)
>     rebuild_sched_domains_energy();
> 
> What do you think?

I already had a patch for this, but for a different reason, i.e. to
avoid the enable/disable dance.

       /* We aren't fully invariant yet */
       if (!prev && !cpumask_equal(amu_fie_cpus, cpu_present_mask))
               return;

And this is quite similar to what you have here.

-- 
viresh
