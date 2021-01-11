Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3E02F0FB2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 11:09:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbhAKKIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 05:08:02 -0500
Received: from foss.arm.com ([217.140.110.172]:52256 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728527AbhAKKIC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 05:08:02 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 59CFC101E;
        Mon, 11 Jan 2021 02:07:16 -0800 (PST)
Received: from [10.57.39.145] (unknown [10.57.39.145])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BB0003F70D;
        Mon, 11 Jan 2021 02:07:12 -0800 (PST)
Subject: Re: [PATCH v1 7/7] perf cs-etm: Detect pid in VMID for kernel running
 at EL2
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
Cc:     Al Grant <al.grant@arm.com>
References: <20210109074435.626855-1-leo.yan@linaro.org>
 <20210109074435.626855-8-leo.yan@linaro.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <19205bb1-369a-9274-d752-d94f33a909f8@arm.com>
Date:   Mon, 11 Jan 2021 10:07:03 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210109074435.626855-8-leo.yan@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leo

On 1/9/21 7:44 AM, Leo Yan wrote:
> From: Suzuki K Poulose <suzuki.poulose@arm.com>
> 
> The pid of the task could be traced as VMID when the kernel is
> running at EL2. Teach the decoder to look for vmid when the
> context_id is invalid but we have a valid VMID.

Thank you again for cleaning up this ! Please see one comment
below.

> 
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Al Grant <al.grant@arm.com>
> Co-developed-by: Leo Yan <leo.yan@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>   .../perf/util/cs-etm-decoder/cs-etm-decoder.c | 32 ++++++++++++++++---
>   1 file changed, 28 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> index cd007cc9c283..9e81169dfa76 100644
> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> @@ -6,6 +6,7 @@
>    * Author: Mathieu Poirier <mathieu.poirier@linaro.org>
>    */
>   
> +#include <linux/coresight-pmu.h>
>   #include <linux/err.h>
>   #include <linux/list.h>
>   #include <linux/zalloc.h>
> @@ -500,13 +501,36 @@ cs_etm_decoder__set_tid(struct cs_etm_queue *etmq,
>   			const ocsd_generic_trace_elem *elem,
>   			const uint8_t trace_chan_id)
>   {
> -	pid_t tid;
> +	pid_t tid = -1;
> +	u64 pid_fmt;
> +	int ret;
>   
> -	/* Ignore PE_CONTEXT packets that don't have a valid contextID */
> -	if (!elem->context.ctxt_id_valid)
> +	ret = cs_etm__get_pid_fmt(trace_chan_id, &pid_fmt);
> +	if (ret)
> +		return OCSD_RESP_FATAL_SYS_ERR;

The patch looks fine to me. I am wondering if this can be cached somewhere in
the etmq to avoid doing the search everytime we hit a CID ? Surely for a session,
this woudn't change and thus for the decoder life time.

Cheers
Suzuki
