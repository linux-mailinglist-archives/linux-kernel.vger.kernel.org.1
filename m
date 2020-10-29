Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A969F29EEF1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 15:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbgJ2O6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 10:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbgJ2O6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 10:58:14 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61BF3C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 07:58:14 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id h6so2553114pgk.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 07:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TBLIKfpsklTZAlEASF12NJyKPiqj9Rqie6gj0u/aah0=;
        b=UTgqNPE3CgHTQOjtCEe5fY63HFkau6nwSfU3tebnaMgbLjfmpkzwU3MNlr9pz5gWJD
         qMUwQe1Q4fhp61u6cOCopwyTIOlaGHGfvhks63Bq50GiF48FjbWprnDTLmANetyQoksf
         GvwrXmv0bGrCgCX3hB8LMUQ4Jgz5cyl75lVQEKDeBClyligwXBg5roxgNSU6ppUhcjKA
         BfJkTtEZQWEpcRdQTInYXrt5m7PIWwY4fJ8K7C25pmLV+n9CZ0phyUq8CwILFrvuKa8R
         r9S61kgqBImKz0XJWw1+ThRUb3yU8XJw1crs+t0qsusYUKrGSvQ5kW8WAccX28ny9FyZ
         WpIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TBLIKfpsklTZAlEASF12NJyKPiqj9Rqie6gj0u/aah0=;
        b=p6IQvCcHu2yBlMXr8nXClq/+oB/hIzwCzdtSNaiPFRGVKnJnCOCdOQH874eji5QDh2
         AwCQDfrTUQrtyd6mocq7Guwffa4BVbkxe0anvMBIAOCsSyqsaWiABPuOXY9Ko07TQk3l
         CQ/asVeIWL/y4aVavtVZnhn/hXufD4DBmVg97W7GPuqDR4xwUU998/cA8x+eaDaxqMyc
         xD0Z9kauMMFl37iZaLgaYx9P2/k1a2S7PEBqYgNGUMOxQgmeta0gyjwjlny7/sPWYmXg
         31Wh1ewGt/qwE0RSHiHIY580IYrhR1tWitDuCLZmJ8nOqBDUJP6vP/plSm8qTgxKHopH
         HRJw==
X-Gm-Message-State: AOAM532EsrRsVwQ80hypxUf6QQSrWRWnlMfB5qcacMncxLdEgG9ZQF0r
        dcQmhWo/FVJlInAMQG3sqwjmlg==
X-Google-Smtp-Source: ABdhPJzIFWYKnl/IyiB31hLlKUzs2X73dexAslUVHzXzamn5QQ6KnGb7yj8QBf0SCIt5ulzti78wvw==
X-Received: by 2002:a17:90a:db06:: with SMTP id g6mr194406pjv.156.1603983493976;
        Thu, 29 Oct 2020 07:58:13 -0700 (PDT)
Received: from localhost.localdomain ([117.252.71.231])
        by smtp.gmail.com with ESMTPSA id j11sm3085082pfc.64.2020.10.29.07.58.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Oct 2020 07:58:13 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     maz@kernel.org, catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, tglx@linutronix.de,
        jason@lakedaemon.net, linux@armlinux.org.uk,
        tsbogend@alpha.franken.de, mpe@ellerman.id.au, davem@davemloft.net,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        mark.rutland@arm.com, julien.thierry.kdev@gmail.com,
        dianders@chromium.org, daniel.thompson@linaro.org,
        jason.wessel@windriver.com, msys.mizuma@gmail.com,
        ito-yuichi@fujitsu.com, kgdb-bugreport@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v6 1/7] arm64: Add framework to turn IPI as NMI
Date:   Thu, 29 Oct 2020 20:26:21 +0530
Message-Id: <1603983387-8738-2-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1603983387-8738-1-git-send-email-sumit.garg@linaro.org>
References: <1603983387-8738-1-git-send-email-sumit.garg@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce framework to turn an IPI as NMI using pseudo NMIs. The main
motivation for this feature is to have an IPI that can be leveraged to
invoke NMI functions on other CPUs.

And current prospective users are NMI backtrace and KGDB CPUs round-up
whose support is added via future patches.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 arch/arm64/include/asm/nmi.h | 17 ++++++++++++
 arch/arm64/kernel/Makefile   |  2 +-
 arch/arm64/kernel/ipi_nmi.c  | 65 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 83 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/include/asm/nmi.h
 create mode 100644 arch/arm64/kernel/ipi_nmi.c

diff --git a/arch/arm64/include/asm/nmi.h b/arch/arm64/include/asm/nmi.h
new file mode 100644
index 0000000..4cd14b6
--- /dev/null
+++ b/arch/arm64/include/asm/nmi.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_NMI_H
+#define __ASM_NMI_H
+
+#ifndef __ASSEMBLER__
+
+#include <linux/cpumask.h>
+
+extern bool arm64_supports_nmi(void);
+extern void arm64_send_nmi(cpumask_t *mask);
+
+void set_smp_dynamic_ipi(int ipi);
+void dynamic_ipi_setup(int cpu);
+void dynamic_ipi_teardown(int cpu);
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
index 0000000..a945dcf
--- /dev/null
+++ b/arch/arm64/kernel/ipi_nmi.c
@@ -0,0 +1,65 @@
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
+static struct irq_desc *ipi_nmi_desc __read_mostly;
+static int ipi_nmi_id __read_mostly;
+
+bool arm64_supports_nmi(void)
+{
+	if (ipi_nmi_desc)
+		return true;
+
+	return false;
+}
+
+void arm64_send_nmi(cpumask_t *mask)
+{
+	if (WARN_ON_ONCE(!ipi_nmi_desc))
+		return;
+
+	__ipi_send_mask(ipi_nmi_desc, mask);
+}
+
+static irqreturn_t ipi_nmi_handler(int irq, void *data)
+{
+	/* nop, NMI handlers for special features can be added here. */
+
+	return IRQ_NONE;
+}
+
+void dynamic_ipi_setup(int cpu)
+{
+	if (!ipi_nmi_desc)
+		return;
+
+	if (!prepare_percpu_nmi(ipi_nmi_id))
+		enable_percpu_nmi(ipi_nmi_id, IRQ_TYPE_NONE);
+}
+
+void dynamic_ipi_teardown(int cpu)
+{
+	if (!ipi_nmi_desc)
+		return;
+
+	disable_percpu_nmi(ipi_nmi_id);
+	teardown_percpu_nmi(ipi_nmi_id);
+}
+
+void __init set_smp_dynamic_ipi(int ipi)
+{
+	if (!request_percpu_nmi(ipi, ipi_nmi_handler, "IPI", &cpu_number)) {
+		ipi_nmi_desc = irq_to_desc(ipi);
+		ipi_nmi_id = ipi;
+	}
+}
-- 
2.7.4

