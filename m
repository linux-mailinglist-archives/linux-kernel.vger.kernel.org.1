Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4EFE2FF54A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 21:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbhAUUBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 15:01:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:50318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726693AbhAUT6J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 14:58:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C5D3723A54;
        Thu, 21 Jan 2021 19:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611259042;
        bh=fErj1J8BhuJWVJgO/O00k5gneDRvK4N3MYoaLEK6r/M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J+rrsYEg/Ix8/LNIlIdNZffPO2kYE/sVkuSFZf82MHleDDCTXHBqm3gylwpmv3V5E
         dn640E3KKrIaLVNxBMdnrHWp3ss8xwY0tN83K6GMbWpZtyF8H5MadnQ8YSxM+D8QJo
         VKFggcFLFh1RTMackSaTVHnYS0lzeePRt7sGZ643Z1hNgBsOAzqjv9waCZ1QYAhc12
         Uc43Br/8DcEA06Xk9vO5pIG+dJRz3wcX9MGDRcQzvaJXDxY5cW5NTCUEbOdvEfUi8n
         jhgehwd3zQbgJKKkdIum+aFKhNU3M+7k8UohcclowoMRw70TE9A11L/3p+LFeaOnDZ
         QRD9NMfcLpNFw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D5B9440513; Thu, 21 Jan 2021 16:57:07 -0300 (-03)
Date:   Thu, 21 Jan 2021 16:57:07 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     kan.liang@linux.intel.com
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, jolsa@redhat.com,
        namhyung@kernel.org, ak@linux.intel.com, yao.jin@linux.intel.com
Subject: Re: [PATCH] perf stat: Add Topdown metrics events as default events
Message-ID: <20210121195707.GA356537@kernel.org>
References: <20210121133752.118327-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121133752.118327-1-kan.liang@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jan 21, 2021 at 05:37:52AM -0800, kan.liang@linux.intel.com escreveu:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> The Topdown Microarchitecture Analysis (TMA) Method is a structured
> analysis methodology to identify critical performance bottlenecks in
> out-of-order processors. From the Ice Lake and later platforms, the
> Topdown information can be retrieved from the dedicated "metrics"
> register, which isn't impacted by other events. Also, the Topdown
> metrics support both per thread/process and per core measuring.
> Adding Topdown metrics events as default events can enrich the default
> measuring information, and would not cost any extra multiplexing.
> 
> Introduce arch_evlist__add_default_attrs() to allow architecture
> specific default events. Add the Topdown metrics events in the X86
> specific arch_evlist__add_default_attrs(). Other architectures can
> add their own default events later separately.
> 
> With the patch,
> 
>  $perf stat sleep 1
> 
>  Performance counter stats for 'sleep 1':
> 
>            0.82 msec task-clock:u              #    0.001 CPUs utilized
>               0      context-switches:u        #    0.000 K/sec
>               0      cpu-migrations:u          #    0.000 K/sec
>              61      page-faults:u             #    0.074 M/sec
>         319,941      cycles:u                  #    0.388 GHz
>         242,802      instructions:u            #    0.76  insn per cycle
>          54,380      branches:u                #   66.028 M/sec
>           4,043      branch-misses:u           #    7.43% of all branches
>       1,585,555      slots:u                   # 1925.189 M/sec
>         238,941      topdown-retiring:u        #     15.0% retiring
>         410,378      topdown-bad-spec:u        #     25.8% bad speculation
>         634,222      topdown-fe-bound:u        #     39.9% frontend bound
>         304,675      topdown-be-bound:u        #     19.2% backend bound

Shouldn't we be adding this to one of the -d levels?

But you say that this is essentially for free, so you check if this
extra register is in place and if it is, hey, its for free, add it, is
that the rationale?

I.e. it doesn't cause any impact to what we were getting before, so we
should default to use free stuff?

- Arnaldo
 
>        1.001791625 seconds time elapsed
> 
>        0.000000000 seconds user
>        0.001572000 seconds sys
> 
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  tools/perf/arch/x86/util/Build    |  1 +
>  tools/perf/arch/x86/util/evlist.c | 15 +++++++++++++++
>  tools/perf/builtin-stat.c         |  3 +++
>  tools/perf/util/evlist.c          |  5 +++++
>  tools/perf/util/evlist.h          |  2 ++
>  5 files changed, 26 insertions(+)
>  create mode 100644 tools/perf/arch/x86/util/evlist.c
> 
> diff --git a/tools/perf/arch/x86/util/Build b/tools/perf/arch/x86/util/Build
> index 347c39b960eb..ce1ec92fecdc 100644
> --- a/tools/perf/arch/x86/util/Build
> +++ b/tools/perf/arch/x86/util/Build
> @@ -6,6 +6,7 @@ perf-y += perf_regs.o
>  perf-y += topdown.o
>  perf-y += machine.o
>  perf-y += event.o
> +perf-y += evlist.o
>  
>  perf-$(CONFIG_DWARF) += dwarf-regs.o
>  perf-$(CONFIG_BPF_PROLOGUE) += dwarf-regs.o
> diff --git a/tools/perf/arch/x86/util/evlist.c b/tools/perf/arch/x86/util/evlist.c
> new file mode 100644
> index 000000000000..8c6732cc7794
> --- /dev/null
> +++ b/tools/perf/arch/x86/util/evlist.c
> @@ -0,0 +1,15 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <stdio.h>
> +#include "util/pmu.h"
> +#include "util/evlist.h"
> +#include "util/parse-events.h"
> +
> +#define TOPDOWN_L1_EVENTS	"{slots,topdown-retiring,topdown-bad-spec,topdown-fe-bound,topdown-be-bound}"
> +
> +int arch_evlist__add_default_attrs(struct evlist *evlist)
> +{
> +	if (!pmu_have_event("cpu", "slots"))
> +		return 0;
> +
> +	return parse_events(evlist, TOPDOWN_L1_EVENTS, NULL);
> +}
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 3c054b8d4677..abcdabaf1701 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -1827,6 +1827,9 @@ static int add_default_attributes(void)
>  		}
>  		if (evlist__add_default_attrs(evsel_list, default_attrs1) < 0)
>  			return -1;
> +
> +		if (arch_evlist__add_default_attrs(evsel_list) < 0)
> +			return -1;
>  	}
>  
>  	/* Detailed events get appended to the event list: */
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index 05363a7247c4..b38589d8c027 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -303,6 +303,11 @@ int __evlist__add_default_attrs(struct evlist *evlist, struct perf_event_attr *a
>  	return evlist__add_attrs(evlist, attrs, nr_attrs);
>  }
>  
> +__weak int arch_evlist__add_default_attrs(struct evlist *evlist __maybe_unused)
> +{
> +	return 0;
> +}
> +
>  struct evsel *evlist__find_tracepoint_by_id(struct evlist *evlist, int id)
>  {
>  	struct evsel *evsel;
> diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
> index 1aae75895dea..9eba4958a1e9 100644
> --- a/tools/perf/util/evlist.h
> +++ b/tools/perf/util/evlist.h
> @@ -110,6 +110,8 @@ int __evlist__add_default_attrs(struct evlist *evlist,
>  #define evlist__add_default_attrs(evlist, array) \
>  	__evlist__add_default_attrs(evlist, array, ARRAY_SIZE(array))
>  
> +int arch_evlist__add_default_attrs(struct evlist *evlist);
> +
>  int evlist__add_dummy(struct evlist *evlist);
>  
>  int evlist__add_sb_event(struct evlist *evlist, struct perf_event_attr *attr,
> -- 
> 2.25.1
> 

-- 

- Arnaldo
