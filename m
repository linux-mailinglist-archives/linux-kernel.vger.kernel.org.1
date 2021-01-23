Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80CDB3014DF
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 12:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbhAWLbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jan 2021 06:31:37 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:44232 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbhAWLbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jan 2021 06:31:34 -0500
Received: from mail-ed1-f71.google.com ([209.85.208.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <andrea.righi@canonical.com>)
        id 1l3H7x-0001v0-9T
        for linux-kernel@vger.kernel.org; Sat, 23 Jan 2021 11:30:49 +0000
Received: by mail-ed1-f71.google.com with SMTP id n18so4367836eds.2
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jan 2021 03:30:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=uToEgRvoXkVV5EJTV0FVw52Xk/tppbqWpuo+YSiTF+Q=;
        b=Md0PylJpN//OKm/K771RqVN5Ll41hlsryeSt7Asu4v56gG21t0ufJo0WniWWwebOZe
         365TsEBZr++nQySXn/b0skscfhiCVaXjfJLTxxd3SfCq/Jwm/JACtvvL96UO+d6OAMvW
         KR5XS/8ZHoU7XMWM1McX1/o4HdMf/oknW0yO8WtSx0CX0EQ/KCQFL3AuQThufh3KdHWN
         /8LsW66LOcErVTrH2Hg0VeDU3pSk0t0YU4k/HEgDdVlp+/TXYE/nNTcjYAIqzrqsJGf/
         Gw91zuj57UyFhwrGLsH60afrtniZ3ZEeALQrW/aEJV6o644yaMh95MCXG/x0qQ6LPc7j
         hmlw==
X-Gm-Message-State: AOAM532y3DzCWZc2pf0cWnZ7KelBeQe6PVJmCfVFrF6OfciN6qpzZz6a
        F2wv0iM/YEe0TjxA8yxKRbK43LqYpJjcg/CXIt2ZfHvtU97V6n5LXV2dZMRWtkRbL174T/D38tk
        d7ZRZYXrkjEwNU0J/8eCUHgTb6a979Pu8y1dlhnlT9g==
X-Received: by 2002:a17:906:2755:: with SMTP id a21mr1090318ejd.374.1611401448634;
        Sat, 23 Jan 2021 03:30:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwXkEb6QSDm8kC6vRXOHMm4hCRqEu9ENGWZqbb7/dJXXYsjtH30uxomfvkzH3EPpWCy5EIbJw==
X-Received: by 2002:a17:906:2755:: with SMTP id a21mr1090303ejd.374.1611401448341;
        Sat, 23 Jan 2021 03:30:48 -0800 (PST)
Received: from localhost (host-79-52-126-228.retail.telecomitalia.it. [79.52.126.228])
        by smtp.gmail.com with ESMTPSA id e11sm5813059ejz.94.2021.01.23.03.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jan 2021 03:30:47 -0800 (PST)
Date:   Sat, 23 Jan 2021 12:30:45 +0100
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] x86/entry: build thunk_$(BITS) only if CONFIG_PREEMPTION=y
Message-ID: <YAwI5XE64ZFYkm/g@xps-13-7390>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With CONFIG_PREEMPTION disabled, arch/x86/entry/thunk_64.o is just an
empty object file.

With the newer binutils (tested with 2.35.90.20210113-1ubuntu1) the GNU
assembler doesn't generate a symbol table for empty object files and
objtool fails with the following error when a valid symbol table cannot
be found:

  arch/x86/entry/thunk_64.o: warning: objtool: missing symbol table

To prevent this from happening, build thunk_$(BITS).o only if
CONFIG_PREEMPTION is enabled.

BugLink: https://bugs.launchpad.net/bugs/1911359
Fixes: 320100a5ffe5 ("x86/entry: Remove the TRACE_IRQS cruft")
Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
---
 arch/x86/entry/Makefile   | 3 ++-
 arch/x86/entry/thunk_32.S | 2 --
 arch/x86/entry/thunk_64.S | 4 ----
 arch/x86/um/Makefile      | 3 ++-
 4 files changed, 4 insertions(+), 8 deletions(-)

