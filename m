Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 715351F746E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jun 2020 09:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbgFLHKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Jun 2020 03:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbgFLHKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 03:10:39 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211B1C08C5C2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 00:10:39 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id g12so3379871pll.10
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 00:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ExzTv3ZkZVen5FhxnWerxBjdzkt+ghuUco0ZAfafnJw=;
        b=cwKOxHAe99ZMwtzUWEEjI6Dys+A9NSr9KO59dHNuuuyKEu3c/VQhZfNJkSmzBysEg2
         o8jAHEQDBFsXubzXYnN1IJ9oedPCTzedeW4/E217vaIBl4A99Adj0W17b0sRWFSDZZdz
         EheWkL9Mwk8E78ynURMpkyfBtLteB8J3FhdIhC0CBFjyKVS1IRXJC/sajcjEoq+4vl7T
         GQiZiW8E4gxcETU24vijqPJbqyz8I2qCfp2TogdxPb1KZ2iUeT2ZpZWgU0Sjej4ZeLGf
         e+B02bk9GuH30Hk3QDQ0h+qvZXIxxlFe3ViVIS5CtJJ0l0MiL83hXF8L9GKC7pWpz0VC
         Y5Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ExzTv3ZkZVen5FhxnWerxBjdzkt+ghuUco0ZAfafnJw=;
        b=nnKgONLbwiX20WcBETmdOVZJKUg9NI5SqX2guJGm+VEm0WATgBzsw5fKc6jqkjoWCS
         MO47uXBJPkHlguBfL7HmFWyw8eGqpvYi6p2ejO/DtrvQXhOiWR+GatGm3qSxo7LVaS6X
         pXYHUssgfNgTWeIXLVwM7mtMdJ9SPXATOK7gF5zPlUA6bUn/q9Y7xToqKNHPNyhJ0/PT
         6545sbaTMeufzF6K+o97HJQfn+Ag5GlGhWSEHe2bem0Aqjcu5UQaUpFe0ofrhH7687M0
         NBJMI06vWCvXuh+et6lA6jHxQdKqaTTMUk8oNkKhByEOvCbeHTg50GG8RrbJj1OBC2yM
         WplA==
X-Gm-Message-State: AOAM530kgTrYMQ8P6RLUcNFVuOvqdCVdnxLh9dXKyFi854lcrBSXjSDq
        zb3rxGMVnn2OYjE4XaH3lbONBA==
X-Google-Smtp-Source: ABdhPJzDg6V83DZh/Z6VDxkVqWFHImz9fQIlhPx6VLCrIYP/KpY/gBOfiZoJoAs6a2sgDex53/jCzw==
X-Received: by 2002:a17:90a:a40b:: with SMTP id y11mr12358468pjp.54.1591945838626;
        Fri, 12 Jun 2020 00:10:38 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id d2sm4336919pgp.56.2020.06.12.00.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 00:10:38 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     greentime.hu@sifive.com, oleg@redhat.com, guoren@linux.alibaba.com,
        vincent.chen@sifive.com, paul.walmsley@sifive.com,
        palmerdabbelt@google.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 13/13] riscv: signal: Report signal frame size to userspace via auxv
Date:   Fri, 12 Jun 2020 15:10:02 +0800
Message-Id: <3871f758564a156b4932a1bde19022edd556baf6.1591344965.git.greentime.hu@sifive.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1591344965.git.greentime.hu@sifive.com>
References: <cover.1591344965.git.greentime.hu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincent Chen <vincent.chen@sifive.com>

The vector register belongs to the signal context. They need to be stored
and restored as entering and leaving the signal handler. According to the
V-extension specification, the maximum length of the vector registers can
be 2^(XLEN-1). Hence, if userspace refers to the MINSIGSTKSZ #define
(2KB) to create a sigframe, it may not be enough. To resolve this problem,
this patch refers to the commit 94b07c1f8c39c
("arm64: signal: Report signal frame size to userspace via auxv") to enable
userspace to know the minimum required sigframe size through the auxiliary
vector and use it to allocate enough memory for signal context.

Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
---
 arch/riscv/include/asm/elf.h         | 17 +++++++++++++----
 arch/riscv/include/asm/processor.h   |  2 ++
 arch/riscv/include/uapi/asm/auxvec.h |  2 ++
 arch/riscv/kernel/setup.c            |  5 +++++
 arch/riscv/kernel/signal.c           | 16 ++++++++++++++++
 5 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/include/asm/elf.h b/arch/riscv/include/asm/elf.h
