Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 954FE3028ED
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 18:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731005AbhAYRbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 12:31:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730899AbhAYRam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 12:30:42 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A95CC061786
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 09:30:02 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id q2so5305732plk.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 09:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=naOBrYnG98m3QV0nKV1s7c8LTOjqUrSXlI1ZaarYe0k=;
        b=XGAmNAHdNyh8r6EtOJymwDZGkLFebGMQlX8tqpklYy3Z4NeoqA0yBcDkDgOIGPkV52
         IbiC6dLmxd51KE69p1J2/vRi6uHhgynlW1TVNXEqePTvqe3IizpKY8dh1UahOC/TTUZg
         YQhgxtt3FCKY4zug20vsVSqbpGcGlO8WkYNlBumsqelDDgnQEdZ/vtACF83JxL2vyL5R
         DH6RXwBPmUYqCWOvYrbykTN4RgC5yMMvKoDrouiCADl034wW4udmF8R+Xya0dPD4oJpu
         EfhDQ99JIhZNjgvgKPO1FmuwsMJ3dAuWlmBli/qJnJKu5q03gIrQ8Bw6XCBohXXl23Mi
         GdYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=naOBrYnG98m3QV0nKV1s7c8LTOjqUrSXlI1ZaarYe0k=;
        b=pXcWWp3ATxZiTmNIcNT0pm3XWdvgyuZc+vN1f8L8z5meipLr6c1k5FykxeiFbMbX+X
         fekeexSyClOwM0H9xJPSUSA+TwVNyHJENlsvliUnekpwoPNgBpxALhvJpgt5Vah3VILd
         HK0vTJDrR5EbLvn0au5DU61/adfAbT7uuI1zD4Et2mp0kzepKA+nUovOimpCyb9ybbhh
         yVpLEb+rTYqZ+ly4R9rf9MY2NHTAqqx4qv7P8DC9Ugxs33D9Y2oBSOtpPmEs8Dy3JqFs
         uBxqaWcZwMmi8Zwy+l6Gw0X+nCukxhektbKyAFkdBNywU9oQM1jAb0D+x+mePEEtvCPr
         si8g==
X-Gm-Message-State: AOAM531Q1IAAdUvpbWHPP5V7DB0U9HyAL8j+0u091OWmrK8IFCTwv2TT
        y5zPEHmnvQdZt3ZzrwFiVxAeHg==
X-Google-Smtp-Source: ABdhPJzn1zPcgNDn7RDjs/Qim532A07q2VAvXN2H2w+Do7u2cm9DAaaPIytI2qrTu8jEyNUw0zBCiQ==
X-Received: by 2002:a17:902:bd01:b029:da:3d4f:abe1 with SMTP id p1-20020a170902bd01b02900da3d4fabe1mr1771132pls.16.1611595801300;
        Mon, 25 Jan 2021 09:30:01 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:a6ae:11ff:fe11:4abb])
        by smtp.gmail.com with ESMTPSA id y10sm17173409pff.197.2021.01.25.09.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 09:30:00 -0800 (PST)
Date:   Mon, 25 Jan 2021 09:29:56 -0800
From:   Fangrui Song <maskray@google.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Michael Matz <matz@suse.de>
Subject: Re: [PATCH v3] x86: Treat R_386_PLT32 as R_386_PC32
Message-ID: <20210125172956.j2prlchhqwfcgzuc@google.com>
References: <20210107185555.2781221-1-maskray@google.com>
 <20210114224819.1608929-1-maskray@google.com>
 <20210125142302.GA23070@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210125142302.GA23070@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021-01-25, Borislav Petkov wrote:
>It's a good thing I have a toolchain guy who can explain to me what you
>guys are doing because you need to start writing those commit messages
>for !toolchain developers.

How about this following message? I'll answer your questions in line as
well. Explaining everything in the message will be quite long...  If
someone is interested, I have put every possibly related matter in
https://maskray.me/blog/2021-01-09-copy-relocations-canonical-plt-entries-and-protected


