Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1983C302805
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 17:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730823AbhAYQhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 11:37:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730655AbhAYQgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 11:36:00 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECDF2C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 08:35:18 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id q7so9259538pgm.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 08:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=izjjW/9zccoyWG/BVlEKLo7XojOKOYywCCSsPOjKEpo=;
        b=bSzjmibwJNIQxPxfx8Mf+GNY0FUVyQlnh4/gOY9DceK+6GAHxT8lLpNUqOjE9QdM9I
         2bG3Efwy6liSoaLXLg+YcdMwuYR7bicgBgadxqVcV7VL+ykKpao2Boj6dpCDMTMOblbm
         djLYRQqv9o1E3fODUocyNQEPI9ZUpY5VD7uY53TT2jMuvgAMdKnwUq2cS8llnNiS1uO/
         9I0ARreDrevu/FK/2hwiCgC/Py+BP/flZtNA/xTWCD2ufNG+opCtbzGuDj01S86b8Ngr
         la0XgxK2JTDkXS1CHG1jZ5FV3/8SEGRT4DzmYEUlCVp8khzUkL8Fa09J+fLfilabAm2r
         TWgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=izjjW/9zccoyWG/BVlEKLo7XojOKOYywCCSsPOjKEpo=;
        b=JvaCDxrsAZH0nJ/tgpTCnym8juysl1OwvX82+d85RO8t4n/i+h0rPk35Z73nUOmw1C
         1BlauQJN70gwIVm6fcYw+BbCYKzBA78ZRyfpPgXiA+ZjjKLzW5MYlId7EyGAThf7pxqH
         VIXdY8Jo+qdH8sMO0qJJJDJGVtld3h2ONaA9KANuADRNUV9fcVSGC+HoUnT2E4388Tl/
         qYteBg8npRJ7WZnhzKr/DtiC65S69J2r6H9XuJHdJIAEubpCS78kHSHI5iUUPAA2VZRT
         OSRaLxfGsXHFCUtmaLTueD2nSJ5sRlut9FSeL+jFSZnJlOMXoUmgox+tIcJCnLwUelwb
         RrDg==
X-Gm-Message-State: AOAM532Le54Eo+NVyQlVGVh0b0DmTE2XBcbD5nrV8y9IlMBFNZoW23pi
        0uUYD5eiigsMZXuAHXVxdM84NXs06lFsSQ==
X-Google-Smtp-Source: ABdhPJy7jZWWYvVDd0nwA+v7B/JaReDjfKm1w5oovf9ottFahg2Xe0P0Yx5tCC/Hc+crEgLkYPYz3Q==
X-Received: by 2002:aa7:8b0f:0:b029:1c0:e782:ba29 with SMTP id f15-20020aa78b0f0000b02901c0e782ba29mr1161353pfd.37.1611592518357;
        Mon, 25 Jan 2021 08:35:18 -0800 (PST)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id a4sm17293260pfg.41.2021.01.25.08.35.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jan 2021 08:35:17 -0800 (PST)
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
Subject: [PATCH V2 4/6] x86_32/sysenter: restore %fs before switching stack
Date:   Tue, 26 Jan 2021 01:34:32 +0800
Message-Id: <20210125173444.22696-5-jiangshanlai@gmail.com>
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

Prepare for using percpu and removing TSS_entry2task_stack

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry_32.S | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 4513702ba45d..a8d2640394f9 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -279,11 +279,13 @@
 .Lfinished_frame_\@:
 .endm
 
-.macro SAVE_ALL pt_regs_ax=%eax switch_stacks=0 skip_gs=0 unwind_espfix=0
+.macro SAVE_ALL pt_regs_ax=%eax switch_stacks=0 skip_gs=0 skip_fs=0 unwind_espfix=0
 	cld
 .if \skip_gs == 0
 	PUSH_GS
 .endif
+
+.if \skip_fs == 0
 	pushl	%fs
 
 	pushl	%eax
@@ -293,6 +295,7 @@
 	UNWIND_ESPFIX_STACK
 .endif
 	popl	%eax
+.endif
 
 	FIXUP_FRAME
 	pushl	%es
@@ -906,18 +909,27 @@ SYM_FUNC_START(entry_SYSENTER_32)
 	BUG_IF_WRONG_CR3 no_user_check=1
 	SWITCH_TO_KERNEL_CR3 scratch_reg=%eax
 
+	/* Restore kernel %fs, so that we can use PERCPU */
+	pushl	%fs
+	movl	$(__KERNEL_PERCPU), %eax
+	movl	%eax, %fs
+
 	/* Switch to task stack */
 	movl	%esp, %eax
-	movl	(2*4+TSS_entry2task_stack)(%esp), %esp
+	movl	(3*4+TSS_entry2task_stack)(%esp), %esp
 
 .Lsysenter_past_esp:
 	pushl	$__USER_DS		/* pt_regs->ss */
 	pushl	$0			/* pt_regs->sp (placeholder) */
-	pushl	4(%eax)			/* pt_regs->flags (except IF = 0) */
+	pushl	8(%eax)			/* pt_regs->flags (except IF = 0) */
 	pushl	$__USER_CS		/* pt_regs->cs */
 	pushl	$0			/* pt_regs->ip = 0 (placeholder) */
-	pushl	(%eax)			/* pt_regs->orig_ax */
-	SAVE_ALL pt_regs_ax=$-ENOSYS	/* save rest, stack already switched */
+	pushl	4(%eax)			/* pt_regs->orig_ax */
+	PUSH_GS				/* pt_regs->gs */
+	pushl	(%eax)			/* pt_regs->fs */
+	/* save rest, stack and %fs already switched */
+	SAVE_ALL pt_regs_ax=$-ENOSYS skip_gs=1 skip_fs=1
+	SET_KERNEL_GS %edx
 
 	/*
 	 * SYSENTER doesn't filter flags, so we need to clear NT, AC
-- 
2.19.1.6.gb485710b

