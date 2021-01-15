Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAA2F2F70A4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 03:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732082AbhAOChA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 21:37:00 -0500
Received: from foss.arm.com ([217.140.110.172]:59178 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbhAOCg7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 21:36:59 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3801FD6E;
        Thu, 14 Jan 2021 18:36:14 -0800 (PST)
Received: from [192.168.0.130] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7FF153F66E;
        Thu, 14 Jan 2021 18:36:11 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH V2 08/11] coresight: core: Add support for dedicated
 percpu sinks
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org
Cc:     mathieu.poirier@linaro.org, mike.leach@linaro.org,
        Linu Cherian <lcherian@marvell.com>,
        linux-kernel@vger.kernel.org
References: <1610511498-4058-1-git-send-email-anshuman.khandual@arm.com>
 <1610511498-4058-9-git-send-email-anshuman.khandual@arm.com>
 <83939b79-31de-2984-7418-7e4c026dba3a@arm.com>
Message-ID: <6dc0baeb-cc9b-562b-ac4d-03fe894be099@arm.com>
Date:   Fri, 15 Jan 2021 08:06:31 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <83939b79-31de-2984-7418-7e4c026dba3a@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/13/21 3:13 PM, Suzuki K Poulose wrote:
> On 1/13/21 4:18 AM, Anshuman Khandual wrote:
>> Add support for dedicated sinks that are bound to individual CPUs. (e.g,
>> TRBE). To allow quicker access to the sink for a given CPU bound source,
>> keep a percpu array of the sink devices. Also, add support for building
>> a path to the CPU local sink from the ETM.
>>
>> This adds a new percpu sink type CORESIGHT_DEV_SUBTYPE_SINK_PERCPU_SYSMEM.
>> This new sink type is exclusively available and can only work with percpu
>> source type device CORESIGHT_DEV_SUBTYPE_SOURCE_PERCPU_PROC.
>>
>> This defines a percpu structure that accommodates a single coresight_device
>> which can be used to store an initialized instance from a sink driver. As
>> these sinks are exclusively linked and dependent on corresponding percpu
>> sources devices, they should also be the default sink device during a perf
>> session.
>>
>> Outwards device connections are scanned while establishing paths between a
>> source and a sink device. But such connections are not present for certain
>> percpu source and sink devices which are exclusively linked and dependent.
>> Build the path directly and skip connection scanning for such devices.
>>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Cc: Mike Leach <mike.leach@linaro.org>
>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>   drivers/hwtracing/coresight/coresight-core.c | 14 ++++++++++++++
>>   include/linux/coresight.h                    | 12 ++++++++++++
>>   2 files changed, 26 insertions(+)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
>> index 0062c89..b300606 100644
>> --- a/drivers/hwtracing/coresight/coresight-core.c
>> +++ b/drivers/hwtracing/coresight/coresight-core.c
>> @@ -23,6 +23,7 @@
>>   #include "coresight-priv.h"
>>     static DEFINE_MUTEX(coresight_mutex);
>> +DEFINE_PER_CPU(struct coresight_device *, csdev_sink);
>>     /**
>>    * struct coresight_node - elements of a path, from source to sink
>> @@ -784,6 +785,13 @@ static int _coresight_build_path(struct coresight_device *csdev,
>>       if (csdev == sink)
>>           goto out;
>>   +    if (coresight_is_percpu_source(csdev) && coresight_is_percpu_sink(sink) &&
>> +        sink == per_cpu(csdev_sink, source_ops(csdev)->cpu_id(csdev))) {
>> +        _coresight_build_path(sink, sink, path);
>> +        found = true;
>> +        goto out;
>> +    }
>> +
>>       /* Not a sink - recursively explore each port found on this element */
>>       for (i = 0; i < csdev->pdata->nr_outport; i++) {
>>           struct coresight_device *child_dev;
>> @@ -998,6 +1006,12 @@ coresight_find_default_sink(struct coresight_device *csdev)
>>   {
>>       int depth = 0;
>>   +    if (coresight_is_percpu_source(csdev)) {
> 
> On a system without per_cpu sink, this would reset the default sink for the source device
> every single time and fallback to searching every single time.

Right.

> So I think it would be better if did check if the def_sink was not set.
> We could fold this into the case below may be. i.e,
> 
> 
>     if (!csdev->def_sink) {
>         if (coresight_is_percpu_source(csdev))
>             csdev->def_sink = per_cpu(csdev_sink, source_ops(csdev)->cpu_id(csdev));
>         if (!csdev->def_sink)            csdev->def_sink = coresight_find_sink(csdev, &depth);
>     }
> 
> Otherwise looks good to me.

struct coresight_device *
coresight_find_default_sink(struct coresight_device *csdev)
{
        int depth = 0;

        /* look for a default sink if we have not found for this device */
        if (!csdev->def_sink) {
                if (coresight_is_percpu_source(csdev))
                        csdev->def_sink = per_cpu(csdev_sink, source_ops(csdev)->cpu_id(csdev));
                if (!csdev->def_sink)
                        csdev->def_sink = coresight_find_sink(csdev, &depth);
        }
        return csdev->def_sink;
}

Would this be better instead ? coresight_find_sink() is invoked both when the
source is not percpu (traditional coresight sources) and also as a fallback in
case a percpu sink is not found for the percpu source device.
