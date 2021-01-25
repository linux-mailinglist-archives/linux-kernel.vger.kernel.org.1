Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72EF0301FD5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 02:15:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbhAYBPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 20:15:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbhAYBOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 20:14:34 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C3BC061574
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jan 2021 17:13:53 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id a20so4379060pjs.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jan 2021 17:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kpR+LcqUG8WrnRhBIsNcli5gcV2dsTTenYMD+YFbDe4=;
        b=oeHsQIH+A/HOjIZkjTsKNuieUwtVwvKpJxOB8v2Krv8lA2Adpfzp4XGLMS/lE1KsqB
         Qji4pW/MIpGhUAySJwtv36LPpJkFN+nkuAeoekirNYD1+wTZss+UrDcoA512H/mRpTNJ
         qWh/rZcgmHPvUqmtt07hxIaJR8fmKApBCgAeP5pp+M+QfYzniw/TMDEK5qhxwVtrs1b+
         tYM5F/Tjn0Lzm9HWbkWgObcblKbNzdzZoGWSz3iasNGYsSLeyHgZIZPu74RNkeya4IBf
         vzKH0MKjBl5azhhZzdvHa1tRAyEN7Eq3EFQuk2QS/4dtGqbZvByvSZWV5liZP/oF7PdF
         Dajw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kpR+LcqUG8WrnRhBIsNcli5gcV2dsTTenYMD+YFbDe4=;
        b=uFuhSBWdYnYqNUKI/qdopyUn9feKIV0jFzJo3sCFR0hG3CyVDWNHNo0OzGSc9wEQij
         m3ohJdg4zvknO/6H7zQr70KBSh86ZhglYXzbTdXQWUwFmJXvhadcKTz0owECBIERmQ1s
         QTl7KKOL7og1gnXuWo6K1X0pJAne6wyozvwJrfRSuFd00N//17OHZOJ9VVaA2kS/bdBf
         Rnxx6cbQaKm/1KQDhLxQt8kO2eJCjMQHbo8o18RhILrx1RXWrIWlgowQEbFOQb71h1Lg
         Js6QM8fGC7GcEsFysD1WCOKHBZ1+sMI6/4+asVD3b1W8uXEWqpbmXLVF7x9IkgI7u0rh
         /ikw==
X-Gm-Message-State: AOAM532vHP7tvUDJnmC2L0shegz2SqZYwbbg0pOg10+qcDJx+kyd52Tm
        /XJBKM8vYv2SrV+dYdDc5nSh3v4fUTs=
X-Google-Smtp-Source: ABdhPJx5SjZ5bXbbbSAxuhhvXXBb+J4jCkx7zHTxJ6639nURTCPlKP1Z3mj4smZesxRqnI4PU8Mg2Q==
X-Received: by 2002:a17:90a:17c8:: with SMTP id q66mr18729740pja.167.1611537233337;
        Sun, 24 Jan 2021 17:13:53 -0800 (PST)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id 21sm322762pfh.56.2021.01.24.17.13.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Jan 2021 17:13:52 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] x86/entry/64: De-Xen-ify our NMI code further
Date:   Mon, 25 Jan 2021 10:14:35 +0800
Message-Id: <20210125021435.16646-1-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

The commit 929bacec21478("x86/entry/64: De-Xen-ify our NMI code") simplified
the NMI code by changing paravirt code into native code and left a comment
about "inspecting RIP instead".  But until now, "inspecting RIP instead"
has not been made happened and this patch tries to complete it.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry_64.S | 46 +++++++++++----------------------------
 1 file changed, 13 insertions(+), 33 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index cad08703c4ad..cb6b8a6c6652 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1268,32 +1268,12 @@ SYM_CODE_START(asm_exc_nmi)
 	je	nested_nmi
 
 	/*
-	 * Now test if the previous stack was an NMI stack.  This covers
-	 * the case where we interrupt an outer NMI after it clears
-	 * "NMI executing" but before IRET.  We need to be careful, though:
-	 * there is one case in which RSP could point to the NMI stack
-	 * despite there being no NMI active: naughty userspace controls
-	 * RSP at the very beginning of the SYSCALL targets.  We can
-	 * pull a fast one on naughty userspace, though: we program
-	 * SYSCALL to mask DF, so userspace cannot cause DF to be set
-	 * if it controls the kernel's RSP.  We set DF before we clear
-	 * "NMI executing".
+	 * Now test if we interrupt an outer NMI after it clears
+	 * "NMI executing" but before iret.
 	 */
-	lea	6*8(%rsp), %rdx
-	/* Compare the NMI stack (rdx) with the stack we came from (4*8(%rsp)) */
-	cmpq	%rdx, 4*8(%rsp)
-	/* If the stack pointer is above the NMI stack, this is a normal NMI */
-	ja	first_nmi
-
-	subq	$EXCEPTION_STKSZ, %rdx
-	cmpq	%rdx, 4*8(%rsp)
-	/* If it is below the NMI stack, it is a normal NMI */
-	jb	first_nmi
-
-	/* Ah, it is within the NMI stack. */
-
-	testb	$(X86_EFLAGS_DF >> 8), (3*8 + 1)(%rsp)
-	jz	first_nmi	/* RSP was user controlled. */
+	movq	$nmi_executing_cleared, %rdx
+	cmpq	8(%rsp), %rdx
+	jne	first_nmi
 
 	/* This is a nested NMI. */
 
@@ -1438,16 +1418,16 @@ nmi_restore:
 	addq	$6*8, %rsp
 
 	/*
-	 * Clear "NMI executing".  Set DF first so that we can easily
-	 * distinguish the remaining code between here and IRET from
-	 * the SYSCALL entry and exit paths.
-	 *
-	 * We arguably should just inspect RIP instead, but I (Andy) wrote
-	 * this code when I had the misapprehension that Xen PV supported
-	 * NMIs, and Xen PV would break that approach.
+	 * Clear "NMI executing".  It also leaves a window after it before
+	 * iret which should be also considered to be "NMI executing" albeit
+	 * with "NMI executing" variable being zero.  So we should also check
+	 * the RIP after it when checking "NMI executing".  See the code
+	 * before nested_nmi.  No code is allowed to be added to between
+	 * clearing "NMI executing" and iret unless we check a larger window
+	 * with a range of RIPs instead of currently a single-RIP window.
 	 */
-	std
 	movq	$0, 5*8(%rsp)		/* clear "NMI executing" */
+nmi_executing_cleared:
 
 	/*
 	 * iretq reads the "iret" frame and exits the NMI stack in a
-- 
2.19.1.6.gb485710b

