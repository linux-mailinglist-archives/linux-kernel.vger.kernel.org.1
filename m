Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B14CE2F5F04
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 11:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728945AbhANKjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 05:39:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728853AbhANKjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 05:39:49 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA1BC061575;
        Thu, 14 Jan 2021 02:39:35 -0800 (PST)
Received: from zn.tnic (p200300ec2f1aa900dc6a18505a7e3253.dip0.t-ipconnect.de [IPv6:2003:ec:2f1a:a900:dc6a:1850:5a7e:3253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 824741EC04DF;
        Thu, 14 Jan 2021 11:39:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1610620772;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Uz5M8jM6ROkPD6VOKuFFM9kmh68b0rkKCdwLPFJrhGI=;
        b=YqglV8SWnI4cHBOVnPrO5se3k4FwvgHO83L1bJU2aSITWTixgSlMBl4E91liLS/MU4Lf6j
        F20kSVKxUhQ0jiFsCr5XueP3qX8UkYo9lJ9QUPR4Xiv0PnxQGRMVhx1UvKhFhF1xDpMbo3
        MPxzAAcC0BSRxprBsHs+Y+fRryuS/Lg=
Date:   Thu, 14 Jan 2021 11:39:28 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Mark Brown <broonie@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Fangrui Song <maskray@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Joe Perches <joe@perches.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH v4] x86/entry: emit a symbol for register restoring thunk
Message-ID: <20210114103928.GB12284@zn.tnic>
References: <20210112115421.GB13086@zn.tnic>
 <20210112194625.4181814-1-ndesaulniers@google.com>
 <20210112210154.GI4646@sirena.org.uk>
 <20210113165923.acvycpcu5tzksbbi@treble>
 <CAKwvOdnAMsYF-v1LAqttBV3e3rHhSFZmPcRRV0+v=+9AyMFgNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKwvOdnAMsYF-v1LAqttBV3e3rHhSFZmPcRRV0+v=+9AyMFgNA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 09:56:04AM -0800, Nick Desaulniers wrote:
> Apologies, that was not my intention.  I've sent a follow up in
> https://lore.kernel.org/lkml/20210113174620.958429-1-ndesaulniers@google.com/T/#u
> since BP picked up v3 in tip x86/entry:
> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=x86/entry&id=bde718b7e154afc99e1956b18a848401ce8e1f8e

It is the topmost patch so I can rebase...

Also, I replicated that text into linkage.h and removed the change over
SYM_CODE_START and I've got the below.

Further complaints?

---
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Tue, 12 Jan 2021 11:46:24 -0800
Subject: [PATCH] x86/entry: Emit a symbol for register restoring thunk

Arnd found a randconfig that produces the warning:

  arch/x86/entry/thunk_64.o: warning: objtool: missing symbol for insn at
  offset 0x3e

when building with LLVM_IAS=1 (Clang's integrated assembler). Josh
notes:

  With the LLVM assembler not generating section symbols, objtool has no
  way to reference this code when it generates ORC unwinder entries,
  because this code is outside of any ELF function.

  The limitation now being imposed by objtool is that all code must be
  contained in an ELF symbol.  And .L symbols don't create such symbols.

  So basically, you can use an .L symbol *inside* a function or a code
  segment, you just can't use the .L symbol to contain the code using a
  SYM_*_START/END annotation pair.

Fangrui notes that this optimization is helpful for reducing image size
when compiling with -ffunction-sections and -fdata-sections. I have
observed on the order of tens of thousands of symbols for the kernel
images built with those flags.

A patch has been authored against GNU binutils to match this behavior
of not generating unused section symbols ([1]), so this will
also become a problem for users of GNU binutils once they upgrade to 2.36.

Omit the .L prefix on a label so that the assembler will emit an entry
into the symbol table for the label, with STB_LOCAL binding. This
enables objtool to generate proper unwind info here with LLVM_IAS=1 or
GNU binutils 2.36+.

 [ bp: Massage commit message. ]

Reported-by: Arnd Bergmann <arnd@arndb.de>
Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
Suggested-by: Borislav Petkov <bp@alien8.de>
Suggested-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210112194625.4181814-1-ndesaulniers@google.com
Link: https://github.com/ClangBuiltLinux/linux/issues/1209
Link: https://reviews.llvm.org/D93783
Link: https://sourceware.org/binutils/docs/as/Symbol-Names.html
Link: https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=d1bcae833b32f1408485ce69f844dcd7ded093a8 [1]
---
 Documentation/asm-annotations.rst | 5 +++++
 arch/x86/entry/thunk_64.S         | 8 ++++----
 include/linux/linkage.h           | 5 +++++
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/Documentation/asm-annotations.rst b/Documentation/asm-annotations.rst
index 32ea57483378..76424e0431f4 100644
--- a/Documentation/asm-annotations.rst
+++ b/Documentation/asm-annotations.rst
@@ -100,6 +100,11 @@ Instruction Macros
 ~~~~~~~~~~~~~~~~~~
 This section covers ``SYM_FUNC_*`` and ``SYM_CODE_*`` enumerated above.
 
+``objtool`` requires that all code must be contained in an ELF symbol. Symbol
+names that have a ``.L`` prefix do not emit symbol table entries. ``.L``
+prefixed symbols can be used within a code region, but should be avoided for
+denoting a range of code via ``SYM_*_START/END`` annotations.
+
 * ``SYM_FUNC_START`` and ``SYM_FUNC_START_LOCAL`` are supposed to be **the
   most frequent markings**. They are used for functions with standard calling
   conventions -- global and local. Like in C, they both align the functions to
diff --git a/arch/x86/entry/thunk_64.S b/arch/x86/entry/thunk_64.S
index ccd32877a3c4..c9a9fbf1655f 100644
--- a/arch/x86/entry/thunk_64.S
+++ b/arch/x86/entry/thunk_64.S
@@ -31,7 +31,7 @@ SYM_FUNC_START_NOALIGN(\name)
 	.endif
 
 	call \func
-	jmp  .L_restore
+	jmp  __thunk_restore
 SYM_FUNC_END(\name)
 	_ASM_NOKPROBE(\name)
 	.endm
@@ -44,7 +44,7 @@ SYM_FUNC_END(\name)
 #endif
 
 #ifdef CONFIG_PREEMPTION
-SYM_CODE_START_LOCAL_NOALIGN(.L_restore)
+SYM_CODE_START_LOCAL_NOALIGN(__thunk_restore)
 	popq %r11
 	popq %r10
 	popq %r9
@@ -56,6 +56,6 @@ SYM_CODE_START_LOCAL_NOALIGN(.L_restore)
 	popq %rdi
 	popq %rbp
 	ret
-	_ASM_NOKPROBE(.L_restore)
-SYM_CODE_END(.L_restore)
+	_ASM_NOKPROBE(__thunk_restore)
+SYM_CODE_END(__thunk_restore)
 #endif
diff --git a/include/linux/linkage.h b/include/linux/linkage.h
index 5bcfbd972e97..dbf8506decca 100644
--- a/include/linux/linkage.h
+++ b/include/linux/linkage.h
@@ -178,6 +178,11 @@
  * Objtool generates debug info for both FUNC & CODE, but needs special
  * annotations for each CODE's start (to describe the actual stack frame).
  *
+ * Objtool requires that all code must be contained in an ELF symbol. Symbol
+ * names that have a  .L prefix do not emit symbol table entries. .L
+ * prefixed symbols can be used within a code region, but should be avoided for
+ * denoting a range of code via ``SYM_*_START/END`` annotations.
+ *
  * ALIAS -- does not generate debug info -- the aliased function will
  */
 
-- 
2.29.2

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
