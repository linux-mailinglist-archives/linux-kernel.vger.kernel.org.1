Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC6D62C24B4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 12:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732935AbgKXLjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 06:39:05 -0500
Received: from foss.arm.com ([217.140.110.172]:56020 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727909AbgKXLjE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 06:39:04 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 327B21396;
        Tue, 24 Nov 2020 03:39:04 -0800 (PST)
Received: from [10.57.56.151] (unknown [10.57.56.151])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 18A623F71F;
        Tue, 24 Nov 2020 03:39:00 -0800 (PST)
Subject: Re: [PATCH v4 20/25] coresight: etm4x: Detect system instructions
 support
To:     Tingwei Zhang <tingweiz@codeaurora.org>
Cc:     anshuman.khandual@arm.com, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jonathan.zhouwen@huawei.com, mike.leach@linaro.org
References: <20201119164547.2982871-1-suzuki.poulose@arm.com>
 <20201119164547.2982871-21-suzuki.poulose@arm.com>
 <20201123075827.GA18352@codeaurora.org>
 <1c8d4b13-0c80-0bd3-29a6-dd586841377f@arm.com>
 <20201124004155.GA10220@codeaurora.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <bd1cf9ec-eeeb-90a1-beb8-23a39dfa3b2a@arm.com>
Date:   Tue, 24 Nov 2020 11:38:55 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201124004155.GA10220@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/24/20 12:41 AM, Tingwei Zhang wrote:
> On Mon, Nov 23, 2020 at 05:39:43PM +0800, Suzuki K Poulose wrote:
>> On 11/23/20 7:58 AM, Tingwei Zhang wrote:
>>> Hi Suzuki,
>>>
>>> On Fri, Nov 20, 2020 at 12:45:42AM +0800, Suzuki K Poulose wrote:
>>>> ETM v4.4 onwards adds support for system instruction access
>>>> to the ETM. Detect the support on an ETM and switch to using the
>>>> mode when available.
>>>>
>>>> Cc: Mike Leach <mike.leach@linaro.org>
>>>> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>>>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>>>> ---
>>>>   .../coresight/coresight-etm4x-core.c          | 39 +++++++++++++++++++
>>>>   1 file changed, 39 insertions(+)
>>>>
>>>> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c
>>>> b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>>>> index 7ac0a185c146..5cbea9c27f58 100644
>>>> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
>>>> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>>>> @@ -684,6 +684,37 @@ static const struct coresight_ops etm4_cs_ops = {
>>>>   	.source_ops	= &etm4_source_ops,
>>>>   };
>>>>
>>>> +static inline bool cpu_supports_sysreg_trace(void)
>>>> +{
>>>> +	u64 dfr0 = read_sysreg_s(SYS_ID_AA64DFR0_EL1);
>>>> +
>>>> +	return ((dfr0 >> ID_AA64DFR0_TRACEVER_SHIFT) & 0xfUL) > 0;
>>>> +}
>>>> +
>>>> +static bool etm4_init_sysreg_access(struct etmv4_drvdata *drvdata,
>>>> +				    struct csdev_access *csa)
>>>> +{
>>>> +	u32 devarch;
>>>> +
>>>> +	if (!cpu_supports_sysreg_trace())
>>>> +		return false;
>>>> +
>>>> +	/*
>>>> +	 * ETMs implementing sysreg access must implement TRCDEVARCH.
>>>> +	 */
>>>> +	devarch = read_etm4x_sysreg_const_offset(TRCDEVARCH);
>>>> +	if ((devarch & ETM_DEVARCH_ID_MASK) != ETM_DEVARCH_ETMv4x_ARCH)
>>>
>>> Is this driver suppose to work on ETM 5.0/ETE trace unit before ETE driver
>>> is ready?
>>
>> No, it is not supposed to work on an ETE without the ETE support. That check
>> ensures that we only detect ETMv4x for now. The ETE driver support adds the
>> ETE_ARCH as one of the supported ETMs. If you hack around it might still
>> probe,
>> but things could go terribly wrong if we access registers that are not
>> available
>> on ETE.
>>
>> Btw, are you able to test this series on an ETMv4.4+ system ?
>>
> I'm trying to test this series on an ETE. Look like it's not correct.
> I'll apply ETE patch on top of this and test.
> 

Yes please ! Much appreciated. Do you have a TRBE as well ? Or are you
using a legacy CoreSight topology ?

Kind regards
Suzuki
