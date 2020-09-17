Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ABEB26D70F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 10:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgIQIsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 04:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbgIQIrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 04:47:55 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C58C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 01:47:53 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id a9so921333pjg.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 01:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/1ckaom+tOiOkfRaUKY9dy38B+NKTmZ0l4j1sPCG6qU=;
        b=qvbtvrdG56+ubXnUFkVXLFmyEiJyhlJo2b6qUGmNhRmmswJvqRrNU6P+HOhYnDmstO
         OzrnDrE+FytpU6tLhxPx0MDZgge+duKIdon/7q/YTciVZ2y0djLn6hcrFs6HVK7v+B8j
         qPR7ZpYZM31ad+Ny7kU6uzofuNKfGMNwwo4zIQhFOZezvKxRXcYQuLrY7TqTGZMPxVwU
         gSGaet4NsHAjZfYLu1A7v7hj5krUXgOY2nYnfjGFuhXomUol9Ncp3sggWpUuD1GVumWM
         X69FF0SE1zR8fPvtz9tcNVLlwbHOo3Xhe7ja0jKbc9ne6DrpYl78oto4zJBT+PmsP8n+
         IB5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/1ckaom+tOiOkfRaUKY9dy38B+NKTmZ0l4j1sPCG6qU=;
        b=rRTjvOItORSZ2Ij0Lg5CViVe6FWX37+0kuSG6nnA5RgIs0w41SX0lNFPsuIBz4SH6h
         zVXLpTWp/78Z87gvBmsCz6F2WHKF5bpGQ57s3cBarahJ/KBg84TFNMZgtXHfZHcjek8a
         Ad9KVu8yHi/fVmXSJGP8gv0lhNphfdfFN8ELClZFD1Y8lDAkv6UrJbKNCToWgyhmzjnd
         Td8HmH2TsQHJw1aPpxSm83KxmSMtJPUYbmE6sdVCpIQpkMndzvmlPPQs8sLttRhn0YG1
         kmxlBHSFhCiF82gcibjgW+doFvwk2SClPv/Lp6avz9/RO2fFEz6PSdxsgXpyUdI8AGzN
         +ybQ==
X-Gm-Message-State: AOAM532f32wwP1cpOSZQS8N3eOADvhpF/57Zqv04e4k0OkALA6dmkgDU
        JY+2rKvYJdHNsSARIv7WTiTGBw==
X-Google-Smtp-Source: ABdhPJzRpwscMBwFBdHrHdHZVZRz4gyK1LgFcAjcSvO59Kig5amn6v3aetk05cBnIO9er8cesHdhwQ==
X-Received: by 2002:a17:90a:1188:: with SMTP id e8mr7701566pja.185.1600332473241;
        Thu, 17 Sep 2020 01:47:53 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id e13sm4990113pjy.38.2020.09.17.01.47.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Sep 2020 01:47:52 -0700 (PDT)
