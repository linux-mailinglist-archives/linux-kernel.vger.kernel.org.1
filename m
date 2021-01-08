Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9300F2EF0CC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 11:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727571AbhAHKmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 05:42:52 -0500
Received: from foss.arm.com ([217.140.110.172]:48854 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726752AbhAHKmw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 05:42:52 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 625DFD6E;
        Fri,  8 Jan 2021 02:42:06 -0800 (PST)
Received: from localhost (unknown [10.1.198.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 02CAD3F70D;
        Fri,  8 Jan 2021 02:42:05 -0800 (PST)
Date:   Fri, 8 Jan 2021 10:42:04 +0000
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 3/3] arm64: topology: Make AMUs work with modular
 cpufreq drivers
Message-ID: <20210108104204.GA27168@arm.com>
References: <5ffc7b9ed03c6301ac2f710f609282959491b526.1608010334.git.viresh.kumar@linaro.org>
 <8f0fe23d1c9effed71d5660c939472d43726a61b.1608010334.git.viresh.kumar@linaro.org>
 <20201216000349.GA5299@arm.com>
 <20201216043805.bx6laemhfm2eaufv@vireshk-i7>
 <20201216193724.GA375@arm.com>
 <20201217105049.z3aqhl4mo56hhqvk@vireshk-i7>
 <20210108094416.GA19952@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210108094416.GA19952@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 08 Jan 2021 at 09:44:16 (+0000), Ionela Voinescu wrote:
> On Thursday 17 Dec 2020 at 16:20:49 (+0530), Viresh Kumar wrote:
> > On 16-12-20, 19:37, Ionela Voinescu wrote:
> > > I did not yet test this, but reading this comment made me wonder..
> > > 
> > > arch_scale_freq_invariant() (or topology_scale_freq_invariant()) is also
> > > called from schedutil when obtaining the next frequency.
> > > 
> > > So if we had a system that only partly supports AMUs but had at some
> > > point a cpufreq driver that provided FIE for the other CPUs, when we
> > > unregister the driver, the cpufreq_freq_invariance static key is
> > > disabled. Therefore, none of the conditions for system invariance is
> > > now accomplished and arch_scale_freq_invariant() will return false.
> > > This will be broken as utilization is still scaled, but the algorithm
> > > for computing the next frequency in schedutil will not take this into
> > > account.
> > 
> > I think the best and the easiest solution for this is:
> > 
> > bool arch_freq_counters_available(const struct cpumask *cpus)
> > {
> >         return amu_freq_invariant();
> > }
> > 
> > But we probably need to rename it to something like arch_is_fie().
> > 

Forgot to answer this one:

arch_freq_counters_available() is also used in arch_set_freq_scale() to
tell us not only if the arch is FI, but also to tell us if the AMUs are
used for FI for some particular CPUs. So we couldn't easily rewrite this
one, or do it in a way that would be worth it.

Ionela.

> 
> Now that I think of it again (after spending 30 minutes trying to come
> up with a more clear solution) I realised this is not actually a
> problem :).
> 
> The only location that checks the invariance status is schedutil, but
> what a cpufreq governor does becomes irrelevant if you remove the
> cpufreq driver. The only potential problem is if one then inmods a
> cpufreq driver that's not invariant. But I think that might be on "if"
> too many to consider. What do you think?
> 
> Thanks,
> Ionela.
