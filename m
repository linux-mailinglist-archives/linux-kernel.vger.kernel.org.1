Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE04E28DFA6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 13:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387418AbgJNLMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 07:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730617AbgJNLMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 07:12:49 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915DEC061755
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 04:12:49 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id b26so1782444pff.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 04:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EpD0KoAJugnynysnqxP48a140Onq0eehtWGl3LDXcA8=;
        b=rhlKPpmoFDFeIoxy0kn5lhdCooSlojGLKWwvSf9X7yfOTfzXwIaetVpSYSSpeWKKug
         cOUW5T33OovRClyFr3AAzlcjdKJrYrktXQ6wsXSXNKC5cRn8x2J1sRCa/HZqTddfmYSU
         DMYU5csdUSbfAbkBmbcHhXGe1z/ASSyaK5XFJ145Xm7dxc5dIIDF0JhU3nGnmCCmT5Uk
         Rafmd4bzUSEx9TbZVmnjiqM4BBxQCOgVY+7T123Pjpqz3iIik7sOLFBnQSWnN545O2Xp
         +/MJjG9v4ynUN+/2mEQ+zR9sLNGIoFf6+2B0y/ER8Yt6HPTyL9b1B1YdrQhu1X6mX//5
         nArA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EpD0KoAJugnynysnqxP48a140Onq0eehtWGl3LDXcA8=;
        b=TEA7U93G37k87XQe6Ula2g1jk+FCdd1fXmxycnidbdFBxLan9jbd5ZRqPhjo2LEdXl
         2x6+pHSW99c+eZbmRCMthfEnL8n5vjZs4nXD+pJs49dPAVCJhIXGZuityjZ+D0afIND2
         7+3CZ0ucW62BGPcYqaUHwYDt9SU7l9Pge7Go0DreXs1LgSTMI703C0ND9ts4Ammyt03O
         qYRLcXu0gKGQI1naa1uzQ1aE5TfnQZmFd5oucrmT/ifR0ZGbEoUGyopKwgvcM84dS6Mn
         TBupeLpF2X8YC+Vt5O6fb31SQEkmPL/MeUtvQQxH8frKxqjJmBcPfYWLfsuJGwAsUXZg
         IwUw==
X-Gm-Message-State: AOAM531WZxVWVnrMXWYeGE5wl68/JKqj3HYHwior3pAWsKh0D4x0NHmf
        TM3PrTmjZnnzi7xbaSgHbJIgpQ==
X-Google-Smtp-Source: ABdhPJzaYk4hfLpQXPJqrqB7Ua6rrW4FRzGCxUK0kKHZCvvp95FQqLfGnm7s02jcWl6Qmk/w7UdE/A==
X-Received: by 2002:a05:6a00:887:b029:142:2501:396f with SMTP id q7-20020a056a000887b02901422501396fmr3766377pfj.52.1602673969100;
        Wed, 14 Oct 2020 04:12:49 -0700 (PDT)
Received: from localhost.localdomain ([117.252.65.235])
        by smtp.gmail.com with ESMTPSA id f21sm3060102pfk.169.2020.10.14.04.12.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Oct 2020 04:12:48 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     maz@kernel.org, catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, tglx@linutronix.de,
        jason@lakedaemon.net, mark.rutland@arm.com,
        julien.thierry.kdev@gmail.com, dianders@chromium.org,
        daniel.thompson@linaro.org, jason.wessel@windriver.com,
        msys.mizuma@gmail.com, ito-yuichi@fujitsu.com,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v5 1/5] arm64: Add framework to turn IPI as NMI
Date:   Wed, 14 Oct 2020 16:42:07 +0530
Message-Id: <1602673931-28782-2-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1602673931-28782-1-git-send-email-sumit.garg@linaro.org>
References: <1602673931-28782-1-git-send-email-sumit.garg@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce framework to turn an IPI as NMI using pseudo NMIs. In case a
particular platform doesn't support pseudo NMIs, then request IPI as a
regular IRQ.

