Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1222D9C54
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 17:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440206AbgLNQPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 11:15:54 -0500
Received: from foss.arm.com ([217.140.110.172]:49578 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439785AbgLNQPi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 11:15:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A862630E;
        Mon, 14 Dec 2020 08:14:52 -0800 (PST)
Received: from localhost (unknown [10.1.198.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4097C3F66B;
        Mon, 14 Dec 2020 08:14:52 -0800 (PST)
Date:   Mon, 14 Dec 2020 16:14:50 +0000
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: topology: Cleanup init_amu_fie() a bit
Message-ID: <20201214161450.GA20030@arm.com>
References: <5594c7d6756a47b473ceb6f48cc217458db32ab0.1607584435.git.viresh.kumar@linaro.org>
 <20201210103815.GA3313@arm.com>
 <20201211110555.ht3stotrpbkkdxju@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201211110555.ht3stotrpbkkdxju@vireshk-i7>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Sorry, I missed this.

On Friday 11 Dec 2020 at 16:35:55 (+0530), Viresh Kumar wrote:
> On 10-12-20, 10:38, Ionela Voinescu wrote:
> > Basically, that's functions purpose is only to make sure that invariance
> > at the level of the policy is consistent: either all CPUs in a policy
> > support counters and counters will be used for the scale factor, or
> > either none or only some support counters and therefore the default
> > cpufreq implementation will be used (arch_set_freq_scale()) for all CPUs
> > in a policy.
> 
> Why is it important to have this thing at policy level ? If we are
> okay with only one policy having AMUs and not the other one, then what
> about only some CPUs of both the policies having it. Does it break
> anything ?
> 

First of all, in order for a single CPU in a policy to use AMUs for FIE,
when the others do not support AMUs, we'd have to modify
arch_set_freq_scale() which otherwise would uniformly set its own
computed scale factor for all related CPUs.

Beyond this, it's very likely that CPUs in the same policy have the same
uarch and therefore either all or none in the policy would support AMUs.
The check here is just to make sure of that and then ensure that
arch_set_freq_scale() and arch_scale_freq_tick() do not clash with each
other.

Beyond this, it's difficult to say how important it is to have the same
scale for all CPUs in a policy. AMUs would give you a scale based on an
average frequency between ticks, and more importantly it would be based
on the actual core frequency, not on what software requested. Cpufreq
would give you the scale obtained using the frequency that the OS
requested. Therefore, the two scale values could end up being quite
different, and therefore can result in quite different utilization
values for CPUs doing the same work.

An alternative would be to apply the AMU computed scale to all CPUs
although not all CPUs in a policy might support AMUs. But given that
this scenario is unlikely, the added hassle in arch_scale_freq_tick()
which would involve getting information on related CPUs from policies
was not worth it, in my opionion.

Thanks,
Ionela.

> -- 
> viresh
