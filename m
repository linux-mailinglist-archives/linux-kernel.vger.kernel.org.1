Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F56E2ED166
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 15:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728763AbhAGOGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 09:06:43 -0500
Received: from foss.arm.com ([217.140.110.172]:33306 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727711AbhAGOGn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 09:06:43 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD7F1D6E;
        Thu,  7 Jan 2021 06:05:57 -0800 (PST)
Received: from [10.57.37.195] (unknown [10.57.37.195])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2EE9C3F70D;
        Thu,  7 Jan 2021 06:05:54 -0800 (PST)
Subject: Re: [PATCH 11/11] dts: bindings: Document device tree binding for Arm
 TRBE
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Rob Herring <robh@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Linu Cherian <lcherian@marvell.com>, devicetree@vger.kernel.org
References: <1608717823-18387-1-git-send-email-anshuman.khandual@arm.com>
 <1608717823-18387-12-git-send-email-anshuman.khandual@arm.com>
 <20210103170540.GA4055084@robh.at.kernel.org>
 <21536a1c-0878-a390-aff3-fc2300be6941@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <d384e24f-f218-a207-ef8d-0857393277fc@arm.com>
Date:   Thu, 7 Jan 2021 14:05:48 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <21536a1c-0878-a390-aff3-fc2300be6941@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/4/21 3:44 AM, Anshuman Khandual wrote:
> 
> On 1/3/21 10:35 PM, Rob Herring wrote:
>> On Wed, Dec 23, 2020 at 03:33:43PM +0530, Anshuman Khandual wrote:
>>> This patch documents the device tree binding in use for Arm TRBE.
>>>
>>> Cc: devicetree@vger.kernel.org
>>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>>> Cc: Mike Leach <mike.leach@linaro.org>
>>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>> ---
>>> Changes in V1:
>>>
>>> - TRBE DT entry has been renamed as 'arm, trace-buffer-extension'
>>>
>>>   Documentation/devicetree/bindings/arm/trbe.txt | 20 ++++++++++++++++++++
>>>   1 file changed, 20 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/arm/trbe.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/arm/trbe.txt b/Documentation/devicetree/bindings/arm/trbe.txt
>>> new file mode 100644
>>> index 0000000..001945d
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/arm/trbe.txt
>>> @@ -0,0 +1,20 @@
>>> +* Trace Buffer Extension (TRBE)
>>> +
>>> +Trace Buffer Extension (TRBE) is used for collecting trace data generated
>>> +from a corresponding trace unit (ETE) using an in memory trace buffer.
>>> +
>>> +** TRBE Required properties:
>>> +
>>> +- compatible : should be one of:
>>> +	       "arm,trace-buffer-extension"
>>> +
>>> +- interrupts : Exactly 1 PPI must be listed. For heterogeneous systems where
>>> +	       TRBE is only supported on a subset of the CPUs, please consult
>>> +	       the arm,gic-v3 binding for details on describing a PPI partition.
>>> +
>>> +** Example:
>>> +
>>> +trbe {
>>> +	compatible = "arm,trace-buffer-extension";
>>> +	interrupts = <GIC_PPI 15 IRQ_TYPE_LEVEL_HIGH>;
>>
>> If only an interrupt, then could just be part of ETE? If not, how is
>> this hardware block accessed? An interrupt alone is not enough unless
>> there's some architected way to access.
> 
> TRBE hardware block is accessed via respective new system registers but the
> PPI number where the IRQ will be triggered for various buffer events, would
> depend on the platform as defined in the SBSA.

That is correct. TRBE is accessed via CPU system registers. The IRQ is specifically
for the TRBE unit to handle buffer overflow situations and other errors in the
buffer handling. Please include this information in the description section of
the bindings.

Also, it may be worth switching this to yaml format.

Suzuki
