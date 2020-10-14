Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D198728E5FE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 20:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387427AbgJNSGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 14:06:50 -0400
Received: from foss.arm.com ([217.140.110.172]:55400 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727371AbgJNSGu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 14:06:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B8E8FD6E;
        Wed, 14 Oct 2020 11:06:49 -0700 (PDT)
Received: from [10.57.48.76] (unknown [10.57.48.76])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8CBCB3F719;
        Wed, 14 Oct 2020 11:06:46 -0700 (PDT)
Subject: Re: [PATCH RFC v4 06/13] perf vendor events arm64: Add hip09 SMMUv3
 PMCG events
To:     John Garry <john.garry@huawei.com>, acme@kernel.org,
        will@kernel.org, mark.rutland@arm.com, jolsa@redhat.com,
        irogers@google.com, leo.yan@linaro.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, mathieu.poirier@linaro.org
Cc:     linux-kernel@vger.kernel.org, qiangqing.zhang@nxp.com,
        linuxarm@huawei.com, zhangshaokun@hisilicon.com,
        james.clark@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com
References: <1602152121-240367-1-git-send-email-john.garry@huawei.com>
 <1602152121-240367-7-git-send-email-john.garry@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <3929fa83-36e0-b739-ac18-331d96cd25a1@arm.com>
Date:   Wed, 14 Oct 2020 19:06:43 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <1602152121-240367-7-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-10-08 11:15, John Garry wrote:
> Add the SMMUv3 PMCG (Performance Monitor Event Group) events for hip09
> platform.
> 
> This contains a mix of architected and IMP def events
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>   .../hisilicon/hip09/sys/smmu-v3-pmcg.json     | 42 +++++++++++++++++++
>   1 file changed, 42 insertions(+)
>   create mode 100644 tools/perf/pmu-events/arch/arm64/hisilicon/hip09/sys/smmu-v3-pmcg.json
> 
> diff --git a/tools/perf/pmu-events/arch/arm64/hisilicon/hip09/sys/smmu-v3-pmcg.json b/tools/perf/pmu-events/arch/arm64/hisilicon/hip09/sys/smmu-v3-pmcg.json
> new file mode 100644
> index 000000000000..8abafbb2dcb4
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/hisilicon/hip09/sys/smmu-v3-pmcg.json
> @@ -0,0 +1,42 @@
> +[
> +   {
> +	    "ArchStdEvent": "smmuv3_pmcg.CYCLES"
> +	    "Compat": "0x00030736"
> +   },
> +   {
> +	    "ArchStdEvent": "smmuv3_pmcg.TRANSACTION"
> +	    "Compat": "0x00030736"
> +   },
> +   {
> +	    "ArchStdEvent": "smmuv3_pmcg.TLB_MISS"
> +	    "Compat": "0x00030736"
> +   },
> +   {
> +	    "ArchStdEvent": "smmuv3_pmcg.CONFIG_CACHE_MISS"
> +	    "Compat": "0x00030736"
> +   },
> +   {
> +	    "ArchStdEvent": "smmuv3_pmcg.TRANS_TABLE_WALK_ACCESS"
> +	    "Compat": "0x00030736"
> +   },
> +   {
> +	    "ArchStdEvent": "smmuv3_pmcg.CONFIG_STRUCT_ACCESS"
> +	    "Compat": "0x00030736"
> +   },
> +   {
> +	    "ArchStdEvent": "smmuv3_pmcg.PCIE_ATS_TRANS_RQ"
> +	    "Compat": "0x00030736"
> +   },
> +   {
> +	    "ArchStdEvent": "smmuv3_pmcg.PCIE_ATS_TRANS_PASSED"
> +	    "Compat": "0x00030736"
> +   },
> +   {
> +	    "EventCode": "0x8a",
> +	    "EventName": "smmuv3_pmcg.L1_TLB",
> +	    "BriefDescription": "SMMUv3 PMCG L1 TABLE transation",
> +	    "PublicDescription": "SMMUv3 PMCG L1 TABLE transation",

Those typos are either missing "c"s or "l"s, but with SMMU it's never 
clear which ;)

Robin.

> +	    "Unit": "smmuv3_pmcg",
> +	    "Compat": "0x00030736"
> +   },
> +]
> 
