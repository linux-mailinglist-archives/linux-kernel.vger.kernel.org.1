Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 577A81E2398
	for <lists+linux-kernel@lfdr.de>; Tue, 26 May 2020 16:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731671AbgEZOEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 May 2020 10:04:13 -0400
Received: from foss.arm.com ([217.140.110.172]:51320 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726618AbgEZOEN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 10:04:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 552661FB;
        Tue, 26 May 2020 07:04:12 -0700 (PDT)
Received: from [10.163.78.28] (unknown [10.163.78.28])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2D8103F6C4;
        Tue, 26 May 2020 07:04:09 -0700 (PDT)
Subject: Re: [PATCH V2] arm64/cpufeature: Add get_arm64_ftr_reg_nowarn()
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     mark.rutland@arm.com, catalin.marinas@arm.com, will@kernel.org,
        broonie@kernel.org, linux-kernel@vger.kernel.org
References: <1590500353-28082-1-git-send-email-anshuman.khandual@arm.com>
 <0726a5b9-fff6-a15c-e705-db7abd4b1abd@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <6886ec2e-c2e4-c2d2-faaa-b46ef69cc226@arm.com>
Date:   Tue, 26 May 2020 19:33:29 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <0726a5b9-fff6-a15c-e705-db7abd4b1abd@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/26/2020 07:34 PM, Suzuki K Poulose wrote:
> On 05/26/2020 02:39 PM, Anshuman Khandual wrote:
>> There is no way to proceed when requested register could not be searched in
>> arm64_ftr_reg[]. Requesting for a non present register would be an error as
>> well. Hence lets just WARN_ON() when search fails in get_arm64_ftr_reg()
>> rather than checking for return value and doing a BUG_ON() instead in some
>> individual callers. But there are also caller instances that dont error out
>> when register search fails. Add a new helper get_arm64_ftr_reg_nowarn() for
>> such cases.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>> Cc: Mark Brown <broonie@kernel.org>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>> Changes in V2:
>>
>> - Added get_arm64_ftr_reg_nowarn() per Will
>> - read_sanitised_ftr_reg() returns 0 when register search fails per Catalin
>>
>> Changes in V1: (https://patchwork.kernel.org/patch/11559083/)
>>
>>   arch/arm64/kernel/cpufeature.c | 42 +++++++++++++++++++++++-----------
>>   1 file changed, 29 insertions(+), 13 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
>> index bc5048f152c1..f4555b9d145c 100644
>> --- a/arch/arm64/kernel/cpufeature.c
>> +++ b/arch/arm64/kernel/cpufeature.c
>> @@ -548,16 +548,16 @@ static int search_cmp_ftr_reg(const void *id, const void *regp)
>>   }
>>   
> 
> ...
> 
>>   static u64 arm64_ftr_set_value(const struct arm64_ftr_bits *ftrp, s64 reg,
>>                      s64 ftr_val)
>>   {
>> @@ -632,8 +654,6 @@ static void __init init_cpu_ftr_reg(u32 sys_reg, u64 new)
>>       const struct arm64_ftr_bits *ftrp;
>>       struct arm64_ftr_reg *reg = get_arm64_ftr_reg(sys_reg);
>>   -    BUG_ON(!reg);
>> -
>>       for (ftrp = reg->ftr_bits; ftrp->width; ftrp++) {
>>           u64 ftr_mask = arm64_ftr_mask(ftrp);
>>           s64 ftr_new = arm64_ftr_value(ftrp, new);
>> @@ -762,7 +782,6 @@ static int check_update_ftr_reg(u32 sys_id, int cpu, u64 val, u64 boot)
>>   {
>>       struct arm64_ftr_reg *regp = get_arm64_ftr_reg(sys_id);
>>   -    BUG_ON(!regp);
>>       update_cpu_ftr_reg(regp, val);
>>       if ((boot & regp->strict_mask) == (val & regp->strict_mask))
>>           return 0;
>> @@ -776,9 +795,6 @@ static void relax_cpu_ftr_reg(u32 sys_id, int field)
>>       const struct arm64_ftr_bits *ftrp;
>>       struct arm64_ftr_reg *regp = get_arm64_ftr_reg(sys_id);
>>   -    if (WARN_ON(!regp))
>> -        return;
>> -
> 
> You need to return here, on !regp. Rest looks fine to me.

Catalin had suggested and agreed on for this change in behavior here.
If the register is not found, there is already some problem.
