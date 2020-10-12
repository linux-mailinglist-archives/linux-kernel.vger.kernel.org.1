Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABBAD28B230
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 12:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387461AbgJLK0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 06:26:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:38744 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726510AbgJLK0K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 06:26:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1602498368;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ilXt6NkD7kYkq9BqAajphKCLvAtvM4L7108qoj49GGw=;
        b=B645MlSP9esJa/Qq1W/IlcqcC4DNU8k3WeD7ZhM/HFe+lcuUjg6FrL1efaU9tEs8vp7SmV
        y0vWLxlB9hmdQQ3ehDoqBb+Nn4LdH/QvcZxiEhzAfYljTGWSwhdSFPuUnv6zXcTIPBXgeR
        3ivv4T/Cu9tAFcTgdE2u/Dd1GkwFvmw=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 62A3EB1E4;
        Mon, 12 Oct 2020 10:26:08 +0000 (UTC)
Subject: Re: [PATCH] x86/alternative: don't call text_poke() in lazy TLB mode
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>
References: <20201009144225.12019-1-jgross@suse.com>
 <20201012101330.GR2628@hirez.programming.kicks-ass.net>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <fc202e90-00ff-a635-f298-c3ca293e9182@suse.com>
Date:   Mon, 12 Oct 2020 12:26:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201012101330.GR2628@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.10.20 12:13, Peter Zijlstra wrote:
> On Fri, Oct 09, 2020 at 04:42:25PM +0200, Juergen Gross wrote:
>> When running in lazy TLB mode the currently active page tables might
>> be the ones of a previous process, e.g. when running a kernel thread.
>>
>> This can be problematic in case kernel code is being modified via
>> text_poke() in a kernel thread, and on another processor exit_mmap()
>> is active for the process which was running on the first cpu before
>> the kernel thread.
>>
>> As text_poke() is using a temporary address space and the former
>> address space (obtained via cpu_tlbstate.loaded_mm) is restored
>> afterwards, there is a race possible in case the cpu on which
>> exit_mmap() is running wants to make sure there are no stale
>> references to that address space on any cpu active (this e.g. is
>> required when running as a Xen PV guest, where this problem has been
>> observed and analyzed).
>>
>> In order to avoid that, drop off TLB lazy mode before switching to the
>> temporary address space.
> 
> Oh man, that must've been 'fun' :/

Yeah.

> 
>> Fixes: cefa929c034eb5d ("x86/mm: Introduce temporary mm structs")
>> Signed-off-by: Juergen Gross <jgross@suse.com>
>> ---
>>   arch/x86/kernel/alternative.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
>> index cdaab30880b9..cd6be6f143e8 100644
>> --- a/arch/x86/kernel/alternative.c
>> +++ b/arch/x86/kernel/alternative.c
>> @@ -807,6 +807,15 @@ static inline temp_mm_state_t use_temporary_mm(struct mm_struct *mm)
>>   	temp_mm_state_t temp_state;
>>   
>>   	lockdep_assert_irqs_disabled();
>> +
>> +	/*
>> +	 * Make sure not to be in TLB lazy mode, as otherwise we'll end up
>> +	 * with a stale address space WITHOUT being in lazy mode after
>> +	 * restoring the previous mm.
>> +	 */
>> +	if (this_cpu_read(cpu_tlbstate.is_lazy))
>> +		leave_mm(smp_processor_id());
>> +
>>   	temp_state.mm = this_cpu_read(cpu_tlbstate.loaded_mm);
>>   	switch_mm_irqs_off(NULL, mm, current);
> 
> Would it make sense to write it like:
> 
> 	this_state.mm = this_cpu_read(cpu_tlbstate.is_lazy) ?
> 			&init_mm : this_cpu_read(cpu_tlbstate.loaded_mm);
> 
> Possibly with that wrapped in a conveniently named helper function.

Fine with me, but I don't think it matters that much.

For each batch of text_poke() it will be hit only once, and I'm not sure
it is really a good idea to use the knowledge that leave_mm() is just a
switch to init_mm here.

In case it is still the preferred way to do it I can send an update of
the patch.


Juergen
