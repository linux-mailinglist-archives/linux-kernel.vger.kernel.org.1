Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10F362BA6F4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 11:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgKTKDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 05:03:10 -0500
Received: from foss.arm.com ([217.140.110.172]:46302 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725952AbgKTKDJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 05:03:09 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D88621042;
        Fri, 20 Nov 2020 02:03:08 -0800 (PST)
Received: from [10.57.53.209] (unknown [10.57.53.209])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D9F7A3F70D;
        Fri, 20 Nov 2020 02:03:06 -0800 (PST)
Subject: Re: [PATCH v4 25/25] coresight: Add support for v8.4 SelfHosted
 tracing
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, linux-kernel@vger.kernel.org,
        anshuman.khandual@arm.com, jonathan.zhouwen@huawei.com,
        coresight@lists.linaro.org, Will Deacon <will@kernel.org>
References: <20201119164547.2982871-1-suzuki.poulose@arm.com>
 <20201119164547.2982871-26-suzuki.poulose@arm.com>
 <20201119172243.GF4376@gaia>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <cac71aef-e596-2e66-1fa0-2a5336cb270e@arm.com>
Date:   Fri, 20 Nov 2020 10:03:00 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201119172243.GF4376@gaia>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/19/20 5:22 PM, Catalin Marinas wrote:
> On Thu, Nov 19, 2020 at 04:45:47PM +0000, Suzuki K Poulose wrote:
>> From: Jonathan Zhou <jonathan.zhouwen@huawei.com>
>>
>> v8.4 tracing extensions added support for trace filtering controlled
>> by TRFCR_ELx. This must be programmed to allow tracing at EL1/EL2 and
>> EL0. The timestamp used is the virtual time. Also enable CONTEXIDR_EL2
>> tracing if we are running the kernel at EL2.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Cc: Mike Leach <mike.leach@linaro.org>
>> Cc: Will Deacon <will@kernel.org>
>> Signed-off-by: Jonathan Zhou <jonathan.zhouwen@huawei.com>
>> [ Move the trace filtering setup etm_init_arch_data() and
>>   clean ups]
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>   .../coresight/coresight-etm4x-core.c          | 25 +++++++++++++++++++
>>   1 file changed, 25 insertions(+)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> index 1d054d2ab2a0..647685736134 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> @@ -760,6 +760,30 @@ static bool etm4_init_csdev_access(struct etmv4_drvdata *drvdata,
>>   	return false;
>>   }
>>   
>> +static void cpu_enable_tracing(void)
>> +{
>> +	u64 dfr0 = read_sysreg(id_aa64dfr0_el1);
>> +	u64 trfcr;
>> +
>> +	if (!(dfr0 >> ID_AA64DFR0_TRACE_FILT_SHIFT))
>> +		return;
> 
> What if we get a new field at position 44 while the FILT one at 40 is 0?
> We should use cpuid_feature_extract_field() here.
> 

Bah, you're right. Sorry for that silly mistake. Thanks for spotting.

> BTW, can this function not go in the cpufeature.c code?

Yes, this could go there. The only reason for keeping this here
was that the ETM is the only Trace component we support.

Ideally, this should be performed at enable/disable of the ETM,
based on the "config" selected for the session. That way we can
be sure that nobody (read, a VM) traces the host kernel/el0 behind our back
(even though we would trap the access for now).

Suzuki
