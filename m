Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7447329EEF8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 15:59:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbgJ2O6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 10:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727839AbgJ2O6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 10:58:54 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC078C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 07:58:54 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id j18so2559638pfa.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 07:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=63fCD7b9c39BMwHAue5Fl+YEtHFG3eKfVilw8x2/rAA=;
        b=kj3iNPCNr2+M9wcLse6ZQ21oBMHYl72Qc/zJOgpvoUZZqUK4+1MCHZUsaeGS6ui0Cw
         NKMYgFNZDZEEj26ihm97tZCqaNTMiwt8L2gI8RVYyN+frDClvcpXVMJFqKb05BxLkC7G
         pA0NV8O4+fz/AgT5Lsyvp1Hiy6smYo9cDdacpYTYMV336wKhX1U6gCN05GCtvtBbrP3+
         +32FuTSbVwYNzjs7SVRxQFtex1r2DZw/dc7+kq04dEPh84eVNDJmESv2i2upZTMFosJ/
         ALonraRZR/qVAXbwtRieM5V+r2Zwg6rgyGAGcYRou7223Z1UXYNR9wAKUSLXL6Mjz2if
         g6MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=63fCD7b9c39BMwHAue5Fl+YEtHFG3eKfVilw8x2/rAA=;
        b=mtTmSz1Chj102psRM+9qXbiPbpY+wXfexkQfRwwv1pwaIimlbXg+n91I25S1uHTF11
         +xBFVIC6/EBZm191+BGOEOwaXnaFWWM0RNosYTtZ3HtTp3cKyxmg142Lt1vAx7csS61s
         0zkVLz2pDrr/XgKcO8FPpoq45aBPNepYY0OnAKwh1Dbb5WGttIE27FLgslERYXwHC3e6
         l5dUs81QLszuDAqxNgXDjklrVxPsPaQo1EKaODI+enoy71hI8riUqiSK7M65ZeSRrTg3
         ObCCY/rmjkdqgRsl0cRT6RDn1BklVoKHC1rOHdw8L/Q5ekMia/NyTevkTwiuwwQnBfnX
         vEWA==
X-Gm-Message-State: AOAM532U9dt9pF6FZSxwVnQsB9vS/DtgYujQURUXKybx8vMamNtUAYpM
        tpTvgS1HjZ+BpamyduPm0OlvbQ==
X-Google-Smtp-Source: ABdhPJw17SGDkWifbE7fvN8UeDKNxr6nOnVarhxUncUj/mUYxJzpJE6WxXsesAZ4m34FfWUD2Yt8kQ==
X-Received: by 2002:a17:90a:b30b:: with SMTP id d11mr152257pjr.163.1603983534301;
        Thu, 29 Oct 2020 07:58:54 -0700 (PDT)
Received: from localhost.localdomain ([117.252.71.231])
        by smtp.gmail.com with ESMTPSA id j11sm3085082pfc.64.2020.10.29.07.58.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Oct 2020 07:58:53 -0700 (PDT)
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
Subject: [PATCH v6 5/7] arm64: ipi_nmi: Add support for NMI backtrace
Date:   Thu, 29 Oct 2020 20:26:25 +0530
Message-Id: <1603983387-8738-6-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1603983387-8738-1-git-send-email-sumit.garg@linaro.org>
References: <1603983387-8738-1-git-send-email-sumit.garg@linaro.org>
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

