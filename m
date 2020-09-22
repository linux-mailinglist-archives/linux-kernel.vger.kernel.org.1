Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75DEE27462B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 18:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbgIVQHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 12:07:07 -0400
Received: from foss.arm.com ([217.140.110.172]:46488 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726567AbgIVQHH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 12:07:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B210101E;
        Tue, 22 Sep 2020 09:07:06 -0700 (PDT)
Received: from localhost (e108754-lin.cambridge.arm.com [10.1.199.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E04923F718;
        Tue, 22 Sep 2020 09:07:05 -0700 (PDT)
Date:   Tue, 22 Sep 2020 17:07:04 +0100
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     will@kernel.org, sudeep.holla@arm.com, morten.rasmussen@arm.com,
        valentin.schneider@arm.com, souvik.chakravarty@arm.com,
        viresh.kumar@linaro.org, dietmar.eggemann@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] arm64: implement CPPC FFH support using AMUs
Message-ID: <20200922160704.GA796@arm.com>
References: <20200826130309.28027-1-ionela.voinescu@arm.com>
 <20200826130309.28027-5-ionela.voinescu@arm.com>
 <20200911144032.GC12835@gaia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200911144032.GC12835@gaia>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Catalin,

Sorry for the delayed reply. I took advantage of a last chance for a
holiday before the weather gets bad :).

On Friday 11 Sep 2020 at 15:40:32 (+0100), Catalin Marinas wrote:
> On Wed, Aug 26, 2020 at 02:03:09PM +0100, Ionela Voinescu wrote:
> > +/*
> > + * Refer to drivers/acpi/cppc_acpi.c for the description of the functions
> > + * below.
> > + */
> > +bool cpc_ffh_supported(void)
> > +{
> > +	const struct cpumask *cnt_cpu_mask = cpus_with_amu_counters();
> > +	int cpu = nr_cpu_ids;
> > +
> > +	if (cnt_cpu_mask)
> > +		cpu = cpumask_any_and(cnt_cpu_mask, cpu_present_mask);
> > +
> > +	if ((cpu >= nr_cpu_ids) || !freq_counters_valid(cpu))
> > +		return false;
> > +
> > +	return true;
> > +}
> 
> IIUC, the only need for the cpumask is this function, the others would
> have worked just fine with the existing cpu_has_amu_feat(). So you have
> a lot more !cnt_cpu_mask checks now.
> 
> I wonder whether instead you could add a new function near
> cpu_has_amu_feat(), something like get_cpu_with_amu_feat() and do the
> cpumask_any_and() in there.
> 

Yes, it does look ugly. I went for this because I wanted to avoid adding
new functions to the cpu feature code with new AMU usecase additions,
functions that might just end up doing cpumask operations, and nothing
more. This way there is a single function that basically extracts all the
information that the feature code is able to provide on AMU support and
the user of the counters can then manipulate the mask as it sees fit.

Basically I was thinking that with a potential new usecase we might have
to add yet another function and I did not like that prospect.

From performance point of view, the !cnt_cpu_mask checks wouldn't affect
that much: cpc_ffh_supported() is only called during CPPC probe and
freq_counters_valid() is only called at init.
counters_read_on_cpu() will be called more often (cpufreq .get
function) but not as much as to bring significant overhead.

To make this nicer I can do the following:
 - make the !cnt_cpu_mask unlikely due to CONFIG_ARM64_AMU_EXTN being
   enabled by default.
 - wrap all the cpus_with_amu_counters() uses under:

static inline int amu_cpus_any_and(const struct cpumask *cpus)
{
	const struct cpumask *cnt_cpu_mask = cpus_with_amu_counters();
	int cpu = nr_cpu_ids;

	if (likely(cnt_cpu_mask))
		cpu = cpumask_any_and(cnt_cpu_mask, cpus);

	return cpu;
}

This is to be called as:
 - "if (!freq_counters_valid(amu_cpus_any_and(cpu_present_mask)))"
   in cpc_ffh_supported();
 - "if (amu_cpus_any_and(cpumask_of(cpu)) == cpu)"
   in the other two.

It won't eliminate the useless checks but it will make the code a bit
nicer.

If you don't think it's worth it, I'll go with your suggestion.

Thank you for the review,
Ionela.


> -- 
> Catalin
