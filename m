Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9AB2CF27A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 17:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729350AbgLDQ6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 11:58:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:59410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726309AbgLDQ6p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 11:58:45 -0500
From:   Arnd Bergmann <arnd@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [PATCH 2/2] elfcore: fix building with clang
Date:   Fri,  4 Dec 2020 17:57:34 +0100
Message-Id: <20201204165742.3815221-2-arnd@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201204165742.3815221-1-arnd@kernel.org>
References: <20201204165742.3815221-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

kernel/elfcore.c only contains weak symbols, which triggers
a bug with clang in combination with recordmcount:

Cannot find symbol for section 2: .text.
kernel/elfcore.o: failed

Move the empty stubs into linux/elfcore.h as inline functions.
As only two architectures use these, just use the architecture
specific Kconfig symbols to key off the declaration.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/elfcore.h | 22 ++++++++++++++++++++++
 kernel/Makefile         |  1 -
 kernel/elfcore.c        | 26 --------------------------
 3 files changed, 22 insertions(+), 27 deletions(-)
 delete mode 100644 kernel/elfcore.c

diff --git a/include/linux/elfcore.h b/include/linux/elfcore.h
index 46c3d691f677..de51c1bef27d 100644
--- a/include/linux/elfcore.h
+++ b/include/linux/elfcore.h
@@ -104,6 +104,7 @@ static inline int elf_core_copy_task_fpregs(struct task_struct *t, struct pt_reg
 #endif
 }
 
+#if defined(CONFIG_UM) || defined(CONFIG_IA64)
 /*
  * These functions parameterize elf_core_dump in fs/binfmt_elf.c to write out
  * extra segments containing the gate DSO contents.  Dumping its
@@ -118,5 +119,26 @@ elf_core_write_extra_phdrs(struct coredump_params *cprm, loff_t offset);
 extern int
 elf_core_write_extra_data(struct coredump_params *cprm);
 extern size_t elf_core_extra_data_size(void);
+#else
+static inline Elf_Half elf_core_extra_phdrs(void)
+{
+	return 0;
+}
+
+static inline int elf_core_write_extra_phdrs(struct coredump_params *cprm, loff_t offset)
+{
+	return 1;
+}
+
+static inline int elf_core_write_extra_data(struct coredump_params *cprm)
+{
+	return 1;
+}
+
+static inline size_t elf_core_extra_data_size(void)
+{
+	return 0;
+}
+#endif
 
 #endif /* _LINUX_ELFCORE_H */
diff --git a/kernel/Makefile b/kernel/Makefile
index aac15aeb9d69..dddf51266719 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -97,7 +97,6 @@ obj-$(CONFIG_TASK_DELAY_ACCT) += delayacct.o
 obj-$(CONFIG_TASKSTATS) += taskstats.o tsacct.o
 obj-$(CONFIG_TRACEPOINTS) += tracepoint.o
 obj-$(CONFIG_LATENCYTOP) += latencytop.o
-obj-$(CONFIG_ELFCORE) += elfcore.o
 obj-$(CONFIG_FUNCTION_TRACER) += trace/
 obj-$(CONFIG_TRACING) += trace/
 obj-$(CONFIG_TRACE_CLOCK) += trace/
diff --git a/kernel/elfcore.c b/kernel/elfcore.c
deleted file mode 100644
index 57fb4dcff434..000000000000
--- a/kernel/elfcore.c
+++ /dev/null
@@ -1,26 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <linux/elf.h>
-#include <linux/fs.h>
-#include <linux/mm.h>
-#include <linux/binfmts.h>
-#include <linux/elfcore.h>
-
-Elf_Half __weak elf_core_extra_phdrs(void)
-{
-	return 0;
-}
-
-int __weak elf_core_write_extra_phdrs(struct coredump_params *cprm, loff_t offset)
-{
-	return 1;
-}
-
-int __weak elf_core_write_extra_data(struct coredump_params *cprm)
-{
-	return 1;
-}
-
-size_t __weak elf_core_extra_data_size(void)
-{
-	return 0;
-}
-- 
2.27.0

