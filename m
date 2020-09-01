Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38760259108
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Sep 2020 16:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728250AbgIAOoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Sep 2020 10:44:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:56980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728601AbgIAOne (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 10:43:34 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7AB16216C4;
        Tue,  1 Sep 2020 14:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598971413;
        bh=XBtIMVi7ZaF+S81qcwIXwvxe+3Juf8BjRsCKuHP1exQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jgsj/TzopcVnWpg9NE+Zi4XVkO/Hu1nwQ6bKU8MiabNFZ6sLa3qnvTK7aykBuy8Cc
         PvQiucbeqhIMo5WVx4Au/EFmskbdsLZTNs7hCL/pyJU1q7+cGM2ZjIXOBy6+EuDyPL
         4q3cbtVaZ4EDaMCs+N63vjLDBptrvASC8ikmZFGk=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kD7VT-008IQP-Uh; Tue, 01 Sep 2020 15:43:32 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@arm.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Sumit Garg <sumit.garg@linaro.org>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Saravana Kannan <saravanak@google.com>,
        kernel-team@android.com,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: [PATCH v3 03/16] arm64: Allow IPIs to be handled as normal interrupts
Date:   Tue,  1 Sep 2020 15:43:11 +0100
Message-Id: <20200901144324.1071694-4-maz@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200901144324.1071694-1-maz@kernel.org>
References: <20200901144324.1071694-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com, linux@arm.linux.org.uk, tglx@linutronix.de, jason@lakedaemon.net, sumit.garg@linaro.org, Valentin.Schneider@arm.com, f.fainelli@gmail.com, gregory.clement@bootlin.com, andrew@lunn.ch, saravanak@google.com, kernel-team@android.com, valentin.schneider@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to deal with IPIs as normal interrupts, let's add
a new way to register them with the architecture code.

set_smp_ipi_range() takes a range of interrupts, and allows
the arch code to request them as if the were normal interrupts.
A standard handler is then called by the core IRQ code to deal
with the IPI.

This means that we don't need to call irq_enter/irq_exit, and
that we don't need to deal with set_irq_regs either. So let's
move the dispatcher into its own function, and leave handle_IPI()
as a compatibility function.

On the sending side, let's make use of ipi_send_mask, which
already exists for this purpose.

One of the major difference is that we end up, in some cases
(such as when performing IRQ time accounting on the scheduler
IPI), end up with nested irq_enter()/irq_exit() pairs.
Other than the (relatively small) overhead, there should be
no consequences to it (these pairs are designed to nest
correctly, and the accounting shouldn't be off).

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/Kconfig           |  1 +
 arch/arm64/include/asm/smp.h |  5 ++
 arch/arm64/kernel/smp.c      | 93 +++++++++++++++++++++++++++++++-----
 3 files changed, 87 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 6d232837cbee..d0fdbe5fb32f 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -106,6 +106,7 @@ config ARM64
 	select GENERIC_CPU_VULNERABILITIES
 	select GENERIC_EARLY_IOREMAP
 	select GENERIC_IDLE_POLL_SETUP
+	select GENERIC_IRQ_IPI
 	select GENERIC_IRQ_MULTI_HANDLER
 	select GENERIC_IRQ_PROBE
 	select GENERIC_IRQ_SHOW
diff --git a/arch/arm64/include/asm/smp.h b/arch/arm64/include/asm/smp.h
index 0eadbf933e35..57c5db15f6b7 100644
--- a/arch/arm64/include/asm/smp.h
+++ b/arch/arm64/include/asm/smp.h
@@ -78,6 +78,11 @@ extern void set_smp_cross_call(void (*)(const struct cpumask *, unsigned int));
 
 extern void (*__smp_cross_call)(const struct cpumask *, unsigned int);
 
+/*
+ * Register IPI interrupts with the arch SMP code
+ */
+extern void set_smp_ipi_range(int ipi_base, int nr_ipi);
+
 /*
  * Called from the secondary holding pen, this is the secondary CPU entry point.
  */
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 355ee9eed4dd..00c9db1b61b5 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -75,6 +75,13 @@ enum ipi_msg_type {
 	IPI_WAKEUP
 };
 
+static int ipi_irq_base __read_mostly;
+static int nr_ipi __read_mostly = NR_IPI;
+static struct irq_desc *ipi_desc[NR_IPI] __read_mostly;
+
+static void ipi_setup(int cpu);
+static void ipi_teardown(int cpu);
+
 #ifdef CONFIG_HOTPLUG_CPU
 static int op_cpu_kill(unsigned int cpu);
 #else
@@ -237,6 +244,8 @@ asmlinkage notrace void secondary_start_kernel(void)
 	 */
 	notify_cpu_starting(cpu);
 
+	ipi_setup(cpu);
+
 	store_cpu_topology(cpu);
 	numa_add_cpu(cpu);
 
@@ -302,6 +311,7 @@ int __cpu_disable(void)
 	 * and we must not schedule until we're ready to give up the cpu.
 	 */
 	set_cpu_online(cpu, false);
+	ipi_teardown(cpu);
 
 	/*
 	 * OK - migrate IRQs away from this CPU
@@ -890,10 +900,9 @@ static void ipi_cpu_crash_stop(unsigned int cpu, struct pt_regs *regs)
 /*
  * Main handler for inter-processor interrupts
  */
-void handle_IPI(int ipinr, struct pt_regs *regs)
+static void do_handle_IPI(int ipinr)
 {
 	unsigned int cpu = smp_processor_id();
-	struct pt_regs *old_regs = set_irq_regs(regs);
 
 	if ((unsigned)ipinr < NR_IPI) {
 		trace_ipi_entry_rcuidle(ipi_types[ipinr]);
@@ -906,21 +915,16 @@ void handle_IPI(int ipinr, struct pt_regs *regs)
 		break;
 
 	case IPI_CALL_FUNC:
-		irq_enter();
 		generic_smp_call_function_interrupt();
-		irq_exit();
 		break;
 
 	case IPI_CPU_STOP:
-		irq_enter();
 		local_cpu_stop();
-		irq_exit();
 		break;
 
 	case IPI_CPU_CRASH_STOP:
 		if (IS_ENABLED(CONFIG_KEXEC_CORE)) {
-			irq_enter();
-			ipi_cpu_crash_stop(cpu, regs);
+			ipi_cpu_crash_stop(cpu, get_irq_regs());
 
 			unreachable();
 		}
@@ -928,17 +932,13 @@ void handle_IPI(int ipinr, struct pt_regs *regs)
 
 #ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
 	case IPI_TIMER:
-		irq_enter();
 		tick_receive_broadcast();
-		irq_exit();
 		break;
 #endif
 
 #ifdef CONFIG_IRQ_WORK
 	case IPI_IRQ_WORK:
-		irq_enter();
 		irq_work_run();
-		irq_exit();
 		break;
 #endif
 
@@ -957,9 +957,78 @@ void handle_IPI(int ipinr, struct pt_regs *regs)
 
 	if ((unsigned)ipinr < NR_IPI)
 		trace_ipi_exit_rcuidle(ipi_types[ipinr]);
+}
+
+/* Legacy version, should go away once all irqchips have been converted */
+void handle_IPI(int ipinr, struct pt_regs *regs)
+{
+	struct pt_regs *old_regs = set_irq_regs(regs);
+
+	irq_enter();
+	do_handle_IPI(ipinr);
+	irq_exit();
+
 	set_irq_regs(old_regs);
 }
 
+static irqreturn_t ipi_handler(int irq, void *data)
+{
+	do_handle_IPI(irq - ipi_irq_base);
+	return IRQ_HANDLED;
+}
+
+static void ipi_send(const struct cpumask *target, unsigned int ipi)
+{
+	__ipi_send_mask(ipi_desc[ipi], target);
+}
+
+static void ipi_setup(int cpu)
+{
+	int i;
+
+	if (!ipi_irq_base)
+		return;
+
+	for (i = 0; i < nr_ipi; i++)
+		enable_percpu_irq(ipi_irq_base + i, 0);
+}
+
+static void ipi_teardown(int cpu)
+{
+	int i;
+
+	if (!ipi_irq_base)
+		return;
+
+	for (i = 0; i < nr_ipi; i++)
+		disable_percpu_irq(ipi_irq_base + i);
+}
+
+void __init set_smp_ipi_range(int ipi_base, int n)
+{
+	int i;
+
+	WARN_ON(n < NR_IPI);
+	nr_ipi = min(n, NR_IPI);
+
+	for (i = 0; i < nr_ipi; i++) {
+		int err;
+
+		err = request_percpu_irq(ipi_base + i, ipi_handler,
+					 "IPI", &irq_stat);
+		WARN_ON(err);
+
+		ipi_desc[i] = irq_to_desc(ipi_base + i);
+		irq_set_status_flags(ipi_base + i, IRQ_HIDDEN);
+	}
+
+	ipi_irq_base = ipi_base;
+	__smp_cross_call = ipi_send;
+
+	/* Setup the boot CPU immediately */
+	ipi_setup(smp_processor_id());
+}
+
 void smp_send_reschedule(int cpu)
 {
 	smp_cross_call(cpumask_of(cpu), IPI_RESCHEDULE);
-- 
2.27.0

