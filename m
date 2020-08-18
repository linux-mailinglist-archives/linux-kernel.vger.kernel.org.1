Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2AA248CDB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 19:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728832AbgHRRVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 13:21:40 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:22687 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726836AbgHRRTT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 13:19:19 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BWHhL6MRTz9vCxq;
        Tue, 18 Aug 2020 19:19:14 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id ZN1PWKNUWFtk; Tue, 18 Aug 2020 19:19:14 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BWHhL5bhXz9vCxg;
        Tue, 18 Aug 2020 19:19:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 943BA8B7EC;
        Tue, 18 Aug 2020 19:19:16 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id wfILgMUBQyIW; Tue, 18 Aug 2020 19:19:16 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 566798B7D7;
        Tue, 18 Aug 2020 19:19:16 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 3824665CF4; Tue, 18 Aug 2020 17:19:16 +0000 (UTC)
Message-Id: <24a1baedea7f7ae7b6bf27be98bab6d01b5ca2c1.1597770847.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1597770847.git.christophe.leroy@csgroup.eu>
References: <cover.1597770847.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 04/25] powerpc/ptrace: Create ptrace_get_fpr() and
 ptrace_put_fpr()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 18 Aug 2020 17:19:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the same model as ptrace_get_reg() and ptrace_put_reg(),
create ptrace_get_fpr() and ptrace_put_fpr() to get/set
the floating points registers.

We move the boundary checkings in them.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/ptrace/Makefile      |  1 +
 arch/powerpc/kernel/ptrace/ptrace-decl.h |  4 +++
 arch/powerpc/kernel/ptrace/ptrace-fpu.c  | 40 ++++++++++++++++++++++++
 arch/powerpc/kernel/ptrace/ptrace.c      | 40 +++++++-----------------
 4 files changed, 56 insertions(+), 29 deletions(-)
 create mode 100644 arch/powerpc/kernel/ptrace/ptrace-fpu.c

diff --git a/arch/powerpc/kernel/ptrace/Makefile b/arch/powerpc/kernel/ptrace/Makefile
index c2f2402ebc8c..77abd1a5a508 100644
--- a/arch/powerpc/kernel/ptrace/Makefile
+++ b/arch/powerpc/kernel/ptrace/Makefile
@@ -6,6 +6,7 @@
 CFLAGS_ptrace-view.o		+= -DUTS_MACHINE='"$(UTS_MACHINE)"'
 
 obj-y				+= ptrace.o ptrace-view.o
+obj-y				+= ptrace-fpu.o
 obj-$(CONFIG_COMPAT)		+= ptrace32.o
 obj-$(CONFIG_VSX)		+= ptrace-vsx.o
 ifneq ($(CONFIG_VSX),y)
diff --git a/arch/powerpc/kernel/ptrace/ptrace-decl.h b/arch/powerpc/kernel/ptrace/ptrace-decl.h
index 2ddc68412fa8..eafe5f0f6289 100644
--- a/arch/powerpc/kernel/ptrace/ptrace-decl.h
+++ b/arch/powerpc/kernel/ptrace/ptrace-decl.h
@@ -164,6 +164,10 @@ int ptrace_put_reg(struct task_struct *task, int regno, unsigned long data);
 
 extern const struct user_regset_view user_ppc_native_view;
 