ChangeLog (v1 -> v2):
 - do not break UML build

diff --git a/arch/x86/entry/Makefile b/arch/x86/entry/Makefile
index 08bf95dbc911..83c98dae74a6 100644
--- a/arch/x86/entry/Makefile
+++ b/arch/x86/entry/Makefile
@@ -21,12 +21,13 @@ CFLAGS_syscall_64.o		+= $(call cc-option,-Wno-override-init,)
 CFLAGS_syscall_32.o		+= $(call cc-option,-Wno-override-init,)
 CFLAGS_syscall_x32.o		+= $(call cc-option,-Wno-override-init,)
 
-obj-y				:= entry_$(BITS).o thunk_$(BITS).o syscall_$(BITS).o
+obj-y				:= entry_$(BITS).o syscall_$(BITS).o
 obj-y				+= common.o
 
 obj-y				+= vdso/
 obj-y				+= vsyscall/
 
+obj-$(CONFIG_PREEMPTION)	+= thunk_$(BITS).o
 obj-$(CONFIG_IA32_EMULATION)	+= entry_64_compat.o syscall_32.o
 obj-$(CONFIG_X86_X32_ABI)	+= syscall_x32.o
 
diff --git a/arch/x86/entry/thunk_32.S b/arch/x86/entry/thunk_32.S
index f1f96d4d8cd6..5997ec0b4b17 100644
--- a/arch/x86/entry/thunk_32.S
+++ b/arch/x86/entry/thunk_32.S
@@ -29,10 +29,8 @@ SYM_CODE_START_NOALIGN(\name)
 SYM_CODE_END(\name)
 	.endm
 
-#ifdef CONFIG_PREEMPTION
 	THUNK preempt_schedule_thunk, preempt_schedule
 	THUNK preempt_schedule_notrace_thunk, preempt_schedule_notrace
 	EXPORT_SYMBOL(preempt_schedule_thunk)
 	EXPORT_SYMBOL(preempt_schedule_notrace_thunk)
-#endif
 
diff --git a/arch/x86/entry/thunk_64.S b/arch/x86/entry/thunk_64.S
index ccd32877a3c4..c7cf79be7231 100644
--- a/arch/x86/entry/thunk_64.S
+++ b/arch/x86/entry/thunk_64.S
@@ -36,14 +36,11 @@ SYM_FUNC_END(\name)
 	_ASM_NOKPROBE(\name)
 	.endm
 
-#ifdef CONFIG_PREEMPTION
 	THUNK preempt_schedule_thunk, preempt_schedule
 	THUNK preempt_schedule_notrace_thunk, preempt_schedule_notrace
 	EXPORT_SYMBOL(preempt_schedule_thunk)
 	EXPORT_SYMBOL(preempt_schedule_notrace_thunk)
-#endif
 
-#ifdef CONFIG_PREEMPTION
 SYM_CODE_START_LOCAL_NOALIGN(.L_restore)
 	popq %r11
 	popq %r10
@@ -58,4 +55,3 @@ SYM_CODE_START_LOCAL_NOALIGN(.L_restore)
 	ret
 	_ASM_NOKPROBE(.L_restore)
 SYM_CODE_END(.L_restore)
-#endif
diff --git a/arch/x86/um/Makefile b/arch/x86/um/Makefile
index 77f70b969d14..3113800da63a 100644
--- a/arch/x86/um/Makefile
+++ b/arch/x86/um/Makefile
@@ -27,7 +27,8 @@ else
 
 obj-y += syscalls_64.o vdso/
 
-subarch-y = ../lib/csum-partial_64.o ../lib/memcpy_64.o ../entry/thunk_64.o
+subarch-y = ../lib/csum-partial_64.o ../lib/memcpy_64.o
+subarch-$(CONFIG_PREEMPTION) += ../entry/thunk_64.o
 
 endif
 
-- 
2.29.2