This is similar to commit b21ebf2fb4cd ("x86: Treat R_X86_64_PLT32 as
R_X86_64_PC32"), but for i386.  As far as Linux kernel is concerned,
R_386_PLT32 can be treated the same as R_386_PC32.

R_386_PLT32/R_X86_64_PLT32 are PC-relative relocation types which can
only be used by branches. If the referenced symbol is defined
externally, a PLT will be used.
R_386_PC32/R_X86_64_PC32 are PC-relative relocation types which can be
used by address taking operations and branches. If the referenced symbol
is defined externally, a copy relocation/canonical PLT entry will be
created in the executable.

On x86-64, there is no PIC vs non-PIC PLT distinction and an
R_X86_64_PLT32 relocation is produced for both `call/jmp foo` and
`call/jmp foo@PLT` with newer (2018) GNU as/LLVM integrated assembler.
This avoids copy relocations/canonical PLT entries.

On i386, there are 2 types of PLTs, PIC and non-PIC. Currently the
GCC/GNU as convention is to use R_386_PC32 for non-PIC PLT and
R_386_PLT32 for PIC PLT. Copy relocations/canonical PLT entries are
possible ABI issues but GCC/GNU as will likely keep the status quo
because (1) the ABI is legacy (2) the change will drop a GNU ld
diagnostic for non-default visibility ifunc in shared objects.
https://sourceware.org/bugzilla/show_bug.cgi?id=27169

clang-12 -fno-pic (since
https://github.com/llvm/llvm-project/commit/a084c0388e2a59b9556f2de0083333232da3f1d6)
can emit R_386_PLT32 for compiler generated function declarations,
because preventing canonical PLT entries is weighed over the rare ifunc
diagnostic.

Link: https://github.com/ClangBuiltLinux/linux/issues/1210
Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Fangrui Song <maskray@google.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Nathan Chancellor <natechancellor@gmail.com>


>On Thu, Jan 14, 2021 at 02:48:19PM -0800, Fangrui Song wrote:
>> This is similar to commit b21ebf2fb4cd ("x86: Treat R_X86_64_PLT32 as
>> R_X86_64_PC32"), but for i386.  As far as Linux kernel is concerned,
>> R_386_PLT32 can be treated the same as R_386_PC32.
>>
>> R_386_PC32/R_X86_64_PC32 are PC-relative relocation types with the
>> requirement that the symbol address is significant.
>> R_386_PLT32/R_X86_64_PLT32 are PC-relative relocation types without the
>> address significance requirement.
>
>I was told what "significant" means in that context and while it is
>clear to you, I'm pretty sure it is not clear to kernel developers who
>haven't looked at toolchains in depth. So please elaborate.

Expanded "significant" to more words. See above.

>> On x86-64, there is no PIC vs non-PIC PLT distinction and an
>> R_X86_64_PLT32 relocation is produced for both `call/jmp foo` and
>> `call/jmp foo@PLT` with newer (2018) GNU as/LLVM integrated assembler.
>
>Also, please explain in short why LLVM is generating R_X86_64_PLT32
>relocs now? I.e., is it the same reason as why binutils does that?
>
>I.e., mentioning the big picture of things would help as to why you're
>doing this.

It has been explained. The LLVM change was in 2018, roughly the same
time when GNU as emitted R_X86_64_PLT32. I think it does not need
extended explanation because of the separate canonical PLT entries
paragraph.

>> On i386, there are 2 types of PLTs, PIC and non-PIC. Currently the
>> convention is to use R_386_PC32 for non-PIC PLT and R_386_PLT32 for PIC
>> PLT.
>
>Convention in general or convention for LLVM?

Changed to "GCC/GNU as convention".

>> clang-12 -fno-pic (since
>> https://github.com/llvm/llvm-project/commit/a084c0388e2a59b9556f2de0083333232da3f1d6)
>> can emit R_386_PLT32 for compiler generated function declarations as
>> well to avoid a canonical PLT entry (st_shndx=0, st_value!=0) if the
>> symbol turns out to be defined externally. GCC/GNU as will likely keep
>> using R_386_PC32 because (1) the ABI is legacy (2) the change will drop
>> a GNU ld non-default visibility ifunc for shared objects.
>> https://sourceware.org/bugzilla/show_bug.cgi?id=27169
>
>Not sure how useful this paragraph is for kernel developers...

Reorganize it a bit...

>> Link: https://github.com/ClangBuiltLinux/linux/issues/1210
>> Reported-by: Arnd Bergmann <arnd@arndb.de>
>> Signed-off-by: Fangrui Song <maskray@google.com>
>> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
>> Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
>> Tested-by: Nick Desaulniers <ndesaulniers@google.com>
>> Tested-by: Nathan Chancellor <natechancellor@gmail.com>
>>
>> ---
>> Change in v2:
>> * Improve commit message
>> ---
>> Change in v3:
>> * Change the GCC link to the more relevant GNU as link.
>> * Fix the relevant llvm-project commit id.
>> ---
>>  arch/x86/kernel/module.c | 1 +
>>  arch/x86/tools/relocs.c  | 2 ++
>>  2 files changed, 3 insertions(+)
>>
>> diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
>> index 34b153cbd4ac..5e9a34b5bd74 100644
>> --- a/arch/x86/kernel/module.c
>> +++ b/arch/x86/kernel/module.c
>> @@ -114,6 +114,7 @@ int apply_relocate(Elf32_Shdr *sechdrs,
>>  			*location += sym->st_value;
>>  			break;
>>  		case R_386_PC32:
>> +		case R_386_PLT32:
>>  			/* Add the value, subtract its position */
>>  			*location += sym->st_value - (uint32_t)location;
>>  			break;
>> diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
>> index ce7188cbdae5..717e48ca28b6 100644
>> --- a/arch/x86/tools/relocs.c
>> +++ b/arch/x86/tools/relocs.c
>> @@ -867,6 +867,7 @@ static int do_reloc32(struct section *sec, Elf_Rel *rel, Elf_Sym *sym,
>>  	case R_386_PC32:
>>  	case R_386_PC16:
>>  	case R_386_PC8:
>> +	case R_386_PLT32:
>>  		/*
>>  		 * NONE can be ignored and PC relative relocations don't
>>  		 * need to be adjusted.
>
>That comment might need adjustment.
>
>> @@ -910,6 +911,7 @@ static int do_reloc_real(struct section *sec, Elf_Rel *rel, Elf_Sym *sym,
>>  	case R_386_PC32:
>>  	case R_386_PC16:
>>  	case R_386_PC8:
>> +	case R_386_PLT32:
>>  		/*
>>  		 * NONE can be ignored and PC relative relocations don't
>>  		 * need to be adjusted.
>
>Ditto.
>
>-- 
>Regards/Gruss,
>    Boris.
>
>https://people.kernel.org/tglx/notes-about-netiquette
