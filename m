Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A03F20B6CF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jun 2020 19:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728424AbgFZRVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jun 2020 13:21:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:39848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726924AbgFZRVW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 13:21:22 -0400
Received: from localhost (c-67-180-165-146.hsd1.ca.comcast.net [67.180.165.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D074E2089D;
        Fri, 26 Jun 2020 17:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593192082;
        bh=IsZUG4DWzvA5uLxr8FPqPjPY/G30t4PJ9fenQs+LjGI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YNevlYfKxY6uu/Gi8TBzCE+XdVn7T4ndq5e8PG6MZ1JZcGyH+KFUJidzhoRiEFFyA
         1FTh6R0hLZFEDWjIodr7Gi7GPhdVRkX6rW/ZkwkQQpcldZroFSZy4bdbKaLxN0V/tt
         PRMvw9o6LitoJQo3F5w2IZMseo9jF5Nv/gz7qhrk=
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Juergen Gross <jgross@suse.com>,
        Andy Lutomirski <luto@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org
Subject: [PATCH 3/6] x86/entry/64/compat: Fix Xen PV SYSENTER frame setup
Date:   Fri, 26 Jun 2020 10:21:13 -0700
Message-Id: <947880c41ade688ff4836f665d0c9fcaa9bd1201.1593191971.git.luto@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <cover.1593191971.git.luto@kernel.org>
References: <cover.1593191971.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SYSENTER frame setup was nonsense.  It worked by accident
because the normal code into which the Xen asm jumped
(entry_SYSENTER_32/compat) threw away SP without touching the stack.
entry_SYSENTER_compat was recently modified such that it relied on
having a valid stack pointer, so now the Xen asm needs to invoke it
with a valid stack.

Fix it up like SYSCALL: use the Xen-provided frame and skip the bare
metal prologue.

Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: xen-devel@lists.xenproject.org
Fixes: 1c3e5d3f60e2 ("x86/entry: Make entry_64_compat.S objtool clean")
Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/entry/entry_64_compat.S |  1 +
 arch/x86/xen/xen-asm_64.S        | 20 ++++++++++++++++----
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
index 7b9d8150f652..381a6de7de9c 100644
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -79,6 +79,7 @@ SYM_CODE_START(entry_SYSENTER_compat)
 	pushfq				/* pt_regs->flags (except IF = 0) */
 	pushq	$__USER32_CS		/* pt_regs->cs */
 	pushq	$0			/* pt_regs->ip = 0 (placeholder) */
+SYM_INNER_LABEL(entry_SYSENTER_compat_after_hwframe, SYM_L_GLOBAL)
 	pushq	%rax			/* pt_regs->orig_ax */
 	pushq	%rdi			/* pt_regs->di */
 	pushq	%rsi			/* pt_regs->si */
diff --git a/arch/x86/xen/xen-asm_64.S b/arch/x86/xen/xen-asm_64.S
index 5d252aaeade8..e1e1c7eafa60 100644
--- a/arch/x86/xen/xen-asm_64.S
+++ b/arch/x86/xen/xen-asm_64.S
@@ -161,10 +161,22 @@ SYM_FUNC_END(xen_syscall32_target)
 
 /* 32-bit compat sysenter target */
 SYM_FUNC_START(xen_sysenter_target)
-	mov 0*8(%rsp), %rcx
-	mov 1*8(%rsp), %r11
-	mov 5*8(%rsp), %rsp
-	jmp entry_SYSENTER_compat
+	/*
+	 * NB: Xen is polite and clears TF from EFLAGS for us.  This means
+	 * that we don't need to guard against single step exceptions here.
+	 */
+	popq %rcx
+	popq %r11
+
+	/*
+	 * Neither Xen nor the kernel really knows what the old SS and
+	 * CS were.  The kernel expects __USER32_DS and __USER32_CS, so
+	 * report those values even though Xen will guess its own values.
+	 */
+	movq $__USER32_DS, 4*8(%rsp)
+	movq $__USER32_CS, 1*8(%rsp)
+
+	jmp entry_SYSENTER_compat_after_hwframe
 SYM_FUNC_END(xen_sysenter_target)
 
 #else /* !CONFIG_IA32_EMULATION */
-- 
2.25.4

