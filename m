Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 913B328A63E
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 10:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729123AbgJKIJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 04:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbgJKIJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 04:09:03 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A557C0613CE
        for <linux-kernel@vger.kernel.org>; Sun, 11 Oct 2020 01:09:03 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id u21so19013927eja.2
        for <linux-kernel@vger.kernel.org>; Sun, 11 Oct 2020 01:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=QeJKHKFo1+oYE4cAjCsIuxgUdsxnX+NLFnzJ98hrfSg=;
        b=gX5nqTv1RmW0bev3cCkDv++p6kk92lF0eZa94OFDD13gxCmaSSMdTa1qMXAyiBtihp
         SefLlfiJlwSVOWtPQoRG3CoQcPAaU23YWlczaItO/JeDECAooO0wbDn8A8+OdzAHIvf5
         /vkseHQU+RMwS8VdcaKrqPYe8QbMDg+FZev/Stc3ytWgAobLKoyP2hhASx5WRYdsOA4H
         4Ng5f+2y83RJaEjDCRjri1JEaolXneOdh1dIZXkP9k3Goxh87xblFfnI19sFw1BefLxP
         QPRqIpH0mnan7ZExTpz2lLhDDZ1vmkr4uPhFE85ZUg/jp36reswy3RjNt2w4cNC+oXn5
         Ulqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=QeJKHKFo1+oYE4cAjCsIuxgUdsxnX+NLFnzJ98hrfSg=;
        b=SM9+Zn3e9AZ1pzlhnDe+/P///67W2JjRm7IHxPV914Iwq/l3tNKKX3Mn6oDBh7aQ2y
         9y+LlHyJdDxDuAiC8MuD6yN6SsXfBcXLqgfG5DEmTNJp/E6KvX96C9BqoNgfRVPhRrkw
         MYW+VuFfif34XeL20+EH5tXyhKTbCc1LQflOv7J+95roZC8e/XZfat8Hp/BUi0uBqZEs
         zc/Ld4MGRDq/Xpj0dHauVcVum+Fve7AyFp7R8MbdrIWOpvRf9+hG8Fe56993RHIP5RQe
         pS1z3UNikEggdfsRx3g1m20GX5S8jftAC006bF5jQZw4u2Uya6JTg7rjiCuWhrIbif9H
         e1vw==
X-Gm-Message-State: AOAM531G91jq1J1ZUUGqVz2p97BD4IrCz+mo348hVQGWsUFA2Por8cvq
        ke5EonRLX7nXx0bAM1C11to=
X-Google-Smtp-Source: ABdhPJzdVd06iBfiCtLcuoEX1VtR1A1kZDlU83LJIfzp8JTlCHJ5nHFgo4TXNOpaJ1yoowtm9D3+qw==
X-Received: by 2002:a17:907:43c0:: with SMTP id ok24mr22510837ejb.385.1602403741556;
        Sun, 11 Oct 2020 01:09:01 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id jw9sm9003407ejb.33.2020.10.11.01.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2020 01:09:00 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sun, 11 Oct 2020 10:08:59 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86 fixes
Message-ID: <20201011080859.GA3598074@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86/urgent git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2020-10-11

   # HEAD: 0c7689830e907668288a1a1da84dca66dbdb4728 Documentation/x86: Fix incorrect references to zero-page.txt

Two fixes:

 - Fix a (hopefully final) IRQ state tracking bug vs. MCE handling
 - Fix a documentation link

 Thanks,

	Ingo

------------------>
Heinrich Schuchardt (1):
      Documentation/x86: Fix incorrect references to zero-page.txt

Thomas Gleixner (1):
      x86/mce: Use idtentry_nmi_enter/exit()


 Documentation/x86/boot.rst     | 6 +++---
 arch/x86/kernel/cpu/mce/core.c | 6 ++++--
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/Documentation/x86/boot.rst b/Documentation/x86/boot.rst
index 7fafc7ac00d7..abb9fc164657 100644
--- a/Documentation/x86/boot.rst
+++ b/Documentation/x86/boot.rst
@@ -1342,8 +1342,8 @@ follow::
 
 In addition to read/modify/write the setup header of the struct
 boot_params as that of 16-bit boot protocol, the boot loader should
-also fill the additional fields of the struct boot_params as that
-described in zero-page.txt.
+also fill the additional fields of the struct boot_params as
+described in chapter :doc:`zero-page`.
 
 After setting up the struct boot_params, the boot loader can load the
 32/64-bit kernel in the same way as that of 16-bit boot protocol.
@@ -1379,7 +1379,7 @@ can be calculated as follows::
 In addition to read/modify/write the setup header of the struct
 boot_params as that of 16-bit boot protocol, the boot loader should
 also fill the additional fields of the struct boot_params as described
-in zero-page.txt.
+in chapter :doc:`zero-page`.
 
 After setting up the struct boot_params, the boot loader can load
 64-bit kernel in the same way as that of 16-bit boot protocol, but
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index f43a78bde670..fc4f8c04bdb5 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1904,6 +1904,8 @@ void (*machine_check_vector)(struct pt_regs *) = unexpected_machine_check;
 
 static __always_inline void exc_machine_check_kernel(struct pt_regs *regs)
 {
+	bool irq_state;
+
 	WARN_ON_ONCE(user_mode(regs));
 
 	/*
@@ -1914,7 +1916,7 @@ static __always_inline void exc_machine_check_kernel(struct pt_regs *regs)
 	    mce_check_crashing_cpu())
 		return;
 
-	nmi_enter();
+	irq_state = idtentry_enter_nmi(regs);
 	/*
 	 * The call targets are marked noinstr, but objtool can't figure
 	 * that out because it's an indirect call. Annotate it.
@@ -1925,7 +1927,7 @@ static __always_inline void exc_machine_check_kernel(struct pt_regs *regs)
 	if (regs->flags & X86_EFLAGS_IF)
 		trace_hardirqs_on_prepare();
 	instrumentation_end();
-	nmi_exit();
+	idtentry_exit_nmi(regs, irq_state);
 }
 
 static __always_inline void exc_machine_check_user(struct pt_regs *regs)
