Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95A4E28DFB0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 13:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730655AbgJNLNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 07:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730016AbgJNLNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 07:13:21 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 524DEC061755
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 04:13:21 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id t18so1597249plo.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 04:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pARdoa1Mzik3sFMoHiQMoHrcZnI06KYeFtpW0tbTfww=;
        b=IeK3ROMEUBzEPfFI89bhNOg9C4y+EbMx+iOpDcSO2ElT9727J1tgmW4RGkoN9rzQCi
         atrhNXA/wIu0f3I1aUjUzfWJOXjgL6ECP1sjx5Ab/Zg6rz4eLuNJ5K5zG4S+aUjq3Oib
         cxdYRcNEiBhmj8iTu2QGxIrvq/cWsxizqSDQaCe/jTslqIZZuju7rjE6gQl422bWlEjL
         9VCljp63Olb+jJp9giRDzKoseDjX99Tb6AE4eMevIMw+ALO/CA+sUTfNuLNhJEGb8c0J
         oYI0Zt3nfikvx5QJ/4IuAxaIq8L6SWRqFGI6bPnICR1dB4i6tEKQYBgZXVGY2JmDCaQt
         J1IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pARdoa1Mzik3sFMoHiQMoHrcZnI06KYeFtpW0tbTfww=;
        b=ptIT12fEmJEVY+kGUS1t7yf2GmvPht3E6c3EzcqU2E+fOzcKf7fiyJK5MubagHt0Il
         S4HW5jmCGZtyV08EG2JmMsJcIhjef87k7pH5RpmZbZhON2VA6neS4Jej37u3B80hQ3rr
         2sM0HH3NiCuu6APCHiSE7XBLJdpYVoSy6VmDy1iWrsBcACrVEb7082TUT/sNAg+LmBt8
         tDjIBXKhstsptxFBLMqAplKxzF/6sdJqqwtwJ2iDX43sOojh1MZGh/WKG6/U2e9MPxH/
         UEJnATg18op1ksUVAP7QdN612Q8FKKN/cHXleNFRQVEJH3MN1pb8bwZ1pdbTX5zMU4yM
         DjVQ==
X-Gm-Message-State: AOAM530u9bhQyQrXXwUblSzTViHFO3mgc+OPijOGUuxSUZvTrwLkNNz+
        gXJ2phxfZJIUuCsPtes8f86+Sw==
X-Google-Smtp-Source: ABdhPJxGgmScGvPFqKQIvL1Gl6IbDWm4Zk16CAUqS+hExrozMFM5iv/+6ThqFh0h4Q+YpuS9RR+sFA==
X-Received: by 2002:a17:90a:de90:: with SMTP id n16mr2940279pjv.215.1602674000885;
        Wed, 14 Oct 2020 04:13:20 -0700 (PDT)
Received: from localhost.localdomain ([117.252.65.235])
        by smtp.gmail.com with ESMTPSA id f21sm3060102pfk.169.2020.10.14.04.13.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Oct 2020 04:13:20 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     maz@kernel.org, catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, tglx@linutronix.de,
        jason@lakedaemon.net, mark.rutland@arm.com,
        julien.thierry.kdev@gmail.com, dianders@chromium.org,
        daniel.thompson@linaro.org, jason.wessel@windriver.com,
        msys.mizuma@gmail.com, ito-yuichi@fujitsu.com,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v5 5/5] arm64: ipi_nmi: Add support for NMI backtrace
Date:   Wed, 14 Oct 2020 16:42:11 +0530
Message-Id: <1602673931-28782-6-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1602673931-28782-1-git-send-email-sumit.garg@linaro.org>
References: <1602673931-28782-1-git-send-email-sumit.garg@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable NMI backtrace support on arm64 using IPI turned as an NMI
leveraging pseudo NMIs support. It is now possible for users to get a
backtrace of a CPU stuck in hard-lockup using magic SYSRQ.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 arch/arm64/include/asm/irq.h |  6 ++++++
 arch/arm64/kernel/ipi_nmi.c  | 12 +++++++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/irq.h b/arch/arm64/include/asm/irq.h
index b2b0c64..e840bf1 100644
--- a/arch/arm64/include/asm/irq.h
+++ b/arch/arm64/include/asm/irq.h
@@ -6,6 +6,12 @@
 
 #include <asm-generic/irq.h>
 
+#ifdef CONFIG_SMP
+extern void arch_trigger_cpumask_backtrace(const cpumask_t *mask,
+					   bool exclude_self);
+#define arch_trigger_cpumask_backtrace arch_trigger_cpumask_backtrace
+#endif
+
 struct pt_regs;
 
 static inline int nr_legacy_irqs(void)
diff --git a/arch/arm64/kernel/ipi_nmi.c b/arch/arm64/kernel/ipi_nmi.c
index e0a9e03..e1dc19d 100644
--- a/arch/arm64/kernel/ipi_nmi.c
+++ b/arch/arm64/kernel/ipi_nmi.c
@@ -9,6 +9,7 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/kgdb.h>
+#include <linux/nmi.h>
 #include <linux/smp.h>
 
 #include <asm/nmi.h>
@@ -25,12 +26,21 @@ void arch_send_call_nmi_func_ipi_mask(cpumask_t *mask)
 	__ipi_send_mask(ipi_desc, mask);
 }
 
+void arch_trigger_cpumask_backtrace(const cpumask_t *mask, bool exclude_self)
+{
+	nmi_trigger_cpumask_backtrace(mask, exclude_self,
+				      arch_send_call_nmi_func_ipi_mask);
+}
+
 static irqreturn_t ipi_nmi_handler(int irq, void *data)
 {
 	unsigned int cpu = smp_processor_id();
 
-	ipi_kgdb_nmicallback(cpu, get_irq_regs());
+	if (nmi_cpu_backtrace(get_irq_regs()))
+		goto out;
 
+	ipi_kgdb_nmicallback(cpu, get_irq_regs());
+out:
 	return IRQ_HANDLED;
 }
 
-- 
2.7.4

