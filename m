Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC85E2A29C8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 12:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbgKBLrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 06:47:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728716AbgKBLqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 06:46:25 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18AD5C061A48
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 03:46:24 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id b3so10917768pfo.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 03:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=63fCD7b9c39BMwHAue5Fl+YEtHFG3eKfVilw8x2/rAA=;
        b=hJ9/Ezv1ZgdvCLAG1rgjJ/9mpQ+SKh3LvAYZ/WUKYXIalESoV9Oql4vEQPCT2oMRus
         Drdj9tN3YSjMyBl+gq1AeNPOpvihBVmc1GU7Jm/9saZgCQNc7QuyUJilIvyNHRHrw9VW
         fY1y9FZJNr/taNUexlK7F8FnmRslj7+n7UVcb6vdTIfHXDkMGs9Vv+EQPz03XeTpwM4T
         y0sxHRkvp7vk08etU9dCuWcROXesLKCqMHWaZ93iaANXXu+HO+gONdCfJ23JAcZbp6zr
         1PC8Lnkk0Pilok7g7Kx4MQXncXBIwSgsu/qS0WXMl5HrPqZek7EGWxjeoaUiBFo3oGqX
         Q5Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=63fCD7b9c39BMwHAue5Fl+YEtHFG3eKfVilw8x2/rAA=;
        b=CAhDoli4TsNHo1zgFo6YKPbv49MGcZCKJYVpBM0nnYGxbW4NERsdc8+Dn6WdUMmONF
         arsQ6hfqNS+jwSVxUGXIvhXM1kWBGRi+lK6ZR1jFq6RTl7T5O/SUadbB6j19cYkEMHsY
         jgJj0WwwISptj5LN+vvsJH/lw98oZvm0glRtkJlf0q0wLNY/AG/uviZZNlcq80Jt6eSV
         oq9e0HNtOYhB9sLscskXy2ATCl7kwCd3/L2nmFqTIqQiEoMjdMd+4T31xYDnJlteZofz
         ojlzJiMgBT52hx/RYNsm+AhV6R5GvmLP/E/ttjGiDE3WneSaJUrJ4CH1CaM1fQ5fsf2M
         b5tQ==
X-Gm-Message-State: AOAM530DlLmElmIGEkCZq44k1Wgvrxn1tyOYmt94IfTeBvJ/AgOawkJv
        IAJ8slg+kf9vmM4mgfXmbyVlfw==
X-Google-Smtp-Source: ABdhPJxo+jJRsFTKov77OJRU77007ycelGKbPaV5dYEs45Z4UJIU+NvAvFXsfZkDaHO0m3EtjWrM2A==
X-Received: by 2002:a63:3d8c:: with SMTP id k134mr12755914pga.22.1604317583680;
        Mon, 02 Nov 2020 03:46:23 -0800 (PST)
Received: from localhost.localdomain ([122.173.169.225])
        by smtp.gmail.com with ESMTPSA id y5sm14276184pfq.79.2020.11.02.03.46.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Nov 2020 03:46:22 -0800 (PST)
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
Subject: [PATCH v7 5/7] arm64: ipi_nmi: Add support for NMI backtrace
Date:   Mon,  2 Nov 2020 17:14:45 +0530
Message-Id: <1604317487-14543-6-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1604317487-14543-1-git-send-email-sumit.garg@linaro.org>
References: <1604317487-14543-1-git-send-email-sumit.garg@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable NMI backtrace support on arm64 using IPI turned as an NMI
leveraging pseudo NMIs support. It is now possible for users to get a
backtrace of a CPU stuck in hard-lockup using magic SYSRQ.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 arch/arm64/include/asm/irq.h |  6 ++++++
 arch/arm64/kernel/ipi_nmi.c  | 18 ++++++++++++++++--
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/irq.h b/arch/arm64/include/asm/irq.h
index b2b0c64..ef018a8 100644
--- a/arch/arm64/include/asm/irq.h
+++ b/arch/arm64/include/asm/irq.h
@@ -6,6 +6,12 @@
 
 #include <asm-generic/irq.h>
 
+#ifdef CONFIG_SMP
+extern bool arch_trigger_cpumask_backtrace(const cpumask_t *mask,
+					   bool exclude_self);
+#define arch_trigger_cpumask_backtrace arch_trigger_cpumask_backtrace
+#endif
+
 struct pt_regs;
 
 static inline int nr_legacy_irqs(void)
diff --git a/arch/arm64/kernel/ipi_nmi.c b/arch/arm64/kernel/ipi_nmi.c
index a945dcf..597dcf7 100644
--- a/arch/arm64/kernel/ipi_nmi.c
+++ b/arch/arm64/kernel/ipi_nmi.c
@@ -8,6 +8,7 @@
 
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/nmi.h>
 #include <linux/smp.h>
 
 #include <asm/nmi.h>
@@ -31,11 +32,24 @@ void arm64_send_nmi(cpumask_t *mask)
 	__ipi_send_mask(ipi_nmi_desc, mask);
 }
 
+bool arch_trigger_cpumask_backtrace(const cpumask_t *mask, bool exclude_self)
+{
+	if (!ipi_nmi_desc)
+		return false;
+
+	nmi_trigger_cpumask_backtrace(mask, exclude_self, arm64_send_nmi);
+
+	return true;
+}
+
 static irqreturn_t ipi_nmi_handler(int irq, void *data)
 {
-	/* nop, NMI handlers for special features can be added here. */
+	irqreturn_t ret = IRQ_NONE;
+
+	if (nmi_cpu_backtrace(get_irq_regs()))
+		ret = IRQ_HANDLED;
 
-	return IRQ_NONE;
+	return ret;
 }
 
 void dynamic_ipi_setup(int cpu)
-- 
2.7.4

