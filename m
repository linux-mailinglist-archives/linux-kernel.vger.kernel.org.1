Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9452A29CD
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 12:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728783AbgKBLrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 06:47:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728677AbgKBLp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 06:45:59 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 457A6C040201
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 03:45:50 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id b3so10916435pfo.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 03:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TBLIKfpsklTZAlEASF12NJyKPiqj9Rqie6gj0u/aah0=;
        b=E0zlvuCR88oHQsE4WYprnL6Cyxa8vZWkrCSnRxyAkYmj/8JBrBP6Y8xASUQayvZAR5
         Yg8kWJ1lQk2tLGfyJCZ9Hu1sPRIkpt5zxfYG6KqV6+2vTYwD5ERfO42Yixd29XgwT5ST
         AiP8f8DUKEFz+d2LlXJbTiH+nSAw3u987NNCPUZhpcLOmUMmr4BqWikHwrgdAfBTQg0I
         ZlnjA8CvgHaizhr2X9PyB0in3prA9L/haL55wNR5TTTLOf4HwW1YU3B8QNIUrj4Ybhk6
         8P3eMbb0DrTdQimvjHb09bmR2EVMPE0D9R6oChUQ9i1Jxts44Yli9lrPgxIlALJCE1KU
         4aiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TBLIKfpsklTZAlEASF12NJyKPiqj9Rqie6gj0u/aah0=;
        b=XQtHSf5rVSTr63VSFgD/kNO8xuPF7+bGFwexPirlbkJx66KKOlD7eXbn/AogRYHIky
         rqAHLyjp6zDDY/5GxkWEk7QRC1qr9dH5BMKJY73qHTqyNJujNkkXp87CSGsIQVTIeHvY
         q8B2IwgTRWcps0H4ZBOw0XPsI3hOoxGw9njFpkRXYkix8iFc+uQI+Eo/JhlGZeilvzJa
         atpsUyqMXU8ZpbqI54XgvglUiXTFXJXXjQIjcojRHVWmGnrfq2sfY1ZOe6Kl90LDoOd9
         vIWeNiCIzdkULiIO57RINjsfgqmmj/8HolYSLMIMWO9DJdEEF5v8x3TqH6V9u9NCe41T
         6/Yg==
X-Gm-Message-State: AOAM531YNW3uc+l/XzCXP/ff9s5OwwLz17URTrnSvAryn0m3dB6QOGut
        R0iMbH+FVLuLA5YWbiCjrm4TGw==
X-Google-Smtp-Source: ABdhPJzeSbWyx0zTDhLxg+mHYiTpnkodIkCYGRCeMEkqtHqivG6UrK+sVI8IK1jDmCGe66Wo9QvQaw==
X-Received: by 2002:a17:90a:5d8e:: with SMTP id t14mr15827085pji.199.1604317549868;
        Mon, 02 Nov 2020 03:45:49 -0800 (PST)
Received: from localhost.localdomain ([122.173.169.225])
        by smtp.gmail.com with ESMTPSA id y5sm14276184pfq.79.2020.11.02.03.45.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Nov 2020 03:45:49 -0800 (PST)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     maz@kernel.org, catalin.marinas@arm.com, will@kernel.org,
        daniel.thompson@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, tglx@linutronix.de,
        jason@lakedaemon.net, linux@armlinux.org.uk,
        tsbogend@alpha.franken.de, mpe@ellerman.id.au, davem@davemloft.net,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        mark.rutland@arm.com, julien.thierry.kdev@gmail.com,
        dianders@chromium.org, jason.wessel@windriver.com,
        msys.mizuma@gmail.com, ito-yuichi@fujitsu.com,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v7 1/7] arm64: Add framework to turn IPI as NMI
Date:   Mon,  2 Nov 2020 17:14:41 +0530
Message-Id: <1604317487-14543-2-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1604317487-14543-1-git-send-email-sumit.garg@linaro.org>
References: <1604317487-14543-1-git-send-email-sumit.garg@linaro.org>
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

