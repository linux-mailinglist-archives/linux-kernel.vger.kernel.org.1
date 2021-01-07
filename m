Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC4E22EE727
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 21:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbhAGUrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 15:47:51 -0500
Received: from mga09.intel.com ([134.134.136.24]:33806 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726410AbhAGUrv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 15:47:51 -0500
IronPort-SDR: tq2YURX77rlUtI86OhM+MAiy6el8155GwsqzJxhj/2UJ0tRiH55dthtQBm+cMzkXBHj2M3sfWa
 R7oql8U4YXhA==
X-IronPort-AV: E=McAfee;i="6000,8403,9857"; a="177641881"
X-IronPort-AV: E=Sophos;i="5.79,330,1602572400"; 
   d="scan'208";a="177641881"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2021 12:46:05 -0800
IronPort-SDR: iDmxfNdRHWyJTN5zy13lBHxrGFaBw3nCdpKs4JZDCk9fMCH+nadxJmKVAcGlC6bSKwB8g/SOaO
 mUdgXfMzxP9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,330,1602572400"; 
   d="scan'208";a="497644557"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 07 Jan 2021 12:46:05 -0800
Received: from [10.254.76.189] (kliang2-MOBL.ccr.corp.intel.com [10.254.76.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 8583E580409;
        Thu,  7 Jan 2021 12:46:04 -0800 (PST)
Subject: Re: [PATCH] perf intel-pt: Fix 'CPU too large' error
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     linux-kernel@vger.kernel.org
References: <20210107174159.24897-1-adrian.hunter@intel.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <225955df-f11f-d627-0690-6864f46151f5@linux.intel.com>
Date:   Thu, 7 Jan 2021 15:46:03 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210107174159.24897-1-adrian.hunter@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/7/2021 12:41 PM, Adrian Hunter wrote:
> In some cases, the number of cpus (nr_cpus_online) is confused with the
> maximum cpu number (nr_cpus_avail), which results in the error in the
> example below:
> 
> Example on system with 8 cpus:
> 
>   Before:
>     # echo 0 > /sys/devices/system/cpu/cpu2/online
>     # ./perf record --kcore -e intel_pt// taskset --cpu-list 7 uname
>     Linux
>     [ perf record: Woken up 1 times to write data ]
>     [ perf record: Captured and wrote 0.147 MB perf.data ]
>     # ./perf script --itrace=e
>     Requested CPU 7 too large. Consider raising MAX_NR_CPUS
>     0x25908 [0x8]: failed to process type: 68 [Invalid argument]
> 
>   After:
>     # ./perf script --itrace=e
>     #
> 
> Fixes: 8c7274691f0d ("perf machine: Replace MAX_NR_CPUS with perf_env::nr_cpus_online")
> Fixes: 7df4e36a4785 ("perf session: Replace MAX_NR_CPUS with perf_env::nr_cpus_online")
> Cc: stable@vger.kernel.org
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>


Tested-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan

> ---
>   tools/perf/util/machine.c | 4 ++--
>   tools/perf/util/session.c | 2 +-
>   2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index 1ae32a81639c..46844599d25d 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -2977,7 +2977,7 @@ int machines__for_each_thread(struct machines *machines,
>   
>   pid_t machine__get_current_tid(struct machine *machine, int cpu)
>   {
> -	int nr_cpus = min(machine->env->nr_cpus_online, MAX_NR_CPUS);
> +	int nr_cpus = min(machine->env->nr_cpus_avail, MAX_NR_CPUS);
>   
>   	if (cpu < 0 || cpu >= nr_cpus || !machine->current_tid)
>   		return -1;
> @@ -2989,7 +2989,7 @@ int machine__set_current_tid(struct machine *machine, int cpu, pid_t pid,
>   			     pid_t tid)
>   {
>   	struct thread *thread;
> -	int nr_cpus = min(machine->env->nr_cpus_online, MAX_NR_CPUS);
> +	int nr_cpus = min(machine->env->nr_cpus_avail, MAX_NR_CPUS);
>   
>   	if (cpu < 0)
>   		return -EINVAL;
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 3b3c50b12791..2777c2df7d87 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -2391,7 +2391,7 @@ int perf_session__cpu_bitmap(struct perf_session *session,
>   {
>   	int i, err = -1;
>   	struct perf_cpu_map *map;
> -	int nr_cpus = min(session->header.env.nr_cpus_online, MAX_NR_CPUS);
> +	int nr_cpus = min(session->header.env.nr_cpus_avail, MAX_NR_CPUS);
>   
>   	for (i = 0; i < PERF_TYPE_MAX; ++i) {
>   		struct evsel *evsel;
> 