index d83a4efd052b..b6b15fc5f784 100644
--- a/arch/riscv/include/asm/elf.h
+++ b/arch/riscv/include/asm/elf.h
@@ -57,10 +57,19 @@ extern unsigned long elf_hwcap;
 #define ELF_PLATFORM	(NULL)
 
 #ifdef CONFIG_MMU
-#define ARCH_DLINFO						\
-do {								\
-	NEW_AUX_ENT(AT_SYSINFO_EHDR,				\
-		(elf_addr_t)current->mm->context.vdso);		\
+#define ARCH_DLINFO						 \
+do {								 \
+	NEW_AUX_ENT(AT_SYSINFO_EHDR,				 \
+		(elf_addr_t)current->mm->context.vdso);		 \
+	/*							 \
+	 * Should always be nonzero unless there's a kernel bug. \
+	 * If we haven't determined a sensible value to give to	 \
+	 * userspace, omit the entry:				 \
+	 */							 \
+	if (likely(signal_minsigstksz))				 \
+		NEW_AUX_ENT(AT_MINSIGSTKSZ, signal_minsigstksz); \
+	else							 \
+		NEW_AUX_ENT(AT_IGNORE, 0);			 \
 } while (0)
 #define ARCH_HAS_SETUP_ADDITIONAL_PAGES
 struct linux_binprm;
diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index 217273375cfb..5be2da702897 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -7,6 +7,7 @@
 #define _ASM_RISCV_PROCESSOR_H
 
 #include <linux/const.h>
+#include <linux/cache.h>
 
 #include <asm/ptrace.h>
 
@@ -79,6 +80,7 @@ int riscv_of_processor_hartid(struct device_node *node);
 
 extern void riscv_fill_hwcap(void);
 
+extern unsigned long signal_minsigstksz __ro_after_init;
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_RISCV_PROCESSOR_H */
diff --git a/arch/riscv/include/uapi/asm/auxvec.h b/arch/riscv/include/uapi/asm/auxvec.h
index d86cb17bbabe..9745a01e5e61 100644
--- a/arch/riscv/include/uapi/asm/auxvec.h
+++ b/arch/riscv/include/uapi/asm/auxvec.h
@@ -10,4 +10,6 @@
 /* vDSO location */
 #define AT_SYSINFO_EHDR 33
 
+#define AT_MINSIGSTKSZ 51
+
 #endif /* _UAPI_ASM_RISCV_AUXVEC_H */
diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index 145128a7e560..6220e25ea9b0 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -17,6 +17,7 @@
 #include <linux/sched/task.h>
 #include <linux/swiotlb.h>
 #include <linux/smp.h>
+#include <linux/processor.h>
 
 #include <asm/clint.h>
 #include <asm/cpu_ops.h>
@@ -62,6 +63,8 @@ void __init parse_dtb(void)
 #endif
 }
 
+extern void __init minsigstksz_setup(void);
+
 void __init setup_arch(char **cmdline_p)
 {
 	init_mm.start_code = (unsigned long) _stext;
@@ -95,6 +98,8 @@ void __init setup_arch(char **cmdline_p)
 #endif
 
 	riscv_fill_hwcap();
+
+	minsigstksz_setup();
 }
 
 static int __init topology_init(void)
diff --git a/arch/riscv/kernel/signal.c b/arch/riscv/kernel/signal.c
index 9ada6f74bb95..4f81251867e6 100644
--- a/arch/riscv/kernel/signal.c
+++ b/arch/riscv/kernel/signal.c
@@ -404,3 +404,19 @@ asmlinkage __visible void do_notify_resume(struct pt_regs *regs,
 		tracehook_notify_resume(regs);
 	}
 }
+
+unsigned long __ro_after_init signal_minsigstksz;
+
+/*
+ * Determine the stack space required for guaranteed signal devliery.
+ * This function is used to populate AT_MINSIGSTKSZ at process startup.
+ * cpufeatures setup is assumed to be complete.
+ */
+void __init minsigstksz_setup(void)
+{
+	signal_minsigstksz = sizeof(struct rt_sigframe);
+#ifdef CONFIG_VECTOR
+	if (has_vector)
+		signal_minsigstksz += riscv_vsize;
+#endif
+}
-- 
2.27.0

