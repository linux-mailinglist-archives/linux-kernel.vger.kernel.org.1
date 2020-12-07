Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB1F2D1A7E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 21:27:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbgLGU04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 15:26:56 -0500
Received: from mga05.intel.com ([192.55.52.43]:20438 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725816AbgLGU04 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 15:26:56 -0500
IronPort-SDR: SWnu6RLmYHeuz3u6ZLmgtOtpDXeetR/xqMl+1wEd1ovx9hghuh5fG9osdDPLKCM3BR690mNZmb
 ZE+Adv7Om9Vg==
X-IronPort-AV: E=McAfee;i="6000,8403,9828"; a="258479337"
X-IronPort-AV: E=Sophos;i="5.78,400,1599548400"; 
   d="scan'208";a="258479337"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2020 12:25:09 -0800
IronPort-SDR: c3QzzemuhZqGh6jZra0t41QlZXAPjPmNC0424cnruodzR0j3aO6V8Ql9pgHD1K0SsI2eDVNXMP
 ID4+crUgHwdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,400,1599548400"; 
   d="scan'208";a="375495765"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Dec 2020 12:25:09 -0800
Received: from [10.251.11.130] (kliang2-MOBL.ccr.corp.intel.com [10.251.11.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 78B47580816;
        Mon,  7 Dec 2020 12:25:08 -0800 (PST)
Subject: Re: [PATCH V2 02/12] perf record: Support new sample type for data
 page size
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     mingo@kernel.org, jolsa@redhat.com, linux-kernel@vger.kernel.org,
        namhyung@kernel.org, eranian@google.com, ak@linux.intel.com,
        mark.rutland@arm.com, will@kernel.org, mpe@ellerman.id.au
References: <20201130172803.2676-1-kan.liang@linux.intel.com>
 <20201130172803.2676-3-kan.liang@linux.intel.com>
 <20201207170759.GB129853@kernel.org>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <124d0414-f834-e2f0-8359-50488add60d1@linux.intel.com>
Date:   Mon, 7 Dec 2020 15:25:07 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201207170759.GB129853@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/7/2020 12:07 PM, Arnaldo Carvalho de Melo wrote:
> Em Mon, Nov 30, 2020 at 09:27:53AM -0800, kan.liang@linux.intel.com escreveu:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> Support new sample type PERF_SAMPLE_DATA_PAGE_SIZE for page size.
>>
>> Add new option --data-page-size to record sample data page size.
> 
> So, trying this on a kernel without this feature I get:
> 
> [acme@five perf]$ perf record --data-page-size sleep 1
> Error:
> The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (cycles:u).
> /bin/dmesg | grep -i perf may provide additional information.
> 
> [acme@five perf]$
> 
> I'm adding the following patch right after yours, next time please test
> this and provide a similar error message.
>

Sorry, I missed it.

Besides the PERF_SAMPLE_DATA_PAGE_SIZE, I think we have to fix the 
PERF_SAMPLE_CODE_PAGE_SIZE as well.
Should I send a separate patch to fix it?

Thanks,
Kan


> - Arnaldo
> 
> commit 2044fec7fcc6070b09f9b6a67922b0b9e4295dba
> Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> Date:   Mon Dec 7 14:04:05 2020 -0300
> 
>      perf evsel: Emit warning about kernel not supporting the data page size sample_type bit
>      
>      Before we had this unhelpful message:
>      
>        $ perf record --data-page-size sleep 1
>        Error:
>        The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (cycles:u).
>        /bin/dmesg | grep -i perf may provide additional information.
>        $
>      
>      Add support to the perf_missing_features variable to remember what
>      caused evsel__open() to fail and then use that information in
>      evsel__open_strerror().
>      
>        $ perf record --data-page-size sleep 1
>        Error:
>        Asking for the data page size isn't supported by this kernel.
>        $
>      
>      Cc: Kan Liang <kan.liang@linux.intel.com>
>      Cc: Namhyung Kim <namhyung@kernel.org>
>      Cc: Andi Kleen <ak@linux.intel.com>
>      Cc: Jiri Olsa <jolsa@redhat.com>
>      Cc: Mark Rutland <mark.rutland@arm.com>
>      Cc: Michael Ellerman <mpe@ellerman.id.au>
>      Cc: Stephane Eranian <eranian@google.com>
>      Cc: Will Deacon <will@kernel.org>
>      Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 5e6085c3fc761a55..c26ea82220bd8625 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1873,7 +1873,12 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
>   	 * Must probe features in the order they were added to the
>   	 * perf_event_attr interface.
>   	 */
> -        if (!perf_missing_features.cgroup && evsel->core.attr.cgroup) {
> +        if (!perf_missing_features.data_page_size &&
> +	    (evsel->core.attr.sample_type & PERF_SAMPLE_DATA_PAGE_SIZE)) {
> +		perf_missing_features.data_page_size = true;
> +		pr_debug2_peo("Kernel has no PERF_SAMPLE_DATA_PAGE_SIZE support, bailing out\n");
> +		goto out_close;
> +	} else if (!perf_missing_features.cgroup && evsel->core.attr.cgroup) {
>   		perf_missing_features.cgroup = true;
>   		pr_debug2_peo("Kernel has no cgroup sampling support, bailing out\n");
>   		goto out_close;
> @@ -2673,6 +2678,8 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
>   	"We found oprofile daemon running, please stop it and try again.");
>   		break;
>   	case EINVAL:
> +		if (evsel->core.attr.sample_type & PERF_SAMPLE_DATA_PAGE_SIZE && perf_missing_features.data_page_size)
> +			return scnprintf(msg, size, "Asking for the data page size isn't supported by this kernel.");
>   		if (evsel->core.attr.write_backward && perf_missing_features.write_backward)
>   			return scnprintf(msg, size, "Reading from overwrite event is not supported by this kernel.");
>   		if (perf_missing_features.clockid)
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index 79a860d8e3eefe23..cd1d8dd431997b84 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -144,6 +144,7 @@ struct perf_missing_features {
>   	bool aux_output;
>   	bool branch_hw_idx;
>   	bool cgroup;
> +	bool data_page_size;
>   };
>   
>   extern struct perf_missing_features perf_missing_features;
> 
