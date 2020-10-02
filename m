Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9372810D0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 12:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733166AbgJBK5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 06:57:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:44744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725964AbgJBK5T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 06:57:19 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC47E20719;
        Fri,  2 Oct 2020 10:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601636238;
        bh=JVlU++9I4Eh+24MsneTU60GUpd1hguIowleYY8CRmD8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RbQUjIKjWJODypWfcbcq6JRhJQuNy78gFmtqHId53ikILo8CeY5dxzxc2XhJlgxiN
         Ylm3VWhwcFJZ72xujvAi++jVclt8MWi87q4Nc7Xw+/BOc3wuLkC5QHhIhe+9dmXeVj
         Y86XpAmcshY3guTDf22/dF56WhoJNLxsjF1mXnIQ=
Date:   Fri, 2 Oct 2020 11:57:12 +0100
From:   Will Deacon <will@kernel.org>
To:     Wei Li <liwei391@huawei.com>
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
Message-ID: <20201002105711.GA20475@willie-the-truck>
References: <20200930093136.30301-1-liwei391@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930093136.30301-1-liwei391@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 05:31:35PM +0800, Wei Li wrote:
> Armv8.3 extends the SPE by adding:
> - Alignment field in the Events packet, and filtering on this event
>   using PMSEVFR_EL1.
> - Support for the Scalable Vector Extension (SVE).
> 
> The main additions for SVE are:
> - Recording the vector length for SVE operations in the Operation Type
>   packet. It is not possible to filter on vector length.
> - Incomplete predicate and empty predicate fields in the Events packet,
>   and filtering on these events using PMSEVFR_EL1.
> 
> Update the check of pmsevfr for empty/partial predicated SVE and
> alignment event in SPE driver. For adaption by the version of SPE,
> expose 'pmsver' as cap attribute to userspace.
> 
> Signed-off-by: Wei Li <liwei391@huawei.com>
> ---
> v1 -> v2:
>  - Rename 'pmuver' to 'pmsver', change it's type to 'u16' from 'int'.
>    (Suggested by Will and Leo.)
>  - Expose 'pmsver' as cap attribute through sysfs, instead of printing.
>    (Suggested by Will.)
> ---
>  arch/arm64/include/asm/sysreg.h |  4 +++-
>  drivers/perf/arm_spe_pmu.c      | 18 ++++++++++++++++--
>  2 files changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index 554a7e8ecb07..f4f9c1fc6398 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -281,7 +281,6 @@
>  #define SYS_PMSFCR_EL1_ST_SHIFT		18
>  
>  #define SYS_PMSEVFR_EL1			sys_reg(3, 0, 9, 9, 5)
> -#define SYS_PMSEVFR_EL1_RES0		0x0000ffff00ff0f55UL
>  
>  #define SYS_PMSLATFR_EL1		sys_reg(3, 0, 9, 9, 6)
>  #define SYS_PMSLATFR_EL1_MINLAT_SHIFT	0
> @@ -787,6 +786,9 @@
>  #define ID_AA64DFR0_PMUVER_8_5		0x6
>  #define ID_AA64DFR0_PMUVER_IMP_DEF	0xf
>  
> +#define ID_AA64DFR0_PMSVER_8_2		0x1
> +#define ID_AA64DFR0_PMSVER_8_3		0x2
> +
>  #define ID_DFR0_PERFMON_SHIFT		24
>  
>  #define ID_DFR0_PERFMON_8_1		0x4
> diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
> index cc00915ad6d1..52e7869f5621 100644
> --- a/drivers/perf/arm_spe_pmu.c
> +++ b/drivers/perf/arm_spe_pmu.c
> @@ -54,7 +54,7 @@ struct arm_spe_pmu {
>  	struct hlist_node			hotplug_node;
>  
>  	int					irq; /* PPI */
> -
> +	u16					pmsver;
>  	u16					min_period;
>  	u16					counter_sz;
>  
> @@ -80,6 +80,15 @@ struct arm_spe_pmu {
>  /* Keep track of our dynamic hotplug state */
>  static enum cpuhp_state arm_spe_pmu_online;
>  
> +static u64 sys_pmsevfr_el1_mask[] = {
> +	[ID_AA64DFR0_PMSVER_8_2] = GENMASK_ULL(63, 48) | GENMASK_ULL(31, 24) |
> +		GENMASK_ULL(15, 12) | BIT_ULL(7) | BIT_ULL(5) | BIT_ULL(3) |
> +		BIT_ULL(1),
> +	[ID_AA64DFR0_PMSVER_8_3] = GENMASK_ULL(63, 48) | GENMASK_ULL(31, 24) |
> +		GENMASK_ULL(18, 17) | GENMASK_ULL(15, 11) | BIT_ULL(7) |
> +		BIT_ULL(5) | BIT_ULL(3) | BIT_ULL(1),
> +};

Ok, so I finally figured out what I don't like about this: it's the fact
that the RES0 mask only ever reduces, but we have no way of ensuring that
by construction with this approach. In other words, it's a bit brittle to
keep all of these things defined entirely separately from one another.

How about a small change so that we define things like:

#define SYS_PMSEVFR_EL1_RES0_8_2	SYS_PMSEVFR_EL1_RES0 &
					~(...)

#define SYS_PMSEVFR_EL1_RES0_8_3	SYS_PMSEVFR_EL1_RES0_8_2 &
					~(...)

where the '...' parts identify the bits that are no longer RES0 for that
version of the architecture?

What do you think?

Will
