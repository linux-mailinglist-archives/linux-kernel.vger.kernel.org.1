Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A13502D5A9E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 13:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729324AbgLJMfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 07:35:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728925AbgLJMfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 07:35:25 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B15C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 04:34:45 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id t18so2712491plo.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 04:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gFTB9WhLXgyszBQsKX4VClpStIl4eclzeNfN1mO++cg=;
        b=BvwoJWGgWhIppmW6/QG7wUsPFGPCrz3Gze/SGd3ZX0BJrfLqG3sxM7hXNOgR//sDbz
         PC4LHGhppLtCKiXb0m8Q85iVfK7kRnw/gxx3QsB744vXj/as5fIwt93w4Ih9SfEEoPf7
         WC5xHPns+G2g6TklHcwJID8oXdLjRH3N/ddTguNkgTMXRmq+ctuPAfR18GSz4hKhZV59
         RTXN9RyF5+w5YOV7vQY4AYzkWGUVFbzEF8YGp/HuvzyCZl9VC66gfUWFN02ij3JgsKW5
         xEZMhbDKiiifRhDLQRpo28WClxVDdfkzedPvaobqrbNeUKOEsvbQgaV9GKEzdE9YcIzB
         NdNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gFTB9WhLXgyszBQsKX4VClpStIl4eclzeNfN1mO++cg=;
        b=LzThFs6hjuuWuJndyhuB1Nm15a9cafUeCIM2WGMXV6NK63uANF5ISImiFxfbUZxxfK
         DE5dw9j7dK3afBVxZ/OUdFkbR+2h/CheS3ewv8QID4zH4mqRZ6l7C5jci31baFtoJvNd
         irdDATIsq05yVgQwwlJEL6YTD37Gv8oE15EeyRst7IDjLUACbo9qcU0rIMPdn5ukojMR
         sPRCT05uRtHBdMZADUpLut8cg/3Ov8PY2LG9usNhHhNafvzxZjao4+ixXtXN30glIpIM
         GQaaUVAF4iivbLXgzsBc02E3KahFuTrkvR6DmIVX1rRLMkUXhOCaztk+P7lcHqywWc1e
         0gew==
X-Gm-Message-State: AOAM533+LpSGC47RLJoKXD5ObTlEpmxO6hL+sCCaR5Bps7PeP3t5YnTX
        gOEztthY9T9HpOaPSZy417zJSvHoaGhprQ==
X-Google-Smtp-Source: ABdhPJwsxCGeX6fM9UNlo+6e3ATPlw+yVPxF9jQjxg5Dr+BrMxV2S33z+yvxGzjnGLnIuPZJVdqJRw==
X-Received: by 2002:a17:902:b707:b029:da:a304:1952 with SMTP id d7-20020a170902b707b02900daa3041952mr5187544pls.6.1607603684416;
        Thu, 10 Dec 2020 04:34:44 -0800 (PST)
Received: from localhost ([122.172.20.109])
        by smtp.gmail.com with ESMTPSA id y24sm6040207pfe.42.2020.12.10.04.34.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Dec 2020 04:34:42 -0800 (PST)
Date:   Thu, 10 Dec 2020 18:04:39 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: topology: Cleanup init_amu_fie() a bit
Message-ID: <20201210123439.zugex2zzbmy6z3le@vireshk-i7>
References: <5594c7d6756a47b473ceb6f48cc217458db32ab0.1607584435.git.viresh.kumar@linaro.org>
 <20201210103815.GA3313@arm.com>
 <20201210105506.gi76peabl2bv5j62@vireshk-i7>
 <20201210112912.GB5300@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201210112912.GB5300@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-12-20, 11:29, Ionela Voinescu wrote:
> On Thursday 10 Dec 2020 at 16:25:06 (+0530), Viresh Kumar wrote:
> > - But right after that we call static_branch_disable() if we aren't
> >   invariant (call to topology_scale_freq_invariant()), and this will
> >   happen if amu_fie_cpus doesn't have all the CPUs there. Isn't it? So
> >   partial amu support is already disallowed, without cpufreq.
> > 
> 
> This is the point that needs clarification:
> 
> topology_scale_freq_invariant()) = cpufreq_supports_freq_invariance() ||
>                                    arch_freq_counters_available(cpu_online_mask);
> 
> This checks if the full system is invariant.
> 
> The possible scenarios are:
> 
>  - All online CPUs support AMUs - arch_freq_counters_available() will
>    return true -> topology_scale_freq_invariant() will return true.
> 
>  - None of the CPUs support AMUs, or part of the CPUs support AMUs - the
>    system is invariant only if cpufreq is invariant (dependent on
>    whether the driver implements the proper callbacks that results in
>    calling arch_set_freq_scale() in cpufreq core.
> 
>  - Either cpufreq does not support invariance or we don't have AMU
>    support on all CPUs -> the system is not invariant so we disable
>    the AMU static key that guards the calls to
>    topology_scale_freq_tick() - we would not want to set a scale factor
>    for only a part of the CPUs.
> 
> So whether were are or are not invariant does not depend only on the AMU
> presence, but also on the cpufreq support for invariance. We have to
> disable invariance altogether (including the AMU guarding static key)
> if the system is not invariant (it no all CPUs have means to provide the
> scale).

Okay, I think I mis-assumed that amu_fie_cpus will get set by
enable_policy_freq_counters() even for CPUs where AMU support isn't
there, it won't be though.

Having said that, this patch, along with the minor suggestion in the
commit log, still stands fine, right ? The other patch which I sent is
probably incorrect due to the above assumption I had.

-- 
viresh
