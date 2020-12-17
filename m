Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC682DCFC6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 11:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727896AbgLQKve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 05:51:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgLQKvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 05:51:33 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F55C061794
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 02:50:53 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id d2so18791565pfq.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 02:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qhek/ZoXr5kvoklgOpzW0vQKDjV39nf+N7ITPqoLerA=;
        b=WS89X/8FFmpCi5bwBCSX9QFDkSmgpIqTzO34KCS1AP8+WG0FM5JJ7oxFvd82olqQXu
         4X58anbQaijN2t+X+RLeynAQrUsiS0MEiotfzfp14Iz7OenR6phxoI4y6hqNhEVB+Cqh
         tpRyYckBMp4lWdpFJRMdIsaWH18i/z+w0J5NLAMQ+7gm1xe9VGQPNIEG57gLWcy2x6mz
         nbt4qHfp9Nf34kqrgbWPK1xIxaq959Q3iIhBAXgprhnR7VjOLm6afUq8PyOgTeMQLHr0
         25a44xe8bR6SS2RRUOXHx5aiUyyo2kZBTiOn5xlrhz2C3FtjMw0RhmaW722yAd+CEyoy
         ZwOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qhek/ZoXr5kvoklgOpzW0vQKDjV39nf+N7ITPqoLerA=;
        b=lKuWPJ1vpLAeVee4NEwe5NcQ/jnH+MhSvpW/RfSdQxzDpffRyZzPK2k/RToWAzWXl4
         eDTRtWUas+9qqbOpezlCKyM5ngKR22G801bPON7ap/dByPFJyGsfWJs1AOF+FUjJK4O9
         y3BoUzw+fj2xRk1s6LlvqjI0ZRz/RQXDVOD/sxKZuQoWPqlEkkjEc1mCCaHYQzm8iq4m
         cS3kW0FgQEO+n8EblZ2PV2eByfuB97G2/qdcpxUct2Ek6AGi0VtCqwQ2ScpPUJcmym6m
         JpBgDh5b9RJESLzxPI2KqPBIM1ioAqTQiZt3F4ADS86k7HY/T4/wCyzz7eg4R5lCz0zl
         Jm2w==
X-Gm-Message-State: AOAM532qjC9FBZyj3lo1Ab+nW0RKac9AtSZtHeBPpUgSXK+Frjf2GISQ
        RCQKG6x9L08TAFq0S0icN0zrhA==
X-Google-Smtp-Source: ABdhPJzvvlJ7sLr17pfkVjIYEg4FrUdZcBcrQruW8+GjQ2aJwlJLm8UPgkV/9DySu+mUNt+K3a0UJA==
X-Received: by 2002:a62:8895:0:b029:19e:92ec:6886 with SMTP id l143-20020a6288950000b029019e92ec6886mr25683245pfd.12.1608202253313;
        Thu, 17 Dec 2020 02:50:53 -0800 (PST)
Received: from localhost ([122.172.20.109])
        by smtp.gmail.com with ESMTPSA id e6sm4666385pjr.34.2020.12.17.02.50.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Dec 2020 02:50:51 -0800 (PST)
Date:   Thu, 17 Dec 2020 16:20:49 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 3/3] arm64: topology: Make AMUs work with modular
 cpufreq drivers
Message-ID: <20201217105049.z3aqhl4mo56hhqvk@vireshk-i7>
References: <5ffc7b9ed03c6301ac2f710f609282959491b526.1608010334.git.viresh.kumar@linaro.org>
 <8f0fe23d1c9effed71d5660c939472d43726a61b.1608010334.git.viresh.kumar@linaro.org>
 <20201216000349.GA5299@arm.com>
 <20201216043805.bx6laemhfm2eaufv@vireshk-i7>
 <20201216193724.GA375@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201216193724.GA375@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-12-20, 19:37, Ionela Voinescu wrote:
> I did not yet test this, but reading this comment made me wonder..
> 
> arch_scale_freq_invariant() (or topology_scale_freq_invariant()) is also
> called from schedutil when obtaining the next frequency.
> 
> So if we had a system that only partly supports AMUs but had at some
> point a cpufreq driver that provided FIE for the other CPUs, when we
> unregister the driver, the cpufreq_freq_invariance static key is
> disabled. Therefore, none of the conditions for system invariance is
> now accomplished and arch_scale_freq_invariant() will return false.
> This will be broken as utilization is still scaled, but the algorithm
> for computing the next frequency in schedutil will not take this into
> account.

I think the best and the easiest solution for this is:

bool arch_freq_counters_available(const struct cpumask *cpus)
{
        return amu_freq_invariant();
}

But we probably need to rename it to something like arch_is_fie().

> 
> [..]
> > > > +	ret = cpufreq_register_notifier(&init_amu_fie_notifier,
> > > > +					CPUFREQ_POLICY_NOTIFIER);
> 
> The above makes the use of AMUs for FIE tightly coupled with cpufreq.
> 
> Initially I made cpufreq_get_hw_max_freq(cpu) a weak function for the
> possible platforms that might not use a cpufreq driver and might want to
> provide this function to still benefit from the use of counters for
> frequency invariance.
> 
> But I'm starting to believe that supporting all these corner-cases in
> advance just introduces messiness.
> 
> So feel free to remove the 'weak' state of cpufreq_get_hw_max_freq() as
> well, so we don't keep wondering why we had that in the first place.
> It would not make any sense keeping that in light of these changes.

Will do it in a separate patch then.

> P.S. I will be on holiday starting tomorrow until beginning of January.
> Were you intending this for 5.11, or can I take more time to review
> future versions and continue testing?

I wanted to  :)

-- 
viresh