The main motivation for this feature is to have an IPI that can be
leveraged to invoke NMI functions on other CPUs. And current prospective
users are NMI backtrace and KGDB CPUs round-up whose support is added
via future patches.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 arch/arm64/include/asm/nmi.h | 16 +++++++++
 arch/arm64/kernel/Makefile   |  2 +-
 arch/arm64/kernel/ipi_nmi.c  | 77 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 94 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/include/asm/nmi.h
 create mode 100644 arch/arm64/kernel/ipi_nmi.c

diff --git a/arch/arm64/include/asm/nmi.h b/arch/arm64/include/asm/nmi.h
new file mode 100644
index 0000000..3433c55
--- /dev/null
+++ b/arch/arm64/include/asm/nmi.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_NMI_H
+#define __ASM_NMI_H
+
+#ifndef __ASSEMBLER__
+
+#include <linux/cpumask.h>
+
+extern void arch_send_call_nmi_func_ipi_mask(cpumask_t *mask);
+
+void set_smp_ipi_nmi(int ipi);
+void ipi_nmi_setup(int cpu);
+void ipi_nmi_teardown(int cpu);
+
+#endif /* !__ASSEMBLER__ */
+#endif
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index bbaf0bc..525a1e0 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -17,7 +17,7 @@ obj-y			:= debug-monitors.o entry.o irq.o fpsimd.o		\
 			   return_address.o cpuinfo.o cpu_errata.o		\
 			   cpufeature.o alternative.o cacheinfo.o		\
 			   smp.o smp_spin_table.o topology.o smccc-call.o	\
-			   syscall.o proton-pack.o
+			   syscall.o proton-pack.o ipi_nmi.o
 
 targets			+= efi-entry.o
 
diff --git a/arch/arm64/kernel/ipi_nmi.c b/arch/arm64/kernel/ipi_nmi.c
new file mode 100644
index 0000000..a959256
--- /dev/null
+++ b/arch/arm64/kernel/ipi_nmi.c
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * NMI support for IPIs
+ *
+ * Copyright (C) 2020 Linaro Limited
+ * Author: Sumit Garg <sumit.garg@linaro.org>
+ */
+
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/smp.h>
+
+#include <asm/nmi.h>
+
+static struct irq_desc *ipi_desc __read_mostly;
+static int ipi_id __read_mostly;
+static bool is_nmi __read_mostly;
+
+void arch_send_call_nmi_func_ipi_mask(cpumask_t *mask)
+{
+	if (WARN_ON_ONCE(!ipi_desc))
+		return;
+
+	__ipi_send_mask(ipi_desc, mask);
+}
+
+static irqreturn_t ipi_nmi_handler(int irq, void *data)
+{
+	/* nop, NMI handlers for special features can be added here. */
+
+	return IRQ_HANDLED;
+}
+
+void ipi_nmi_setup(int cpu)
+{
+	if (!ipi_desc)
+		return;
+
+	if (is_nmi) {
+		if (!prepare_percpu_nmi(ipi_id))
+			enable_percpu_nmi(ipi_id, IRQ_TYPE_NONE);
+	} else {
+		enable_percpu_irq(ipi_id, IRQ_TYPE_NONE);
+	}
+}
+
+void ipi_nmi_teardown(int cpu)
+{
+	if (!ipi_desc)
+		return;
+
+	if (is_nmi) {
+		disable_percpu_nmi(ipi_id);
+		teardown_percpu_nmi(ipi_id);
+	} else {
+		disable_percpu_irq(ipi_id);
+	}
+}
+
+void __init set_smp_ipi_nmi(int ipi)
+{
+	int err;
+
+	err = request_percpu_nmi(ipi, ipi_nmi_handler, "IPI", &cpu_number);
+	if (err) {
+		err = request_percpu_irq(ipi, ipi_nmi_handler, "IPI",
+					 &cpu_number);
+		WARN_ON(err);
+		is_nmi = false;
+	} else {
+		is_nmi = true;
+	}
+
+	ipi_desc = irq_to_desc(ipi);
+	irq_set_status_flags(ipi, IRQ_HIDDEN);
+	ipi_id = ipi;
+}
-- 
2.7.4

