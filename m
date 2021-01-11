Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABC0E2F0F5D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 10:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728618AbhAKJqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 04:46:11 -0500
Received: from foss.arm.com ([217.140.110.172]:51576 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728550AbhAKJqL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 04:46:11 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7FE7F101E;
        Mon, 11 Jan 2021 01:45:25 -0800 (PST)
Received: from [10.57.39.145] (unknown [10.57.39.145])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DE7293F70D;
        Mon, 11 Jan 2021 01:45:21 -0800 (PST)
Subject: Re: [PATCH v1 4/7] perf cs-etm: Add PID format into metadata
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
 <20210109074435.626855-5-leo.yan@linaro.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <c9aa6c3b-9df5-31c7-9a57-3180d260c660@arm.com>
Date:   Mon, 11 Jan 2021 09:45:12 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210109074435.626855-5-leo.yan@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leo,

On 1/9/21 7:44 AM, Leo Yan wrote:
> It's possible for CoreSight to trace PID in either CONTEXTIDR_EL1 or
> CONTEXTIDR_EL2, the PID format info is used to distinguish the PID
> is traced in which register.
> 
> This patch saves PID format into the metadata when record.

The patch looks good to me. One minor suggestion below

> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>   tools/perf/arch/arm/util/cs-etm.c | 21 +++++++++++++++++++++
>   tools/perf/util/cs-etm.c          |  2 ++
>   tools/perf/util/cs-etm.h          |  2 ++
>   3 files changed, 25 insertions(+)
> 
> diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
> index fad7b6e13ccc..ee78df3b1b07 100644
> --- a/tools/perf/arch/arm/util/cs-etm.c
> +++ b/tools/perf/arch/arm/util/cs-etm.c
> @@ -613,6 +613,7 @@ static void cs_etm_get_metadata(int cpu, u32 *offset,
>   	struct cs_etm_recording *ptr =
>   			container_of(itr, struct cs_etm_recording, itr);
>   	struct perf_pmu *cs_etm_pmu = ptr->cs_etm_pmu;
> +	u64 pid_fmt;
>   
>   	/* first see what kind of tracer this cpu is affined to */
>   	if (cs_etm_is_etmv4(itr, cpu)) {
> @@ -641,6 +642,16 @@ static void cs_etm_get_metadata(int cpu, u32 *offset,
>   				      metadata_etmv4_ro
>   				      [CS_ETMV4_TRCAUTHSTATUS]);
>   
> +		/*
> +		 * The PID format will be used when decode the trace data;
> +		 * based on it the decoder will make decision for setting
> +		 * sample's PID as context_id or VMID.
> +		 */
> +		pid_fmt = perf_pmu__format_bits(&cs_etm_pmu->format, "pid");
> +		if (!pid_fmt)
> +			pid_fmt = 1ULL << ETM_OPT_CTXTID;
> +		info->priv[*offset + CS_ETMV4_PID_FMT] = pid_fmt;
> +

Given we do this same step twice here in this function and also in patch 2.
I am wondering if this could be made into a small helper function ?

static u64 cs_etm_pmu_format_pid(cs_etm_pm)
{
	pid_fmt = perf_pmu__format_bits(&cs_etm_pmu->format, "pid");
	/*
	 * An older kernel doesn't expose this, so fall back to using
	 * CTXTID.
	 */
	if (!pid_fmt)
		pid_fmt = 1ULL << ETM_OPT_CTXTID;
	return pid_fmt;
}

Suzuki
