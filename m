Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8935A2D585A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 11:40:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733120AbgLJKjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 05:39:03 -0500
Received: from foss.arm.com ([217.140.110.172]:34196 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726768AbgLJKjC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 05:39:02 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E11AC30E;
        Thu, 10 Dec 2020 02:38:16 -0800 (PST)
Received: from localhost (unknown [10.1.198.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 833903F718;
        Thu, 10 Dec 2020 02:38:16 -0800 (PST)
Date:   Thu, 10 Dec 2020 10:38:15 +0000
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: topology: Cleanup init_amu_fie() a bit
Message-ID: <20201210103815.GA3313@arm.com>
References: <5594c7d6756a47b473ceb6f48cc217458db32ab0.1607584435.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5594c7d6756a47b473ceb6f48cc217458db32ab0.1607584435.git.viresh.kumar@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thursday 10 Dec 2020 at 12:48:20 (+0530), Viresh Kumar wrote:
> Every time I have stumbled upon this routine, I get confused with the
> way 'have_policy' is used and I have to dig in to understand why is it
> so.
> 

I'm first of all replying to discuss the need of this policy analysis
that enable_policy_freq_counters() does which results in the setting of
have_policy.

Basically, that's functions purpose is only to make sure that invariance
at the level of the policy is consistent: either all CPUs in a policy
support counters and counters will be used for the scale factor, or
either none or only some support counters and therefore the default
cpufreq implementation will be used (arch_set_freq_scale()) for all CPUs
in a policy.

If we find that cpufreq policies are not present at all, we only enable
counter use if all CPUs support them.

This being said, there is a very important part of your patches in this
set:

+	/* Disallow partial use of counters for frequency invariance */
+	if (!cpumask_equal(amu_fie_cpus, cpu_present_mask))
+		goto free_valid_mask;


If this is agreed upon, there is a lot more that can be removed from the
initialisation: enable_policy_freq_counters() can entirely go away plus
all the checks around it.

I completely agree that all of this will be more clear if we decided to
"Disallow partial use of counters for frequency invariance", but I think
we might have to add it back in again when systems with partial support
for counters show up.

I don't agree to not support these systems from the get go as it's
likely that the first big.LITTLE systems will only have partial support
for AMUs, but it's only an assumption at this point.

I'm happy to hear the opinion of other arm64 folk about this.

Many thanks for looking over the code,
Ionela.
