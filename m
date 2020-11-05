Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6682A813E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 15:48:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730960AbgKEOr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 09:47:58 -0500
Received: from mga12.intel.com ([192.55.52.136]:35491 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727275AbgKEOr6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 09:47:58 -0500
IronPort-SDR: eYjb6cwsr2CpGty/ip9Ffb3lonFJen/wo2mX06undcstA30oOfvMGt7+Hzw7eNOnhcA/OkbIuZ
 eFwGKvzL0ZIg==
X-IronPort-AV: E=McAfee;i="6000,8403,9795"; a="148671571"
X-IronPort-AV: E=Sophos;i="5.77,453,1596524400"; 
   d="scan'208";a="148671571"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2020 06:47:57 -0800
IronPort-SDR: xc6lYkzB0wsZKzibQC+/AVpt8xmjyABKWw+VKmE3YyNZRkkMJHBlxgJLw50Tzwo1RIYScWcGdb
 bD3UecaE0l/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,453,1596524400"; 
   d="scan'208";a="397270363"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 05 Nov 2020 06:47:56 -0800
Received: from [10.254.97.216] (kliang2-MOBL.ccr.corp.intel.com [10.254.97.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id EA1F158073D;
        Thu,  5 Nov 2020 06:47:55 -0800 (PST)
Subject: Re: [RFC 1/2] perf/core: Enable sched_task callbacks if PMU has it
To:     Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>, Gabriel Marin <gmx@google.com>
References: <20201102145221.309001-1-namhyung@kernel.org>
 <20201102145221.309001-2-namhyung@kernel.org>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <f92281d1-03ec-a1bc-b54f-e2b867d5b787@linux.intel.com>
Date:   Thu, 5 Nov 2020 09:47:54 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201102145221.309001-2-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/2/2020 9:52 AM, Namhyung Kim wrote:
> If an event associated with a PMU which has a sched_task callback,
> it should be called regardless of cpu/task context.  For example,


I don't think it's necessary. We should call it when we have to. 
Otherwise, it just waste cycles.
Shouldn't the patch 2 be enough?

Thanks,
Kan

> a per-cpu event might enable large PEBS buffers so it needs to flush
> the buffer whenever task scheduling happens. >
> The underlying PMU may or may not require this for the given event,
> but it will be handled in the pmu::sched_task() callback anyway.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>   kernel/events/core.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index b458ed3dc81b..aaa0155c4142 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -4696,6 +4696,8 @@ static void unaccount_event(struct perf_event *event)
>   		dec = true;
>   	if (has_branch_stack(event))
>   		dec = true;
> +	if (event->pmu->sched_task)
> +		dec = true;
>   	if (event->attr.ksymbol)
>   		atomic_dec(&nr_ksymbol_events);
>   	if (event->attr.bpf_event)
> @@ -11225,6 +11227,8 @@ static void account_event(struct perf_event *event)
>   		inc = true;
>   	if (is_cgroup_event(event))
>   		inc = true;
> +	if (event->pmu->sched_task)
> +		inc = true;
>   	if (event->attr.ksymbol)
>   		atomic_inc(&nr_ksymbol_events);
>   	if (event->attr.bpf_event)
> 