+/* ptrace-fpu */
+int ptrace_get_fpr(struct task_struct *child, int index, unsigned long *data);
+int ptrace_put_fpr(struct task_struct *child, int index, unsigned long data);
+
 /* ptrace-(no)adv */
 void ppc_gethwdinfo(struct ppc_debug_info *dbginfo);
 int ptrace_get_debugreg(struct task_struct *child, unsigned long addr,
diff --git a/arch/powerpc/kernel/ptrace/ptrace-fpu.c b/arch/powerpc/kernel/ptrace/ptrace-fpu.c
new file mode 100644
index 000000000000..8301cb52dd99
--- /dev/null
+++ b/arch/powerpc/kernel/ptrace/ptrace-fpu.c
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <linux/regset.h>
+
+#include <asm/switch_to.h>
+
+#include "ptrace-decl.h"
+
+int ptrace_get_fpr(struct task_struct *child, int index, unsigned long *data)
+{
+	unsigned int fpidx = index - PT_FPR0;
+
+	if (index > PT_FPSCR)
+		return -EIO;
+
+	flush_fp_to_thread(child);
+	if (fpidx < (PT_FPSCR - PT_FPR0))
+		memcpy(data, &child->thread.TS_FPR(fpidx), sizeof(long));
+	else
+		*data = child->thread.fp_state.fpscr;
+
+	return 0;
+}
+
+int ptrace_put_fpr(struct task_struct *child, int index, unsigned long data)
+{
+	unsigned int fpidx = index - PT_FPR0;
+
+	if (index > PT_FPSCR)
+		return -EIO;
+
+	flush_fp_to_thread(child);
+	if (fpidx < (PT_FPSCR - PT_FPR0))
+		memcpy(&child->thread.TS_FPR(fpidx), &data, sizeof(long));
+	else
+		child->thread.fp_state.fpscr = data;
+
+	return 0;
+}
+
diff --git a/arch/powerpc/kernel/ptrace/ptrace.c b/arch/powerpc/kernel/ptrace/ptrace.c
index 51557a9c0765..3d44b73adb83 100644
--- a/arch/powerpc/kernel/ptrace/ptrace.c
+++ b/arch/powerpc/kernel/ptrace/ptrace.c
@@ -56,25 +56,17 @@ long arch_ptrace(struct task_struct *child, long request,
 		ret = -EIO;
 		/* convert to index and check */
 		index = addr / sizeof(long);
-		if ((addr & (sizeof(long) - 1)) || (index > PT_FPSCR)
-		    || (child->thread.regs == NULL))
+		if ((addr & (sizeof(long) - 1)) || !child->thread.regs)
 			break;
 
 		CHECK_FULL_REGS(child->thread.regs);
-		if (index < PT_FPR0) {
+		if (index < PT_FPR0)
 			ret = ptrace_get_reg(child, (int) index, &tmp);
-			if (ret)
-				break;
-		} else {
-			unsigned int fpidx = index - PT_FPR0;
-
-			flush_fp_to_thread(child);
-			if (fpidx < (PT_FPSCR - PT_FPR0))
-				memcpy(&tmp, &child->thread.TS_FPR(fpidx),
-				       sizeof(long));
-			else
-				tmp = child->thread.fp_state.fpscr;
-		}
+		else
+			ret = ptrace_get_fpr(child, index, &tmp);
+
+		if (ret)
+			break;
 		ret = put_user(tmp, datalp);
 		break;
 	}
@@ -86,24 +78,14 @@ long arch_ptrace(struct task_struct *child, long request,
 		ret = -EIO;
 		/* convert to index and check */
 		index = addr / sizeof(long);
-		if ((addr & (sizeof(long) - 1)) || (index > PT_FPSCR)
-		    || (child->thread.regs == NULL))
+		if ((addr & (sizeof(long) - 1)) || !child->thread.regs)
 			break;
 
 		CHECK_FULL_REGS(child->thread.regs);
-		if (index < PT_FPR0) {
+		if (index < PT_FPR0)
 			ret = ptrace_put_reg(child, index, data);
-		} else {
-			unsigned int fpidx = index - PT_FPR0;
-
-			flush_fp_to_thread(child);
-			if (fpidx < (PT_FPSCR - PT_FPR0))
-				memcpy(&child->thread.TS_FPR(fpidx), &data,
-				       sizeof(long));
-			else
-				child->thread.fp_state.fpscr = data;
-			ret = 0;
-		}
+		else
+			ret = ptrace_put_fpr(child, index, data);
 		break;
 	}
 
-- 
2.25.0

