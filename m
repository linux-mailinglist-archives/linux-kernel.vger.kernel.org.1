Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85FCE2A7FAB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 14:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730714AbgKEN1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 08:27:10 -0500
Received: from foss.arm.com ([217.140.110.172]:60854 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725468AbgKEN1K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 08:27:10 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A6D06142F;
        Thu,  5 Nov 2020 05:27:09 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.58.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D7EFC3F719;
        Thu,  5 Nov 2020 05:27:07 -0800 (PST)
Date:   Thu, 5 Nov 2020 13:27:05 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     catalin.marinas@arm.com, sudeep.holla@arm.com, will@kernel.org,
        souvik.chakravarty@arm.com, viresh.kumar@linaro.org,
        valentin.schneider@arm.com, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] arm64: wrap and generalise counter read functions
Message-ID: <20201105132705.GF82102@C02TD0UTHF1T.local>
References: <20201105122702.13916-1-ionela.voinescu@arm.com>
 <20201105122702.13916-2-ionela.voinescu@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105122702.13916-2-ionela.voinescu@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ionela,

On Thu, Nov 05, 2020 at 12:27:00PM +0000, Ionela Voinescu wrote:
> -#ifdef CONFIG_ARM64_AMU_EXTN
> +#define COUNTER_READ_STORE(NAME, VAL) \
> +static inline u64 read_##NAME(void) \
> +{ \
> +	return VAL; \
> +} \
> +static inline void store_##NAME(void *val) \
> +{ \
> +	*(u64 *)val = read_##NAME(); \
> +}
>  
> -#undef pr_fmt
> -#define pr_fmt(fmt) "AMU: " fmt
> +#ifdef CONFIG_ARM64_AMU_EXTN
> +COUNTER_READ_STORE(corecnt, read_sysreg_s(SYS_AMEVCNTR0_CORE_EL0));
> +COUNTER_READ_STORE(constcnt, read_sysreg_s(SYS_AMEVCNTR0_CONST_EL0));
> +#else
> +COUNTER_READ_STORE(corecnt, 0);
> +COUNTER_READ_STORE(constcnt, 0);
> +#endif

I think this level of indirection is confusing (e.g. since you can't
grep for `read_constcnt` to find the implementation). I also don't think
we need to store_* functions here -- they're only needed by patch 3, and
they can be wrapped in helper functions there (which should also solve
the warning you mention in the cover letter).

I think if we need these wrappers, it'd be better to have:

#ifdef CONFIG_ARM64_AMU_EXTN
#define read_corecnt()	read_sysreg_s(SYS_AMEVCNTR0_CORE_EL0)
#define read_constcnt()	read_sysreg_s(SYS_AMEVCNTR0_CONST_EL0)
#else
#define read_corecnt()	(0UL)
#define read_constcnt()	(0UL)
#endif

Thanks,
Mark.
