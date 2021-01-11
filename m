Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D04FB2F0F6E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 10:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728714AbhAKJsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 04:48:31 -0500
Received: from foss.arm.com ([217.140.110.172]:51658 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728679AbhAKJsa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 04:48:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC012101E;
        Mon, 11 Jan 2021 01:47:44 -0800 (PST)
Received: from [10.57.39.145] (unknown [10.57.39.145])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3EE1C3F70D;
        Mon, 11 Jan 2021 01:47:41 -0800 (PST)
Subject: Re: [PATCH v1 5/7] perf cs-etm: Fixup PID_FMT when it is zero
To:     Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Daniel Kiss <Daniel.Kiss@arm.com>,
        Denis Nikitin <denik@chromium.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210109074435.626855-1-leo.yan@linaro.org>
 <20210109074435.626855-6-leo.yan@linaro.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <27c8f898-93f3-6a2d-5e9e-b5b1225df1c9@arm.com>
Date:   Mon, 11 Jan 2021 09:47:31 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210109074435.626855-6-leo.yan@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/9/21 7:44 AM, Leo Yan wrote:
> If the metadata item CS_ETM_PID_FMT/CS_ETMV4_PID_FMT is zero, this means
> the perf data file is recorded with old version tool and the tool has
> not extended to support the item.
> 
> For this case, this patch fixes up PID_FMT entry to set the value as
> BIT(ETM_OPT_CTXTID), this info will be delivered to the decoder to
> extract PID from packet's field "context_id".
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>

Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>

> ---
>   tools/perf/util/cs-etm.c | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
> 
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 763085db29ae..8c125134a756 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -7,6 +7,7 @@
>    */
>   
>   #include <linux/bitops.h>
> +#include <linux/coresight-pmu.h>
>   #include <linux/err.h>
>   #include <linux/kernel.h>
>   #include <linux/log2.h>
> @@ -2577,6 +2578,15 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
>   			for (k = 0; k < metadata_cpu_array_size; k++)
>   				metadata[j][k] = ptr[i + k];
>   
> +			/*
> +			 * If the data in CS_ETM_PID_FMT is zero, means the
> +			 * information isn't stored in the data file, this is
> +			 * because the old perf tool hasn't yet supported
> +			 * CS_ETM_PID_FMT.  Fixup the item to option "CTXTID".
> +			 */
> +			if (!metadata[j][CS_ETM_PID_FMT])
> +				metadata[j][CS_ETM_PID_FMT] = BIT(ETM_OPT_CTXTID);
> +
>   			/* The traceID is our handle */
>   			idx = metadata[j][CS_ETM_ETMTRACEIDR];
>   			i += metadata_cpu_array_size;
> @@ -2590,6 +2600,15 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
>   			for (k = 0; k < metadata_cpu_array_size; k++)
>   				metadata[j][k] = ptr[i + k];
>   
> +			/*
> +			 * If the data in CS_ETMV4_PID_FMT is zero, means the
> +			 * information isn't stored in the data file, this is
> +			 * because the old perf tool hasn't yet supported
> +			 * CS_ETMV4_PID_FMT.  Fixup the item to option "CTXTID".
> +			 */
> +			if (!metadata[j][CS_ETMV4_PID_FMT])
> +				metadata[j][CS_ETMV4_PID_FMT] = BIT(ETM_OPT_CTXTID);
> +
>   			/* The traceID is our handle */
>   			idx = metadata[j][CS_ETMV4_TRCTRACEIDR];
>   			i += metadata_cpu_array_size;
> 

