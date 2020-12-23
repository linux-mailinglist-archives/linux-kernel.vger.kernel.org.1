Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 395BB2E22AF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 00:22:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727373AbgLWXWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 18:22:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgLWXWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 18:22:15 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A316EC061794
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 15:21:35 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id gv14so1834488pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 15:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=OpeQspjNfc+YtA5Luu2f8A+bIc+qEdp7z4+y4LvF6NY=;
        b=IL6aTVxWbJFR9k/6V2lhp8lxWK/zbQUEVKmPso1N+eNFQZJCyNBXdWCw/4+Q8AWkz3
         e/Ly3UZjlZrMbpfqsQA8Aj9P+D/09RMrQGecE6r/pDI4RjOUtceQiD7d8+vOG14nktCj
         eKO0R4rbhmpYDjCCzFc+rytHppd1TJKdl7gd4FbWNPxdK3GHQKDjYsqJAikUyYL7Sd2i
         1xz6VeIzqRAGICJCiYMweFvV6g87tp9Pj7Nd/ea0SXxe5NojszFOJVawxdC3LbawmMAr
         YZeO2OsmtyHLBbaK9EA6YHOlHlokpyiGmzabcHBet9SyLitJ4VX14qyhKVYtM5dzSJqc
         w78g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=OpeQspjNfc+YtA5Luu2f8A+bIc+qEdp7z4+y4LvF6NY=;
        b=TZXGvN/02Jc6sGSZLvuhL9toATgmOKzMm1UnK+R3G1nRCnHZd/J5/6jzFn6vT3jkb8
         l5bFsVPot/WcvLww61zsE7f5sWiBJhhNjbRFfFV7SQzCIVBolLxm89ihsn7QjIdhfXAm
         /8UE7eZswFKoKAzVaDF3CyTnB848yU0zQALPU8jSnlUImx1sExweBHaL5vnwDjJQgj59
         zujOE5+gykWIUtrEoBNTKFozzVcjtC6DIF3rBCBSoU2WmwKTbFEi9gK35WOlerbwyGZi
         zk1XLiBF++cKwurOpvjYzCrryIxz0ftJI4beE8yFcW38YnJeX1anSNRqfo38qsUd1YqV
         2aFQ==
X-Gm-Message-State: AOAM5332eiSG9C9/KQmF5osXDkRovET/mqMAzyutW4lXQxUKnTm7CD6p
        xiJxhqnb6WD8cwAPzKeDssVEFRkpfzxE/1OCHYU=
X-Google-Smtp-Source: ABdhPJxCoTZVJOlJ0h93BIEDs1u7pBw7aTTE0xuGV/SKr1jlMefUS3JMCbFZaaav0OA+rxKLPdrcMJH0nrJip40xbEI=
Sender: "ndesaulniers via sendgmr" 
        <ndesaulniers@ndesaulniers1.mtv.corp.google.com>
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:4d25])
 (user=ndesaulniers job=sendgmr) by 2002:a17:902:a5cb:b029:dc:2706:4cc8 with
 SMTP id t11-20020a170902a5cbb02900dc27064cc8mr8357472plq.62.1608765695098;
 Wed, 23 Dec 2020 15:21:35 -0800 (PST)
Date:   Wed, 23 Dec 2020 15:21:26 -0800
Message-Id: <20201223232126.759416-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
Subject: [PATCH] x86/entry: use STB_GLOBAL for register restoring thunk
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

This behavior was implemented as an optimization in LLVM 5 years ago,
but it's not the first time this has caused issues for objtool.  A patch
has been authored against LLVM to revert the behavior, which may or may
not be accepted.  Until then use a global symbol for the thunk that way
objtool can generate proper unwind info here with LLVM_IAS=1.

Cc: Fangrui Song <maskray@google.com>
Reported-by: Arnd Bergmann <arnd@arndb.de>
Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://github.com/ClangBuiltLinux/linux/issues/1209
Link: https://reviews.llvm.org/D93783
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
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

