Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD972F20F2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 21:39:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403775AbhAKUiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 15:38:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731317AbhAKUiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 15:38:54 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC60EC061786
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 12:38:13 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id f27so68318qkh.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 12:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=MNO0aT79NlBMBpFFFhrGm8b8k1yazD1r5qWQUpbsXR8=;
        b=jqdYj09xqJ7NPJFfDPG1xhVfnZH4Sd4zOcH5v9XvqdA7FIXIOvHifJ8Qr7ros/tvln
         Ujwv12oosfKaB/EMCupa6i6CRWm84DTHkt70xOo9aWGfvQyxvZp6udjp6vPOErub4/r6
         ti0qJTM2aS7WtAEm9ROkXhZCokn/mjy03Mlz0S39IsURhCEKvJuOO9Pl5/hvZVSz8snX
         1QLHwzuW6ncT17E35iUQCZjSfqZMM/+06jQCD9STRp9lr9rGUIoKg4R4HoYZEp4o1+k2
         NgW+dtdXYJt96z4ysHFnQ5m+ysBZlbLpt9LqJRb2Gui80NB5ZsvrL95k3mSGrYeMqIfl
         2faw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MNO0aT79NlBMBpFFFhrGm8b8k1yazD1r5qWQUpbsXR8=;
        b=rNcKO//g0JlXyH1vr1SsPume8niDgZY2I3nNYlu5gW0owSpMMYKd9c9pcx2g8sbMSI
         a2N9RAACVuKYOVZsC00VXSchmfyPrT8Lg2nSPqccmIOpOnKlnbUWlAYD+DYlJbM5WH6r
         btBhcNpUQHnY6BDZcE8IIYiPUpHwzW4ASNpZzJ9l9L0GJ4WqLa9YDT9i/YeQEC3uJkXm
         t7KcUzbHl1JJIXwb9pXrwMKta0hWGvIrQRr2IkktWvinJjgGkCcdhnI+hWwzU8NVncmA
         U3FJt//09Q+HrUQtP2hBBOJfWWIgcATeA7oHrnvoFCg1Al+s89QUD7NmwYRSHdrz3KVN
         TDnQ==
X-Gm-Message-State: AOAM531in/n7qwQva5+2cKnGxK3oL4XHSH7+CCzxrFs730v9qwcn+Tx4
        7EzaouDi1P3/ZxehHUkcp/DU65/Hx0QSAzsVdDM=
X-Google-Smtp-Source: ABdhPJyxiPiESzmUMT5UsgmUw2kSSo3ycvPIO72VMR2iPzxzSGDF4YTqUbs0LLi+UouYdKd+6tQaYXlKcVl1U69gfyI=
Sender: "ndesaulniers via sendgmr" 
        <ndesaulniers@ndesaulniers1.mtv.corp.google.com>
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:4d25])
 (user=ndesaulniers job=sendgmr) by 2002:a05:6214:302:: with SMTP id
 i2mr1512072qvu.14.1610397492970; Mon, 11 Jan 2021 12:38:12 -0800 (PST)
Date:   Mon, 11 Jan 2021 12:38:06 -0800
In-Reply-To: <20210106015810.5p6crnh7jqtmjtv4@treble>
Message-Id: <20210111203807.3547278-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20210106015810.5p6crnh7jqtmjtv4@treble>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH v3] x86/entry: emit a symbol for register restoring thunk
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Fangrui Song <maskray@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd found a randconfig that produces the warning:

arch/x86/entry/thunk_64.o: warning: objtool: missing symbol for insn at
offset 0x3e

when building with LLVM_IAS=1 (use Clang's integrated assembler). Josh
notes:

  With the LLVM assembler stripping the .text section symbol, objtool
  has no way to reference this code when it generates ORC unwinder
  entries, because this code is outside of any ELF function.

Fangrui notes that this optimization is helpful for reducing images size
when compiling with -ffunction-sections and -fdata-sections. I have
observerd on the order of tens of thousands of symbols for the kernel
images built with those flags. A patch has been authored against GNU
binutils to match this behavior, with a new flag
--generate-unused-section-symbols=[yes|no].

We can omit the .L prefix on a label to emit an entry into the symbol
table for the label, with STB_LOCAL binding.  This enables objtool to
generate proper unwind info here with LLVM_IAS=1.

Cc: Fangrui Song <maskray@google.com>
Link: https://github.com/ClangBuiltLinux/linux/issues/1209
Link: https://reviews.llvm.org/D93783
Link: https://sourceware.org/binutils/docs/as/Symbol-Names.html
Link: https://sourceware.org/pipermail/binutils/2020-December/114671.html
Reported-by: Arnd Bergmann <arnd@arndb.de>
Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
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


 arch/x86/entry/thunk_64.S | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

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
-- 
2.30.0.284.gd98b1dd5eaa7-goog

