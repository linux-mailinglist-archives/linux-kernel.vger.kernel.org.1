Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 916D62F6083
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 12:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbhANLtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 06:49:21 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:52095 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbhANLtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 06:49:20 -0500
Received: from mail-wm1-f72.google.com ([209.85.128.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <andrea.righi@canonical.com>)
        id 1l017G-0002L9-Ig
        for linux-kernel@vger.kernel.org; Thu, 14 Jan 2021 11:48:38 +0000
Received: by mail-wm1-f72.google.com with SMTP id f187so1818772wme.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 03:48:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=FLLYZm9rUD9tfKVOhVNJx/ygk7Jnkfk1bz9+k9DmnUA=;
        b=Gg8mrUXRCeQ9Jol/2rPF+ihaV0TnBmgW7QuR/rnSze4c4POGU18I+V0x2bfpRT3U/g
         AThuc2XWMHtaSHDG9rgTyT+iIt2OFomgPE3SLtfFyOzzCOZ5ptA/xbv/V7gNyhq1ZnBa
         z6AaKzU6hoypujsuJTrbP0dvp208L8TYDEvkCIXE8ZKBdggZrS1gkxgj/T0ak9rgsWTf
         0C98MqFmc3BfMLSVCe0xXp2UFNgci+qJnce0B2WRkadQ6ckkRjk1PX6PLbcnwAoe8kFY
         54DNCUJl+TXR428vpYmpR46p6Jf0YsF5v/IryPWb1CefVK03UMJqImUyN9jLjt8k/4Z/
         8SxQ==
X-Gm-Message-State: AOAM5311G/aVIgXM0BPSDdjUilK/RAEDODC+qw+LKTKqS6bHFXYDhXdk
        TzzCO1VAa/XP1S4a4Dwr80EeCSgOPF3fLFawRJbMvN1A4g1Q3qPo/wbMme5miaVWRn6yzDwlJLm
        Z7zNqUK5mfNrbjaQlu5MSaNx59Q6cs/t1bPlzPeMigA==
X-Received: by 2002:adf:9525:: with SMTP id 34mr7685307wrs.389.1610624917165;
        Thu, 14 Jan 2021 03:48:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyzp2JOX8Z2GwBB8GZbRAaBN/k8RAxAFC3QRW1azqx4Nio8+CVTzC/Ktlf+ZHqsSh9LW15MBw==
X-Received: by 2002:adf:9525:: with SMTP id 34mr7685277wrs.389.1610624916833;
        Thu, 14 Jan 2021 03:48:36 -0800 (PST)
Received: from localhost (host-95-235-157-85.retail.telecomitalia.it. [95.235.157.85])
        by smtp.gmail.com with ESMTPSA id r82sm8348002wma.18.2021.01.14.03.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 03:48:36 -0800 (PST)
Date:   Thu, 14 Jan 2021 12:48:35 +0100
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86/entry: build thunk_$(BITS) only if CONFIG_PREEMPTION=y
Message-ID: <YAAvk0UQelq0Ae7+@xps-13-7390>
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
 3 files changed, 2 insertions(+), 7 deletions(-)

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
-- 
2.29.2

