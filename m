Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1662D584F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 11:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733193AbgLJKfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 05:35:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728530AbgLJKfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 05:35:30 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B91AC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 02:34:50 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id b26so3654741pfi.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 02:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uEAmFBtn9DIc2GsXdmT9No5SksB1bwRgTA586ihwWeM=;
        b=VOCUdiOqBJg99jyVaghfCInTcZYP2WDknFCn4RcJDamMNe7qszv23YrYGwnxR/wFaf
         bh3G0SRpCYa4U1cYlll05ojaBqeZqlymIwDZEELTrqALsKtedwImg7AEp5MDJXpkNg0N
         PhYVQo/s9tGQqBYaPVqOqFjIdMNtYJfcszvgCZvohJKFijbGPo8w83cYkIuqR4qqXU6/
         FkBXgk/ADwztS3lLXh4fMoxwroz8f9DBD7SsLksmSYaMDbbPGd7iBnHcJ4vDKwp3fSuf
         QoNH+LZqDFu5qBciynZPobqhORuUDM7yJF+MCTgcZ4tgtYiqKnggdaZwrw2e5NesN9kk
         Euow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uEAmFBtn9DIc2GsXdmT9No5SksB1bwRgTA586ihwWeM=;
        b=iMbHiJAQo8YvBkFDNH12Q73TZpt5DzI3965kJ44/DkaHes5UjzZJ4ZUOoo2wpLx/q5
         qidIzodO7QLHj7hSdf9Pap1tnOpNU3t0xXTVlwccvpoXSzXa/EB2w5Qhn41Ki/gawhj3
         1MyERVvXY2NtIZRAjcLAIliY83r0wGza2/Ei8c3u13t9dF06nFX018/dfBF/wqO85cog
         UdXprikxLXpRihT5Fiu7qq5/AI7D79/rdsfVzZv/um8jf3pU75qToRrnTw36WfKV0Azg
         l96Z3wDuWZ62cfjA4Q/yTWBILed/f0NDx3zAlbo23zfn98jsqi7+lgOIstDJrZu7VTim
         jb5Q==
X-Gm-Message-State: AOAM532zXZ7SGub7mEL04xtNZ6i3V+HoprRCOSjHjmXKrbXU73hu1emB
        kzcMDHYzNVDk2c4lZWaBnB5Vlw==
X-Google-Smtp-Source: ABdhPJzCkWRZQv35zi6S2H9a4Mw80RmDsor3+ExZfwClcdV2Kt6OALScAeROmqHhB2NZCnzKmZjCOA==
X-Received: by 2002:a65:688a:: with SMTP id e10mr6073916pgt.347.1607596490022;
        Thu, 10 Dec 2020 02:34:50 -0800 (PST)
Received: from localhost ([122.172.20.109])
        by smtp.gmail.com with ESMTPSA id x23sm5841204pfo.209.2020.12.10.02.34.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Dec 2020 02:34:48 -0800 (PST)
Date:   Thu, 10 Dec 2020 16:04:46 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ionela Voinescu <ionela.voinescu@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: topology: Cleanup init_amu_fie() a bit
Message-ID: <20201210103446.r5tlgoptc7n4r33z@vireshk-i7>
References: <5594c7d6756a47b473ceb6f48cc217458db32ab0.1607584435.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5594c7d6756a47b473ceb6f48cc217458db32ab0.1607584435.git.viresh.kumar@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-12-20, 12:48, Viresh Kumar wrote:
> Every time I have stumbled upon this routine, I get confused with the
> way 'have_policy' is used and I have to dig in to understand why is it
> so.
> 
> Here is an attempt to make it easier to understand, and hopefully it is
> an improvement. This is based on the logic that amu_fie_cpus will be
> empty if cpufreq policy wasn't available for any CPU.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> 
> Ionela, I think it would be even better to do this over this patch
> 
> -       /*
> -        * If none of the CPUs have cpufreq support, we only enable
> -        * the use of the AMU feature for FIE if all CPUs support AMU.
> -        * Otherwise, enable_policy_freq_counters has already enabled
> -        * policy cpus.
> -        */
> -       if (cpumask_empty(amu_fie_cpus) &&
> -           cpumask_equal(valid_cpus, cpu_present_mask))
> +       /* Overwrite amu_fie_cpus if all CPUs support AMU */
> +       if (cpumask_equal(valid_cpus, cpu_present_mask))
>                 cpumask_copy(amu_fie_cpus, cpu_present_mask);
> 
> This will also take care of the case where the cpufreq policy isn't
> there for a small group of CPUs, which do have AMUs enabled for them.
> (This doesn't normally happen though).

And on similar lines, this change as well as amu_fie_cpus must be set
to all the CPUs and this check (and parameter to the routine) aren't
required..

 bool arch_freq_counters_available(const struct cpumask *cpus)
 {
-       return amu_freq_invariant() &&
-              cpumask_subset(cpus, amu_fie_cpus);
+       return amu_freq_invariant();
 }

-- 
viresh
