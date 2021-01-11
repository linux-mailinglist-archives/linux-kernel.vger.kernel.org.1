Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A87B2F0F88
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 10:57:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728764AbhAKJ4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 04:56:15 -0500
Received: from foss.arm.com ([217.140.110.172]:51914 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728669AbhAKJ4P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 04:56:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9212B101E;
        Mon, 11 Jan 2021 01:55:29 -0800 (PST)
Received: from [10.57.39.145] (unknown [10.57.39.145])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F375B3F70D;
        Mon, 11 Jan 2021 01:55:25 -0800 (PST)
Subject: Re: [PATCH v1 6/7] perf cs-etm: Add helper cs_etm__get_pid_fmt()
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
 <20210109074435.626855-7-leo.yan@linaro.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <60d2c6b5-4465-188b-f4be-a762e2d57510@arm.com>
Date:   Mon, 11 Jan 2021 09:55:16 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210109074435.626855-7-leo.yan@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/9/21 7:44 AM, Leo Yan wrote:
> This patch adds helper function cs_etm__get_pid_fmt(), by passing
> parameter "traceID", it returns the corresponding PID format.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>

Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>

> ---
>   tools/perf/util/cs-etm.c | 18 ++++++++++++++++++
>   tools/perf/util/cs-etm.h |  1 +
>   2 files changed, 19 insertions(+)
> 
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 8c125134a756..6705d39c8cee 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -157,6 +157,24 @@ int cs_etm__get_cpu(u8 trace_chan_id, int *cpu)
>   	return 0;
>   }
>   
> +int cs_etm__get_pid_fmt(u8 trace_chan_id, u64 *pid_fmt)
> +{
> +	struct int_node *inode;
> +	u64 *metadata;
> +
> +	inode = intlist__find(traceid_list, trace_chan_id);
> +	if (!inode)
> +		return -EINVAL;
> +
> +	metadata = inode->priv;
> +	if (metadata[CS_ETM_MAGIC] == __perf_cs_etmv3_magic)
> +		*pid_fmt = metadata[CS_ETM_PID_FMT];
> +	else
> +		*pid_fmt = metadata[CS_ETMV4_PID_FMT];
> +
> +	return 0;
> +}
> +
>   void cs_etm__etmq_set_traceid_queue_timestamp(struct cs_etm_queue *etmq,
>   					      u8 trace_chan_id)
>   {
> diff --git a/tools/perf/util/cs-etm.h b/tools/perf/util/cs-etm.h
> index 8cbbea6100a1..98801040175f 100644
> --- a/tools/perf/util/cs-etm.h
> +++ b/tools/perf/util/cs-etm.h
> @@ -175,6 +175,7 @@ struct cs_etm_packet_queue {
>   int cs_etm__process_auxtrace_info(union perf_event *event,
>   				  struct perf_session *session);
>   int cs_etm__get_cpu(u8 trace_chan_id, int *cpu);
> +int cs_etm__get_pid_fmt(u8 trace_chan_id, u64 *pid_fmt);
>   int cs_etm__etmq_set_tid(struct cs_etm_queue *etmq,
>   			 pid_t tid, u8 trace_chan_id);
>   bool cs_etm__etmq_is_timeless(struct cs_etm_queue *etmq);
> 

