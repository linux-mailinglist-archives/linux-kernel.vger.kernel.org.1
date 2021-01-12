Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A288C2F3B32
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 20:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436732AbhALTvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 14:51:53 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2328 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393268AbhALTvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 14:51:51 -0500
Received: from fraeml706-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DFh2N2KvDz67b1F;
        Wed, 13 Jan 2021 03:48:12 +0800 (CST)
Received: from lhreml741-chm.china.huawei.com (10.201.108.191) by
 fraeml706-chm.china.huawei.com (10.206.15.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Tue, 12 Jan 2021 20:51:09 +0100
Received: from [10.47.197.90] (10.47.197.90) by lhreml741-chm.china.huawei.com
 (10.201.108.191) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Tue, 12 Jan
 2021 19:51:03 +0000
Subject: Re: [PATCH 1/2] perf tools: add 'perf irq' to measure the hardware
 interrupts
To:     Bixuan Cui <cuibixuan@huawei.com>, <peterz@infradead.org>,
        <mingo@redhat.com>, <acme@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <john.wanghui@huawei.com>, <abudankov@huawei.com>
References: <20210112125558.72989-1-cuibixuan@huawei.com>
 <20210112125558.72989-2-cuibixuan@huawei.com>
From:   Alexei Budankov <abudankov@huawei.com>
Message-ID: <03316fe6-f59b-9911-67e0-2841bb79cac7@huawei.com>
Date:   Tue, 12 Jan 2021 22:50:57 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210112125558.72989-2-cuibixuan@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.197.90]
X-ClientProxiedBy: braeml709-chm.china.huawei.com (10.226.71.35) To
 lhreml741-chm.china.huawei.com (10.201.108.191)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Bixuan,

On 12.01.2021 15:55, Bixuan Cui wrote:
> Add 'perf irq' to trace/measure the hardware interrupts.
> 
> Now three functions are provided:
>   1. 'perf irq record <command>' to record the irq handler events.
>   2. 'perf irq script' to see a detailed trace of the workload that
>    was recorded.
>   3. 'perf irq timeconsume' to calculate the time consumed by each
>    hardware interrupt processing function.
> 
> Signed-off-by: Bixuan Cui <cuibixuan@huawei.com>

Thanks for the patches. There is still something that could be improved.

> ---
>  tools/perf/Build         |   1 +
>  tools/perf/builtin-irq.c | 288 +++++++++++++++++++++++++++++++++++++++
>  tools/perf/builtin.h     |   1 +
>  tools/perf/perf.c        |   1 +
>  4 files changed, 291 insertions(+)
>  create mode 100644 tools/perf/builtin-irq.c
> 

<SNIP>

> +
> +static int __cmd_record(int argc, const char **argv)
> +{
> +	unsigned int rec_argc, i, j;
> +	const char **rec_argv;
> +	const char * const record_args[] = {
> +		"record",
> +		"-a",

I see it works also like this:

sudo perf record -p PID -c 1 -e irq:irq_handler_entry,irq:irq_handler_exit
sudo perf record -R -c 1 -e irq:irq_handler_entry,irq:irq_handler_exit -- find /

This -a option jointly with -p option could be made configurable from
the command line for perf irq mode.

> +		"-R",
> +		"-m", "1024",

Do you see data losses with default buffer size of 512KB
when capturing trace in your specific use case?

If not then this -m could be avoided or made configurable
if you still need it.

Regards,
Alexei
