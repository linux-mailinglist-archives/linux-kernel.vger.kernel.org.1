Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20BC4278640
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 13:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbgIYLry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 07:47:54 -0400
Received: from foss.arm.com ([217.140.110.172]:43228 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728173AbgIYLry (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 07:47:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 95A77101E;
        Fri, 25 Sep 2020 04:47:53 -0700 (PDT)
Received: from [10.37.12.53] (unknown [10.37.12.53])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 872613F70D;
        Fri, 25 Sep 2020 04:47:50 -0700 (PDT)
Subject: Re: [PATCH v3 29/39] arm64: mte: Switch GCR_EL1 in kernel entry and
 exit
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <cover.1600987622.git.andreyknvl@google.com>
 <4e503a54297cf46ea1261f43aa325c598d9bd73e.1600987622.git.andreyknvl@google.com>
 <20200925113433.GF4846@gaia>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <e4624059-1598-17eb-2c64-3e7f26c2a1ba@arm.com>
Date:   Fri, 25 Sep 2020 12:50:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200925113433.GF4846@gaia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/25/20 12:34 PM, Catalin Marinas wrote:
> On Fri, Sep 25, 2020 at 12:50:36AM +0200, Andrey Konovalov wrote:
>> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
>> index ff34461524d4..c7cc1fdfbd1a 100644
>> --- a/arch/arm64/kernel/entry.S
>> +++ b/arch/arm64/kernel/entry.S
>> @@ -175,6 +175,49 @@ alternative_else_nop_endif
>>  #endif
>>  	.endm
>>  
>> +	.macro mte_set_gcr, tmp, tmp2
>> +#ifdef CONFIG_ARM64_MTE
>> +alternative_if_not ARM64_MTE
>> +	b	1f
>> +alternative_else_nop_endif
> 
> You don't need the alternative here. The macro is only invoked in an
> alternative path already (I'd be surprised if it even works, we don't
> handle nested alternatives well).
>

Yes, you are right. I forgot to remove it.

>> +	/*
>> +	 * Calculate and set the exclude mask preserving
>> +	 * the RRND (bit[16]) setting.
>> +	 */
>> +	mrs_s	\tmp2, SYS_GCR_EL1
>> +	bfi	\tmp2, \tmp, #0, #16
>> +	msr_s	SYS_GCR_EL1, \tmp2
>> +	isb
>> +1:
>> +#endif
>> +	.endm
>> +
>> +	.macro mte_set_kernel_gcr, tsk, tmp, tmp2
> 
> What's the point of a 'tsk' argument here?
> 

It is unused. I kept the interface same in between kernel and user.
I can either add a comment or remove it. Which one do you prefer?

>> +#ifdef CONFIG_KASAN_HW_TAGS
>> +#ifdef CONFIG_ARM64_MTE
> 
> Does KASAN_HW_TAGS depend on ARM64_MTE already? Just to avoid too may
> ifdefs. Otherwise, you can always write it as:
> 
> #if defined(CONFIG_KASAN_HW_TAGS) && defined(CONFIG_ARM64_MTE)
> 
> to save two lines (and its easier to read).
> 

It is indeed. I forgot to remove CONFIG_ARM64_MTE.

>> +alternative_if_not ARM64_MTE
>> +	b	1f
>> +alternative_else_nop_endif
>> +	ldr_l	\tmp, gcr_kernel_excl
>> +
>> +	mte_set_gcr \tmp, \tmp2
>> +1:
>> +#endif
>> +#endif
>> +	.endm
>> +
>> +	.macro mte_set_user_gcr, tsk, tmp, tmp2
>> +#ifdef CONFIG_ARM64_MTE
>> +alternative_if_not ARM64_MTE
>> +	b	1f
>> +alternative_else_nop_endif
>> +	ldr	\tmp, [\tsk, #THREAD_GCR_EL1_USER]
>> +
>> +	mte_set_gcr \tmp, \tmp2
>> +1:
>> +#endif
>> +	.endm
>> +
>>  	.macro	kernel_entry, el, regsize = 64
>>  	.if	\regsize == 32
>>  	mov	w0, w0				// zero upper 32 bits of x0
>> @@ -214,6 +257,8 @@ alternative_else_nop_endif
>>  
>>  	ptrauth_keys_install_kernel tsk, x20, x22, x23
>>  
>> +	mte_set_kernel_gcr tsk, x22, x23
>> +
>>  	scs_load tsk, x20
>>  	.else
>>  	add	x21, sp, #S_FRAME_SIZE
>> @@ -332,6 +377,8 @@ alternative_else_nop_endif
>>  	/* No kernel C function calls after this as user keys are set. */
>>  	ptrauth_keys_install_user tsk, x0, x1, x2
>>  
>> +	mte_set_user_gcr tsk, x0, x1
>> +
>>  	apply_ssbd 0, x0, x1
>>  	.endif
>>  
>> diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
>> index 393d0c794be4..c3b4f056fc54 100644
>> --- a/arch/arm64/kernel/mte.c
>> +++ b/arch/arm64/kernel/mte.c
>> @@ -22,6 +22,8 @@
>>  #include <asm/ptrace.h>
>>  #include <asm/sysreg.h>
>>  
>> +u64 gcr_kernel_excl __ro_after_init;
>> +
>>  static void mte_sync_page_tags(struct page *page, pte_t *ptep, bool check_swap)
>>  {
>>  	pte_t old_pte = READ_ONCE(*ptep);
>> @@ -116,6 +118,13 @@ void *mte_set_mem_tag_range(void *addr, size_t size, u8 tag)
>>  	return ptr;
>>  }
>>  
>> +void mte_init_tags(u64 max_tag)
>> +{
>> +	u64 incl = GENMASK(max_tag & MTE_TAG_MAX, 0);
>> +
>> +	gcr_kernel_excl = ~incl & SYS_GCR_EL1_EXCL_MASK;
>> +}
>> +
>>  static void update_sctlr_el1_tcf0(u64 tcf0)
>>  {
>>  	/* ISB required for the kernel uaccess routines */
>> @@ -151,7 +160,11 @@ static void update_gcr_el1_excl(u64 excl)
>>  static void set_gcr_el1_excl(u64 excl)
>>  {
>>  	current->thread.gcr_user_excl = excl;
>> -	update_gcr_el1_excl(excl);
>> +
>> +	/*
>> +	 * SYS_GCR_EL1 will be set to current->thread.gcr_user_incl value
>                                                       ^^^^^^^^^^^^^
> That's gcr_user_excl now.
> 
>> +	 * by mte_restore_gcr() in kernel_exit,
> 
> I don't think mte_restore_gcr is still around in this patch.
> 

This comment requires updating. I missed it.

-- 
Regards,
Vincenzo
