Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 692732B19D9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 12:16:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbgKMLQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 06:16:42 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:45420 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbgKMLQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 06:16:10 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: aratiu)
        with ESMTPSA id 52DAE1F468E4
From:   Adrian Ratiu <adrian.ratiu@collabora.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Arvind Sankar <nivedita@alum.mit.edu>, kernel@collabora.com,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] arm: lib: xor-neon: move pragma options to makefile
In-Reply-To: <CAMj1kXEpD1pp5uzOMeSYhgS_dzOysKuPMOMNgivUx58PGUdMJw@mail.gmail.com>
References: <20201112212457.2042105-1-adrian.ratiu@collabora.com>
 <20201112212457.2042105-3-adrian.ratiu@collabora.com>
 <CAMj1kXEpD1pp5uzOMeSYhgS_dzOysKuPMOMNgivUx58PGUdMJw@mail.gmail.com>
Date:   Fri, 13 Nov 2020 13:17:38 +0200
Message-ID: <87k0upjyjx.fsf@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Nov 2020, Ard Biesheuvel <ardb@kernel.org> wrote:
> On Thu, 12 Nov 2020 at 22:23, Adrian Ratiu 
> <adrian.ratiu@collabora.com> wrote: 
>> 
>> Using a pragma like GCC optimize is a bad idea because it tags 
>> all functions with an __attribute__((optimize)) which replaces 
>> optimization options rather than appending so could result in 
>> dropping important flags. Not recommended for production use. 
>> 
>> Because these options should always be enabled for this file, 
>> it's better to set them via command line. tree-vectorize is on 
>> by default in Clang, but it doesn't hurt to make it explicit. 
>> 
>> Suggested-by: Arvind Sankar <nivedita@alum.mit.edu> 
>> Suggested-by: Ard Biesheuvel <ardb@kernel.org> Signed-off-by: 
>> Adrian Ratiu <adrian.ratiu@collabora.com> --- 
>>  arch/arm/lib/Makefile   |  2 +- arch/arm/lib/xor-neon.c | 10 
>>  ---------- 2 files changed, 1 insertion(+), 11 deletions(-) 
>> 
>> diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile 
>> index 6d2ba454f25b..12d31d1a7630 100644 --- 
>> a/arch/arm/lib/Makefile +++ b/arch/arm/lib/Makefile @@ -45,6 
>> +45,6 @@ $(obj)/csumpartialcopyuser.o: 
>> $(obj)/csumpartialcopygeneric.S 
>> 
>>  ifeq ($(CONFIG_KERNEL_MODE_NEON),y) 
>>    NEON_FLAGS                   := -march=armv7-a 
>>    -mfloat-abi=softfp -mfpu=neon 
>> -  CFLAGS_xor-neon.o            += $(NEON_FLAGS) + 
>> CFLAGS_xor-neon.o            += $(NEON_FLAGS) -ftree-vectorize 
>> -Wno-unused-variable 
>>    obj-$(CONFIG_XOR_BLOCKS)     += xor-neon.o 
>>  endif 
>> diff --git a/arch/arm/lib/xor-neon.c b/arch/arm/lib/xor-neon.c 
>> index e1e76186ec23..62b493e386c4 100644 --- 
>> a/arch/arm/lib/xor-neon.c +++ b/arch/arm/lib/xor-neon.c @@ 
>> -14,16 +14,6 @@ MODULE_LICENSE("GPL"); 
>>  #error You should compile this file with '-march=armv7-a 
>>  -mfloat-abi=softfp -mfpu=neon' #endif 
>> 
>> -/* - * Pull in the reference implementations while instructing 
>> GCC (through - * -ftree-vectorize) to attempt to exploit 
>> implicit parallelism and emit - * NEON instructions.  - */ 
>> -#ifdef CONFIG_CC_IS_GCC -#pragma GCC optimize "tree-vectorize" 
>> -#endif - -#pragma GCC diagnostic ignored "-Wunused-variable" 
>>  #include <asm-generic/xor.h> 
>> 
>>  struct xor_block_template const xor_block_neon_inner = { 
>> -- 2.29.2 
>> 
> 
> So what is the status now here? How does putting 
> -ftree-vectorize on the command line interact with Clang? 

Clang needs to be fixed separately as -ftree-vectorize does not 
change anything, the option is enabled by default.

I know it sucks to have such a silent failure, but it's always 
been there (the "upgrade your GCC" warning during Clang builds was 
bogus) and I do not want to rush a Clang fix without fully 
understanding it.

Warning Clang users that the optimization doesn't work was 
discussed but dropped because users can't do anything about it.

If we are positively certain this is a kernel bug and not a Clang 
bug (i.e. the xor-neon use case is not enabling/triggering the 
optimization properly) I could add a TODO comment in the code 
FWIW.

Adrian
