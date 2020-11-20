Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA652BA6F6
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 11:05:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbgKTKDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 05:03:46 -0500
Received: from foss.arm.com ([217.140.110.172]:46326 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727214AbgKTKDq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 05:03:46 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A2EF11D4;
        Fri, 20 Nov 2020 02:03:46 -0800 (PST)
Received: from [10.57.53.209] (unknown [10.57.53.209])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E8E5F3F70D;
        Fri, 20 Nov 2020 02:03:43 -0800 (PST)
Subject: Re: [PATCH v4 24/25] arm64: Add TRFCR_ELx definitions
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, linux-kernel@vger.kernel.org,
        anshuman.khandual@arm.com, jonathan.zhouwen@huawei.com,
        coresight@lists.linaro.org, Will Deacon <will@kernel.org>
References: <20201119164547.2982871-1-suzuki.poulose@arm.com>
 <20201119164547.2982871-25-suzuki.poulose@arm.com>
 <20201119171801.GE4376@gaia>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <43d9f4ac-df91-1cc4-ea4b-518f3433a915@arm.com>
Date:   Fri, 20 Nov 2020 10:03:37 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201119171801.GE4376@gaia>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/19/20 5:18 PM, Catalin Marinas wrote:
> On Thu, Nov 19, 2020 at 04:45:46PM +0000, Suzuki K Poulose wrote:
>> @@ -988,6 +991,14 @@
>>   /* Safe value for MPIDR_EL1: Bit31:RES1, Bit30:U:0, Bit24:MT:0 */
>>   #define SYS_MPIDR_SAFE_VAL	(BIT(31))
>>   
>> +#define TRFCR_ELx_TS_SHIFT		5
>> +#define TRFCR_ELx_TS_VIRTUAL		((0x1) << TRFCR_ELx_TS_SHIFT)
>> +#define TRFCR_ELx_TS_GUEST_PHYSICAL	((0x2) << TRFCR_ELx_TS_SHIFT)
>> +#define TRFCR_ELx_TS_PHYSICAL		((0x3) << TRFCR_ELx_TS_SHIFT)
> 
> For consistency, I'd use 0x1UL etc. in case the shift goes beyond 32
> (not the case here though).

Agreed, will fix it.

> 
> Otherwise:
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Thanks
Suzuki
