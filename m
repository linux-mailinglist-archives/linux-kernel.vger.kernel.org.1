Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8782B9C9A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 22:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbgKSVHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 16:07:45 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:10019 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726304AbgKSVHo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 16:07:44 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4CcXM14zGlz9v4nj;
        Thu, 19 Nov 2020 22:07:41 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id F-4BTdxGLIpJ; Thu, 19 Nov 2020 22:07:41 +0100 (CET)
Received: from vm-hermes.si.c-s.fr (vm-hermes.si.c-s.fr [192.168.25.253])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4CcXM13sgdz9v4nh;
        Thu, 19 Nov 2020 22:07:41 +0100 (CET)
Received: by vm-hermes.si.c-s.fr (Postfix, from userid 33)
        id 5D1733AF; Thu, 19 Nov 2020 22:10:33 +0100 (CET)
Received: from 192.168.4.90 ([192.168.4.90]) by messagerie.c-s.fr (Horde
 Framework) with HTTP; Thu, 19 Nov 2020 22:10:33 +0100
Date:   Thu, 19 Nov 2020 22:10:33 +0100
Message-ID: <20201119221033.Horde.be-msjDTeIW4XeXARjUu7g1@messagerie.c-s.fr>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Jan Kratochvil <jan.kratochvil@redhat.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] powerpc/ptrace: Hard wire PT_SOFTE value to 1 in
 gpr_get() too
References: <20201119160154.GA5183@redhat.com>
 <20201119160247.GB5188@redhat.com>
In-Reply-To: <20201119160247.GB5188@redhat.com>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.3)
Content-Type: text/plain; charset=UTF-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Quoting Oleg Nesterov <oleg@redhat.com>:

> The commit a8a4b03ab95f ("powerpc: Hard wire PT_SOFTE value to 1 in
> ptrace & signals") changed ptrace_get_reg(PT_SOFTE) to report 0x1,
> but PTRACE_GETREGS still copies pt_regs->softe as is.
>
> This is not consistent and this breaks the user-regs-peekpoke test
> from https://sourceware.org/systemtap/wiki/utrace/tests/
>
> Reported-by: Jan Kratochvil <jan.kratochvil@redhat.com>
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> ---
>  arch/powerpc/kernel/ptrace/ptrace-tm.c   | 8 +++++++-
>  arch/powerpc/kernel/ptrace/ptrace-view.c | 8 +++++++-
>  2 files changed, 14 insertions(+), 2 deletions(-)
>

I think the following should work, and not require the first patch  
(compile tested only).

diff --git a/arch/powerpc/kernel/ptrace/ptrace-tm.c  
b/arch/powerpc/kernel/ptrace/ptrace-tm.c
index 54f2d076206f..f779b3bc0279 100644
--- a/arch/powerpc/kernel/ptrace/ptrace-tm.c
+++ b/arch/powerpc/kernel/ptrace/ptrace-tm.c
@@ -104,8 +104,14 @@ int tm_cgpr_get(struct task_struct *target, const  
struct user_regset *regset,
  		     offsetof(struct pt_regs, msr) + sizeof(long));

  	membuf_write(&to, &target->thread.ckpt_regs.orig_gpr3,
-			sizeof(struct user_pt_regs) -
-			offsetof(struct pt_regs, orig_gpr3));
+		     offsetof(struct pt_regs, softe) - offsetof(struct pt_regs,  
orig_gpr3));
+	membuf_store(&to, 1UL);
+
+	BUILD_BUG_ON(offsetof(struct pt_regs, trap) !=
+		     offsetof(struct pt_regs, softe) + sizeof(long));
+
+	membuf_write(&to, &target->thread.ckpt_regs.trap,
+		     sizeof(struct user_pt_regs) - offsetof(struct pt_regs, trap));
  	return membuf_zero(&to, ELF_NGREG * sizeof(unsigned long) -
  			sizeof(struct user_pt_regs));
  }
diff --git a/arch/powerpc/kernel/ptrace/ptrace-view.c  
b/arch/powerpc/kernel/ptrace/ptrace-view.c
index 7e6478e7ed07..736bfbf33890 100644
--- a/arch/powerpc/kernel/ptrace/ptrace-view.c
+++ b/arch/powerpc/kernel/ptrace/ptrace-view.c
@@ -234,9 +234,21 @@ static int gpr_get(struct task_struct *target,  
const struct user_regset *regset,
  	BUILD_BUG_ON(offsetof(struct pt_regs, orig_gpr3) !=
  		     offsetof(struct pt_regs, msr) + sizeof(long));

+#ifdef CONFIG_PPC64
+	membuf_write(&to, &target->thread.regs->orig_gpr3,
+		     offsetof(struct pt_regs, softe) - offsetof(struct pt_regs,  
orig_gpr3));
+	membuf_store(&to, 1UL);
+
+	BUILD_BUG_ON(offsetof(struct pt_regs, trap) !=
+		     offsetof(struct pt_regs, softe) + sizeof(long));
+
+	membuf_write(&to, &target->thread.regs->trap,
+		     sizeof(struct user_pt_regs) - offsetof(struct pt_regs, trap));
+#else
  	membuf_write(&to, &target->thread.regs->orig_gpr3,
  			sizeof(struct user_pt_regs) -
  			offsetof(struct pt_regs, orig_gpr3));
+#endif
  	return membuf_zero(&to, ELF_NGREG * sizeof(unsigned long) -
  				 sizeof(struct user_pt_regs));
  }
---
Christophe
