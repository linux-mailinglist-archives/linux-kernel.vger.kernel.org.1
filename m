Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFCAE2AD282
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 10:32:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729938AbgKJJbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 04:31:52 -0500
Received: from foss.arm.com ([217.140.110.172]:52722 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727991AbgKJJbv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 04:31:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 840DBD6E;
        Tue, 10 Nov 2020 01:31:50 -0800 (PST)
Received: from [10.57.23.123] (unknown [10.57.23.123])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3833A3F6CF;
        Tue, 10 Nov 2020 01:31:49 -0800 (PST)
Subject: Re: [PATCH v3 23/26] coresight: etm4x: Detect system instructions
 support
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, mike.leach@linaro.org,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
References: <20201028220945.3826358-1-suzuki.poulose@arm.com>
 <20201028220945.3826358-25-suzuki.poulose@arm.com>
 <20201109202205.GB3396611@xps15>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <b4a4bd73-00c5-a921-3f01-7100d2a0edf8@arm.com>
Date:   Tue, 10 Nov 2020 09:31:42 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.1
MIME-Version: 1.0
In-Reply-To: <20201109202205.GB3396611@xps15>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/9/20 8:22 PM, Mathieu Poirier wrote:
> On Wed, Oct 28, 2020 at 10:09:42PM +0000, Suzuki K Poulose wrote:
>> ETM v4.4 onwards adds support for system instruction access
>> to the ETM. Detect the support on an ETM and switch to using the
>> mode when available.
>>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>   .../coresight/coresight-etm4x-core.c          | 39 +++++++++++++++++++
>>   1 file changed, 39 insertions(+)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> index 4bc2f15b6332..dc537b5612eb 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> @@ -675,6 +675,37 @@ static const struct coresight_ops etm4_cs_ops = {
>>   	.source_ops	= &etm4_source_ops,
>>   };
>>   
>> +static inline bool cpu_supports_sysreg_trace(void)
>> +{
>> +	u64 dfr0 = read_sysreg_s(SYS_ID_AA64DFR0_EL1);
>> +
>> +	return ((dfr0 >> ID_AA64DFR0_TRACEVER_SHIFT) & 0xfUL) > 0;
> 
> I would do:
> 
>          return ((dfr0 >> ID_AA64DFR0_TRACEVER_SHIFT) & 0xfUL) == 1;
> 
> Because any other value than '1' are reserved.

Correct. However, this is something we follow for all ID features
in the arm64 kernel and is clarified in the Arm ARM (ARM DDI 0487F.a) :

"D13.1.3 Principles of the ID scheme for fields in ID registers"

Which guarantees that a (field  > n) implies, everything that field == n
is implied. (Well there are exceptions listed in the section, but
TRACEVER is not one of those). So this should cover an old kernel
running on a future CPU, using the features that it understands.
(See feature_matches() in arch/arm64/kernel/cpufeature.c, which is
the fundamental logic to detect a feature).

Please let me know if you're OK with the justification.

Thanks for the review.

Suzuki
