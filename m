Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD6022F3B07
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 20:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406909AbhALTre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 14:47:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406742AbhALTre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 14:47:34 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97387C061794
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 11:46:53 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id m8so2284545qvk.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 11:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=575K5Wa01BXuSX5wfEbu2mOnTk5h9ngYJOt0hPIiDbE=;
        b=uWIQwzplj0dSfYqg/T40aBR3p//IOck88E6Nca9IgUtiYbKfdinxhWWnC3QKE7NYv3
         0UMB7z2PAs7qpXcDAAuN5wzmCxwgaMRy5OISAgIcPBOQCzXd5eX3ihg6O9avJYHqBOpL
         B6UTnPRuCzCKKsJTMvaJuMPmaisO9J67gQvgX23WwgEvVEAnI9I9JlwYidsoX0f+7pY1
         ymwnAiOh3fO8c5+aeJqPRsoGvFdA91JB4M/txMK8o5pxoCr6gMYLZAb9UrayWrz9D6YD
         9xpAmByPNxYAH/FodYigxhG1MYxAtuGxn3hiaY6s/ZE/tKwPVrYndVXPEpSVp97xPEB8
         Ymhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=575K5Wa01BXuSX5wfEbu2mOnTk5h9ngYJOt0hPIiDbE=;
        b=oGKir3GEHCuS71sdpRH/R2787tA2UjrIipnhyDma7HSNrWBdntSj8rSEO3c0IdFN7q
         d+NSSfZ6fKa73UnY1TZzyjUyUG1n1uqrBkhoClwidcNT3DgIRvv3Z1k0Tk+ATS+qHQkO
         KfapxkCr2ShoOn4J2cBn9h5BhbjY3QeuJgt0cCpPZMT/NQvhEKUeXJXQePJ8BQ7gE/TK
         xIFnaqT0U64wd1+q3FXMrTz849vX+PbH5EYKfQgVkHnfOEIrqWQe0fTnt600YYS3o3B8
         QkucMivN+HlBoq4T2xMXZ53AWP/nNB/XhVSHZVPuZHAXEIhgtmQYiKKtYbfpzimU+vDv
         cl1A==
X-Gm-Message-State: AOAM531xm+QZss4R9lJbxjSZGAT1nP5vS9qRFYWZWxJ31BZj+8zVH+ya
        uVYLybuiq+ftLcIXNuvqo0xZ7O1KRMQOtUQnVzY=
X-Google-Smtp-Source: ABdhPJwFr5GNH3mYsB63vu/qRw5kPYC06VeiweTXzWX2Xnus8dFpApEikj2fXJ+HMNrEno0SRfXqfGs5F0Hy5DkKDxM=
Sender: "ndesaulniers via sendgmr" 
        <ndesaulniers@ndesaulniers1.mtv.corp.google.com>
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:4d25])
 (user=ndesaulniers job=sendgmr) by 2002:ad4:4390:: with SMTP id
 s16mr1155717qvr.28.1610480812711; Tue, 12 Jan 2021 11:46:52 -0800 (PST)
Date:   Tue, 12 Jan 2021 11:46:24 -0800
In-Reply-To: <20210112115421.GB13086@zn.tnic>
Message-Id: <20210112194625.4181814-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20210112115421.GB13086@zn.tnic>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH v4] x86/entry: emit a symbol for register restoring thunk
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Fangrui Song <maskray@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Joe Perches <joe@perches.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

A patch has been authored against GNU binutils to match this behavior,
so this will also become a problem for users of GNU binutils once they
upgrade to 2.36.

We can omit the .L prefix on a label so that the assembler will emit an
entry into the symbol table for the label, with STB_LOCAL binding.  This
enables objtool to generate proper unwind info here with LLVM_IAS=1 or
GNU binutils 2.36+.

Cc: Fangrui Song <maskray@google.com>
Link: https://github.com/ClangBuiltLinux/linux/issues/1209
Link: https://reviews.llvm.org/D93783
Link: https://sourceware.org/binutils/docs/as/Symbol-Names.html
Link: https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=d1bcae833b32f1408485ce69f844dcd7ded093a8
Reported-by: Arnd Bergmann <arnd@arndb.de>
Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
Changes v3 -> v4:
* Add changes to Documentation/ and include/ as per Boris.
* Fix typos as per Josh.
* Replace link and note in commit message about
  --generate-unused-section-symbols=[yes|no] which was dropped from GNU
  binutils with link to actual commit in binutils-gdb.
* Add additional notes from Josh in commit message.
* Slightly reword commit message to indicate that section symbols are
  not emitted, rather than stripped.

Changes v2 -> v3:
* rework to use STB_LOCAL rather than STB_GLOBAL by dropping .L prefix,
  as per Josh.
* rename oneline to drop STB_GLOBAL in commit message.
* add link to GAS docs on .L prefix.
* drop Josh's ack since patch changed.

Changes v1 -> v2:
* Pick up Josh's Ack.
* Add commit message info about -ffunction-sections/-fdata-sections, and
  link to binutils patch.

 Documentation/asm-annotations.rst | 9 +++++++++
 arch/x86/entry/thunk_64.S         | 8 ++++----
 include/linux/linkage.h           | 5 ++++-
 3 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/Documentation/asm-annotations.rst b/Documentation/asm-annotations.rst
index 32ea57483378..e711ff98102a 100644
--- a/Documentation/asm-annotations.rst
+++ b/Documentation/asm-annotations.rst
@@ -153,6 +153,15 @@ This section covers ``SYM_FUNC_*`` and ``SYM_CODE_*`` enumerated above.
   To some extent, this category corresponds to deprecated ``ENTRY`` and
   ``END``. Except ``END`` had several other meanings too.
 
+  Developers should avoid using local symbol names that are prefixed with
+  ``.L``, as this has special meaning for the assembler; a symbol entry will
+  not be emitted into the symbol table. This can prevent ``objtool`` from
+  generating correct unwind info. Symbols with STB_LOCAL binding may still be
+  used, and ``.L`` prefixed local symbol names are still generally useable
+  within a function, but ``.L`` prefixed local symbol names should not be used
+  to denote the beginning or end of code regions via
+  ``SYM_CODE_START_LOCAL``/``SYM_CODE_END``.
+
 * ``SYM_INNER_LABEL*`` is used to denote a label inside some
   ``SYM_{CODE,FUNC}_START`` and ``SYM_{CODE,FUNC}_END``.  They are very similar
   to C labels, except they can be made global. An example of use::
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
index 5bcfbd972e97..11537ba9f512 100644
--- a/include/linux/linkage.h
+++ b/include/linux/linkage.h
@@ -270,7 +270,10 @@
 	SYM_END(name, SYM_T_FUNC)
 #endif
 
-/* SYM_CODE_START -- use for non-C (special) functions */
+/*
+ * SYM_CODE_START -- use for non-C (special) functions, avoid .L prefixed local
+ * symbol names which may not emit a symbol table entry.
+ */
 #ifndef SYM_CODE_START
 #define SYM_CODE_START(name)				\
 	SYM_START(name, SYM_L_GLOBAL, SYM_A_ALIGN)
-- 
2.30.0.284.gd98b1dd5eaa7-goog

