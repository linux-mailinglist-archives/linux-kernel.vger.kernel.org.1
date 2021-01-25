Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6985930281F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 17:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730821AbhAYQmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 11:42:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728927AbhAYQfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 11:35:53 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18174C0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 08:35:03 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id q7so9258707pgm.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 08:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=boDIhTNveL/8HHbCdQWZkom//s1uIHiPUA052kJfxyw=;
        b=M7Dlr/sTMUd7pIVTpkNSZ0QPlSH+HUO7eSm66TTopBn1QyoMIzpD9dprUK1YTNciJa
         AjZHqXtpZrNr89W2I4tXKNFHfAVWtEjRj5KrKXMViCxncoKGeoiVS3yYVJ55LIMYbOe4
         35Pd6v7Y90PfjOLFsIIcPjCcurt1EyNr7pogv3CzLW1Z5s3/tLIR19atVWqgAlcR337q
         vHKgVmGlym4Mn/WC2u3SUzJqUDm7psYpPn7F7wlX0mHLKTWcrUOsE6CiSubagP8bk2Bd
         9LUqFHMtlXCe+3n9ha/HjpXyGhXJHKRFiatHd4x1YkGWgk6SJ9Y/LeslZc3nTFd55GrX
         DojQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=boDIhTNveL/8HHbCdQWZkom//s1uIHiPUA052kJfxyw=;
        b=t5wl91ElQ3VFnDFBOltf8CxZVwMnhlsepMZr5opRR5RTDPNhInSTIUbzS0pLNfGC92
         gOLCoX0LHFMskvNlgktafqLWKe5zBkWPb8cl1H8p4rhKBiSXgOGNveoJyoWTtp2HyZVK
         nWfQt25sQMks9k/5fKS3C3CW7B9tE0IzKokTDy2Ju6WV5XOtoMDljfY5F7y5DK1C8MQ/
         kZ7pDPZtygFTT+X+12MkbFNdSUoN0qB2Z5nAjLfOPhRAFN/OvdqeR4ScC/XbZRk/Z4OM
         ak7nmwEcXGvdw0KYWUykyf4nxbIPjxzLICwQhfIO/e8F/SWVoWV3Oeu++3hi7VODK7i9
         W3ug==
X-Gm-Message-State: AOAM533QFH22dCdmEKyCjSUQAKTF8aDV3+lvSTEItuh++PdhueAtojW0
        9H/JzAZUAnHMm5XOTXoWW5GuMs3Rkof/mA==
X-Google-Smtp-Source: ABdhPJxJ+YMIRL9lCPsWVlo9wOx7JfperulYU/Z+kULUdNSuazEVNS6xO0P5fxyrGdR4dxsdTpBH5Q==
X-Received: by 2002:a62:e516:0:b029:156:3b35:9423 with SMTP id n22-20020a62e5160000b02901563b359423mr1292417pff.19.1611592502344;
        Mon, 25 Jan 2021 08:35:02 -0800 (PST)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id r7sm3459001pfc.26.2021.01.25.08.35.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jan 2021 08:35:01 -0800 (PST)
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
Subject: [PATCH V2 3/6] x86_32/sysenter: switch to the task stack without emptying the entry stack
Date:   Tue, 26 Jan 2021 01:34:31 +0800
Message-Id: <20210125173444.22696-4-jiangshanlai@gmail.com>
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

Like the way x86_64 uses the "old" stack, we can save the entry stack
pointer to a register and switch to the task stack.  So that we have
space on the "old" stack to save more things or scratch registers.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry_32.S | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 3b4d1a63d1f0..4513702ba45d 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -905,19 +905,18 @@ SYM_FUNC_START(entry_SYSENTER_32)
 	pushl	%eax
 	BUG_IF_WRONG_CR3 no_user_check=1
 	SWITCH_TO_KERNEL_CR3 scratch_reg=%eax
-	popl	%eax
-	popfl
 
-	/* Stack empty again, switch to task stack */
-	movl	TSS_entry2task_stack(%esp), %esp
+	/* Switch to task stack */
+	movl	%esp, %eax
+	movl	(2*4+TSS_entry2task_stack)(%esp), %esp
 
 .Lsysenter_past_esp:
 	pushl	$__USER_DS		/* pt_regs->ss */
 	pushl	$0			/* pt_regs->sp (placeholder) */
-	pushfl				/* pt_regs->flags (except IF = 0) */
+	pushl	4(%eax)			/* pt_regs->flags (except IF = 0) */
 	pushl	$__USER_CS		/* pt_regs->cs */
 	pushl	$0			/* pt_regs->ip = 0 (placeholder) */
-	pushl	%eax			/* pt_regs->orig_ax */
+	pushl	(%eax)			/* pt_regs->orig_ax */
 	SAVE_ALL pt_regs_ax=$-ENOSYS	/* save rest, stack already switched */
 
 	/*
-- 
2.19.1.6.gb485710b

