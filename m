Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13F352D58AA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 11:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389142AbgLJKzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 05:55:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389133AbgLJKzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 05:55:50 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E12FC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 02:55:10 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id c79so3697486pfc.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 02:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NFauqkgneznjlRMcl8odto0hzzqqVW/+kNMozBax5Is=;
        b=qDzyiTLqUiNe9RkO5/uFPdKfgqSA9+w+ciTO3eW8P4B46Pa3hQoioJWgBZUIfp3cn7
         3ZmpKsY6RPkFqCznsQ8R7Nk1HlFJdoeKZ6C4yja41+zwK79ccAvBz5U8Cwf5jp0/4qty
         ewwTmhtk2kIXOn3h70//2i0c/OEhP88kDLuxhXAMz1AJX+76z2QfYuTq3JdYsBDRAuXx
         brFc48nGbWlEGMwi/Q6aFdubi/j4uTHtqTq5iuNC7yPdjZB1BD2Ma5CvqORrvHtfTxho
         fWy53Xv3ykGxCsdyPIxgBMOeQKRkrCznaU7iRBKsjy2h5GnD4byl7xyVigOYC+m4pIsC
         rNkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NFauqkgneznjlRMcl8odto0hzzqqVW/+kNMozBax5Is=;
        b=A9NKfhfTYs5MFaNNjy6nhyBEWIK3w1l5mTg0EehZmY/uwK1sbNm13DaYXWm+Zzp93T
         C8lx1LaadpvTR9Bx4kEAZlG838d3XSyo04e8lyq/E6o+eJhPHjjrCqaLJXYgG2sd1PHk
         RAFUi0DAuwutVtRTUVFVEC9t9N1wOE1+ZveGgwurpMO0R7chy5YNlP/f0l3CEePofrZH
         0BPGKA2w73A1ItyynPgjyVSMzRgts3+qfz9jZOh4rmHLoyPOEH7e/pt9L/3vCNP6iYbx
         FCBL3TFfb+qackuYqmD0B0WAhszVz7uZ3FjoIPRAcGppXBLGs0z/mwwwrMt5indUK+XA
         9siQ==
X-Gm-Message-State: AOAM532ziDdafRS8shocS5s2MwOwK3Gfv2x/1VCLi5NIMq8ZB1qHp4Sd
        EiV2PXN1JuExZ9VGR0YGb5XY8g==
X-Google-Smtp-Source: ABdhPJyyrMNvp1jEOcYJKBQlh4aSFWH+zDaU8BNy3S8z8l/zop1YfCMrk8mg1HA5hmdl4QsqYXYPXw==
X-Received: by 2002:a62:543:0:b029:19e:5627:1c4d with SMTP id 64-20020a6205430000b029019e56271c4dmr6310717pff.31.1607597709830;
        Thu, 10 Dec 2020 02:55:09 -0800 (PST)
Received: from localhost ([122.172.20.109])
        by smtp.gmail.com with ESMTPSA id a31sm142364pgb.93.2020.12.10.02.55.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Dec 2020 02:55:09 -0800 (PST)
Date:   Thu, 10 Dec 2020 16:25:06 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: topology: Cleanup init_amu_fie() a bit
Message-ID: <20201210105506.gi76peabl2bv5j62@vireshk-i7>
References: <5594c7d6756a47b473ceb6f48cc217458db32ab0.1607584435.git.viresh.kumar@linaro.org>
 <20201210103815.GA3313@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201210103815.GA3313@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My intent was to keep the logical working of the code as is (in all
the patches I have sent today), let me see if I broke that assumption
somewhere unintentionally.

On 10-12-20, 10:38, Ionela Voinescu wrote:
> I'm first of all replying to discuss the need of this policy analysis
> that enable_policy_freq_counters() does which results in the setting of
> have_policy.
> 
> Basically, that's functions purpose is only to make sure that invariance
> at the level of the policy is consistent: either all CPUs in a policy
> support counters and counters will be used for the scale factor, or
> either none or only some support counters and therefore the default
> cpufreq implementation will be used (arch_set_freq_scale()) for all CPUs
> in a policy.
> 
> If we find that cpufreq policies are not present at all, we only enable
> counter use if all CPUs support them.

Right, and the same must be true after this patch.

> This being said, there is a very important part of your patches in this
> set:
> 
> +	/* Disallow partial use of counters for frequency invariance */
> +	if (!cpumask_equal(amu_fie_cpus, cpu_present_mask))
> +		goto free_valid_mask;

The current code already has this check and so this isn't something
new.
 
> If this is agreed upon, there is a lot more that can be removed from the
> initialisation: enable_policy_freq_counters() can entirely go away plus
> all the checks around it.
> 
> I completely agree that all of this will be more clear if we decided to
> "Disallow partial use of counters for frequency invariance", but I think
> we might have to add it back in again when systems with partial support
> for counters show up.
> 
> I don't agree to not support these systems from the get go as it's
> likely that the first big.LITTLE systems will only have partial support
> for AMUs, but it's only an assumption at this point.

Here is how things move AFAICT:

- We set valid_cpus 1-by-1 with all CPUs that have counters available.

- Once all CPUs of a policy are part of valid_cpus, we update
  amu_fie_cpus with that policies related_cpus.

- Once we are done with all CPUs, we check if cpufreq policy was there
  for any of the CPUs, if not, we update amu_fie_cpus if all present
  CPUs are part of valid_cpus.

- At this point we call static_branch_enable() if amu_fie_cpus is not
  empty (i.e. even if it is partially set).

- But right after that we call static_branch_disable() if we aren't
  invariant (call to topology_scale_freq_invariant()), and this will
  happen if amu_fie_cpus doesn't have all the CPUs there. Isn't it? So
  partial amu support is already disallowed, without cpufreq.

Where am I wrong ? (And I know there is a high possibility of that
happening here :) )..

-- 
viresh
