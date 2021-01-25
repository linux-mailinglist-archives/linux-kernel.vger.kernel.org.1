Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D63B2302816
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 17:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730820AbhAYQlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 11:41:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730781AbhAYQgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 11:36:39 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5A3C061786
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 08:35:58 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id j12so8719912pjy.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 08:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z41UuKh+J5aniE9+28c3DumogNmp+4Y18W99bbzbbBM=;
        b=WK19KQkZCYCTyhv+cncKz2OmECR9h+SoB3yc9f+g2b6uDLU1ojYhD70oqZD0ev+dVu
         5s9TJ5z/4omLDqJtYlrfGsI4keHPEQBOrj4ix6fDyb4ZgIC8KXqpJedTFikBoAIjsDeS
         7+mI7GlnbzfiPfUiJFF8ejaA3oe3paAol6YaOSqYj23zV+0Z+hFHQz4y3mkKnNBGwoUI
         zLKeykcU2AzbF3SG8Mw5GzvWTl751r2NKnShG5BsW9co+ZMiCBivLB2FigQuFoxGzZfe
         ti9XmAZZjI4XjmsrGQiK2g+amtf5HBXsl85CQFGQR5aS0r7L22ZlyIy2eh8a1JFwlQf9
         QkHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z41UuKh+J5aniE9+28c3DumogNmp+4Y18W99bbzbbBM=;
        b=nut7ODO/46J6MeaJJJaNPuqzMFRRlLh2g/sjqmIsM2ka6RSh6jSZ6pb8mo+NY7w/6t
         KxqXGFw7cgVld3mOpKK0V9kWeeUAGUczMfqx9h/lUGT9cgUwP3lvaOtAW2AbvcOxYpd0
         ehJBjLF8X62T/Npbi1gM9j/u2lG8aJjJWcoh3qnbS7MSOSjII6+rNzNU2BcFE63OPwEQ
         g/xvtu9TgXWllJgwl0jpRsLzKk7PQWNqUm3A+v0JnzUd3mNc3HjQ40Rk1uYwToELPY3H
         FGls3aVRFrdbkjKSSdGKZQpN5WT6B0OVlvjLqic9Lvt8j8dl/TFifvOFWjTFKoYQXRx9
         F0DA==
X-Gm-Message-State: AOAM530ban5Z67QIJJJqka7nYOGvOH9O3UvxTvTTN6deFIAV5j6bM3Kw
        /wH4R8luP0S3MrSz55YdkM7xpzVfvFUbXA==
X-Google-Smtp-Source: ABdhPJwS8xLIyQ0VuBobIO3kxH1bw+94N8qxKq7O0Msc3aL+tSsBdXymgC0QjBHEio0ThFhObTKAMQ==
X-Received: by 2002:a17:90b:246:: with SMTP id fz6mr1001381pjb.131.1611592558269;
        Mon, 25 Jan 2021 08:35:58 -0800 (PST)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id q141sm7200350pfc.24.2021.01.25.08.35.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jan 2021 08:35:57 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Joerg Roedel <jroedel@suse.de>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Kees Cook <keescook@chromium.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Brian Gerst <brgerst@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Mike Rapoport <rppt@kernel.org>, Mike Hommey <mh@glandium.org>,
        Mark Gross <mgross@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Anthony Steinhauser <asteinhauser@google.com>,
        Jay Lang <jaytlang@mit.edu>,
        "Chang S. Bae" <chang.seok.bae@intel.com>
Subject: [PATCH V2 5/6] x86_32/sysenter: use percpu to get thread.sp0 when sysenter
Date:   Tue, 26 Jan 2021 01:34:33 +0800
Message-Id: <20210125173444.22696-6-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20210125173444.22696-1-jiangshanlai@gmail.com>
References: <CALCETrWPnvNr9S2hsxL+pbhNWv0OOL7tBq1XmABPjYK7zZSJbw@mail.gmail.com>
 <20210125173444.22696-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

TSS_entry2task_stack is used to refer to tss.sp1 which is stored the value
of thread.sp0.

At the code where TSS_entry2task_stack is used in sysenter, the CR3 is
already kernel CR3 and kernel segments is loaded.

So that we can directly use percpu for it instead of offset-calculation.

And we remove the unused TSS_entry2task_stack.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry_32.S        |  2 +-
 arch/x86/kernel/asm-offsets_32.c | 10 ----------
 2 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index a8d2640394f9..3cb42efb3c04 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -916,7 +916,7 @@ SYM_FUNC_START(entry_SYSENTER_32)
 
 	/* Switch to task stack */
 	movl	%esp, %eax
-	movl	(3*4+TSS_entry2task_stack)(%esp), %esp
+	movl	PER_CPU_VAR(cpu_tss_rw + TSS_sp1), %esp
 
 .Lsysenter_past_esp:
 	pushl	$__USER_DS		/* pt_regs->ss */
diff --git a/arch/x86/kernel/asm-offsets_32.c b/arch/x86/kernel/asm-offsets_32.c
index 6e043f295a60..6d4143cfbf03 100644
--- a/arch/x86/kernel/asm-offsets_32.c
+++ b/arch/x86/kernel/asm-offsets_32.c
@@ -43,16 +43,6 @@ void foo(void)
 	OFFSET(saved_context_gdt_desc, saved_context, gdt_desc);
 	BLANK();
 
-	/*
-	 * Offset from the entry stack to task stack stored in TSS. Kernel entry
-	 * happens on the per-cpu entry-stack, and the asm code switches to the
-	 * task-stack pointer stored in x86_tss.sp1, which is a copy of
-	 * task->thread.sp0 where entry code can find it.
-	 */
-	DEFINE(TSS_entry2task_stack,
-	       offsetof(struct cpu_entry_area, tss.x86_tss.sp1) -
-	       offsetofend(struct cpu_entry_area, entry_stack_page.stack));
-
 #ifdef CONFIG_STACKPROTECTOR
 	BLANK();
 	OFFSET(stack_canary_offset, stack_canary, canary);
-- 
2.19.1.6.gb485710b

