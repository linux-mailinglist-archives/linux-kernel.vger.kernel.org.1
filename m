Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C005E2D7008
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 07:13:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395462AbgLKGMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 01:12:10 -0500
Received: from mga03.intel.com ([134.134.136.65]:52836 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389524AbgLKGLY (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 01:11:24 -0500
IronPort-SDR: +npOG2itrmh9u3edOxObPHlzkWn4qKIuSW9SSK+hYfMa4c3TTp/2TUcmYaawO0fNjXoCt9eORW
 SjKHrZuMsYew==
X-IronPort-AV: E=McAfee;i="6000,8403,9831"; a="174499956"
X-IronPort-AV: E=Sophos;i="5.78,410,1599548400"; 
   d="scan'208";a="174499956"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2020 22:10:42 -0800
IronPort-SDR: lmIRnu2HZnjGNgHD743NMRlrVHozvDlTHCUPKxYImRWjb8dVtqd4XBM1lBA2BvsJj/eaKoss6C
 tseFUHQb4r0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,410,1599548400"; 
   d="scan'208";a="544940183"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.94]) ([10.237.72.94])
  by fmsmga005.fm.intel.com with ESMTP; 10 Dec 2020 22:10:40 -0800
Subject: Re: [PATCH v2] perf script: Fix overrun issue for
 dynamically-allocated pmu type number
To:     Jin Yao <yao.jin@linux.intel.com>, acme@kernel.org,
        jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20201209005828.21302-1-yao.jin@linux.intel.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <3fcdc860-d858-0166-de23-34fc6fe5c1cd@intel.com>
Date:   Fri, 11 Dec 2020 08:10:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201209005828.21302-1-yao.jin@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/12/20 2:58 am, Jin Yao wrote:
> When unpacking the event which is from dynamic pmu, the array
> output[OUTPUT_TYPE_MAX] may be overrun. For example, type number of
> SKL uncore_imc is 10, but OUTPUT_TYPE_MAX is 7 now (OUTPUT_TYPE_MAX =
> PERF_TYPE_MAX + 1).
> 
> /* In builtin-script.c */
> process_event()
> {
>         unsigned int type = output_type(attr->type);
> 
>         if (output[type].fields == 0)
>                 return;
> }
> 
> output[10] is overrun.
> 
> Create a type OUTPUT_TYPE_OTHER for dynamic pmu events, then
> output_type(attr->type) will return OUTPUT_TYPE_OTHER here.
> 
> Note that if PERF_TYPE_MAX ever changed, then there would be a conflict
> between old perf.data files that had a dynamicaliy allocated PMU number
> that would then be the same as a fixed PERF_TYPE.
> 
> Example:
> 
> perf record --switch-events -C 0 -e "{cpu-clock,uncore_imc/data_reads/,uncore_imc/data_writes/}:SD" -a -- sleep 1
> perf script
> 
> Before:
>          swapper     0 [000] 1479253.987551:     277766               cpu-clock:  ffffffff9d4ddb6f cpuidle_enter_state+0xdf ([kernel.kallsyms])
>          swapper     0 [000] 1479253.987797:     246709               cpu-clock:  ffffffff9d4ddb6f cpuidle_enter_state+0xdf ([kernel.kallsyms])
>          swapper     0 [000] 1479253.988127:     329883               cpu-clock:  ffffffff9d4ddb6f cpuidle_enter_state+0xdf ([kernel.kallsyms])
>          swapper     0 [000] 1479253.988273:     146393               cpu-clock:  ffffffff9d4ddb6f cpuidle_enter_state+0xdf ([kernel.kallsyms])
>          swapper     0 [000] 1479253.988523:     249977               cpu-clock:  ffffffff9d4ddb6f cpuidle_enter_state+0xdf ([kernel.kallsyms])
>          swapper     0 [000] 1479253.988877:     354090               cpu-clock:  ffffffff9d4ddb6f cpuidle_enter_state+0xdf ([kernel.kallsyms])
>          swapper     0 [000] 1479253.989023:     145940               cpu-clock:  ffffffff9d4ddb6f cpuidle_enter_state+0xdf ([kernel.kallsyms])
>          swapper     0 [000] 1479253.989383:     359856               cpu-clock:  ffffffff9d4ddb6f cpuidle_enter_state+0xdf ([kernel.kallsyms])
>          swapper     0 [000] 1479253.989523:     140082               cpu-clock:  ffffffff9d4ddb6f cpuidle_enter_state+0xdf ([kernel.kallsyms])
> 
> After:
>          swapper     0 [000] 1397040.402011:     272384               cpu-clock:  ffffffff9d4ddb6f cpuidle_enter_state+0xdf ([kernel.kallsyms])
>          swapper     0 [000] 1397040.402011:       5396  uncore_imc/data_reads/:
>          swapper     0 [000] 1397040.402011:        967 uncore_imc/data_writes/:
>          swapper     0 [000] 1397040.402259:     249153               cpu-clock:  ffffffff9d4ddb6f cpuidle_enter_state+0xdf ([kernel.kallsyms])
>          swapper     0 [000] 1397040.402259:       7231  uncore_imc/data_reads/:
>          swapper     0 [000] 1397040.402259:       1297 uncore_imc/data_writes/:
>          swapper     0 [000] 1397040.402508:     249108               cpu-clock:  ffffffff9d4ddb6f cpuidle_enter_state+0xdf ([kernel.kallsyms])
>          swapper     0 [000] 1397040.402508:       5333  uncore_imc/data_reads/:
>          swapper     0 [000] 1397040.402508:       1008 uncore_imc/data_writes/:
> 
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> v2:
>   Remove Fixes tag because this issue has always been here, not caused by
>   1405720d4f26 ("perf script: Add 'synth' event type for synthesized events").
>   No functional change in v2. 
>  
>  tools/perf/builtin-script.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 1c322c129185..5d8a64836228 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -183,6 +183,7 @@ struct output_option {
>  
>  enum {
>  	OUTPUT_TYPE_SYNTH = PERF_TYPE_MAX,
> +	OUTPUT_TYPE_OTHER,
>  	OUTPUT_TYPE_MAX
>  };
>  
> @@ -279,6 +280,18 @@ static struct {
>  
>  		.invalid_fields = PERF_OUTPUT_TRACE | PERF_OUTPUT_BPF_OUTPUT,
>  	},
> +
> +	[OUTPUT_TYPE_OTHER] = {
> +		.user_set = false,
> +
> +		.fields = PERF_OUTPUT_COMM | PERF_OUTPUT_TID |
> +			      PERF_OUTPUT_CPU | PERF_OUTPUT_TIME |
> +			      PERF_OUTPUT_EVNAME | PERF_OUTPUT_IP |
> +			      PERF_OUTPUT_SYM | PERF_OUTPUT_SYMOFFSET |
> +			      PERF_OUTPUT_DSO | PERF_OUTPUT_PERIOD,
> +
> +		.invalid_fields = PERF_OUTPUT_TRACE | PERF_OUTPUT_BPF_OUTPUT,
> +	},
>  };
>  
>  struct evsel_script {
> @@ -339,8 +352,11 @@ static inline int output_type(unsigned int type)
>  	case PERF_TYPE_SYNTH:
>  		return OUTPUT_TYPE_SYNTH;
>  	default:
> -		return type;
> +		if (type < PERF_TYPE_MAX)
> +			return type;
>  	}
> +
> +	return OUTPUT_TYPE_OTHER;
>  }
>  
>  static inline unsigned int attr_type(unsigned int type)
> 