Date:   Thu, 17 Sep 2020 16:47:44 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Suleiman Souhlal <suleiman@google.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCHv3] perf kvm: add kvm-stat for arm64
Message-ID: <20200917084744.GB12548@leoy-ThinkPad-X240s>
References: <20200917003645.689665-1-sergey.senozhatsky@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917003645.689665-1-sergey.senozhatsky@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 09:36:45AM +0900, Sergey Senozhatsky wrote:
> Add support for perf kvm stat on arm64 platform.
> 
> Example:
>  # perf kvm stat report
> 
> Analyze events for all VMs, all VCPUs:
> 
>     VM-EXIT    Samples  Samples%     Time%    Min Time    Max Time         Avg time
> 
>    DABT_LOW     661867    98.91%    40.45%      2.19us   3364.65us      6.24us ( +-   0.34% )
>         IRQ       4598     0.69%    57.44%      2.89us   3397.59us   1276.27us ( +-   1.61% )
>         WFx       1475     0.22%     1.71%      2.22us   3388.63us    118.31us ( +-   8.69% )
>    IABT_LOW       1018     0.15%     0.38%      2.22us   2742.07us     38.29us ( +-  12.55% )
>       SYS64        180     0.03%     0.01%      2.07us    112.91us      6.57us ( +-  14.95% )
>       HVC64         17     0.00%     0.01%      2.19us    322.35us     42.95us ( +-  58.98% )
> 
> Total Samples:669155, Total events handled time:10216387.86us.
> 
> Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> ---
> v3: report ARM_EXCEPTION_IL exceptions (Leo)
> v2: reworked the patch after offline discussion with Suleiman
> 
>  tools/perf/arch/arm64/Makefile                |  1 +
>  tools/perf/arch/arm64/util/Build              |  1 +
>  .../arch/arm64/util/arm64_exception_types.h   | 92 +++++++++++++++++++
>  tools/perf/arch/arm64/util/kvm-stat.c         | 86 +++++++++++++++++
>  4 files changed, 180 insertions(+)
>  create mode 100644 tools/perf/arch/arm64/util/arm64_exception_types.h
>  create mode 100644 tools/perf/arch/arm64/util/kvm-stat.c
> 
> diff --git a/tools/perf/arch/arm64/Makefile b/tools/perf/arch/arm64/Makefile
> index dbef716a1913..fab3095fb5d0 100644
> --- a/tools/perf/arch/arm64/Makefile
> +++ b/tools/perf/arch/arm64/Makefile
> @@ -4,6 +4,7 @@ PERF_HAVE_DWARF_REGS := 1
>  endif
>  PERF_HAVE_JITDUMP := 1
>  PERF_HAVE_ARCH_REGS_QUERY_REGISTER_OFFSET := 1
> +HAVE_KVM_STAT_SUPPORT := 1
>  
>  #
>  # Syscall table generation for perf
> diff --git a/tools/perf/arch/arm64/util/Build b/tools/perf/arch/arm64/util/Build
> index 5c13438c7bd4..4cba12f4b741 100644
> --- a/tools/perf/arch/arm64/util/Build
> +++ b/tools/perf/arch/arm64/util/Build
> @@ -1,6 +1,7 @@
>  perf-y += header.o
>  perf-y += machine.o
>  perf-y += perf_regs.o
> +perf-y += kvm-stat.o
>  perf-$(CONFIG_DWARF)     += dwarf-regs.o
>  perf-$(CONFIG_LOCAL_LIBUNWIND) += unwind-libunwind.o
>  perf-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
> diff --git a/tools/perf/arch/arm64/util/arm64_exception_types.h b/tools/perf/arch/arm64/util/arm64_exception_types.h
> new file mode 100644
> index 000000000000..27c981ebe401
> --- /dev/null
> +++ b/tools/perf/arch/arm64/util/arm64_exception_types.h
> @@ -0,0 +1,92 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#ifndef ARCH_PERF_ARM64_EXCEPTION_TYPES_H
> +#define ARCH_PERF_ARM64_EXCEPTION_TYPES_H
> +
> +/* Per asm/virt.h */
> +#define HVC_STUB_ERR		  0xbadca11
> +
> +/* Per asm/kvm_asm.h */
> +#define ARM_EXCEPTION_IRQ		0
> +#define ARM_EXCEPTION_EL1_SERROR	1
> +#define ARM_EXCEPTION_TRAP		2
> +#define ARM_EXCEPTION_IL		3
> +/* The hyp-stub will return this for any kvm_call_hyp() call */
> +#define ARM_EXCEPTION_HYP_GONE		HVC_STUB_ERR
> +
> +#define kvm_arm_exception_type					\
> +	{ARM_EXCEPTION_IRQ,		"IRQ"		},	\
> +	{ARM_EXCEPTION_EL1_SERROR,	"SERROR"	},	\
> +	{ARM_EXCEPTION_TRAP,		"TRAP"		},	\
> +	{ARM_EXCEPTION_IL,		"ILLEGAL"	},	\
> +	{ARM_EXCEPTION_HYP_GONE,	"HYP_GONE"	}
> +
> +/* Per asm/esr.h */
> +#define ESR_ELx_EC_UNKNOWN	(0x00)
> +#define ESR_ELx_EC_WFx		(0x01)
> +/* Unallocated EC: 0x02 */
> +#define ESR_ELx_EC_CP15_32	(0x03)
> +#define ESR_ELx_EC_CP15_64	(0x04)
> +#define ESR_ELx_EC_CP14_MR	(0x05)
> +#define ESR_ELx_EC_CP14_LS	(0x06)
> +#define ESR_ELx_EC_FP_ASIMD	(0x07)
> +#define ESR_ELx_EC_CP10_ID	(0x08)	/* EL2 only */
> +#define ESR_ELx_EC_PAC		(0x09)	/* EL2 and above */
> +/* Unallocated EC: 0x0A - 0x0B */
> +#define ESR_ELx_EC_CP14_64	(0x0C)
> +/* Unallocated EC: 0x0d */
> +#define ESR_ELx_EC_ILL		(0x0E)
> +/* Unallocated EC: 0x0F - 0x10 */
> +#define ESR_ELx_EC_SVC32	(0x11)
> +#define ESR_ELx_EC_HVC32	(0x12)	/* EL2 only */
> +#define ESR_ELx_EC_SMC32	(0x13)	/* EL2 and above */
> +/* Unallocated EC: 0x14 */
> +#define ESR_ELx_EC_SVC64	(0x15)
> +#define ESR_ELx_EC_HVC64	(0x16)	/* EL2 and above */
> +#define ESR_ELx_EC_SMC64	(0x17)	/* EL2 and above */
> +#define ESR_ELx_EC_SYS64	(0x18)
> +#define ESR_ELx_EC_SVE		(0x19)
> +#define ESR_ELx_EC_ERET		(0x1a)	/* EL2 only */
> +/* Unallocated EC: 0x1b - 0x1E */
> +#define ESR_ELx_EC_IMP_DEF	(0x1f)	/* EL3 only */
> +#define ESR_ELx_EC_IABT_LOW	(0x20)
> +#define ESR_ELx_EC_IABT_CUR	(0x21)
> +#define ESR_ELx_EC_PC_ALIGN	(0x22)
> +/* Unallocated EC: 0x23 */
> +#define ESR_ELx_EC_DABT_LOW	(0x24)
> +#define ESR_ELx_EC_DABT_CUR	(0x25)
> +#define ESR_ELx_EC_SP_ALIGN	(0x26)
> +/* Unallocated EC: 0x27 */
> +#define ESR_ELx_EC_FP_EXC32	(0x28)
> +/* Unallocated EC: 0x29 - 0x2B */
> +#define ESR_ELx_EC_FP_EXC64	(0x2C)
> +/* Unallocated EC: 0x2D - 0x2E */
> +#define ESR_ELx_EC_SERROR	(0x2F)
> +#define ESR_ELx_EC_BREAKPT_LOW	(0x30)
> +#define ESR_ELx_EC_BREAKPT_CUR	(0x31)
> +#define ESR_ELx_EC_SOFTSTP_LOW	(0x32)
> +#define ESR_ELx_EC_SOFTSTP_CUR	(0x33)
> +#define ESR_ELx_EC_WATCHPT_LOW	(0x34)
> +#define ESR_ELx_EC_WATCHPT_CUR	(0x35)
> +/* Unallocated EC: 0x36 - 0x37 */
> +#define ESR_ELx_EC_BKPT32	(0x38)
> +/* Unallocated EC: 0x39 */
> +#define ESR_ELx_EC_VECTOR32	(0x3A)	/* EL2 only */
> +/* Unallocated EC: 0x3B */
> +#define ESR_ELx_EC_BRK64	(0x3C)
> +/* Unallocated EC: 0x3D - 0x3F */
> +#define ESR_ELx_EC_MAX		(0x3F)
> +
> +#define ECN(x) { ESR_ELx_EC_##x, #x }
> +
> +#define kvm_arm_exception_class \
> +	ECN(UNKNOWN), ECN(WFx), ECN(CP15_32), ECN(CP15_64), ECN(CP14_MR), \
> +	ECN(CP14_LS), ECN(FP_ASIMD), ECN(CP10_ID), ECN(PAC), ECN(CP14_64), \
> +	ECN(SVC64), ECN(HVC64), ECN(SMC64), ECN(SYS64), ECN(SVE), \
> +	ECN(IMP_DEF), ECN(IABT_LOW), ECN(IABT_CUR), \
> +	ECN(PC_ALIGN), ECN(DABT_LOW), ECN(DABT_CUR), \
> +	ECN(SP_ALIGN), ECN(FP_EXC32), ECN(FP_EXC64), ECN(SERROR), \
> +	ECN(BREAKPT_LOW), ECN(BREAKPT_CUR), ECN(SOFTSTP_LOW), \
> +	ECN(SOFTSTP_CUR), ECN(WATCHPT_LOW), ECN(WATCHPT_CUR), \
> +	ECN(BKPT32), ECN(VECTOR32), ECN(BRK64)
> +
> +#endif /* ARCH_PERF_ARM64_EXCEPTION_TYPES_H */
> diff --git a/tools/perf/arch/arm64/util/kvm-stat.c b/tools/perf/arch/arm64/util/kvm-stat.c
> new file mode 100644
> index 000000000000..32e58576f186
> --- /dev/null
> +++ b/tools/perf/arch/arm64/util/kvm-stat.c
> @@ -0,0 +1,86 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <errno.h>
> +#include <memory.h>
> +#include "../../util/evsel.h"
> +#include "../../util/kvm-stat.h"
> +#include "arm64_exception_types.h"
> +#include "debug.h"
> +
> +define_exit_reasons_table(arm64_exit_reasons, kvm_arm_exception_type);
> +define_exit_reasons_table(arm64_trap_exit_reasons, kvm_arm_exception_class);
> +
> +const char *kvm_trap_exit_reason = "esr_ec";
> +const char *vcpu_id_str = "id";
> +const int decode_str_len = 20;
> +const char *kvm_exit_reason = "ret";
> +const char *kvm_entry_trace = "kvm:kvm_entry";
> +const char *kvm_exit_trace = "kvm:kvm_exit";
> +
> +const char *kvm_events_tp[] = {
> +	"kvm:kvm_entry",
> +	"kvm:kvm_exit",
> +	NULL,
> +};
> +
> +static void event_get_key(struct evsel *evsel,
> +			  struct perf_sample *sample,
> +			  struct event_key *key)
> +{
> +	key->info = 0;
> +	key->key = perf_evsel__intval(evsel, sample, kvm_exit_reason);

Now the perf/core branch doesn't have API perf_evsel__intval(), and it
has been replaced with evsel__intval(); so please

s/perf_evsel__intval/evsel__intval

It's good to rebase patch on the Arnaldo's perf/core branch:
  $ git clone --single-branch --branch perf/core \
       https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git

> +	key->exit_reasons = arm64_exit_reasons;
> +
> +	/*
> +	 * TRAP exceptions carry exception class info in esr_ec field
> +	 * and, hence, we need to use a different exit_reasons table to
> +	 * properly decode event's est_ec.
> +	 */
> +	if (key->key == ARM_EXCEPTION_TRAP) {
> +		key->key = perf_evsel__intval(evsel, sample,

Ditto.

> +					      kvm_trap_exit_reason);

Otherwise, this patch is good for me and I have tested this patch with
below commands:

  $ perf kvm stat record
  $ perf kvm stat report

Reviewed-by: Leo Yan <leo.yan@linaro.org>
Tested-by: Leo Yan <leo.yan@linaro.org>

Thanks,
Leo

> +		key->exit_reasons = arm64_trap_exit_reasons;
> +	}
> +}
> +
> +static bool event_begin(struct evsel *evsel,
> +			struct perf_sample *sample __maybe_unused,
> +			struct event_key *key __maybe_unused)
> +{
> +	return !strcmp(evsel->name, kvm_entry_trace);
> +}
> +
> +static bool event_end(struct evsel *evsel,
> +		      struct perf_sample *sample,
> +		      struct event_key *key)
> +{
> +	if (!strcmp(evsel->name, kvm_exit_trace)) {
> +		event_get_key(evsel, sample, key);
> +		return true;
> +	}
> +	return false;
> +}
> +
> +static struct kvm_events_ops exit_events = {
> +	.is_begin_event = event_begin,
> +	.is_end_event	= event_end,
> +	.decode_key	= exit_event_decode_key,
> +	.name		= "VM-EXIT"
> +};
> +
> +struct kvm_reg_events_ops kvm_reg_events_ops[] = {
> +	{
> +		.name	= "vmexit",
> +		.ops	= &exit_events,
> +	},
> +	{ NULL },
> +};
> +
> +const char * const kvm_skip_events[] = {
> +	NULL,
> +};
> +
> +int cpu_isa_init(struct perf_kvm_stat *kvm, const char *cpuid __maybe_unused)
> +{
> +	kvm->exit_reasons_isa = "arm64";
> +	return 0;
> +}
> -- 
> 2.28.0
> 
