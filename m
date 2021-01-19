Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B37842FBAC5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 16:13:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389102AbhASPJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 10:09:40 -0500
Received: from foss.arm.com ([217.140.110.172]:34008 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404575AbhASOm4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 09:42:56 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 871D3D6E;
        Tue, 19 Jan 2021 06:42:06 -0800 (PST)
Received: from [10.37.8.29] (unknown [10.37.8.29])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E8A2A3F719;
        Tue, 19 Jan 2021 06:42:03 -0800 (PST)
Subject: Re: [PATCH v4 4/5] arm64: mte: Enable async tag check fault
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>
References: <20210118183033.41764-1-vincenzo.frascino@arm.com>
 <20210118183033.41764-5-vincenzo.frascino@arm.com>
 <20210119143412.GD17369@gaia>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <7db77f90-d595-c094-2f71-8ef1b05f1c7f@arm.com>
Date:   Tue, 19 Jan 2021 14:45:52 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210119143412.GD17369@gaia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/19/21 2:34 PM, Catalin Marinas wrote:
> On Mon, Jan 18, 2021 at 06:30:32PM +0000, Vincenzo Frascino wrote:
>>  static void update_sctlr_el1_tcf0(u64 tcf0)
>>  {
>>  	/* ISB required for the kernel uaccess routines */
>> @@ -235,6 +273,15 @@ void mte_thread_switch(struct task_struct *next)
>>  	/* avoid expensive SCTLR_EL1 accesses if no change */
>>  	if (current->thread.sctlr_tcf0 != next->thread.sctlr_tcf0)
>>  		update_sctlr_el1_tcf0(next->thread.sctlr_tcf0);
>> +
>> +	/*
>> +	 * Check if an async tag exception occurred at EL1.
>> +	 *
>> +	 * Note: On the context switch path we rely on the dsb() present
>> +	 * in __switch_to() to guarantee that the indirect writes to TFSR_EL1
>> +	 * are synchronized before this point.
>> +	 */
>> +	mte_check_tfsr_el1();
>>  }
> 
> We need an isb() before mte_check_tfsr_el1() here as well, we only have
> a dsb() in __switch_to(). We do have an isb() in update_sctlr_el1_tcf0()
> but only if the check passed. Now, it's worth benchmarking how expensive
> update_sctlr_el1_tcf0() is (i.e. an SCTLR_EL1 access + isb with
> something like hackbench) and we could probably remove the check
> altogether. In the meantime, you can add an isb() on the "else" path of
> the above check.
> 

Good catch, I saw the isb() in update_sctlr_el1_tcf0() and for some reasons that
it is not escaping me I thought it was sufficient, but clearly it is not.

I am happy to benchmark what you are suggesting and provide some data after this
series is merged (if it works for you) so that we can decide. In the meantime as
you suggested I will fix the "else" for v5.

-- 
Regards,
Vincenzo
