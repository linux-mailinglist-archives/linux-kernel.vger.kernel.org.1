Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1917E1E35A2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 04:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbgE0C1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 May 2020 22:27:13 -0400
Received: from foss.arm.com ([217.140.110.172]:59518 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726330AbgE0C1N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 22:27:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DB3BA30E;
        Tue, 26 May 2020 19:27:12 -0700 (PDT)
Received: from [10.163.76.100] (unknown [10.163.76.100])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B36143F52E;
        Tue, 26 May 2020 19:27:10 -0700 (PDT)
Subject: Re: [PATCH V2] arm64/cpufeature: Add get_arm64_ftr_reg_nowarn()
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
References: <1590500353-28082-1-git-send-email-anshuman.khandual@arm.com>
 <20200526150135.GI17051@gaia> <20200526194648.GA2206@willie-the-truck>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <ca38b2c0-533f-9b98-46a2-37ba8bf21d83@arm.com>
Date:   Wed, 27 May 2020 07:56:30 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200526194648.GA2206@willie-the-truck>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/27/2020 01:16 AM, Will Deacon wrote:
> On Tue, May 26, 2020 at 04:01:35PM +0100, Catalin Marinas wrote:
>> On Tue, May 26, 2020 at 07:09:13PM +0530, Anshuman Khandual wrote:
>>> @@ -632,8 +654,6 @@ static void __init init_cpu_ftr_reg(u32 sys_reg, u64 new)
>>>  	const struct arm64_ftr_bits *ftrp;
>>>  	struct arm64_ftr_reg *reg = get_arm64_ftr_reg(sys_reg);
>>>  
>>> -	BUG_ON(!reg);
>>> -
>>>  	for (ftrp = reg->ftr_bits; ftrp->width; ftrp++) {
>>>  		u64 ftr_mask = arm64_ftr_mask(ftrp);
>>>  		s64 ftr_new = arm64_ftr_value(ftrp, new);
>>> @@ -762,7 +782,6 @@ static int check_update_ftr_reg(u32 sys_id, int cpu, u64 val, u64 boot)
>>>  {
>>>  	struct arm64_ftr_reg *regp = get_arm64_ftr_reg(sys_id);
>>>  
>>> -	BUG_ON(!regp);
>>>  	update_cpu_ftr_reg(regp, val);
>>>  	if ((boot & regp->strict_mask) == (val & regp->strict_mask))
>>>  		return 0;
>>> @@ -776,9 +795,6 @@ static void relax_cpu_ftr_reg(u32 sys_id, int field)
>>>  	const struct arm64_ftr_bits *ftrp;
>>>  	struct arm64_ftr_reg *regp = get_arm64_ftr_reg(sys_id);
>>>  
>>> -	if (WARN_ON(!regp))
>>> -		return;
>>
>> I think Will wanted an early return in all these functions not just
>> removing the BUG_ON(). I'll let him clarify.
> 
> Yes, the callers need to check the pointer and return early.

Sure, will do. But for check_update_ftr_reg(), a feature register search
failure should be treated as a success (0) or a failure (1). What should
it return ? Seems bit tricky, as there are good reasons to go either way.
