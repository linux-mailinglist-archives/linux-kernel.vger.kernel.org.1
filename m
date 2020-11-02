Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9B932A363B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 23:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725864AbgKBWEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 17:04:22 -0500
Received: from foss.arm.com ([217.140.110.172]:38388 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725777AbgKBWEV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 17:04:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C74B11FB;
        Mon,  2 Nov 2020 14:04:20 -0800 (PST)
Received: from [10.57.20.162] (unknown [10.57.20.162])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 916113F719;
        Mon,  2 Nov 2020 14:04:18 -0800 (PST)
Subject: Re: [PATCH v3 06/26] coresight: etm4x: Handle access to TRCSSPCICRn
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, mike.leach@linaro.org,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
References: <20201028220945.3826358-1-suzuki.poulose@arm.com>
 <20201028220945.3826358-8-suzuki.poulose@arm.com>
 <20201102214633.GD2749502@xps15>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <69e31875-10e5-2cd1-dd2d-0b63b1427c65@arm.com>
Date:   Mon, 2 Nov 2020 22:04:16 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201102214633.GD2749502@xps15>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/2/20 9:46 PM, Mathieu Poirier wrote:
> Hi Suzuki,
> 
> On Wed, Oct 28, 2020 at 10:09:25PM +0000, Suzuki K Poulose wrote:
>> TRCSSPCICR<n> is present only if all of the following are true:
>> 	TRCIDR4.NUMSSCC > n.
>> 	TRCIDR4.NUMPC > 0b0000 .
>> 	TRCSSCSR<n>.PC == 0b1
>>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>   drivers/hwtracing/coresight/coresight-etm4x-core.c | 13 ++++++++-----
>>   1 file changed, 8 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> index d78a37b6592c..0310eac9dc16 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> @@ -175,8 +175,9 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
>>   			       drvdata->base + TRCSSCCRn(i));
>>   		writel_relaxed(config->ss_status[i],
>>   			       drvdata->base + TRCSSCSRn(i));
>> -		writel_relaxed(config->ss_pe_cmp[i],
>> -			       drvdata->base + TRCSSPCICRn(i));
>> +		if (drvdata->nr_pe)
> 
> Aren't you missing to check the value of the PC bit in TRCSSCSRn?
> 
>                  /*
>                   * TRCSSCSRn:PC, bit[3]: Indidate support for single-shot PE
>                   * comparator input.
>                   */
>                  if (drvdata->nr_pe && (config->ss_status[i] & BIT(3)))
> 
> 

You're right. Thank for catching this. I will update the series and drop
the patches 1-5.


> I have picked up patches 1 to 5 and added a "Cc:stable" to paches 2, 4 and 5.
> More comments to come tomorrow.

Thanks !
Suzuki
