Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8CCC1E03D4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 May 2020 01:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388432AbgEXXI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 May 2020 19:08:57 -0400
Received: from foss.arm.com ([217.140.110.172]:34344 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387863AbgEXXI4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 19:08:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D171230E;
        Sun, 24 May 2020 16:08:55 -0700 (PDT)
Received: from [192.168.0.129] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 351073F52E;
        Sun, 24 May 2020 16:08:52 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH V4 12/17] arm64/cpufeature: Add remaining feature bits in
 ID_AA64MMFR0 register
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org
References: <1589881254-10082-1-git-send-email-anshuman.khandual@arm.com>
 <1589881254-10082-13-git-send-email-anshuman.khandual@arm.com>
 <aab025fd-a9aa-0f1a-783b-eb5d3b40a327@arm.com>
Message-ID: <4df6059d-baad-0f21-ec0d-cbb972bfabdf@arm.com>
Date:   Mon, 25 May 2020 04:38:13 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <aab025fd-a9aa-0f1a-783b-eb5d3b40a327@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/19/2020 07:02 PM, Suzuki K Poulose wrote:
> On 05/19/2020 10:40 AM, Anshuman Khandual wrote:
>> Enable EVC, FGT, EXS, TGRAN4_2, TGRAN64_2 and TGRAN16_2 features bits in
>> ID_AA64MMFR0 register as per ARM DDI 0487F.a specification.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>>
>> Suggested-by: Will Deacon <will@kernel.org>
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> 
>> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
>> index d1433f996710..7ce19f97ba73 100644
>> --- a/arch/arm64/kernel/cpufeature.c
>> +++ b/arch/arm64/kernel/cpufeature.c
>> @@ -267,6 +267,10 @@ static const struct arm64_ftr_bits ftr_id_aa64zfr0[] = {
>>   };
>>     static const struct arm64_ftr_bits ftr_id_aa64mmfr0[] = {
>> +
> 
> minor nit: spurious new line.
> 
>> +    ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR0_ECV_SHIFT, 4, 0),
>> +    ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR0_FGT_SHIFT, 4, 0),
>> +    ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR0_EXS_SHIFT, 4, 0),
>>       /*
>>        * We already refuse to boot CPUs that don't support our configured
>>        * page size, so we can only detect mismatches for a page size other
>> @@ -274,6 +278,9 @@ static const struct arm64_ftr_bits ftr_id_aa64mmfr0[] = {
>>        * exist in the wild so, even though we don't like it, we'll have to go
>>        * along with it and treat them as non-strict.
>>        */
>> +    S_ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64MMFR0_TGRAN4_2_SHIFT, 4, ID_AA64MMFR0_TGRAN4_2_NI),
>> +    S_ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64MMFR0_TGRAN64_2_SHIFT, 4, ID_AA64MMFR0_TGRAN64_2_NI),
>> +    S_ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64MMFR0_TGRAN16_2_SHIFT, 4, ID_AA64MMFR0_TGRAN16_2_NI),
> 
> These are not SIGNED as they don't have 0b1111 defined to represent
> something "lower" than '0b0'. It was signed for 4K and 64K, since
> 
> 0b0000 => supported
> 0b1111 => Not supported.
> 
> Also Please note, KVM-NV patches are adding these, so you may as well drop them.

Sure, will drop all ID_AA64MMFR0_TGRAN changes along with related
macros from arch/arm64/include/asm/sysreg.h.
