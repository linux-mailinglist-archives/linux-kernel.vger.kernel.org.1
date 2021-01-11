Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1865A2F213E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 22:00:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729412AbhAKU7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 15:59:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbhAKU67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 15:58:59 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8574C061786
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 12:58:18 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id v1so274866pjr.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 12:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4YnXT6/Dl7rfyU2s6Zv/oTTpfI/8RYAIA+FYqzJ/gss=;
        b=ftxFX/RU6sx+57Iy3Ly4LXwZaOD8AvGuq25V19LzhVd+7g9N0puRkvVl4hdAebNO/+
         YX16ahOt64sI4RPvo8sugoBuO2/78xAEBcF36UfBgbsStU6stsFpL70U388sOyssMHN6
         pnn4WtgDwYH4YmAIQu+y0qAvpzNL3kRA7XgWOkE466ipu2X4Xf7sNUIwGhXelfG7+5PL
         JMHzpMuJ8sGRjQyzJbAlPeC7noDFGZVxIcwSIW+VIB5lHS6btZaAJ6RCkoNBM6x9FSHB
         F2Fyra7zv2LM+cTWyvj2ETS5nXOkncBtyxmQBzDsh6mPc2/lv/yFald52wUS6IVkDEvj
         83Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4YnXT6/Dl7rfyU2s6Zv/oTTpfI/8RYAIA+FYqzJ/gss=;
        b=SAt9phFg00Joe4QGQDTd4NuvZUQZfmkCk7nEfGBbTjmhTWjMh1hCRyYyid1g00pgXR
         Pc5EwUuJ9eb/H3072RKMVshfc81j4ZaIIYpWROuSfqksYgPO1id0ARFPH4RRW2ByqI8X
         2CkXgiOlo0X/IUPfbmBgySNL79SQjGRwvozvr2Fn0BRMlYo4KYcbji37ndjoV/Jnht+Q
         u2bcBZuxrEXX0EJDAakmo3icd6JNaoBr1nU5czrYEwnNAU4BmKtPmgFz27ViQnfSniFc
         oz+p4Fow3vl4is46pFU5G46Zr4+A2GrorpViKQmkyxA75h3VTVBV4au7ZS7TgRvyv25K
         SK9Q==
X-Gm-Message-State: AOAM5335lcxioVdv8XR1/awlC476mcOkQEUixnn/Y8067hCwifkBWYDB
        9fJ6yOh4iHYJyEoa3Aef48ve+g==
X-Google-Smtp-Source: ABdhPJwVRkNPZLbjg+kM+D5BLH6uMcQGXVkzhKlyXiRgvoQI4Dti2PTuAYytu30HkdGBCUlHQLKRrA==
X-Received: by 2002:a17:90a:c82:: with SMTP id v2mr706241pja.171.1610398698156;
        Mon, 11 Jan 2021 12:58:18 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:a6ae:11ff:fe11:4abb])
        by smtp.gmail.com with ESMTPSA id y5sm579046pfp.45.2021.01.11.12.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 12:58:17 -0800 (PST)
Date:   Mon, 11 Jan 2021 12:58:14 -0800
From:   Fangrui Song <maskray@google.com>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH v3] x86/entry: emit a symbol for register restoring thunk
Message-ID: <20210111205814.m6bbvekdhqs7pnhr@google.com>
References: <20210106015810.5p6crnh7jqtmjtv4@treble>
 <20210111203807.3547278-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210111203807.3547278-1-ndesaulniers@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021-01-11, Nick Desaulniers wrote:
>Arnd found a randconfig that produces the warning:
>
>arch/x86/entry/thunk_64.o: warning: objtool: missing symbol for insn at
>offset 0x3e
>
>when building with LLVM_IAS=1 (use Clang's integrated assembler). Josh
>notes:
>
>  With the LLVM assembler stripping the .text section symbol, objtool
>  has no way to reference this code when it generates ORC unwinder
>  entries, because this code is outside of any ELF function.
>
>Fangrui notes that this optimization is helpful for reducing images size
>when compiling with -ffunction-sections and -fdata-sections. I have
>observerd on the order of tens of thousands of symbols for the kernel
>images built with those flags. A patch has been authored against GNU
>binutils to match this behavior, with a new flag
>--generate-unused-section-symbols=[yes|no].

https://sourceware.org/git/gitweb.cgi?p=binutils-gdb.git;h=d1bcae833b32f1408485ce69f844dcd7ded093a8
has been committed. The patch should be included in binutils 2.37.
The maintainers are welcome to the idea, but fixing all the arch-specific tests is tricky.

H.J. fixed the x86 tests and enabled this for x86. When binutils 2.37
come out, some other architectures may follow as well.

>We can omit the .L prefix on a label to emit an entry into the symbol
>table for the label, with STB_LOCAL binding.  This enables objtool to
>generate proper unwind info here with LLVM_IAS=1.

Josh, I think objtool orc generate needs to synthesize STT_SECTION
symbols even if they do not exist in object files.

rg 'SYM_CODE.*\.L' reveals a few other .S files which may have similar problems.

>Cc: Fangrui Song <maskray@google.com>
>Link: https://github.com/ClangBuiltLinux/linux/issues/1209
>Link: https://reviews.llvm.org/D93783
>Link: https://sourceware.org/binutils/docs/as/Symbol-Names.html
>Link: https://sourceware.org/pipermail/binutils/2020-December/114671.html
>Reported-by: Arnd Bergmann <arnd@arndb.de>
>Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
>Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
>---
>Changes v2 -> v3:
>* rework to use STB_LOCAL rather than STB_GLOBAL by dropping .L prefix,
>  as per Josh.
>* rename oneline to drop STB_GLOBAL in commit message.
>* add link to GAS docs on .L prefix.
>* drop Josh's ack since patch changed.
>
>Changes v1 -> v2:
>* Pick up Josh's Ack.
>* Add commit message info about -ffunction-sections/-fdata-sections, and
>  link to binutils patch.
>
>
> arch/x86/entry/thunk_64.S | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)
>
>diff --git a/arch/x86/entry/thunk_64.S b/arch/x86/entry/thunk_64.S
>index ccd32877a3c4..c9a9fbf1655f 100644
>--- a/arch/x86/entry/thunk_64.S
>+++ b/arch/x86/entry/thunk_64.S
>@@ -31,7 +31,7 @@ SYM_FUNC_START_NOALIGN(\name)
> 	.endif
>
> 	call \func
>-	jmp  .L_restore
>+	jmp  __thunk_restore
> SYM_FUNC_END(\name)
> 	_ASM_NOKPROBE(\name)
> 	.endm
>@@ -44,7 +44,7 @@ SYM_FUNC_END(\name)
> #endif
>
> #ifdef CONFIG_PREEMPTION
>-SYM_CODE_START_LOCAL_NOALIGN(.L_restore)
>+SYM_CODE_START_LOCAL_NOALIGN(__thunk_restore)
> 	popq %r11
> 	popq %r10
> 	popq %r9
>@@ -56,6 +56,6 @@ SYM_CODE_START_LOCAL_NOALIGN(.L_restore)
> 	popq %rdi
> 	popq %rbp
> 	ret
>-	_ASM_NOKPROBE(.L_restore)
>-SYM_CODE_END(.L_restore)
>+	_ASM_NOKPROBE(__thunk_restore)
>+SYM_CODE_END(__thunk_restore)
> #endif
>-- 
>2.30.0.284.gd98b1dd5eaa7-goog
>
