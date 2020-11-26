Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACC3E2C4EFB
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 07:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388093AbgKZGv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 01:51:59 -0500
Received: from mga06.intel.com ([134.134.136.31]:46598 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728014AbgKZGv7 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 01:51:59 -0500
IronPort-SDR: NvtNpeLWRJqrjk805iN16tA7PM6wCyOkmmdxQ/1/IDSfZr2KveLDe50g8iWJd5fDnSm9yRu1/2
 5Xc96/WUY30w==
X-IronPort-AV: E=McAfee;i="6000,8403,9816"; a="233850545"
X-IronPort-AV: E=Sophos;i="5.78,371,1599548400"; 
   d="scan'208";a="233850545"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2020 22:51:58 -0800
IronPort-SDR: qhw12Nc3nt/oOP1bWROFLb1RgVVMc6gr/3CoEunYah5M/mhUkcU5m8DA4/BCNGb2J6YYZcAYL5
 +5NMSU7zkM3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,371,1599548400"; 
   d="scan'208";a="313930890"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.94]) ([10.237.72.94])
  by fmsmga007.fm.intel.com with ESMTP; 25 Nov 2020 22:51:54 -0800
Subject: Re: [PATCH] perf script: Fix overrun issue for dynamically-allocated
 pmu type number
To:     Jin Yao <yao.jin@linux.intel.com>, acme@kernel.org,
        jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20201126032425.19226-1-yao.jin@linux.intel.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <e72c243b-a50f-510b-5e21-10c3a38176db@intel.com>
Date:   Thu, 26 Nov 2020 08:51:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201126032425.19226-1-yao.jin@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/11/20 5:24 am, Jin Yao wrote:
> When unpacking the event which is from dynamic pmu, the array
> output[OUTPUT_TYPE_MAX] may be overrun. For example, type number of
> SKL uncore_imc is 10, but OUTPUT_TYPE_MAX is 7 now (OUTPUT_TYPE_MAX =
> PERF_TYPE_MAX + 1).
> 
> /* In builtin-script.c */
> process_event()
> {
> 	unsigned int type = output_type(attr->type);
> 
> 	if (output[type].fields == 0)
> 		return;
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
> Fixes: 1405720d4f26 ("perf script: Add 'synth' event type for synthesized events")

It does not look to me like the problem was introduced by that commit.  Are
you sure this Fixes tag is correct?
