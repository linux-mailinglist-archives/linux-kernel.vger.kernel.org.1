Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D25832C02DE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 10:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728585AbgKWJ4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 04:56:38 -0500
Received: from foss.arm.com ([217.140.110.172]:39282 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728571AbgKWJ4h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 04:56:37 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD6E1101E;
        Mon, 23 Nov 2020 01:56:36 -0800 (PST)
Received: from [10.57.53.209] (unknown [10.57.53.209])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5C8B83F70D;
        Mon, 23 Nov 2020 01:56:35 -0800 (PST)
Subject: Re: [RFC 06/11] coresight: ete: Detect ETE as one of the supported
 ETMs
To:     Tingwei Zhang <tingweiz@codeaurora.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     coresight@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, mike.leach@linaro.org
References: <1605012309-24812-1-git-send-email-anshuman.khandual@arm.com>
 <1605012309-24812-7-git-send-email-anshuman.khandual@arm.com>
 <20201114053650.GA28964@codeaurora.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <4b03b32c-edca-a19a-e10e-40d6fcd3cfcd@arm.com>
Date:   Mon, 23 Nov 2020 09:56:28 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201114053650.GA28964@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tingwei,


On 11/14/20 5:36 AM, Tingwei Zhang wrote:
> Hi Anshuman,
> 
> On Tue, Nov 10, 2020 at 08:45:04PM +0800, Anshuman Khandual wrote:
>> From: Suzuki K Poulose <suzuki.poulose@arm.com>
>>
>> Add ETE as one of the supported device types we support
>> with ETM4x driver. The devices are named following the
>> existing convention as ete<N>.
>>
>> ETE mandates that the trace resource status register is programmed
>> before the tracing is turned on. For the moment simply write to
>> it indicating TraceActive.
>>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---

>> @@ -1742,6 +1758,19 @@ static int etm4_probe(struct device *dev, void
>> __iomem *base)
>>   	if (!desc.access.io_mem ||
>>   	    fwnode_property_present(dev_fwnode(dev), "qcom,skip-power-up"))
>>   		drvdata->skip_power_up = true;
>> +	major = ETM_ARCH_MAJOR_VERSION(drvdata->arch);
>> +	minor = ETM_ARCH_MINOR_VERSION(drvdata->arch);
>> +	if (drvdata->arch >= ETM_ARCH_ETE) {
>> +		type_name = "ete";
>> +		major -= 4;
>> +	} else {
>> +		type_name = "etm";
>> +	}
>> +
> When trace unit supports ETE, could it be still compatible with ETMv4.4?
> Can use selectively use it as ETM instead of ETE?

No. Even though most of the register sets are compatible, there are additional
restrictions and some new rules for the ETE. So, when you treat the ETE as an
ETMv4.4, you could be treading into "UNPREDICTABLE" behaviors.

Suzuki

