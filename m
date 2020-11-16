Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A790B2B43E3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 13:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbgKPMmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 07:42:18 -0500
Received: from foss.arm.com ([217.140.110.172]:39166 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726614AbgKPMmR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 07:42:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC39B101E;
        Mon, 16 Nov 2020 04:42:16 -0800 (PST)
Received: from [10.37.12.42] (unknown [10.37.12.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 003023F70D;
        Mon, 16 Nov 2020 04:42:12 -0800 (PST)
Subject: Re: [PATCH RFC v2 04/21] kasan: unpoison stack only with
 CONFIG_KASAN_STACK
To:     Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Will Deacon <will.deacon@arm.com>,
        Alexander Potapenko <glider@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Serban Constantinescu <serbanc@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <cover.1603372719.git.andreyknvl@google.com>
 <ded454eeff88f631dc08eef76f0ad9f2daff0085.1603372719.git.andreyknvl@google.com>
 <CACT4Y+Zys3+VUsO6GDWQEcjCS6Wx16W_+B6aNy-fyhPcir7eeA@mail.gmail.com>
 <CAAeHK+xvGZNwTtvkzNnU7Hh7iUiPKFNDKDpKT8UPcqQk6Ah3yQ@mail.gmail.com>
 <CACT4Y+Z3UCwAY2Mm1KiQMBXVhc2Bobi-YrdiNYtToNgMRjOE4g@mail.gmail.com>
 <CANpmjNPNqHsOfcw7Wh+XQ_pPT1610-+B9By171t7KMS3aB2sBg@mail.gmail.com>
 <X7Jthb9D5Ekq93sS@trantor>
 <CACT4Y+ZubLBEiGZOVyptB4RPf=3Qr570GN+JBpSmaeEvHWQB5g@mail.gmail.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <9d4156e6-ec4f-a742-a44e-f38bf7fa9ba9@arm.com>
Date:   Mon, 16 Nov 2020 12:45:19 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+ZubLBEiGZOVyptB4RPf=3Qr570GN+JBpSmaeEvHWQB5g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/16/20 12:19 PM, Dmitry Vyukov wrote:
> On Mon, Nov 16, 2020 at 1:16 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>>
>> On Mon, Nov 16, 2020 at 12:50:00PM +0100, Marco Elver wrote:
>>> On Mon, 16 Nov 2020 at 11:59, Dmitry Vyukov <dvyukov@google.com> wrote:
>>>> On Thu, Oct 29, 2020 at 8:57 PM 'Andrey Konovalov' via kasan-dev
>>>> <kasan-dev@googlegroups.com> wrote:
>>>>> On Tue, Oct 27, 2020 at 1:44 PM Dmitry Vyukov <dvyukov@google.com> wrote:
>>>>>>
>>>>>> On Thu, Oct 22, 2020 at 3:19 PM Andrey Konovalov <andreyknvl@google.com> wrote:
>>>>>>>
>>>>>>> There's a config option CONFIG_KASAN_STACK that has to be enabled for
>>>>>>> KASAN to use stack instrumentation and perform validity checks for
>>>>>>> stack variables.
>>>>>>>
>>>>>>> There's no need to unpoison stack when CONFIG_KASAN_STACK is not enabled.
>>>>>>> Only call kasan_unpoison_task_stack[_below]() when CONFIG_KASAN_STACK is
>>>>>>> enabled.
>>>>>>>
>>>>>>> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
>>>>>>> Link: https://linux-review.googlesource.com/id/If8a891e9fe01ea543e00b576852685afec0887e3
>>>>>>> ---
>>>>>>>  arch/arm64/kernel/sleep.S        |  2 +-
>>>>>>>  arch/x86/kernel/acpi/wakeup_64.S |  2 +-
>>>>>>>  include/linux/kasan.h            | 10 ++++++----
>>>>>>>  mm/kasan/common.c                |  2 ++
>>>>>>>  4 files changed, 10 insertions(+), 6 deletions(-)
>>>>>>>
>>>>>>> diff --git a/arch/arm64/kernel/sleep.S b/arch/arm64/kernel/sleep.S
>>>>>>> index ba40d57757d6..bdadfa56b40e 100644
>>>>>>> --- a/arch/arm64/kernel/sleep.S
>>>>>>> +++ b/arch/arm64/kernel/sleep.S
>>>>>>> @@ -133,7 +133,7 @@ SYM_FUNC_START(_cpu_resume)
>>>>>>>          */
>>>>>>>         bl      cpu_do_resume
>>>>>>>
>>>>>>> -#ifdef CONFIG_KASAN
>>>>>>> +#if defined(CONFIG_KASAN) && CONFIG_KASAN_STACK
>>>>>>>         mov     x0, sp
>>>>>>>         bl      kasan_unpoison_task_stack_below
>>>>>>>  #endif
>>>>>>> diff --git a/arch/x86/kernel/acpi/wakeup_64.S b/arch/x86/kernel/acpi/wakeup_64.S
>>>>>>> index c8daa92f38dc..5d3a0b8fd379 100644
>>>>>>> --- a/arch/x86/kernel/acpi/wakeup_64.S
>>>>>>> +++ b/arch/x86/kernel/acpi/wakeup_64.S
>>>>>>> @@ -112,7 +112,7 @@ SYM_FUNC_START(do_suspend_lowlevel)
>>>>>>>         movq    pt_regs_r14(%rax), %r14
>>>>>>>         movq    pt_regs_r15(%rax), %r15
>>>>>>>
>>>>>>> -#ifdef CONFIG_KASAN
>>>>>>> +#if defined(CONFIG_KASAN) && CONFIG_KASAN_STACK
>>>>>>>         /*
>>>>>>>          * The suspend path may have poisoned some areas deeper in the stack,
>>>>>>>          * which we now need to unpoison.
>>>>>>> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
>>>>>>> index 3f3f541e5d5f..7be9fb9146ac 100644
>>>>>>> --- a/include/linux/kasan.h
>>>>>>> +++ b/include/linux/kasan.h
>>>>>>> @@ -68,8 +68,6 @@ static inline void kasan_disable_current(void) {}
>>>>>>>
>>>>>>>  void kasan_unpoison_memory(const void *address, size_t size);
>>>>>>>
>>>>>>> -void kasan_unpoison_task_stack(struct task_struct *task);
>>>>>>> -
>>>>>>>  void kasan_alloc_pages(struct page *page, unsigned int order);
>>>>>>>  void kasan_free_pages(struct page *page, unsigned int order);
>>>>>>>
>>>>>>> @@ -114,8 +112,6 @@ void kasan_restore_multi_shot(bool enabled);
>>>>>>>
>>>>>>>  static inline void kasan_unpoison_memory(const void *address, size_t size) {}
>>>>>>>
>>>>>>> -static inline void kasan_unpoison_task_stack(struct task_struct *task) {}
>>>>>>> -
>>>>>>>  static inline void kasan_alloc_pages(struct page *page, unsigned int order) {}
>>>>>>>  static inline void kasan_free_pages(struct page *page, unsigned int order) {}
>>>>>>>
>>>>>>> @@ -167,6 +163,12 @@ static inline size_t kasan_metadata_size(struct kmem_cache *cache) { return 0; }
>>>>>>>
>>>>>>>  #endif /* CONFIG_KASAN */
>>>>>>>
>>>>>>> +#if defined(CONFIG_KASAN) && CONFIG_KASAN_STACK
>>>>>>
>>>>>> && defined(CONFIG_KASAN_STACK) for consistency
>>>>>
>>>>> CONFIG_KASAN_STACK is different from other KASAN configs. It's always
>>>>> defined, and its value is what controls whether stack instrumentation
>>>>> is enabled.
>>>>
>>>> Not sure why we did this instead of the following, but okay.
>>>>
>>>>  config KASAN_STACK
>>>> -       int
>>>> -       default 1 if KASAN_STACK_ENABLE || CC_IS_GCC
>>>> -       default 0
>>>> +       bool
>>>> +       default y if KASAN_STACK_ENABLE || CC_IS_GCC
>>>> +       default n
>>>
>>> I wondered the same, but then looking at scripts/Makefile.kasan I
>>> think it's because we directly pass it to the compiler:
>>>     ...
>>>     $(call cc-param,asan-stack=$(CONFIG_KASAN_STACK)) \
>>>     ...
>>
>> Try this instead:
>>
>>       $(call cc-param,asan-stack=$(if $(CONFIG_KASAN_STACK),1,0)) \
> 
> 
> We could have just 1 config instead of 2 as well.
> For gcc we could do no prompt and default value y, and for clang --
> prompt and default value n. I think it should do what we need.
> 

I agree with Catalin's proposal since it should simplify things.

Nit: 'default n' is the default hence I do not think it should be required
explicitly.

-- 
Regards,
Vincenzo
