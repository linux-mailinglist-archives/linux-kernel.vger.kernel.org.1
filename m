Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E51B2E8FA2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 04:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbhADDpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 22:45:06 -0500
Received: from foss.arm.com ([217.140.110.172]:50586 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725840AbhADDpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 22:45:06 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 320B9101E;
        Sun,  3 Jan 2021 19:44:20 -0800 (PST)
Received: from [192.168.0.130] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F1D323F66E;
        Sun,  3 Jan 2021 19:44:16 -0800 (PST)
Subject: Re: [PATCH 11/11] dts: bindings: Document device tree binding for Arm
 TRBE
To:     Rob Herring <robh@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Linu Cherian <lcherian@marvell.com>, devicetree@vger.kernel.org
References: <1608717823-18387-1-git-send-email-anshuman.khandual@arm.com>
 <1608717823-18387-12-git-send-email-anshuman.khandual@arm.com>
 <20210103170540.GA4055084@robh.at.kernel.org>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <21536a1c-0878-a390-aff3-fc2300be6941@arm.com>
Date:   Mon, 4 Jan 2021 09:14:24 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210103170540.GA4055084@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/3/21 10:35 PM, Rob Herring wrote:
> On Wed, Dec 23, 2020 at 03:33:43PM +0530, Anshuman Khandual wrote:
>> This patch documents the device tree binding in use for Arm TRBE.
>>
>> Cc: devicetree@vger.kernel.org
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Cc: Mike Leach <mike.leach@linaro.org>
>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>> Changes in V1:
>>
>> - TRBE DT entry has been renamed as 'arm, trace-buffer-extension'
>>
>>  Documentation/devicetree/bindings/arm/trbe.txt | 20 ++++++++++++++++++++
>>  1 file changed, 20 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/arm/trbe.txt
>>
>> diff --git a/Documentation/devicetree/bindings/arm/trbe.txt b/Documentation/devicetree/bindings/arm/trbe.txt
>> new file mode 100644
>> index 0000000..001945d
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/trbe.txt
>> @@ -0,0 +1,20 @@
>> +* Trace Buffer Extension (TRBE)
>> +
>> +Trace Buffer Extension (TRBE) is used for collecting trace data generated
>> +from a corresponding trace unit (ETE) using an in memory trace buffer.
>> +
>> +** TRBE Required properties:
>> +
>> +- compatible : should be one of:
>> +	       "arm,trace-buffer-extension"
>> +
>> +- interrupts : Exactly 1 PPI must be listed. For heterogeneous systems where
>> +	       TRBE is only supported on a subset of the CPUs, please consult
>> +	       the arm,gic-v3 binding for details on describing a PPI partition.
>> +
>> +** Example:
>> +
>> +trbe {
>> +	compatible = "arm,trace-buffer-extension";
>> +	interrupts = <GIC_PPI 15 IRQ_TYPE_LEVEL_HIGH>;
> 
> If only an interrupt, then could just be part of ETE? If not, how is 
> this hardware block accessed? An interrupt alone is not enough unless 
> there's some architected way to access.

TRBE hardware block is accessed via respective new system registers but the
PPI number where the IRQ will be triggered for various buffer events, would
depend on the platform as defined in the SBSA.

TRBE would need a ETE to work but the reverse is not true. ETE might just
be present without a corresponding TRBE and can work with traditional sinks.
Hence just wondering whether it would be prudent to add the TRBE interrupt
number as part of the ETE DT specification.
