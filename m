Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F00F030223B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 07:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbhAYGrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 01:47:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbhAYGpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 01:45:04 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD753C061573
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jan 2021 22:44:23 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id gx1so2316106pjb.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jan 2021 22:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oTvj0bJFQ+clUckTa5Uz1qyRueqmBt51RQhXdKOAiHQ=;
        b=rRokgsrAFUBwxaoCWnS8obc/RfFGHlTvJpxlHRIIsrkEQj6VhXimaIX3E1zcPjD6Tl
         pEuRwweCtLvKauPW2eNyoKtDHAA5oPMu2j2XOIG4WuYqq4z9gvyB7H3x4Tqyvh5owWum
         UMjwaVQR3AE5psrHyVhnUJP8qAzfRmrcK7z8wHt38trVU3yj1Y+VJEz2VOssErTJm6/G
         o2Xm1ET+GSVXBbFSMaGub8o1DnsiRjytKbbUxonUOFTjI5n8Oy/7+FqWJeQgeR+mYuxZ
         d+SngBNJqTdW2PIbBH1wz3UiYcLcZF6IoR6i35ZwYQ28V2t9A7KJgN1eRBH/2t4+SIVo
         uXew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oTvj0bJFQ+clUckTa5Uz1qyRueqmBt51RQhXdKOAiHQ=;
        b=YyCkmPR8jFzfq332gj69yIpBI3I7T5CC0bl3pbSiWeT+I6i6DHWG6Nje7v5e8uAVH+
         looFeofiLir+9ZXgpvX93GwMtRd5oP/dYX4URkXNbDeaNhjyIXoMx5HMoWTBZdNTwIky
         HUAMbRVaSU/26IZY7BYFC4hyG4VQmJ70nogMOOTBZ58Gvfzk79ELhOPpNKO9Zwg1RKuQ
         Az/bNjVpanz2Vcd2FRF7Lmj1Qpslf5O3HtDr2gRr8PsNW885moQPhWd8QA/Lot4d2xAP
         iuIZGvyBSKTTYS/1OLdDRyG0NeaADn0fgE2kcToJ2CkqzKh6hxxix0dNXnR+CODXG+v3
         d5fw==
X-Gm-Message-State: AOAM533zwZjzRN0CkYN683ve5F4WuMhSr5idNwr5DpF7G0aF4svHv3t3
        1tKUHpLosVMOhyyDNOXEhBn/vXdc4BM=
X-Google-Smtp-Source: ABdhPJxTDZk0UnZB53oCMtrXs5n1HqlxCkyK3Bj9cHZOhauS4rU7BrL5BmZkEf2OGCFyAJ42KN44Rw==
X-Received: by 2002:a17:902:a708:b029:da:ec42:a3d4 with SMTP id w8-20020a170902a708b02900daec42a3d4mr1688380plq.40.1611557063133;
        Sun, 24 Jan 2021 22:44:23 -0800 (PST)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id fs14sm13881190pjb.46.2021.01.24.22.44.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Jan 2021 22:44:22 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V2] x86/entry/64: De-Xen-ify our NMI code further
Date:   Mon, 25 Jan 2021 15:45:06 +0800
Message-Id: <20210125074506.15064-1-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <CALCETrW1qP=vbHCSdgOLjjP+-i=io3o1w5bMdtH_UHSV3gvBXg@mail.gmail.com>
References: <CALCETrW1qP=vbHCSdgOLjjP+-i=io3o1w5bMdtH_UHSV3gvBXg@mail.gmail.com>
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

Comments in the code was from Andy Lutomirski.  Thanks!

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry_64.S | 44 ++++++++++-----------------------------
 1 file changed, 11 insertions(+), 33 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index cad08703c4ad..21f67ea62341 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1268,32 +1268,14 @@ SYM_CODE_START(asm_exc_nmi)
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
+	 * Now test if we interrupted an outer NMI that just cleared "NMI
+	 * executing" and is about to IRET.  This is a single-instruction
+	 * window.  This check does not handle the case in which we get a
+	 * nested interrupt (#MC, #VE, #VC, etc.) after clearing
+	 * "NMI executing" but before the outer NMI executes IRET.
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
+	cmpq	$.Lnmi_iret, 8(%rsp)
+	jne	first_nmi
 
 	/* This is a nested NMI. */
 
@@ -1438,17 +1420,13 @@ nmi_restore:
 	addq	$6*8, %rsp
 
 	/*
-	 * Clear "NMI executing".  Set DF first so that we can easily
-	 * distinguish the remaining code between here and IRET from
-	 * the SYSCALL entry and exit paths.
-	 *
-	 * We arguably should just inspect RIP instead, but I (Andy) wrote
-	 * this code when I had the misapprehension that Xen PV supported
-	 * NMIs, and Xen PV would break that approach.
+	 * Clear "NMI executing".  This leaves a window in which a nested NMI
+	 * could observe "NMI executing" cleared, and a nested NMI will detect
+	 * this by inspecting RIP.
 	 */
-	std
 	movq	$0, 5*8(%rsp)		/* clear "NMI executing" */
 
+.Lnmi_iret: /* must be immediately after clearing "NMI executing" */
 	/*
 	 * iretq reads the "iret" frame and exits the NMI stack in a
 	 * single instruction.  We are returning to kernel mode, so this
-- 
2.19.1.6.gb485710b

