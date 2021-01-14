Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2612F5D27
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 10:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbhANJUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 04:20:16 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2339 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727382AbhANJUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 04:20:15 -0500
Received: from fraeml734-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DGdvY0cV0z67bNq;
        Thu, 14 Jan 2021 17:15:37 +0800 (CST)
Received: from lhreml741-chm.china.huawei.com (10.201.108.191) by
 fraeml734-chm.china.huawei.com (10.206.15.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 14 Jan 2021 10:19:32 +0100
Received: from [10.199.170.166] (10.199.170.166) by
 lhreml741-chm.china.huawei.com (10.201.108.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 14 Jan 2021 09:19:26 +0000
Subject: Re: [PATCH v2 2/2] perf tools: Add documentation for 'perf irq'
 command
To:     Bixuan Cui <cuibixuan@huawei.com>, <peterz@infradead.org>,
        <mingo@redhat.com>, <acme@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <john.wanghui@huawei.com>
References: <20210114074852.13231-1-cuibixuan@huawei.com>
 <20210114074852.13231-3-cuibixuan@huawei.com>
From:   Alexei Budankov <abudankov@huawei.com>
Message-ID: <fb92ed49-96b9-9873-2e3f-932bbe25dba3@huawei.com>
Date:   Thu, 14 Jan 2021 12:19:20 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210114074852.13231-3-cuibixuan@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.199.170.166]
X-ClientProxiedBy: braeml706-chm.china.huawei.com (10.226.71.62) To
 lhreml741-chm.china.huawei.com (10.201.108.191)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 14.01.2021 10:48, Bixuan Cui wrote:
> Add documentation for 'perf irq' command.
> 
> Signed-off-by: Bixuan Cui <cuibixuan@huawei.com>
> ---
>  tools/perf/Documentation/perf-irq.txt | 58 +++++++++++++++++++++++++++
>  tools/perf/command-list.txt           |  1 +
>  2 files changed, 59 insertions(+)
>  create mode 100644 tools/perf/Documentation/perf-irq.txt

<SNIP>

> +
> +OPTIONS for 'perf irq report'
> +----------------------------
> +
> +--cpus::
> +	Show just entries with activities for the given CPUs.

perf report mode already has -C,--cpu <num> option so 
it makes sense to reuse the option for perf irq report.

Regards,
Alexei
