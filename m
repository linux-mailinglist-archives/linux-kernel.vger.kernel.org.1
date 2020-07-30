Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 917BA2336E1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jul 2020 18:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730050AbgG3Qdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jul 2020 12:33:54 -0400
Received: from foss.arm.com ([217.140.110.172]:42294 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728473AbgG3Qdx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 12:33:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 38B3D1FB;
        Thu, 30 Jul 2020 09:33:53 -0700 (PDT)
Received: from [10.37.12.83] (unknown [10.37.12.83])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CF01C3F66E;
        Thu, 30 Jul 2020 09:33:51 -0700 (PDT)
Subject: Re: [RFC PATCH 14/14] dts: bindings: coresight: ETMv4.4 system
 register access only units
To:     mathieu.poirier@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mike.leach@linaro.org, coresight@lists.linaro.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org
References: <20200722172040.1299289-1-suzuki.poulose@arm.com>
 <20200722172040.1299289-15-suzuki.poulose@arm.com>
 <20200729172058.GA3060370@xps15>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <7036b8c5-b920-3de7-21d0-474e759e2624@arm.com>
Date:   Thu, 30 Jul 2020 17:38:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20200729172058.GA3060370@xps15>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/29/2020 06:20 PM, Mathieu Poirier wrote:
> On Wed, Jul 22, 2020 at 06:20:40PM +0100, Suzuki K Poulose wrote:
>> Document the bindings for ETMv4.4 and later with only system register
>> access.
>>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: devicetree@vger.kernel.org
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Cc: Mike Leach <mike.leach@linaro.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>   Documentation/devicetree/bindings/arm/coresight.txt | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/coresight.txt b/Documentation/devicetree/bindings/arm/coresight.txt
>> index d711676b4a51..cfe47bdda728 100644
>> --- a/Documentation/devicetree/bindings/arm/coresight.txt
>> +++ b/Documentation/devicetree/bindings/arm/coresight.txt
>> @@ -34,9 +34,13 @@ its hardware characteristcs.
>>   					Program Flow Trace Macrocell:
>>   			"arm,coresight-etm3x", "arm,primecell";
>>   
>> -		- Embedded Trace Macrocell (version 4.x):
>> +		- Embedded Trace Macrocell (version 4.x), with memory mapped access.
>>   			"arm,coresight-etm4x", "arm,primecell";
>>   
>> +		- Embedded Trace Macrocell (version 4.4 and later) with system
>> +		  register access only.
>> +			"arm,coresight-etm-v4.4";
> 
> I would rather call this "arm,coresight-etm-v4.4+" so that the binding's
> semantic is still relevant when dealing with ETM v4.5 and onward.

AFAIUC, "compatible" stands for something that is compatible with v4.4.
All v4.4+ versions that are compatible with v4.4 are covered here.
Having said that I am fine with "arm,coresight-etm-v4.4+" , if it
is fine by the DT conventions.

Cheers
Suzuki
