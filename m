Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 453C52C41EF
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 15:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729812AbgKYOOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 09:14:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:37920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729109AbgKYOOb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 09:14:31 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8527A2063A;
        Wed, 25 Nov 2020 14:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606313670;
        bh=JVyYiftV/84nTz15vyQDnsNcLCooj6P83K0HvyBZYVY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dok2vx4XW6eVq2QqlMuWQdyMf+QGjldtSbAOcxUzr3oyrmJGhrXiO9bYUMDD4XkZr
         KRkg/DTr46xcUAZ8x4bEDtZGPyJgGRBQPjuVznY27248z99esL2Bh/dZckOxwyyxok
         S/toXuP8HjQIFgbC9XVcmUfG7Zvft3cDV0D97YeA=
Date:   Wed, 25 Nov 2020 14:14:24 +0000
From:   Will Deacon <will@kernel.org>
To:     "liwei (GF)" <liwei391@huawei.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Clark <james.clark@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Hanjun Guo <guohanjun@huawei.com>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>
Subject: Re: [PATCH v2] drivers/perf: Add support for ARMv8.3-SPE
Message-ID: <20201125141423.GA16159@willie-the-truck>
References: <20200930093136.30301-1-liwei391@huawei.com>
 <20201002105711.GA20475@willie-the-truck>
 <8341ca72-82cc-5369-01ce-da92b6055310@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8341ca72-82cc-5369-01ce-da92b6055310@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 10:57:47PM +0800, liwei (GF) wrote:
> On 2020/10/2 18:57, Will Deacon wrote:
> > On Wed, Sep 30, 2020 at 05:31:35PM +0800, Wei Li wrote:
> >> @@ -80,6 +80,15 @@ struct arm_spe_pmu {
> >>  /* Keep track of our dynamic hotplug state */
> >>  static enum cpuhp_state arm_spe_pmu_online;
> >>  
> >> +static u64 sys_pmsevfr_el1_mask[] = {
> >> +	[ID_AA64DFR0_PMSVER_8_2] = GENMASK_ULL(63, 48) | GENMASK_ULL(31, 24) |
> >> +		GENMASK_ULL(15, 12) | BIT_ULL(7) | BIT_ULL(5) | BIT_ULL(3) |
> >> +		BIT_ULL(1),
> >> +	[ID_AA64DFR0_PMSVER_8_3] = GENMASK_ULL(63, 48) | GENMASK_ULL(31, 24) |
> >> +		GENMASK_ULL(18, 17) | GENMASK_ULL(15, 11) | BIT_ULL(7) |
> >> +		BIT_ULL(5) | BIT_ULL(3) | BIT_ULL(1),
> >> +};
> > 
> > Ok, so I finally figured out what I don't like about this: it's the fact
> > that the RES0 mask only ever reduces, but we have no way of ensuring that
> > by construction with this approach. In other words, it's a bit brittle to
> > keep all of these things defined entirely separately from one another.
> > 
> > How about a small change so that we define things like:
> > 
> > #define SYS_PMSEVFR_EL1_RES0_8_2	SYS_PMSEVFR_EL1_RES0 &
> > 					~(...)
> > 
> > #define SYS_PMSEVFR_EL1_RES0_8_3	SYS_PMSEVFR_EL1_RES0_8_2 &
> > 					~(...)
> > 
> > where the '...' parts identify the bits that are no longer RES0 for that
> > version of the architecture?
> > 
> 
> Sorry for the long delay.
> 
> These is also an array-index-out-of-bounds issue when accessing 'sys_pmsevfr_el1_mask', if
> the pmsver read in the future is bigger than what the driver supports.
> 
> So how about change to:
> 
> static u64 arm_spe_pmsevfr_mask(u16 pmsver)
> {
> 	u64 mask = 0;
> 
> 	if (pmsver >= ID_AA64DFR0_PMSVER_8_3)
> 		mask |= BIT_ULL(18) | BIT_ULL(17) | BIT_ULL(11);
> 	if (pmsver >= ID_AA64DFR0_PMSVER_8_2)
> 		mask |= GENMASK_ULL(63, 48) | GENMASK_ULL(31, 24) |
> 			GENMASK_ULL(15, 12) | BIT_ULL(7) | BIT_ULL(5) | BIT_ULL(3) |
> 			BIT_ULL(1);
> 	return mask;
> }
> 
> Thus, the driver can try its best to support, and the definition is clear enough to show
> the difference between versions of SPE.
> 
> Or should i still define them as what you advised and add a check of pmsver to just serve
> the versions what the driver support?

I think I'd prefer that, yes.

Will
