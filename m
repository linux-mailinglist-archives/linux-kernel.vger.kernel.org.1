Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74C622F636F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 15:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729114AbhANOsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 09:48:36 -0500
Received: from foss.arm.com ([217.140.110.172]:50956 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726175AbhANOsf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 09:48:35 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 789EE1FB;
        Thu, 14 Jan 2021 06:47:49 -0800 (PST)
Received: from [10.57.56.97] (unknown [10.57.56.97])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6FA283F70D;
        Thu, 14 Jan 2021 06:47:47 -0800 (PST)
Subject: Re: [PATCH V2 11/11] dts: bindings: Document device tree bindings for
 Arm TRBE
To:     Rob Herring <robh@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        Linu Cherian <lcherian@marvell.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <1610511498-4058-1-git-send-email-anshuman.khandual@arm.com>
 <1610511498-4058-12-git-send-email-anshuman.khandual@arm.com>
 <20210114140754.GA2816889@robh.at.kernel.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <54b49858-3475-f3db-7c81-f0a251a261af@arm.com>
Date:   Thu, 14 Jan 2021 14:47:37 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210114140754.GA2816889@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/14/21 2:07 PM, Rob Herring wrote:
> On Wed, Jan 13, 2021 at 09:48:18AM +0530, Anshuman Khandual wrote:
>> From: Suzuki K Poulose <suzuki.poulose@arm.com>
>>
>> Document the device tree bindings for Trace Buffer Extension (TRBE).
>>
>> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Cc: Rob Herring <robh@kernel.org>
>> Cc: devicetree@vger.kernel.org
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>   Documentation/devicetree/bindings/arm/trbe.yaml | 46 +++++++++++++++++++++++++
>>   1 file changed, 46 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/arm/trbe.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/arm/trbe.yaml b/Documentation/devicetree/bindings/arm/trbe.yaml
>> new file mode 100644
>> index 0000000..2258595
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/trbe.yaml
>> @@ -0,0 +1,46 @@
>> +# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
>> +# Copyright 2021, Arm Ltd
>> +%YAML 1.2
>> +---
>> +$id: "http://devicetree.org/schemas/arm/trbe.yaml#"
>> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
>> +
>> +title: ARM Trace Buffer Extensions
>> +
>> +maintainers:
>> +  - Anshuman Khandual <anshuman.khandual@arm.com>
>> +
>> +description: |
>> +  Description of TRBE hw
> 
> Huh?
> 

Doh ! That was due to a miscommunication between us.
This should be :

description: |
   Arm Trace Buffer Extension (TRBE) is a per CPU component
   for storing trace generated on the CPU to memory. It is
   accessed via CPU system registers. The software can verify
   if it is permitted to use the component by checking the
   TRBIDR register.

>> +
>> +properties:
>> +  $nodename:
>> +    pattern: "trbe"
> 
> const: trbe
> 
>> +  compatible:
>> +    items:
>> +      - const: arm,trace-buffer-extension
> 
> Any versioning to this? Or is that discoverable?
> 

It must be discoverable via ID_AA64DFR0_EL1.TraceBuffer.
The IP is entirely accessed by the CPU system registers. So, any
further changes can be interpreted from the system registers
(including if the access is blocked by a higher exception level).

>> +
>> +  interrupts:
>> +    description: |
>> +       Exactly 1 PPI must be listed. For heterogeneous systems where
>> +       TRBE is only supported on a subset of the CPUs, please consult
>> +       the arm,gic-v3 binding for details on describing a PPI partition.
>> +    maxItems: 1
>> +
>> +required:
>> +  - compatible
>> +  - interrupts
>> +
>> +additionalProperties: false
>> +
>> +
> 
> Extra blank line.

Removed.

Cheers

Suzuki
