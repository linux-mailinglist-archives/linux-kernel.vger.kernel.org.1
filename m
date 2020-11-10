Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D96B92AD337
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 11:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729279AbgKJKLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 05:11:32 -0500
Received: from foss.arm.com ([217.140.110.172]:53248 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726462AbgKJKLc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 05:11:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 61C3C11D4;
        Tue, 10 Nov 2020 02:11:31 -0800 (PST)
Received: from [10.57.23.123] (unknown [10.57.23.123])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 58AC53F6CF;
        Tue, 10 Nov 2020 02:11:30 -0800 (PST)
Subject: Re: [PATCH v3 22/26] coresight: etm4x: Add necessary synchronization
 for sysreg access
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, mike.leach@linaro.org,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
References: <20201028220945.3826358-1-suzuki.poulose@arm.com>
 <20201028220945.3826358-24-suzuki.poulose@arm.com>
 <20201109183255.GA3396611@xps15>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <7370dc60-ca9c-7b58-0b56-6fcef628304f@arm.com>
Date:   Tue, 10 Nov 2020 10:11:23 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.1
MIME-Version: 1.0
In-Reply-To: <20201109183255.GA3396611@xps15>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/9/20 6:32 PM, Mathieu Poirier wrote:
> On Wed, Oct 28, 2020 at 10:09:41PM +0000, Suzuki K Poulose wrote:
>> As per the specification any update to the TRCPRGCTLR must be synchronized
>> by a context synchronization event (in our case an explicist ISB) before
>> the TRCSTATR is checked.
>>
>> Cc: Mike Leach <mike.leach@linaro.org>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>   drivers/hwtracing/coresight/coresight-etm4x-core.c | 13 +++++++++++++
>>   1 file changed, 13 insertions(+)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> index e36bc1c722c7..4bc2f15b6332 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> @@ -178,6 +178,15 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
>>   	/* Disable the trace unit before programming trace registers */
>>   	etm4x_relaxed_write32(csa, 0, TRCPRGCTLR);
>>   
>> +	/*
>> +	 * If we use system instructions, we need to synchronize the
>> +	 * write to the TRCPRGCTLR, before accessing the TRCSTATR.
>> +	 * See ARM IHI0064F, section
>> +	 * "4.3.7 Synchronization of register updates"
>> +	 */
>> +	if (!csa->io_mem)
>> +		isb();
>> +
> 
> When I first read the documentation on system instruction section 4.3.7 really
> got me thinking...
> 
> At the very top, right after the title "Synchronization of register updates" one
> can read "Software running on the PE...".  Later in the text, when specifying
> the synchronisation rules, the term "trace analyzer" is used.  _Typically_ a trace
> analyzer is an external box.
> 

Very good point. The trace analyzer could still use the system register
to program the ETM and causing a context synchronization event is tricky
from within the trace analyzer. And I agree that there is a bit of
confusion around the synchronization from a self-hosted point of view.
I believe this is true for the self-hosted case too and should be
clarified in the TRM.

> Arm documentation is precise and usually doesn't overlook that kind of detail.
> The question is to understand if a context synchronisation event is also needed
> when programming is done on the PE.  If so I think the documentation should be
> amended.
> 
> In that case:
> 
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> 

Thanks
Suzuki
