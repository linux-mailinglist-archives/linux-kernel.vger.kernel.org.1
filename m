Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1D32AD422
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 11:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728949AbgKJKva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 05:51:30 -0500
Received: from foss.arm.com ([217.140.110.172]:53812 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726706AbgKJKva (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 05:51:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CE66511D4;
        Tue, 10 Nov 2020 02:51:29 -0800 (PST)
Received: from [10.57.23.123] (unknown [10.57.23.123])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A4CC93F6CF;
        Tue, 10 Nov 2020 02:51:28 -0800 (PST)
Subject: Re: [PATCH v3 26/26] dts: bindings: coresight: ETM system register
 access only units
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, mike.leach@linaro.org,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
References: <20201028220945.3826358-1-suzuki.poulose@arm.com>
 <20201028220945.3826358-28-suzuki.poulose@arm.com>
 <20201109205000.GE3396611@xps15>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <54dc1426-d73a-27ed-45ad-d833853fe20c@arm.com>
Date:   Tue, 10 Nov 2020 10:51:21 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.1
MIME-Version: 1.0
In-Reply-To: <20201109205000.GE3396611@xps15>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/9/20 8:50 PM, Mathieu Poirier wrote:
> On Wed, Oct 28, 2020 at 10:09:45PM +0000, Suzuki K Poulose wrote:
>> Document the bindings for ETMs with system register accesses.
>>
>> Cc: devicetree@vger.kernel.org
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Cc: Mike Leach <mike.leach@linaro.org>
>> Cc: Rob Herring <robh@kernel.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>   Documentation/devicetree/bindings/arm/coresight.txt | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/coresight.txt b/Documentation/devicetree/bindings/arm/coresight.txt
>> index d711676b4a51..bff96a550102 100644
>> --- a/Documentation/devicetree/bindings/arm/coresight.txt
>> +++ b/Documentation/devicetree/bindings/arm/coresight.txt
>> @@ -34,9 +34,12 @@ its hardware characteristcs.
>>   					Program Flow Trace Macrocell:
>>   			"arm,coresight-etm3x", "arm,primecell";
>>   
>> -		- Embedded Trace Macrocell (version 4.x):
>> +		- Embedded Trace Macrocell (version 4.x), with memory mapped access.
>>   			"arm,coresight-etm4x", "arm,primecell";
>>   
>> +		- Embedded Trace Macrocell with system register access only.
>> +			"arm,coresight-etm-sysreg";
> 
> Please make this "arm,coresight-etm4x-sysreg".  Up to now all reference of
> "etm" without a version related to ETMv3/PTM1.1.  If we start mixing things it
> will be come insanely confusing.

Agreed. will rename it.

Suzuki
