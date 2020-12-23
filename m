Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B39C32E1ABA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 11:05:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728521AbgLWKFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 05:05:22 -0500
Received: from foss.arm.com ([217.140.110.172]:48060 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728443AbgLWKFV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 05:05:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B0631500;
        Wed, 23 Dec 2020 02:04:14 -0800 (PST)
Received: from p8cg001049571a15.blr.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 913A53F718;
        Wed, 23 Dec 2020 02:04:11 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Linu Cherian <lcherian@marvell.com>
Subject: [PATCH 10/11] coresight: sink: Add TRBE driver
Date:   Wed, 23 Dec 2020 15:33:42 +0530
Message-Id: <1608717823-18387-11-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1608717823-18387-1-git-send-email-anshuman.khandual@arm.com>
References: <1608717823-18387-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trace Buffer Extension (TRBE) implements a trace buffer per CPU which is
accessible via the system registers. The TRBE supports different addressing
modes including CPU virtual address and buffer modes including the circular
buffer mode. The TRBE buffer is addressed by a base pointer (TRBBASER_EL1),
an write pointer (TRBPTR_EL1) and a limit pointer (TRBLIMITR_EL1). But the
access to the trace buffer could be prohibited by a higher exception level
(EL3 or EL2), indicated by TRBIDR_EL1.P. The TRBE can also generate a CPU
private interrupt (PPI) on address translation errors and when the buffer
is full. Overall implementation here is inspired from the Arm SPE driver.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
Changes in V1:

- Replaced direct alignment tests with IS_ALIGNED()
- Dropped trbe_perf->pid as its not really required
- Dropped trbe_drvdata->atclk is its not really required
- Changed trbe_cpudata->trbe_align sysfs entry as hex
- Dropped trbe_cpudata->irq sysfs entry completely and updated the documentation
- Dropped ACPI based TRBE detection support
- Dropped trbe_address_mode and string enum
- Added CORESIGHT_DEV_SUBTYPE_SINK_PERCPU_SYSMEM enumeration
- Make TRBE driver modular
- Premature exit when mode != CS_MODE_PERF
- Dropped CONFIG_PM suspend and resume support
- Dropped unused helpers and enumerations
- Truncate the perf record when perf_aux_output_begin() fails
- Dropped assert_trbe_address_[mode|align]()
- Introduce clear_trbe_state() which clear TRBSR in single pass
- Introduce set_trbe_state() which configures TRBE for perf session
- Changed percpu trbe_drvdata->handle to hold a pointer instead
- Dropped TSB_CSYNC, dsb(), isb() from trbe_get_fault_act()
- Dropped two redundant isb() from trbe_reset_local()
- Dropped flush_tlb_all() from trbe_enable_hw()
- Moved dsb() after TSB_CSYNC in trbe_enable_hw() and trbe_disable_and_drain_local()
- Changed dsb() argument to ish for all instances
- Introduce set_trbe_flush()
- Reorganized arm_trbe_[probe|remove]_coresight_cpu()
- Dropped smp_call_function_single() from cpu online path i.e arm_trbe_cpu_startup() 
- Replaced smp_call_function_single() with smp_call_function_many()
- Added some documentation on TRBE buffer management for perf
- Added comment for padding packet ETE_IGNORE_PACKET
- Dropped trbe_name[], instead used DRVNAME
- Changed TRBE DT node from arm-trbe to trace-buffer-extension
- Renamed trbe_perf structure as trbe_buf
- Changed all TRBE enum classification into just simple int defines
- Reworked TRBE module init/exit and CPU start-up/tear-down sequences

 Documentation/trace/coresight/coresight-trbe.rst |  39 +
 arch/arm64/include/asm/sysreg.h                  |   2 +
 drivers/hwtracing/coresight/Kconfig              |  11 +
 drivers/hwtracing/coresight/Makefile             |   1 +
 drivers/hwtracing/coresight/coresight-trbe.c     | 925 +++++++++++++++++++++++
 drivers/hwtracing/coresight/coresight-trbe.h     | 248 ++++++
 6 files changed, 1226 insertions(+)
 create mode 100644 Documentation/trace/coresight/coresight-trbe.rst
 create mode 100644 drivers/hwtracing/coresight/coresight-trbe.c
 create mode 100644 drivers/hwtracing/coresight/coresight-trbe.h

diff --git a/Documentation/trace/coresight/coresight-trbe.rst b/Documentation/trace/coresight/coresight-trbe.rst
new file mode 100644
index 0000000..8b79850
--- /dev/null
+++ b/Documentation/trace/coresight/coresight-trbe.rst
@@ -0,0 +1,39 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==============================
+Trace Buffer Extension (TRBE).
+==============================
+
+    :Author:   Anshuman Khandual <anshuman.khandual@arm.com>
+    :Date:     November 2020
+
+Hardware Description
+--------------------
+
+Trace Buffer Extension (TRBE) is a percpu hardware which captures in system
+memory, CPU traces generated from a corresponding percpu tracing unit. This
+gets plugged in as a coresight sink device because the corresponding trace
+genarators (ETE), are plugged in as source device.
+
+The TRBE is not compliant to CoreSight architecture specifications, but is
+driven via the CoreSight driver framework to support the ETE (which is
+CoreSight compliant) integration.
+
+Sysfs files and directories
+---------------------------
+
+The TRBE devices appear on the existing coresight bus alongside the other
+coresight devices::
+
+	>$ ls /sys/bus/coresight/devices
+	trbe0  trbe1  trbe2 trbe3
+
+The ``trbe<N>`` named TRBEs are associated with a CPU.::
+
+	>$ ls /sys/bus/coresight/devices/trbe0/
+	irq align dbm
+
+*Key file items are:-*
+   * ``align``: TRBE write pointer alignment
+   * ``dbm``: TRBE updates memory with access and dirty flags
+
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index e6962b1..2a9bfb7 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -97,6 +97,7 @@
 #define SET_PSTATE_UAO(x)		__emit_inst(0xd500401f | PSTATE_UAO | ((!!x) << PSTATE_Imm_shift))
 #define SET_PSTATE_SSBS(x)		__emit_inst(0xd500401f | PSTATE_SSBS | ((!!x) << PSTATE_Imm_shift))
 #define SET_PSTATE_TCO(x)		__emit_inst(0xd500401f | PSTATE_TCO | ((!!x) << PSTATE_Imm_shift))
+#define TSB_CSYNC			__emit_inst(0xd503225f)
 
 #define __SYS_BARRIER_INSN(CRm, op2, Rt) \
 	__emit_inst(0xd5000000 | sys_insn(0, 3, 3, (CRm), (op2)) | ((Rt) & 0x1f))
@@ -869,6 +870,7 @@
 #define ID_AA64MMFR2_CNP_SHIFT		0
 
 /* id_aa64dfr0 */
+#define ID_AA64DFR0_TRBE_SHIFT		44
 #define ID_AA64DFR0_TRACE_FILT_SHIFT	40
 #define ID_AA64DFR0_DOUBLELOCK_SHIFT	36
 #define ID_AA64DFR0_PMSVER_SHIFT	32
diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
index c119824..0f5e101 100644
--- a/drivers/hwtracing/coresight/Kconfig
+++ b/drivers/hwtracing/coresight/Kconfig
@@ -156,6 +156,17 @@ config CORESIGHT_CTI
 	  To compile this driver as a module, choose M here: the
 	  module will be called coresight-cti.
 
+config CORESIGHT_TRBE
+	bool "Trace Buffer Extension (TRBE) driver"
+	depends on ARM64
+	help
+	  This driver provides support for percpu Trace Buffer Extension (TRBE).
+	  TRBE always needs to be used along with it's corresponding percpu ETE
+	  component. ETE generates trace data which is then captured with TRBE.
+	  Unlike traditional sink devices, TRBE is a CPU feature accessible via
+	  system registers. But it's explicit dependency with trace unit (ETE)
+	  requires it to be plugged in as a coresight sink device.
+
 config CORESIGHT_CTI_INTEGRATION_REGS
 	bool "Access CTI CoreSight Integration Registers"
 	depends on CORESIGHT_CTI
diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
index f20e357..d608165 100644
--- a/drivers/hwtracing/coresight/Makefile
+++ b/drivers/hwtracing/coresight/Makefile
@@ -21,5 +21,6 @@ obj-$(CONFIG_CORESIGHT_STM) += coresight-stm.o
 obj-$(CONFIG_CORESIGHT_CPU_DEBUG) += coresight-cpu-debug.o
 obj-$(CONFIG_CORESIGHT_CATU) += coresight-catu.o
 obj-$(CONFIG_CORESIGHT_CTI) += coresight-cti.o
+obj-$(CONFIG_CORESIGHT_TRBE) += coresight-trbe.o
 coresight-cti-y := coresight-cti-core.o	coresight-cti-platform.o \
 		   coresight-cti-sysfs.o
diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
new file mode 100644
index 0000000..ba280e6
--- /dev/null
+++ b/drivers/hwtracing/coresight/coresight-trbe.c
@@ -0,0 +1,925 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * This driver enables Trace Buffer Extension (TRBE) as a per-cpu coresight
+ * sink device could then pair with an appropriate per-cpu coresight source
+ * device (ETE) thus generating required trace data. Trace can be enabled
+ * via the perf framework.
+ *
+ * Copyright (C) 2020 ARM Ltd.
+ *
+ * Author: Anshuman Khandual <anshuman.khandual@arm.com>
+ */
+#define DRVNAME "arm_trbe"
+
+#define pr_fmt(fmt) DRVNAME ": " fmt
+
+#include "coresight-trbe.h"
+
+#define PERF_IDX2OFF(idx, buf) ((idx) % ((buf)->nr_pages << PAGE_SHIFT))
+
+/*
+ * A padding packet that will help the user space tools
+ * in skipping relevant sections in the captured trace
+ * data which could not be decoded.
+ */
+#define ETE_IGNORE_PACKET 0x70
+
+enum trbe_fault_action {
+	TRBE_FAULT_ACT_WRAP,
+	TRBE_FAULT_ACT_SPURIOUS,
+	TRBE_FAULT_ACT_FATAL,
+};
+
+struct trbe_buf {
+	unsigned long trbe_base;
+	unsigned long trbe_limit;
+	unsigned long trbe_write;
+	int nr_pages;
+	void **pages;
+	bool snapshot;
+	struct trbe_cpudata *cpudata;
+};
+
+struct trbe_cpudata {
+	bool trbe_dbm;
+	u64 trbe_align;
+	int cpu;
+	enum cs_mode mode;
+	struct trbe_buf *buf;
+	struct trbe_drvdata *drvdata;
+};
+
+struct trbe_drvdata {
+	struct trbe_cpudata __percpu *cpudata;
+	struct perf_output_handle __percpu **handle;
+	struct hlist_node hotplug_node;
+	int irq;
+	cpumask_t supported_cpus;
+	enum cpuhp_state trbe_online;
+	struct platform_device *pdev;
+};
+
+static int trbe_alloc_node(struct perf_event *event)
+{
+	if (event->cpu == -1)
+		return NUMA_NO_NODE;
+	return cpu_to_node(event->cpu);
+}
+
+static void set_trbe_flush(void)
+{
+	asm(TSB_CSYNC);
+	dsb(ish);
+}
+
+static void trbe_disable_and_drain_local(void)
+{
+	write_sysreg_s(0, SYS_TRBLIMITR_EL1);
+	isb();
+	set_trbe_flush();
+}
+
+static void trbe_reset_local(void)
+{
+	trbe_disable_and_drain_local();
+	write_sysreg_s(0, SYS_TRBPTR_EL1);
+	write_sysreg_s(0, SYS_TRBBASER_EL1);
+	write_sysreg_s(0, SYS_TRBSR_EL1);
+	isb();
+}
+
+/*
+ * TRBE Buffer Management
+ *
+ * The TRBE buffer spans from the base pointer till the limit pointer. When enabled,
+ * it starts writing trace data from the write pointer onward till the limit pointer.
+ * When the write pointer reaches the address just before the limit pointer, it gets
+ * wrapped around again to the base pointer. This is called a TRBE wrap event which
+ * is accompanied by an IRQ. The write pointer again starts writing trace data from
+ * the base pointer until just before the limit pointer before getting wrapped again
+ * with an IRQ and this process just goes on as long as the TRBE is enabled.
+ *
+ *	Wrap around with an IRQ
+ *	------ < ------ < ------- < ----- < -----
+ *	|					|
+ *	------ > ------ > ------- > ----- > -----
+ *
+ *	+---------------+-----------------------+
+ *	|		|			|
+ *	+---------------+-----------------------+
+ *	Base Pointer	Write Pointer		Limit Pointer
+ *
+ * The base and limit pointers always needs to be PAGE_SIZE aligned. But the write
+ * pointer can be aligned to the implementation defined TRBE trace buffer alignment
+ * as captured in trbe_cpudata->trbe_align.
+ *
+ *
+ *		head		tail		wakeup
+ *	+---------------------------------------+----- ~ ~ ------
+ *	|$$$$$$$|################|$$$$$$$$$$$$$$|		|
+ *	+---------------------------------------+----- ~ ~ ------
+ *	Base Pointer	Write Pointer		Limit Pointer
+ *
+ * The perf_output_handle indices (head, tail, wakeup) are monotonically increasing
+ * values which tracks all the driver writes and user reads from the perf auxiliary
+ * buffer. Generally [head..tail] is the area where the driver can write into unless
+ * the wakeup is behind the tail. Enabled TRBE buffer span needs to be adjusted and
+ * configured depending on the perf_output_handle indices, so that the driver does
+ * not override into areas in the perf auxiliary buffer which is being or yet to be
+ * consumed from the user space. The enabled TRBE buffer area is a moving subset of
+ * the allocated perf auxiliary buffer.
+ */
+static void trbe_pad_buf(struct perf_output_handle *handle, int len)
+{
+	struct trbe_buf *buf = etm_perf_sink_config(handle);
+	u64 head = PERF_IDX2OFF(handle->head, buf);
+
+	memset((void *) buf->trbe_base + head, ETE_IGNORE_PACKET, len);
+	if (!buf->snapshot)
+		perf_aux_output_skip(handle, len);
+}
+
+static unsigned long trbe_snapshot_offset(struct perf_output_handle *handle)
+{
+	struct trbe_buf *buf = etm_perf_sink_config(handle);
+	u64 head = PERF_IDX2OFF(handle->head, buf);
+	u64 limit = buf->nr_pages * PAGE_SIZE;
+
+	/*
+	 * The trace format isn't parseable in reverse, so clamp the limit
+	 * to half of the buffer size in snapshot mode so that the worst
+	 * case is half a buffer of records, as opposed to a single record.
+	 */
+	if (head < limit >> 1)
+		limit >>= 1;
+
+	return limit;
+}
+
+/*
+ * TRBE Limit Calculation
+ *
+ * The following markers are used to illustrate various TRBE buffer situations.
+ *
+ * $$$$ - Data area, unconsumed captured trace data, not to be overridden
+ * #### - Free area, enabled, trace will be written
+ * %%%% - Free area, disabled, trace will not be written
+ * ==== - Free area, padded with ETE_IGNORE_PACKET, trace will be skipped
+ */
+static unsigned long trbe_normal_offset(struct perf_output_handle *handle)
+{
+	struct trbe_buf *buf = etm_perf_sink_config(handle);
+	struct trbe_cpudata *cpudata = buf->cpudata;
+	const u64 bufsize = buf->nr_pages * PAGE_SIZE;
+	u64 limit = bufsize;
+	u64 head, tail, wakeup;
+
+	head = PERF_IDX2OFF(handle->head, buf);
+
+	/*
+	 *		head
+	 *	------->|
+	 *	|
+	 *	head	TRBE align	tail
+	 * +----|-------|---------------|-------+
+	 * |$$$$|=======|###############|$$$$$$$|
+	 * +----|-------|---------------|-------+
+	 * trbe_base				trbe_base + nr_pages
+	 *
+	 * Perf aux buffer output head position can be misaligned depending on
+	 * various factors including user space reads. In case misaligned, head
+	 * needs to be aligned before TRBE can be configured. Pad the alignment
+	 * gap with ETE_IGNORE_PACKET bytes that will be ignored by user tools
+	 * and skip this section thus advancing the head.
+	 */
+	if (!IS_ALIGNED(head, cpudata->trbe_align)) {
+		unsigned long delta = roundup(head, cpudata->trbe_align) - head;
+
+		delta = min(delta, handle->size);
+		trbe_pad_buf(handle, delta);
+		head = PERF_IDX2OFF(handle->head, buf);
+	}
+
+	/*
+	 *	head = tail (size = 0)
+	 * +----|-------------------------------+
+	 * |$$$$|$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$	|
+	 * +----|-------------------------------+
+	 * trbe_base				trbe_base + nr_pages
+	 *
+	 * Perf aux buffer does not have any space for the driver to write into.
+	 * Just communicate trace truncation event to the user space by marking
+	 * it with PERF_AUX_FLAG_TRUNCATED.
+	 */
+	if (!handle->size) {
+		perf_aux_output_flag(handle, PERF_AUX_FLAG_TRUNCATED);
+		return 0;
+	}
+
+	/* Compute the tail and wakeup indices now that we've aligned head */
+	tail = PERF_IDX2OFF(handle->head + handle->size, buf);
+	wakeup = PERF_IDX2OFF(handle->wakeup, buf);
+
+	/*
+	 * Lets calculate the buffer area which TRBE could write into. There
+	 * are three possible scenarios here. Limit needs to be aligned with
+	 * PAGE_SIZE per the TRBE requirement. Always avoid clobbering the
+	 * unconsumed data.
+	 *
+	 * 1) head < tail
+	 *
+	 *	head			tail
+	 * +----|-----------------------|-------+
+	 * |$$$$|#######################|$$$$$$$|
+	 * +----|-----------------------|-------+
+	 * trbe_base			limit	trbe_base + nr_pages
+	 *
+	 * TRBE could write into [head..tail] area. Unless the tail is right at
+	 * the end of the buffer, neither an wrap around nor an IRQ is expected
+	 * while being enabled.
+	 *
+	 * 2) head == tail
+	 *
+	 *	head = tail (size > 0)
+	 * +----|-------------------------------+
+	 * |%%%%|###############################|
+	 * +----|-------------------------------+
+	 * trbe_base				limit = trbe_base + nr_pages
+	 *
+	 * TRBE should just write into [head..base + nr_pages] area even though
+	 * the entire buffer is empty. Reason being, when the trace reaches the
+	 * end of the buffer, it will just wrap around with an IRQ giving an
+	 * opportunity to reconfigure the buffer.
+	 *
+	 * 3) tail < head
+	 *
+	 *	tail			head
+	 * +----|-----------------------|-------+
+	 * |%%%%|$$$$$$$$$$$$$$$$$$$$$$$|#######|
+	 * +----|-----------------------|-------+
+	 * trbe_base				limit = trbe_base + nr_pages
+	 *
+	 * TRBE should just write into [head..base + nr_pages] area even though
+	 * the [trbe_base..tail] is also empty. Reason being, when the trace
+	 * reaches the end of the buffer, it will just wrap around with an IRQ
+	 * giving an opportunity to reconfigure the buffer.
+	 */
+	if (head < tail)
+		limit = round_down(tail, PAGE_SIZE);
+
+	/*
+	 * Wakeup may be arbitrarily far into the future. If it's not in the
+	 * current generation, either we'll wrap before hitting it, or it's
+	 * in the past and has been handled already.
+	 *
+	 * If there's a wakeup before we wrap, arrange to be woken up by the
+	 * page boundary following it. Keep the tail boundary if that's lower.
+	 *
+	 *	head		wakeup	tail
+	 * +----|---------------|-------|-------+
+	 * |$$$$|###############|%%%%%%%|$$$$$$$|
+	 * +----|---------------|-------|-------+
+	 * trbe_base		limit		trbe_base + nr_pages
+	 */
+	if (handle->wakeup < (handle->head + handle->size) && head <= wakeup)
+		limit = min(limit, round_up(wakeup, PAGE_SIZE));
+
+	/*
+	 * There are two situation when this can happen i.e limit is before
+	 * the head and hence TRBE cannot be configured.
+	 *
+	 * 1) head < tail (aligned down with PAGE_SIZE) and also they are both
+	 * within the same PAGE size range.
+	 *
+	 *			PAGE_SIZE
+	 *		|----------------------|
+	 *
+	 *		limit	head	tail
+	 * +------------|------|--------|-------+
+	 * |$$$$$$$$$$$$$$$$$$$|========|$$$$$$$|
+	 * +------------|------|--------|-------+
+	 * trbe_base				trbe_base + nr_pages
+	 *
+	 * 2) head < wakeup (aligned up with PAGE_SIZE) < tail and also both
+	 * head and wakeup are within same PAGE size range.
+	 *
+	 *		PAGE_SIZE
+	 *	|----------------------|
+	 *
+	 *	limit	head	wakeup  tail
+	 * +----|------|-------|--------|-------+
+	 * |$$$$$$$$$$$|=======|========|$$$$$$$|
+	 * +----|------|-------|--------|-------+
+	 * trbe_base				trbe_base + nr_pages
+	 */
+	if (limit > head)
+		return limit;
+
+	trbe_pad_buf(handle, handle->size);
+	perf_aux_output_flag(handle, PERF_AUX_FLAG_TRUNCATED);
+	return 0;
+}
+
+static unsigned long get_trbe_limit(struct perf_output_handle *handle)
+{
+	struct trbe_buf *buf = etm_perf_sink_config(handle);
+	unsigned long offset;
+
+	if (buf->snapshot)
+		offset = trbe_snapshot_offset(handle);
+	else
+		offset = trbe_normal_offset(handle);
+	return buf->trbe_base + offset;
+}
+
+static void clear_trbe_state(void)
+{
+	u64 trbsr = read_sysreg_s(SYS_TRBSR_EL1);
+
+	WARN_ON(is_trbe_enabled());
+	trbsr &= ~TRBSR_IRQ;
+	trbsr &= ~TRBSR_TRG;
+	trbsr &= ~TRBSR_WRAP;
+	trbsr &= ~(TRBSR_EC_MASK << TRBSR_EC_SHIFT);
+	trbsr &= ~(TRBSR_BSC_MASK << TRBSR_BSC_SHIFT);
+	trbsr &= ~(TRBSR_FSC_MASK << TRBSR_FSC_SHIFT);
+	write_sysreg_s(trbsr, SYS_TRBSR_EL1);
+}
+
+static void set_trbe_state(void)
+{
+	u64 trblimitr = read_sysreg_s(SYS_TRBLIMITR_EL1);
+
+	trblimitr &= ~TRBLIMITR_NVM;
+	trblimitr &= ~(TRBLIMITR_FILL_MODE_MASK << TRBLIMITR_FILL_MODE_SHIFT);
+	trblimitr &= ~(TRBLIMITR_TRIG_MODE_MASK << TRBLIMITR_TRIG_MODE_SHIFT);
+	trblimitr |= (TRBE_FILL_STOP & TRBLIMITR_FILL_MODE_MASK) << TRBLIMITR_FILL_MODE_SHIFT;
+	trblimitr |= (TRBE_TRIGGER_IGNORE & TRBLIMITR_TRIG_MODE_MASK) << TRBLIMITR_TRIG_MODE_SHIFT;
+	write_sysreg_s(trblimitr, SYS_TRBLIMITR_EL1);
+}
+
+static void trbe_enable_hw(struct trbe_buf *buf)
+{
+	WARN_ON(buf->trbe_write < buf->trbe_base);
+	WARN_ON(buf->trbe_write >= buf->trbe_limit);
+	set_trbe_disabled();
+	clear_trbe_state();
+	set_trbe_state();
+	isb();
+	set_trbe_base_pointer(buf->trbe_base);
+	set_trbe_limit_pointer(buf->trbe_limit);
+	set_trbe_write_pointer(buf->trbe_write);
+	isb();
+	set_trbe_running();
+	set_trbe_enabled();
+	set_trbe_flush();
+}
+
+static void *arm_trbe_alloc_buffer(struct coresight_device *csdev,
+				   struct perf_event *event, void **pages,
+				   int nr_pages, bool snapshot)
+{
+	struct trbe_buf *buf;
+	struct page **pglist;
+	int i;
+
+	if ((nr_pages < 2) || (snapshot && (nr_pages & 1)))
+		return NULL;
+
+	buf = kzalloc_node(sizeof(*buf), GFP_KERNEL, trbe_alloc_node(event));
+	if (IS_ERR(buf))
+		return ERR_PTR(-ENOMEM);
+
+	pglist = kcalloc(nr_pages, sizeof(*pglist), GFP_KERNEL);
+	if (IS_ERR(pglist)) {
+		kfree(buf);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	for (i = 0; i < nr_pages; i++)
+		pglist[i] = virt_to_page(pages[i]);
+
+	buf->trbe_base = (unsigned long) vmap(pglist, nr_pages, VM_MAP, PAGE_KERNEL);
+	if (IS_ERR((void *) buf->trbe_base)) {
+		kfree(pglist);
+		kfree(buf);
+		return ERR_PTR(buf->trbe_base);
+	}
+	buf->trbe_limit = buf->trbe_base + nr_pages * PAGE_SIZE;
+	buf->trbe_write = buf->trbe_base;
+	buf->snapshot = snapshot;
+	buf->nr_pages = nr_pages;
+	buf->pages = pages;
+	kfree(pglist);
+	return buf;
+}
+
+void arm_trbe_free_buffer(void *config)
+{
+	struct trbe_buf *buf = config;
+
+	vunmap((void *) buf->trbe_base);
+	kfree(buf);
+}
+
+static unsigned long arm_trbe_update_buffer(struct coresight_device *csdev,
+					    struct perf_output_handle *handle,
+					    void *config)
+{
+	struct trbe_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+	struct trbe_cpudata *cpudata = dev_get_drvdata(&csdev->dev);
+	struct trbe_buf *buf = config;
+	unsigned long size, offset;
+
+	WARN_ON(buf->cpudata != cpudata);
+	WARN_ON(cpudata->cpu != smp_processor_id());
+	WARN_ON(cpudata->drvdata != drvdata);
+	if (cpudata->mode != CS_MODE_PERF)
+		return -EINVAL;
+
+	offset = get_trbe_write_pointer() - get_trbe_base_pointer();
+	size = offset - PERF_IDX2OFF(handle->head, buf);
+	if (buf->snapshot)
+		handle->head += size;
+	trbe_reset_local();
+	return size;
+}
+
+static int arm_trbe_enable(struct coresight_device *csdev, u32 mode, void *data)
+{
+	struct trbe_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+	struct trbe_cpudata *cpudata = dev_get_drvdata(&csdev->dev);
+	struct perf_output_handle *handle = data;
+	struct trbe_buf *buf = etm_perf_sink_config(handle);
+
+	WARN_ON(cpudata->cpu != smp_processor_id());
+	WARN_ON(cpudata->drvdata != drvdata);
+	if (mode != CS_MODE_PERF)
+		return -EINVAL;
+
+	*this_cpu_ptr(drvdata->handle) = handle;
+	cpudata->buf = buf;
+	cpudata->mode = mode;
+	buf->cpudata = cpudata;
+	buf->trbe_write = buf->trbe_base + PERF_IDX2OFF(handle->head, buf);
+	buf->trbe_limit = get_trbe_limit(handle);
+	if (buf->trbe_limit == buf->trbe_base) {
+		trbe_disable_and_drain_local();
+		return 0;
+	}
+	trbe_enable_hw(buf);
+	return 0;
+}
+
+static int arm_trbe_disable(struct coresight_device *csdev)
+{
+	struct trbe_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+	struct trbe_cpudata *cpudata = dev_get_drvdata(&csdev->dev);
+	struct trbe_buf *buf = cpudata->buf;
+
+	WARN_ON(buf->cpudata != cpudata);
+	WARN_ON(cpudata->cpu != smp_processor_id());
+	WARN_ON(cpudata->drvdata != drvdata);
+	if (cpudata->mode != CS_MODE_PERF)
+		return -EINVAL;
+
+	trbe_disable_and_drain_local();
+	buf->cpudata = NULL;
+	cpudata->buf = NULL;
+	cpudata->mode = CS_MODE_DISABLED;
+	return 0;
+}
+
+static void trbe_handle_fatal(struct perf_output_handle *handle)
+{
+	perf_aux_output_flag(handle, PERF_AUX_FLAG_TRUNCATED);
+	perf_aux_output_end(handle, 0);
+	trbe_disable_and_drain_local();
+}
+
+static void trbe_handle_spurious(struct perf_output_handle *handle)
+{
+	struct trbe_buf *buf = etm_perf_sink_config(handle);
+
+	buf->trbe_write = buf->trbe_base + PERF_IDX2OFF(handle->head, buf);
+	buf->trbe_limit = get_trbe_limit(handle);
+	if (buf->trbe_limit == buf->trbe_base) {
+		trbe_disable_and_drain_local();
+		return;
+	}
+	trbe_enable_hw(buf);
+}
+
+static void trbe_handle_overflow(struct perf_output_handle *handle)
+{
+	struct perf_event *event = handle->event;
+	struct trbe_buf *buf = etm_perf_sink_config(handle);
+	unsigned long offset, size;
+	struct etm_event_data *event_data;
+
+	offset = get_trbe_limit_pointer() - get_trbe_base_pointer();
+	size = offset - PERF_IDX2OFF(handle->head, buf);
+	if (buf->snapshot)
+		handle->head = offset;
+	perf_aux_output_end(handle, size);
+
+	event_data = perf_aux_output_begin(handle, event);
+	if (!event_data) {
+		event->hw.state |= PERF_HES_STOPPED;
+		trbe_disable_and_drain_local();
+		perf_aux_output_flag(handle, PERF_AUX_FLAG_TRUNCATED);
+		return;
+	}
+	buf->trbe_write = buf->trbe_base;
+	buf->trbe_limit = get_trbe_limit(handle);
+	if (buf->trbe_limit == buf->trbe_base) {
+		trbe_disable_and_drain_local();
+		return;
+	}
+	*this_cpu_ptr(buf->cpudata->drvdata->handle) = handle;
+	trbe_enable_hw(buf);
+}
+
+static bool is_perf_trbe(struct perf_output_handle *handle)
+{
+	struct trbe_buf *buf = etm_perf_sink_config(handle);
+	struct trbe_cpudata *cpudata = buf->cpudata;
+	struct trbe_drvdata *drvdata = cpudata->drvdata;
+	int cpu = smp_processor_id();
+
+	WARN_ON(buf->trbe_base != get_trbe_base_pointer());
+	WARN_ON(buf->trbe_limit != get_trbe_limit_pointer());
+
+	if (cpudata->mode != CS_MODE_PERF)
+		return false;
+
+	if (cpudata->cpu != cpu)
+		return false;
+
+	if (!cpumask_test_cpu(cpu, &drvdata->supported_cpus))
+		return false;
+
+	return true;
+}
+
+static enum trbe_fault_action trbe_get_fault_act(struct perf_output_handle *handle)
+{
+	int ec = get_trbe_ec();
+	int bsc = get_trbe_bsc();
+
+	WARN_ON(is_trbe_running());
+	if (is_trbe_trg() || is_trbe_abort())
+		return TRBE_FAULT_ACT_FATAL;
+
+	if ((ec == TRBE_EC_STAGE1_ABORT) || (ec == TRBE_EC_STAGE2_ABORT))
+		return TRBE_FAULT_ACT_FATAL;
+
+	if (is_trbe_wrap() && (ec == TRBE_EC_OTHERS) && (bsc == TRBE_BSC_FILLED)) {
+		if (get_trbe_write_pointer() == get_trbe_base_pointer())
+			return TRBE_FAULT_ACT_WRAP;
+	}
+	return TRBE_FAULT_ACT_SPURIOUS;
+}
+
+static irqreturn_t arm_trbe_irq_handler(int irq, void *dev)
+{
+	struct perf_output_handle **handle_ptr = dev;
+	struct perf_output_handle *handle = *handle_ptr;
+	enum trbe_fault_action act;
+
+	WARN_ON(!is_trbe_irq());
+	clr_trbe_irq();
+
+	if (!perf_get_aux(handle))
+		return IRQ_NONE;
+
+	if (!is_perf_trbe(handle))
+		return IRQ_NONE;
+
+	irq_work_run();
+
+	act = trbe_get_fault_act(handle);
+	switch (act) {
+	case TRBE_FAULT_ACT_WRAP:
+		trbe_handle_overflow(handle);
+		break;
+	case TRBE_FAULT_ACT_SPURIOUS:
+		trbe_handle_spurious(handle);
+		break;
+	case TRBE_FAULT_ACT_FATAL:
+		trbe_handle_fatal(handle);
+		break;
+	}
+	return IRQ_HANDLED;
+}
+
+static const struct coresight_ops_sink arm_trbe_sink_ops = {
+	.enable		= arm_trbe_enable,
+	.disable	= arm_trbe_disable,
+	.alloc_buffer	= arm_trbe_alloc_buffer,
+	.free_buffer	= arm_trbe_free_buffer,
+	.update_buffer	= arm_trbe_update_buffer,
+};
+
+static const struct coresight_ops arm_trbe_cs_ops = {
+	.sink_ops	= &arm_trbe_sink_ops,
+};
+
+static ssize_t align_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct trbe_cpudata *cpudata = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%llx\n", cpudata->trbe_align);
+}
+static DEVICE_ATTR_RO(align);
+
+static ssize_t dbm_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct trbe_cpudata *cpudata = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%d\n", cpudata->trbe_dbm);
+}
+static DEVICE_ATTR_RO(dbm);
+
+static struct attribute *arm_trbe_attrs[] = {
+	&dev_attr_align.attr,
+	&dev_attr_dbm.attr,
+	NULL,
+};
+
+static const struct attribute_group arm_trbe_group = {
+	.attrs = arm_trbe_attrs,
+};
+
+static const struct attribute_group *arm_trbe_groups[] = {
+	&arm_trbe_group,
+	NULL,
+};
+
+static void arm_trbe_probe_coresight_cpu(void *info)
+{
+	struct trbe_drvdata *drvdata = info;
+	struct coresight_desc desc = { 0 };
+	int cpu = smp_processor_id();
+	struct trbe_cpudata *cpudata = per_cpu_ptr(drvdata->cpudata, cpu);
+	struct coresight_device *trbe_csdev = per_cpu(csdev_sink, cpu);
+	struct device *dev;
+
+	if (WARN_ON(!cpudata))
+		goto cpu_clear;
+
+	if (trbe_csdev)
+		return;
+
+	cpudata->cpu = smp_processor_id();
+	cpudata->drvdata = drvdata;
+	dev = &cpudata->drvdata->pdev->dev;
+
+	if (!is_trbe_available()) {
+		pr_err("TRBE is not implemented on cpu %d\n", cpudata->cpu);
+		goto cpu_clear;
+	}
+
+	if (!is_trbe_programmable()) {
+		pr_err("TRBE is owned in higher exception level on cpu %d\n", cpudata->cpu);
+		goto cpu_clear;
+	}
+	desc.name = devm_kasprintf(dev, GFP_KERNEL, "%s%d", DRVNAME, smp_processor_id());
+	if (IS_ERR(desc.name))
+		goto cpu_clear;
+
+	desc.type = CORESIGHT_DEV_TYPE_SINK;
+	desc.subtype.sink_subtype = CORESIGHT_DEV_SUBTYPE_SINK_PERCPU_SYSMEM;
+	desc.ops = &arm_trbe_cs_ops;
+	desc.pdata = dev_get_platdata(dev);
+	desc.groups = arm_trbe_groups;
+	desc.dev = dev;
+	trbe_csdev = coresight_register(&desc);
+	if (IS_ERR(trbe_csdev))
+		goto cpu_clear;
+
+	dev_set_drvdata(&trbe_csdev->dev, cpudata);
+	cpudata->trbe_dbm = get_trbe_flag_update();
+	cpudata->trbe_align = 1ULL << get_trbe_address_align();
+	if (cpudata->trbe_align > SZ_2K) {
+		pr_err("Unsupported alignment on cpu %d\n", cpudata->cpu);
+		goto cpu_clear;
+	}
+	per_cpu(csdev_sink, cpu) = trbe_csdev;
+	trbe_reset_local();
+	enable_percpu_irq(drvdata->irq, IRQ_TYPE_NONE);
+	return;
+cpu_clear:
+	cpumask_clear_cpu(cpudata->cpu, &cpudata->drvdata->supported_cpus);
+}
+
+static void arm_trbe_remove_coresight_cpu(void *info)
+{
+	int cpu = smp_processor_id();
+	struct trbe_drvdata *drvdata = info;
+	struct trbe_cpudata *cpudata = per_cpu_ptr(drvdata->cpudata, cpu);
+	struct coresight_device *trbe_csdev = per_cpu(csdev_sink, cpu);
+
+	if (trbe_csdev) {
+		coresight_unregister(trbe_csdev);
+		cpudata->drvdata = NULL;
+		per_cpu(csdev_sink, cpu) = NULL;
+	}
+	disable_percpu_irq(drvdata->irq);
+	trbe_reset_local();
+}
+
+static int arm_trbe_probe_coresight(struct trbe_drvdata *drvdata)
+{
+	drvdata->cpudata = alloc_percpu(typeof(*drvdata->cpudata));
+	if (IS_ERR(drvdata->cpudata))
+		return PTR_ERR(drvdata->cpudata);
+
+	arm_trbe_probe_coresight_cpu(drvdata);
+	smp_call_function_many(&drvdata->supported_cpus, arm_trbe_probe_coresight_cpu, drvdata, 1);
+	return 0;
+}
+
+static int arm_trbe_remove_coresight(struct trbe_drvdata *drvdata)
+{
+	arm_trbe_remove_coresight_cpu(drvdata);
+	smp_call_function_many(&drvdata->supported_cpus, arm_trbe_remove_coresight_cpu, drvdata, 1);
+	free_percpu(drvdata->cpudata);
+	return 0;
+}
+
+static int arm_trbe_cpu_startup(unsigned int cpu, struct hlist_node *node)
+{
+	struct trbe_drvdata *drvdata = hlist_entry_safe(node, struct trbe_drvdata, hotplug_node);
+
+	if (cpumask_test_cpu(cpu, &drvdata->supported_cpus)) {
+		if (!per_cpu(csdev_sink, cpu) && (system_state == SYSTEM_RUNNING)) {
+			arm_trbe_probe_coresight_cpu(drvdata);
+		} else {
+			trbe_reset_local();
+			enable_percpu_irq(drvdata->irq, IRQ_TYPE_NONE);
+		}
+	}
+	return 0;
+}
+
+static int arm_trbe_cpu_teardown(unsigned int cpu, struct hlist_node *node)
+{
+	struct trbe_drvdata *drvdata = hlist_entry_safe(node, struct trbe_drvdata, hotplug_node);
+
+	if (cpumask_test_cpu(cpu, &drvdata->supported_cpus)) {
+		disable_percpu_irq(drvdata->irq);
+		trbe_reset_local();
+	}
+	return 0;
+}
+
+static int arm_trbe_probe_cpuhp(struct trbe_drvdata *drvdata)
+{
+	enum cpuhp_state trbe_online;
+
+	trbe_online = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN, DRVNAME,
+					arm_trbe_cpu_startup, arm_trbe_cpu_teardown);
+	if (trbe_online < 0)
+		return -EINVAL;
+
+	if (cpuhp_state_add_instance(trbe_online, &drvdata->hotplug_node))
+		return -EINVAL;
+
+	drvdata->trbe_online = trbe_online;
+	return 0;
+}
+
+static void arm_trbe_remove_cpuhp(struct trbe_drvdata *drvdata)
+{
+	cpuhp_remove_multi_state(drvdata->trbe_online);
+}
+
+static int arm_trbe_probe_irq(struct platform_device *pdev,
+			      struct trbe_drvdata *drvdata)
+{
+	drvdata->irq = platform_get_irq(pdev, 0);
+	if (!drvdata->irq) {
+		pr_err("IRQ not found for the platform device\n");
+		return -ENXIO;
+	}
+
+	if (!irq_is_percpu(drvdata->irq)) {
+		pr_err("IRQ is not a PPI\n");
+		return -EINVAL;
+	}
+
+	if (irq_get_percpu_devid_partition(drvdata->irq, &drvdata->supported_cpus))
+		return -EINVAL;
+
+	drvdata->handle = alloc_percpu(typeof(*drvdata->handle));
+	if (!drvdata->handle)
+		return -ENOMEM;
+
+	if (request_percpu_irq(drvdata->irq, arm_trbe_irq_handler, DRVNAME, drvdata->handle)) {
+		free_percpu(drvdata->handle);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static void arm_trbe_remove_irq(struct trbe_drvdata *drvdata)
+{
+	free_percpu_irq(drvdata->irq, drvdata->handle);
+	free_percpu(drvdata->handle);
+}
+
+static int arm_trbe_device_probe(struct platform_device *pdev)
+{
+	struct coresight_platform_data *pdata;
+	struct trbe_drvdata *drvdata;
+	struct device *dev = &pdev->dev;
+	int ret;
+
+	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
+	if (IS_ERR(drvdata))
+		return -ENOMEM;
+
+	pdata = coresight_get_platform_data(dev);
+	if (IS_ERR(pdata)) {
+		kfree(drvdata);
+		return -ENOMEM;
+	}
+
+	dev_set_drvdata(dev, drvdata);
+	dev->platform_data = pdata;
+	drvdata->pdev = pdev;
+	ret = arm_trbe_probe_irq(pdev, drvdata);
+	if (ret)
+		goto irq_failed;
+
+	ret = arm_trbe_probe_coresight(drvdata);
+	if (ret)
+		goto probe_failed;
+
+	ret = arm_trbe_probe_cpuhp(drvdata);
+	if (ret)
+		goto cpuhp_failed;
+
+	return 0;
+cpuhp_failed:
+	arm_trbe_remove_coresight(drvdata);
+probe_failed:
+	arm_trbe_remove_irq(drvdata);
+irq_failed:
+	kfree(pdata);
+	kfree(drvdata);
+	return ret;
+}
+
+static int arm_trbe_device_remove(struct platform_device *pdev)
+{
+	struct coresight_platform_data *pdata = dev_get_platdata(&pdev->dev);
+	struct trbe_drvdata *drvdata = platform_get_drvdata(pdev);
+
+	arm_trbe_remove_coresight(drvdata);
+	arm_trbe_remove_cpuhp(drvdata);
+	arm_trbe_remove_irq(drvdata);
+	kfree(pdata);
+	kfree(drvdata);
+	return 0;
+}
+
+static const struct of_device_id arm_trbe_of_match[] = {
+	{ .compatible = "arm,trace-buffer-extension",	.data = (void *)1 },
+	{},
+};
+MODULE_DEVICE_TABLE(of, arm_trbe_of_match);
+
+static struct platform_driver arm_trbe_driver = {
+	.driver	= {
+		.name = DRVNAME,
+		.of_match_table = of_match_ptr(arm_trbe_of_match),
+		.suppress_bind_attrs = true,
+	},
+	.probe	= arm_trbe_device_probe,
+	.remove	= arm_trbe_device_remove,
+};
+
+static int __init arm_trbe_init(void)
+{
+	int ret;
+
+	ret = platform_driver_register(&arm_trbe_driver);
+	if (!ret)
+		return 0;
+
+	pr_err("Error registering %s platform driver\n", DRVNAME);
+	return ret;
+}
+
+static void __exit arm_trbe_exit(void)
+{
+	platform_driver_unregister(&arm_trbe_driver);
+}
+module_init(arm_trbe_init);
+module_exit(arm_trbe_exit);
+
+MODULE_AUTHOR("Anshuman Khandual <anshuman.khandual@arm.com>");
+MODULE_DESCRIPTION("Arm Trace Buffer Extension (TRBE) driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/hwtracing/coresight/coresight-trbe.h b/drivers/hwtracing/coresight/coresight-trbe.h
new file mode 100644
index 0000000..e956439
--- /dev/null
+++ b/drivers/hwtracing/coresight/coresight-trbe.h
@@ -0,0 +1,248 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * This contains all required hardware related helper functions for
+ * Trace Buffer Extension (TRBE) driver in the coresight framework.
+ *
+ * Copyright (C) 2020 ARM Ltd.
+ *
+ * Author: Anshuman Khandual <anshuman.khandual@arm.com>
+ */
+#include <linux/coresight.h>
+#include <linux/device.h>
+#include <linux/irq.h>
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/smp.h>
+
+#include "coresight-etm-perf.h"
+
+DECLARE_PER_CPU(struct coresight_device *, csdev_sink);
+
+static inline bool is_trbe_available(void)
+{
+	u64 aa64dfr0 = read_sysreg_s(SYS_ID_AA64DFR0_EL1);
+	int trbe = cpuid_feature_extract_unsigned_field(aa64dfr0, ID_AA64DFR0_TRBE_SHIFT);
+
+	return trbe >= 0b0001;
+}
+
+static inline bool is_trbe_enabled(void)
+{
+	u64 trblimitr = read_sysreg_s(SYS_TRBLIMITR_EL1);
+
+	return trblimitr & TRBLIMITR_ENABLE;
+}
+
+#define TRBE_EC_OTHERS		0
+#define TRBE_EC_STAGE1_ABORT	36
+#define TRBE_EC_STAGE2_ABORT	37
+
+static inline int get_trbe_ec(void)
+{
+	u64 trbsr = read_sysreg_s(SYS_TRBSR_EL1);
+
+	return (trbsr >> TRBSR_EC_SHIFT) & TRBSR_EC_MASK;
+}
+
+#define TRBE_BSC_NOT_STOPPED	0
+#define	TRBE_BSC_FILLED		1
+#define TRBE_BSC_TRIGGERED	2
+
+static inline int get_trbe_bsc(void)
+{
+	u64 trbsr = read_sysreg_s(SYS_TRBSR_EL1);
+
+	return (trbsr >> TRBSR_BSC_SHIFT) & TRBSR_BSC_MASK;
+}
+
+static inline void clr_trbe_irq(void)
+{
+	u64 trbsr = read_sysreg_s(SYS_TRBSR_EL1);
+
+	trbsr &= ~TRBSR_IRQ;
+	write_sysreg_s(trbsr, SYS_TRBSR_EL1);
+}
+
+static inline bool is_trbe_irq(void)
+{
+	u64 trbsr = read_sysreg_s(SYS_TRBSR_EL1);
+
+	return trbsr & TRBSR_IRQ;
+}
+
+static inline bool is_trbe_trg(void)
+{
+	u64 trbsr = read_sysreg_s(SYS_TRBSR_EL1);
+
+	return trbsr & TRBSR_TRG;
+}
+
+static inline bool is_trbe_wrap(void)
+{
+	u64 trbsr = read_sysreg_s(SYS_TRBSR_EL1);
+
+	return trbsr & TRBSR_WRAP;
+}
+
+static inline bool is_trbe_abort(void)
+{
+	u64 trbsr = read_sysreg_s(SYS_TRBSR_EL1);
+
+	return trbsr & TRBSR_ABORT;
+}
+
+static inline bool is_trbe_running(void)
+{
+	u64 trbsr = read_sysreg_s(SYS_TRBSR_EL1);
+
+	return !(trbsr & TRBSR_STOP);
+}
+
+static inline void set_trbe_running(void)
+{
+	u64 trbsr = read_sysreg_s(SYS_TRBSR_EL1);
+
+	trbsr &= ~TRBSR_STOP;
+	write_sysreg_s(trbsr, SYS_TRBSR_EL1);
+}
+
+static inline void set_trbe_virtual_mode(void)
+{
+	u64 trblimitr = read_sysreg_s(SYS_TRBLIMITR_EL1);
+
+	trblimitr &= ~TRBLIMITR_NVM;
+	write_sysreg_s(trblimitr, SYS_TRBLIMITR_EL1);
+}
+
+#define TRBE_TRIGGER_STOP	0
+#define TRBE_TRIGGER_IRQ	1
+#define TRBE_TRIGGER_IGNORE	3
+
+static inline int get_trbe_trig_mode(void)
+{
+	u64 trblimitr = read_sysreg_s(SYS_TRBLIMITR_EL1);
+
+	return (trblimitr >> TRBLIMITR_TRIG_MODE_SHIFT) & TRBLIMITR_TRIG_MODE_MASK;
+}
+
+static inline void set_trbe_trig_mode(int mode)
+{
+	u64 trblimitr = read_sysreg_s(SYS_TRBLIMITR_EL1);
+
+	trblimitr &= ~(TRBLIMITR_TRIG_MODE_MASK << TRBLIMITR_TRIG_MODE_SHIFT);
+	trblimitr |= ((mode & TRBLIMITR_TRIG_MODE_MASK) << TRBLIMITR_TRIG_MODE_SHIFT);
+	write_sysreg_s(trblimitr, SYS_TRBLIMITR_EL1);
+}
+
+#define TRBE_FILL_STOP		0
+#define TRBE_FILL_WRAP		1
+#define TRBE_FILL_CIRCULAR	3
+
+static inline int get_trbe_fill_mode(void)
+{
+	u64 trblimitr = read_sysreg_s(SYS_TRBLIMITR_EL1);
+
+	return (trblimitr >> TRBLIMITR_FILL_MODE_SHIFT) & TRBLIMITR_FILL_MODE_MASK;
+}
+
+static inline void set_trbe_fill_mode(int mode)
+{
+	u64 trblimitr = read_sysreg_s(SYS_TRBLIMITR_EL1);
+
+	trblimitr &= ~(TRBLIMITR_FILL_MODE_MASK << TRBLIMITR_FILL_MODE_SHIFT);
+	trblimitr |= ((mode & TRBLIMITR_FILL_MODE_MASK) << TRBLIMITR_FILL_MODE_SHIFT);
+	write_sysreg_s(trblimitr, SYS_TRBLIMITR_EL1);
+}
+
+static inline void set_trbe_disabled(void)
+{
+	u64 trblimitr = read_sysreg_s(SYS_TRBLIMITR_EL1);
+
+	trblimitr &= ~TRBLIMITR_ENABLE;
+	write_sysreg_s(trblimitr, SYS_TRBLIMITR_EL1);
+}
+
+static inline void set_trbe_enabled(void)
+{
+	u64 trblimitr = read_sysreg_s(SYS_TRBLIMITR_EL1);
+
+	trblimitr |= TRBLIMITR_ENABLE;
+	write_sysreg_s(trblimitr, SYS_TRBLIMITR_EL1);
+}
+
+static inline bool get_trbe_flag_update(void)
+{
+	u64 trbidr = read_sysreg_s(SYS_TRBIDR_EL1);
+
+	return trbidr & TRBIDR_FLAG;
+}
+
+static inline bool is_trbe_programmable(void)
+{
+	u64 trbidr = read_sysreg_s(SYS_TRBIDR_EL1);
+
+	return !(trbidr & TRBIDR_PROG);
+}
+
+static inline int get_trbe_address_align(void)
+{
+	u64 trbidr = read_sysreg_s(SYS_TRBIDR_EL1);
+
+	return (trbidr >> TRBIDR_ALIGN_SHIFT) & TRBIDR_ALIGN_MASK;
+}
+
+static inline unsigned long get_trbe_write_pointer(void)
+{
+	u64 trbptr = read_sysreg_s(SYS_TRBPTR_EL1);
+	unsigned long addr = (trbptr >> TRBPTR_PTR_SHIFT) & TRBPTR_PTR_MASK;
+
+	return addr;
+}
+
+static inline void set_trbe_write_pointer(unsigned long addr)
+{
+	WARN_ON(is_trbe_enabled());
+	addr = (addr >> TRBPTR_PTR_SHIFT) & TRBPTR_PTR_MASK;
+	write_sysreg_s(addr, SYS_TRBPTR_EL1);
+}
+
+static inline unsigned long get_trbe_limit_pointer(void)
+{
+	u64 trblimitr = read_sysreg_s(SYS_TRBLIMITR_EL1);
+	unsigned long limit = (trblimitr >> TRBLIMITR_LIMIT_SHIFT) & TRBLIMITR_LIMIT_MASK;
+	unsigned long addr = limit << TRBLIMITR_LIMIT_SHIFT;
+
+	WARN_ON(!IS_ALIGNED(addr, PAGE_SIZE));
+	return addr;
+}
+
+static inline void set_trbe_limit_pointer(unsigned long addr)
+{
+	u64 trblimitr = read_sysreg_s(SYS_TRBLIMITR_EL1);
+
+	WARN_ON(is_trbe_enabled());
+	WARN_ON(!IS_ALIGNED(addr, (1UL << TRBLIMITR_LIMIT_SHIFT)));
+	WARN_ON(!IS_ALIGNED(addr, PAGE_SIZE));
+	trblimitr &= ~(TRBLIMITR_LIMIT_MASK << TRBLIMITR_LIMIT_SHIFT);
+	trblimitr |= (addr & PAGE_MASK);
+	write_sysreg_s(trblimitr, SYS_TRBLIMITR_EL1);
+}
+
+static inline unsigned long get_trbe_base_pointer(void)
+{
+	u64 trbbaser = read_sysreg_s(SYS_TRBBASER_EL1);
+	unsigned long addr = (trbbaser >> TRBBASER_BASE_SHIFT) & TRBBASER_BASE_MASK;
+
+	addr = addr << TRBBASER_BASE_SHIFT;
+	WARN_ON(!IS_ALIGNED(addr, PAGE_SIZE));
+	return addr;
+}
+
+static inline void set_trbe_base_pointer(unsigned long addr)
+{
+	WARN_ON(is_trbe_enabled());
+	WARN_ON(!IS_ALIGNED(addr, (1UL << TRBLIMITR_LIMIT_SHIFT)));
+	WARN_ON(!IS_ALIGNED(addr, PAGE_SIZE));
+	write_sysreg_s(addr, SYS_TRBBASER_EL1);
+}
-- 
2.7.4

