Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6CA2FB27A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 08:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730383AbhASHH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 02:07:57 -0500
Received: from foss.arm.com ([217.140.110.172]:40744 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729489AbhASHGJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 02:06:09 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D13E71FB;
        Mon, 18 Jan 2021 23:05:21 -0800 (PST)
Received: from [10.57.40.145] (unknown [10.57.40.145])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 55B633F66E;
        Mon, 18 Jan 2021 23:05:18 -0800 (PST)
Subject: Re: [PATCH v1 1/7] coresight: etm-perf: Add support for PID tracing
 for kernel at EL2
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
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
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Al Grant <al.grant@arm.com>
References: <20210109074435.626855-1-leo.yan@linaro.org>
 <20210109074435.626855-2-leo.yan@linaro.org> <20210115223043.GA375055@xps15>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <b147f348-1f87-31f9-7941-fca5a76c71f4@arm.com>
Date:   Tue, 19 Jan 2021 07:05:10 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210115223043.GA375055@xps15>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu

On 1/15/21 10:30 PM, Mathieu Poirier wrote:
> Hey guys,
> 
> On Sat, Jan 09, 2021 at 03:44:29PM +0800, Leo Yan wrote:
>> From: Suzuki K Poulose <suzuki.poulose@arm.com>
>>
>> When the kernel is running at EL2, the PID is stored in CONTEXTIDR_EL2.
>> So, tracing CONTEXTIDR_EL1 doesn't give us the pid of the process.
>> Thus we should trace the VMID with VMIDOPT set to trace
>> CONTEXTIDR_EL2 instead of CONTEXTIDR_EL1. Given that we have an existing
>> config option "contextid" and this will be useful for tracing
>> virtual machines (when we get to support virtualization). So instead,
>> this patch adds a new option, contextid_in_vmid as a separate config.
>> Thus on an EL2 kernel, we will have two options available for
>> the perf tool. However, to make it easier for the user to
>> do pid tracing, we add a new format which will default to
>> "contextid" (on EL1 kernel) or "contextid_in_vmid" (on EL2
>> kernel). So that the user doesn't have to bother which EL the
>> kernel is running.
>>
>>   i.e, perf record -e cs_etm/pid/u --
>>
>> will always do the "pid" tracing, independent of the kernel EL.
>>
>> Also, the perf tool will be updated to automatically select
>> "pid" config instead of the "contextid" for system wide/CPU wide
>> mode.
>>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Cc: Al Grant <al.grant@arm.com>
>> Cc: Mike Leach <mike.leach@linaro.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> Signed-off-by: Leo Yan <leo.yan@linaro.org>
>> ---
>>   drivers/hwtracing/coresight/coresight-etm-perf.c   | 14 ++++++++++++++
>>   drivers/hwtracing/coresight/coresight-etm4x-core.c |  9 +++++++++
>>   include/linux/coresight-pmu.h                      | 11 +++++++----
>>   3 files changed, 30 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
>> index bdc34ca449f7..f763def145e4 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
>> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
>> @@ -30,14 +30,28 @@ static DEFINE_PER_CPU(struct coresight_device *, csdev_src);
>>   /* ETMv3.5/PTM's ETMCR is 'config' */
>>   PMU_FORMAT_ATTR(cycacc,		"config:" __stringify(ETM_OPT_CYCACC));
>>   PMU_FORMAT_ATTR(contextid,	"config:" __stringify(ETM_OPT_CTXTID));
>> +PMU_FORMAT_ATTR(contextid_in_vmid,	"config:" __stringify(ETM_OPT_CTXTID_IN_VMID));
> 
> I am not convinced adding this new contextid_in_vmid is the best way forward.
> 
>>   PMU_FORMAT_ATTR(timestamp,	"config:" __stringify(ETM_OPT_TS));
>>   PMU_FORMAT_ATTR(retstack,	"config:" __stringify(ETM_OPT_RETSTK));
>>   /* Sink ID - same for all ETMs */
>>   PMU_FORMAT_ATTR(sinkid,		"config2:0-31");
>>   
>> +static ssize_t format_attr_pid_show(struct device *dev,
>> +				    struct device_attribute *attr,
>> +				    char *page)
>> +{
>> +	int pid_fmt = is_kernel_in_hyp_mode() ? ETM_OPT_CTXTID_IN_VMID : ETM_OPT_CTXTID;
>> +
>> +	return sprintf(page, "config:%d\n", pid_fmt);
>> +}
>> +
>> +struct device_attribute format_attr_pid = __ATTR(pid, 0444, format_attr_pid_show, NULL);
> 
> The same applies here.  PMU format bits are options the PMU supports rather than
> a representation of the hardware, making bit numbering arbitrary.  A such we
> don't explicitly need a contextid_in_vmid option.  Making the current contextid
> variable, the same it was done for 'pid', should be sufficient.  Based on the
> value carried by contexid, i.e 14 or 15, the perf tools will know where to get
> the contextID.
> 
> With regards to backward functionality, user who hard code 'config' on the perf
> command line won't get the results they want when the kernel is at EL2 anyway.
> 
> The kernel, with function is_kernel_in_hyp_mode(), is not an issue.

I did think about that. The reason behind using a new alias is vaguely mentioned
in the description. If a host perf session wants to trace a VM with the contextid_el1,
there is no option for that with "contextid" flipped to trace "contextid_el2".
This is precisely why I preferred keeping both the hardware configurations
and let the kernel choose the right one for the EL, by having an alias.
i.e,

perf record -e cs_etm/contextid,contextid_in_vmid/ vm

could still trace the VM vcpu threads and the CID changes within
the VM. (This is triggered from the host, so VM support is not necessary).

If we decide not to do this, or change the meaning of contextid now
to mean "pid" and change it in the future back to what it really
means for supporting such scenarios above, then we are going to
be back where we are with the proposal.


Suzuki
