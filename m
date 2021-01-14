Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBBFC2F5D9F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 10:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbhANJdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 04:33:01 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2341 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727784AbhANJc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 04:32:59 -0500
Received: from fraeml742-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DGf8p2d9yz67bTC;
        Thu, 14 Jan 2021 17:27:06 +0800 (CST)
Received: from lhreml741-chm.china.huawei.com (10.201.108.191) by
 fraeml742-chm.china.huawei.com (10.206.15.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 14 Jan 2021 10:32:17 +0100
Received: from [10.199.170.166] (10.199.170.166) by
 lhreml741-chm.china.huawei.com (10.201.108.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 14 Jan 2021 09:32:11 +0000
Subject: Re: [PATCH v2 1/2] perf tools: add 'perf irq' to measure the hardware
 interrupts
To:     Bixuan Cui <cuibixuan@huawei.com>, <peterz@infradead.org>,
        <mingo@redhat.com>, <acme@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <john.wanghui@huawei.com>
References: <20210114074852.13231-1-cuibixuan@huawei.com>
 <20210114074852.13231-2-cuibixuan@huawei.com>
From:   Alexei Budankov <abudankov@huawei.com>
Message-ID: <4ad7a048-8982-577b-b7c0-ca7e25f901d6@huawei.com>
Date:   Thu, 14 Jan 2021 12:32:05 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210114074852.13231-2-cuibixuan@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.199.170.166]
X-ClientProxiedBy: braeml707-chm.china.huawei.com (10.226.71.37) To
 lhreml741-chm.china.huawei.com (10.201.108.191)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 14.01.2021 10:48, Bixuan Cui wrote:
> Add 'perf irq' to trace/measure the hardware interrupts.
> 
> Now three functions are provided:
>   1. 'perf irq record <command>' to record the irq handler events.
>   2. 'perf irq script' to see a detailed trace of the workload that
>    was recorded.
>   3. 'perf irq report' to calculate the time consumed by each
>    hardware interrupt processing function.
> 
> Signed-off-by: Bixuan Cui <cuibixuan@huawei.com>
> ---
>  tools/perf/Build         |   1 +
>  tools/perf/builtin-irq.c | 287 +++++++++++++++++++++++++++++++++++++++
>  tools/perf/builtin.h     |   1 +
>  tools/perf/perf.c        |   1 +
>  4 files changed, 290 insertions(+)
>  create mode 100644 tools/perf/builtin-irq.c

<SNIP>

> +static int __cmd_record(int argc, const char **argv)
> +{
> +	unsigned int rec_argc, i, j;
> +	const char **rec_argv;
> +	const char * const record_args[] = {
> +		"record",
> +		"-a",

Could you please make it configurable from the command line 
jointly with -p option?

> +		"-R",
> +		"-c", "1",
> +		"-e", "irq:irq_handler_entry",
> +		"-e", "irq:irq_handler_exit",
> +	};

Thanks,
Alexei
