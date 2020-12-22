Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE63A2E0BC9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 15:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbgLVObZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 09:31:25 -0500
Received: from foss.arm.com ([217.140.110.172]:36498 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726920AbgLVObX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 09:31:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C62C61FB;
        Tue, 22 Dec 2020 06:30:37 -0800 (PST)
Received: from [10.37.12.16] (unknown [10.37.12.16])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1C09E3F6CF;
        Tue, 22 Dec 2020 06:30:35 -0800 (PST)
Subject: Re: [PATCH] arm64: do not descend to vdso directories twice
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20201218024540.1102650-1-masahiroy@kernel.org>
 <55dc2724-cdfe-28ad-395d-707fe9bae2db@arm.com>
 <CAK7LNAQY18miT=yPJBe9ycn7V=7ZO2XxKym6zdfGyCyFJWw9Hg@mail.gmail.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <8b25f7ba-7777-e3b5-2597-2a7a6526d4c7@arm.com>
Date:   Tue, 22 Dec 2020 14:34:04 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAK7LNAQY18miT=yPJBe9ycn7V=7ZO2XxKym6zdfGyCyFJWw9Hg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/21/20 4:03 PM, Masahiro Yamada wrote:
> On Mon, Dec 21, 2020 at 11:36 PM Vincenzo Frascino
> <vincenzo.frascino@arm.com> wrote:
>>
>> Hi Masahiro,
>>
>> On 12/18/20 2:45 AM, Masahiro Yamada wrote:
>>> arm64 descends into each vdso directory twice; first in vdso_prepare,
>>> second during the ordinary build process.
>>>
>>> PPC mimicked it and uncovered a problem [1]. In the first descend,
>>> Kbuild directly visits the vdso directories, therefore it does not
>>> inherit subdir-ccflags-y from upper directories.
>>>
>>> This means the command line parameters may differ between the two.
>>> If it happens, the offset values in the generated headers might be
>>> different from real offsets of vdso.so in the kernel.
>>>
>>> This potential danger should be avoided. The vdso directories are
>>> built in the vdso_prepare stage, so the second descend is unneeded.
>>>
>>> [1]: https://lore.kernel.org/linux-kbuild/CAK7LNARAkJ3_-4gX0VA2UkapbOftuzfSTVMBbgbw=HD8n7N+7w@mail.gmail.com/T/#ma10dcb961fda13f36d42d58fa6cb2da988b7e73a
>>>
>>
>> I could not reproduce the problem you are reporting on arm64. Could you please
>> provide some steps?
> 
> 
> As far as I see in arm64 Makefiles, you cannot reproduce it.
> So, this is a _potential_ problem.
> 
> When somebody adds subdir-ccflags-y to arch/arm64/Kbuild or
> arch/arm64/kernel/Makefile,
> the real issue will suddenly come up.
> 
> 
> arm64 is the first arch that implemented vdso-offsets.h
> 
> arch maintainers tend to copy Makefiles from existing ones.
> 
> Now PPC is the second with almost the same Makefile implementation.
> 
> This time, powerpc hit the problem because arch/powerpc/Kbuild
> has subdir-ccflags-y.
> 
> I do not want to be bothered every time arch maintainers hit this issue.
> So, I want to fix arm64 first,
> then powerpc will eventually copy the correct Makefiles.
> 
>

Ok this seems a problem related to a top down approach in the ccflags
propagation, which as it stands does not affect arm64, hence IMHO we should not
fix what is not broken, but I do not have a strong opinion on this.

> 
> 
>> In my case the vDSO library is not rebuilt as a result of the procedure reported
>> in the email you linked at [1].
>>
>>> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>>> ---
>>>
>>>  arch/arm64/Makefile                                | 10 ++++++----
>>>  arch/arm64/kernel/Makefile                         |  5 +++--
>>>  arch/arm64/kernel/{vdso/vdso.S => vdso-wrap.S}     |  0
>>>  arch/arm64/kernel/vdso/Makefile                    |  1 -
>>>  arch/arm64/kernel/{vdso32/vdso.S => vdso32-wrap.S} |  0
>>>  arch/arm64/kernel/vdso32/Makefile                  |  1 -
>>>  6 files changed, 9 insertions(+), 8 deletions(-)
>>>  rename arch/arm64/kernel/{vdso/vdso.S => vdso-wrap.S} (100%)
>>>  rename arch/arm64/kernel/{vdso32/vdso.S => vdso32-wrap.S} (100%)
>>>
>>> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
>>> index 6a87d592bd00..f18d20a68170 100644
>>> --- a/arch/arm64/Makefile
>>> +++ b/arch/arm64/Makefile
>>> @@ -179,10 +179,12 @@ ifeq ($(KBUILD_EXTMOD),)
>>>  # this hack.
>>>  prepare: vdso_prepare
>>>  vdso_prepare: prepare0
>>> -     $(Q)$(MAKE) $(build)=arch/arm64/kernel/vdso include/generated/vdso-offsets.h
>>> -     $(if $(CONFIG_COMPAT_VDSO),$(Q)$(MAKE) \
>>> -             $(build)=arch/arm64/kernel/vdso32  \
>>> -             include/generated/vdso32-offsets.h)
>>> +     $(Q)$(MAKE) $(build)=arch/arm64/kernel/vdso \
>>> +     include/generated/vdso-offsets.h arch/arm64/kernel/vdso/vdso.so
>>> +ifdef CONFIG_COMPAT_VDSO
>>> +     $(Q)$(MAKE) $(build)=arch/arm64/kernel/vdso32 \
>>> +     include/generated/vdso32-offsets.h arch/arm64/kernel/vdso32/vdso.so
>>> +endif
>>>  endif
>>
>> The reason why it is currently done in two phases (a bit hacky as per comment)
>> is because vdso-offsets.h is required to be generated before compiling kernel/.
>> Please refer to the comment in arch/arm64/Makefile.
> 
> Yes, I know.
> 
>>
>> Could you explain how your change satisfies the dependency?
> 
> vdso_prepare completes before Kbuild starts ordinary descending.
> So *.so files and vdso-offsets.h exist
> when Kbuild builds arch/arm64/kernel/.
> 
> 

This is not immediately obvious, could you please mention it in the commit message?

Nit: Could you please re-organize the code as follows in order to limit the
changes (untested)?

$(Q)$(MAKE) $(build)=arch/arm64/kernel/vdso include/generated/vdso-offsets.h \
	arch/arm64/kernel/vdso/vdso.so
$(if $(CONFIG_COMPAT_VDSO),$(Q)$(MAKE) \
	$(build)=arch/arm64/kernel/vdso32  \
	include/generated/vdso32-offsets.h \
	arch/arm64/kernel/vdso32/vdso.so)

> 
> 
> 
> 
>>>
>>>  define archhelp
>>> diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
>>> index 86364ab6f13f..42f6ad2c7eac 100644
>>> --- a/arch/arm64/kernel/Makefile
>>> +++ b/arch/arm64/kernel/Makefile
>>> @@ -59,9 +59,10 @@ obj-$(CONFIG_CRASH_CORE)           += crash_core.o
>>>  obj-$(CONFIG_ARM_SDE_INTERFACE)              += sdei.o
>>>  obj-$(CONFIG_ARM64_PTR_AUTH)         += pointer_auth.o
>>>  obj-$(CONFIG_ARM64_MTE)                      += mte.o
>>> +obj-y                                        += vdso-wrap.o
>>> +obj-$(CONFIG_COMPAT_VDSO)            += vdso32-wrap.o
>>>
>>> -obj-y                                        += vdso/ probes/
>>> -obj-$(CONFIG_COMPAT_VDSO)            += vdso32/
>>> +obj-y                                        += probes/
>>>  head-y                                       := head.o
>>>  extra-y                                      += $(head-y) vmlinux.lds
>>>
>>> diff --git a/arch/arm64/kernel/vdso/vdso.S b/arch/arm64/kernel/vdso-wrap.S
>>> similarity index 100%
>>> rename from arch/arm64/kernel/vdso/vdso.S
>>> rename to arch/arm64/kernel/vdso-wrap.S
>>> diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
>>> index a8f8e409e2bf..85222f64f394 100644
>>> --- a/arch/arm64/kernel/vdso/Makefile
>>> +++ b/arch/arm64/kernel/vdso/Makefile
>>> @@ -45,7 +45,6 @@ endif
>>>  # Disable gcov profiling for VDSO code
>>>  GCOV_PROFILE := n
>>>
>>> -obj-y += vdso.o
>>>  targets += vdso.lds
>>>  CPPFLAGS_vdso.lds += -P -C -U$(ARCH)
>>>
>>> diff --git a/arch/arm64/kernel/vdso32/vdso.S b/arch/arm64/kernel/vdso32-wrap.S
>>> similarity index 100%
>>> rename from arch/arm64/kernel/vdso32/vdso.S
>>> rename to arch/arm64/kernel/vdso32-wrap.S
>>> diff --git a/arch/arm64/kernel/vdso32/Makefile b/arch/arm64/kernel/vdso32/Makefile
>>> index a1e0f91e6cea..789ad420f16b 100644
>>> --- a/arch/arm64/kernel/vdso32/Makefile
>>> +++ b/arch/arm64/kernel/vdso32/Makefile
>>> @@ -155,7 +155,6 @@ c-obj-vdso-gettimeofday := $(addprefix $(obj)/, $(c-obj-vdso-gettimeofday))
>>>  asm-obj-vdso := $(addprefix $(obj)/, $(asm-obj-vdso))
>>>  obj-vdso := $(c-obj-vdso) $(c-obj-vdso-gettimeofday) $(asm-obj-vdso)
>>>
>>> -obj-y += vdso.o
>>>  targets += vdso.lds
>>>  CPPFLAGS_vdso.lds += -P -C -U$(ARCH)
>>>
>>>
>>
>> --
>> Regards,
>> Vincenzo
> 
> 
> 
> --
> Best Regards
> Masahiro Yamada
> 

-- 
Regards,
Vincenzo
