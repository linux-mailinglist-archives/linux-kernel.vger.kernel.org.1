Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 736B12EB6FE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 01:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbhAFAoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 19:44:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727236AbhAFAon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 19:44:43 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F05FC061574
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 16:44:03 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id k12so995472qth.23
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 16:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=uCHOLSbfrLWN2IaWDOcuRaXgqPPYGeOtLMrp4qq7vB8=;
        b=kWMB4DXaZV68JEm60+w2QxrmH0havZ8dGOHtArTqwpamRYEqpCUnUD5t3tuRVi1NTw
         b2b4FDD4oPhIjDTzwCC2jOe49iGxqUiPDp4u49IfZRXySVBJTygaN/0rCYgI2KR0SGc4
         lS/SuWZPXWB80786HtXX2FA3GY9cbZMucxTn9l8d5aHMMg2oBv0sNGpHxhoOkRsbuzxV
         5P5yeQ4W6klf9R6wtdOsZqrCt0/9slZcmdqPwgPHLmy01ya4L0wuF7OdERD37/lU7RCM
         NBl3PRBe1iXe7hqGn8lnf/Y2A3oSbH4iGIzWgGC6Y163X8RwyG96RDzDaGFlo76v1gXW
         KtbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=uCHOLSbfrLWN2IaWDOcuRaXgqPPYGeOtLMrp4qq7vB8=;
        b=rE38+rtZC8IMPjtYWjdzjl9Lft+6b4n+dow7DOJ347f9QZrEl8ZjqUrKiatmM5gl2C
         UeZDuTwhh1fvWDxs8uchlu0CSS1xYHSiPAY9qoRjDv3BgTCwuAAu1Z3msrQJLR8GIodQ
         +z3A6da6OXp/+eHUdDgdqwswbv0wIsd11ffMyaLR+ZPtaaoOga7VtUinhGP8yJS3po8y
         M699KimH3+AAC498Xxb2NH3eVmxhlgegua4zGBftrHyzXpiEp8PTQCi2M3mNHE9xfBP4
         j96XmMWs1//qDryzMdC/jyY/RGF8hVWNt2htCgqXRLVncVEsBzO1ZODmNP2LgA1tcaxU
         qvLw==
X-Gm-Message-State: AOAM532qnu6d0QKbkhSYaDEbYYLFkXd9N3qq6g0LK0cx6HxTBpC21cKE
        UUqxNE3+uDkzVHM+MHYZ7lX3Zz/kIxGDHNA2YWA=
X-Google-Smtp-Source: ABdhPJw/BsHlG3Q+/Za+hegEidXUlzf64SB1rl+ekcR3ydGqx14tdtLQ5G6JSHHwVIsp2TLMdXwgvhmvee6181pCmnA=
Sender: "ndesaulniers via sendgmr" 
        <ndesaulniers@ndesaulniers1.mtv.corp.google.com>
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:4d25])
 (user=ndesaulniers job=sendgmr) by 2002:ad4:4888:: with SMTP id
 bv8mr2152043qvb.0.1609893842173; Tue, 05 Jan 2021 16:44:02 -0800 (PST)
Date:   Tue,  5 Jan 2021 16:43:51 -0800
In-Reply-To: <20201224045502.zkm34cc5srdgpddb@treble>
Message-Id: <20210106004351.79130-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20201224045502.zkm34cc5srdgpddb@treble>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
Subject: [PATCH v2] x86/entry: use STB_GLOBAL for register restoring thunk
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

Fangrui notes that this is helpful for reducing images size when
compiling with -ffunction-sections and -fdata-sections. I have observerd
on the order of tens of thousands of symbols for the kernel images built
with those flags. A patch has been authored against GNU binutils to
match this behavior, with a new flag
--generate-unused-section-symbols=[yes|no].

Use a global symbol for the thunk that way
objtool can generate proper unwind info here with LLVM_IAS=1.

Cc: Fangrui Song <maskray@google.com>
Link: https://github.com/ClangBuiltLinux/linux/issues/1209
Link: https://reviews.llvm.org/D93783
Link: https://sourceware.org/pipermail/binutils/2020-December/114671.html
Reported-by: Arnd Bergmann <arnd@arndb.de>
Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
Changes v1 -> v2:
* Pick up Josh's Ack.
* Add commit message info about -ffunction-sections/-fdata-sections, and
  link to binutils patch.

 arch/x86/entry/thunk_64.S | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/entry/thunk_64.S b/arch/x86/entry/thunk_64.S
index ccd32877a3c4..878816034a73 100644
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
+SYM_CODE_START_NOALIGN(__thunk_restore)
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
2.29.2.729.g45daf8777d-goog

