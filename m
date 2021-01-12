Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D95D72F3B37
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 20:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436799AbhALTw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 14:52:27 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2329 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436764AbhALTw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 14:52:26 -0500
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DFh210BjRz67Prs;
        Wed, 13 Jan 2021 03:47:53 +0800 (CST)
Received: from lhreml741-chm.china.huawei.com (10.201.108.191) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Tue, 12 Jan 2021 20:51:44 +0100
Received: from [10.47.197.90] (10.47.197.90) by lhreml741-chm.china.huawei.com
 (10.201.108.191) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Tue, 12 Jan
 2021 19:51:38 +0000
Subject: Re: [PATCH 2/2] perf tools: Add documentation for 'perf irq' command
To:     Bixuan Cui <cuibixuan@huawei.com>, <peterz@infradead.org>,
        <mingo@redhat.com>, <acme@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <john.wanghui@huawei.com>, <abudankov@huawei.com>
References: <20210112125558.72989-1-cuibixuan@huawei.com>
 <20210112125558.72989-3-cuibixuan@huawei.com>
From:   Alexei Budankov <abudankov@huawei.com>
Message-ID: <1da239a2-2999-0c61-b524-fd1e81c58dbc@huawei.com>
Date:   Tue, 12 Jan 2021 22:51:32 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210112125558.72989-3-cuibixuan@huawei.com>
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


Hi,

On 12.01.2021 15:55, Bixuan Cui wrote:
> Add documentation for 'perf irq' command.
> 
> Signed-off-by: Bixuan Cui <cuibixuan@huawei.com>
> ---
>  tools/perf/Documentation/perf-irq.txt | 58 +++++++++++++++++++++++++++
>  tools/perf/command-list.txt           |  1 +
>  2 files changed, 59 insertions(+)
>  create mode 100644 tools/perf/Documentation/perf-irq.txt
> 
> diff --git a/tools/perf/Documentation/perf-irq.txt b/tools/perf/Documentation/perf-irq.txt
> new file mode 100644
> index 000000000000..8c0e388dad59
> --- /dev/null
> +++ b/tools/perf/Documentation/perf-irq.txt
> @@ -0,0 +1,58 @@
> +perf-irq(1)
> +=============
> +
> +NAME
> +----
> +perf-irq - Tool to trace/measure hardware interrupts
> +
> +SYNOPSIS
> +--------
> +[verse]
> +'perf irq' {record|timeconsume|script}
> +
> +DESCRIPTION
> +-----------
> +There are several variants of 'perf irq':
> +
> +  'perf irq record <command>' to record the irq handler events
> +  of an arbitrary workload.
> +
> +  'perf irq script' to see a detailed trace of the workload that
> +   was recorded (aliased to 'perf script' for now).
> +
> +  'perf irq timeconsume' to calculate the time consumed by each
> +   hardware interrupt processing function.
> +
> +    Example usage:
> +        perf irq record -- sleep 1
> +        perf irq timeconsume

This timeconsume mode looks more like: perf irq report <options>

> +
> +   By default it shows the individual irq events, including the irq name,
> +   cpu(execute the hardware interrupt processing function), time consumed,
> +   entry time and exit time for the each hardware irq:
> +
> +   -------------------------------------------------------------------------------------------------------------------------------------------
> +     Irq name         |  CPU   | Time consume us | Handler entry time | Handler exit time
> +   -------------------------------------------------------------------------------------------------------------------------------------------
> +     enp2s0f2-tx-0    | [0006] |      0.000001 s |   6631263.313329 s |   6631263.313330 s
> +
> +   -------------------------------------------------------------------------------------------------------------------------------------------
> +     Irq name         |  CPU   | Time consume us | Handler entry time | Handler exit time
> +   -------------------------------------------------------------------------------------------------------------------------------------------
> +     megasas          | [0013] |      0.000003 s |   6631263.209564 s |   6631263.209567 s
> +
> +   -------------------------------------------------------------------------------------------------------------------------------------------
> +     Irq name         |  CPU   | Time consume us | Handler entry time | Handler exit time
> +   -------------------------------------------------------------------------------------------------------------------------------------------
> +     acpi             | [0016] |      0.000018 s |   6631263.085787 s |   6631263.085805 s
> +
> +
> +OPTIONS for 'perf irq'
> +----------------------------
> +
> +--cpus::
> +	Show just entries with activities for the given CPUs.

I am getting this:

tools/perf/perf irq --cpus=0 record -- find /
  Error: unknown option `cpus=0'

 Usage: perf irq [<options>] {record|timeconsume|script}

Regards,
Alexei
