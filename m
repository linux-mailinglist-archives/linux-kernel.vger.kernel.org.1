Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B79826D84A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 12:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726577AbgIQKCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 06:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbgIQKCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 06:02:41 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D3AC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 03:02:41 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id q4so1009775pjh.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 03:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=erWMBBM3JxsBr+17EsODUFrf0I3TpEuCsQmwqMmYipM=;
        b=trfvpQtSlsDSfxJIXI/HZs8lEONknmRWIph1ciixqB1zAI3lP8ySoA0wal+uTkmIap
         NS7CAiLND67tifzfyzYplWShUBv4VFh3e6oofj9c06Swfnk7ojno1V2w10QsUh1S1jvq
         /yhIe3HLu3oYVfqv6vCfPJNffsVNi5On90a0JyZgXioEZFeUdNRU+TnoMJJjszqfh38w
         AK1UF7DJYUn6PcEqFCWuRgWmx+6SWcH2LOX7ZYjb52PFxU76VV3dUoHWGP9dPa/w9LMB
         KiqAnbQma1ZVgTv6p9jHaMOnIyv8IEiWQUlSnJWq8btt6A3YPwUoCliBK5eUiPMIsoR4
         s9jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=erWMBBM3JxsBr+17EsODUFrf0I3TpEuCsQmwqMmYipM=;
        b=GzSOFofeHUtMn8hcXgCinD5MdGgjPIsjt/4iqHVmldiNW8Y5oe+36FIFGOkHWyxRR/
         /ssZutMyB0Zn820pRE3Gd5xuwG+vRxPSEzToBmruIDVGdRa3OnZ5jSnUnaI4sulLAsO3
         PXVNY3cf/NNgmaufZTnC3T/uj4nuWQsqsfmXoUxCRzqI8LAcf5ZlD6pehxLV/TR4T83G
         A1Z3WlS/hGgTKU64u2KyoUIB+6djLJE14SU5aIOhPAVfx9PmzoM/VDWHztEvhMxaoJlx
         fh8EFJVMEEWkfJB5RVU6esXf4g1mRA2x9sC5hJWrpCGt1nk1PRu9YzNgEbQUB/C0kSus
         DQRA==
X-Gm-Message-State: AOAM531oRvHRdjPUclJkil2axYDAz7GfZDqmRz6OcfcvRM8gYgGRidCS
        LaukhnhR5mWRsATa2iBpiww=
X-Google-Smtp-Source: ABdhPJzZ2ypnFJsUoz5qgAiDCYEje3d1tCE2UORBaDb153E2NCboLpUni4/46NmSifuGyZqA2jp/kg==
X-Received: by 2002:a17:902:bd8d:b029:d1:cbfc:6137 with SMTP id q13-20020a170902bd8db02900d1cbfc6137mr16469104pls.23.1600336960461;
        Thu, 17 Sep 2020 03:02:40 -0700 (PDT)
Received: from localhost.localdomain ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id l141sm20027518pfd.47.2020.09.17.03.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 03:02:38 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>
Cc:     John Garry <john.garry@huawei.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Suleiman Souhlal <suleiman@google.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: [PATCHv4] perf kvm: add kvm-stat for arm64
Date:   Thu, 17 Sep 2020 19:02:25 +0900
Message-Id: <20200917100225.208794-1-sergey.senozhatsky@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for perf kvm stat on arm64 platform.

Example:
 # perf kvm stat report

Analyze events for all VMs, all VCPUs:

    VM-EXIT    Samples  Samples%     Time%    Min Time    Max Time         Avg time

   DABT_LOW     661867    98.91%    40.45%      2.19us   3364.65us      6.24us ( +-   0.34% )
        IRQ       4598     0.69%    57.44%      2.89us   3397.59us   1276.27us ( +-   1.61% )
        WFx       1475     0.22%     1.71%      2.22us   3388.63us    118.31us ( +-   8.69% )
   IABT_LOW       1018     0.15%     0.38%      2.22us   2742.07us     38.29us ( +-  12.55% )
      SYS64        180     0.03%     0.01%      2.07us    112.91us      6.57us ( +-  14.95% )
      HVC64         17     0.00%     0.01%      2.19us    322.35us     42.95us ( +-  58.98% )

Total Samples:669155, Total events handled time:10216387.86us.

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Reviewed-by: Leo Yan <leo.yan@linaro.org>
Tested-by: Leo Yan <leo.yan@linaro.org>

---

v4: rebased (Leo)
v3: report ARM_EXCEPTION_IL exceptions (Leo)
v2: reworked the patch after offline discussion with Suleiman

 tools/perf/arch/arm64/Makefile                |  1 +
 tools/perf/arch/arm64/util/Build              |  1 +
 .../arch/arm64/util/arm64_exception_types.h   | 92 +++++++++++++++++++
 tools/perf/arch/arm64/util/kvm-stat.c         | 85 +++++++++++++++++
 4 files changed, 179 insertions(+)
 create mode 100644 tools/perf/arch/arm64/util/arm64_exception_types.h
 create mode 100644 tools/perf/arch/arm64/util/kvm-stat.c

diff --git a/tools/perf/arch/arm64/Makefile b/tools/perf/arch/arm64/Makefile
index dbef716a1913..fab3095fb5d0 100644
--- a/tools/perf/arch/arm64/Makefile
+++ b/tools/perf/arch/arm64/Makefile
@@ -4,6 +4,7 @@ PERF_HAVE_DWARF_REGS := 1
 endif
 PERF_HAVE_JITDUMP := 1
 PERF_HAVE_ARCH_REGS_QUERY_REGISTER_OFFSET := 1
+HAVE_KVM_STAT_SUPPORT := 1
 
 #
 # Syscall table generation for perf
diff --git a/tools/perf/arch/arm64/util/Build b/tools/perf/arch/arm64/util/Build
index 5c13438c7bd4..4cba12f4b741 100644
--- a/tools/perf/arch/arm64/util/Build
+++ b/tools/perf/arch/arm64/util/Build
@@ -1,6 +1,7 @@
 perf-y += header.o
 perf-y += machine.o
 perf-y += perf_regs.o
+perf-y += kvm-stat.o
 perf-$(CONFIG_DWARF)     += dwarf-regs.o
 perf-$(CONFIG_LOCAL_LIBUNWIND) += unwind-libunwind.o
 perf-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
diff --git a/tools/perf/arch/arm64/util/arm64_exception_types.h b/tools/perf/arch/arm64/util/arm64_exception_types.h
new file mode 100644
index 000000000000..27c981ebe401
--- /dev/null
+++ b/tools/perf/arch/arm64/util/arm64_exception_types.h
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: GPL-2.0
+#ifndef ARCH_PERF_ARM64_EXCEPTION_TYPES_H
+#define ARCH_PERF_ARM64_EXCEPTION_TYPES_H
+
+/* Per asm/virt.h */
+#define HVC_STUB_ERR		  0xbadca11
+
+/* Per asm/kvm_asm.h */
+#define ARM_EXCEPTION_IRQ		0
+#define ARM_EXCEPTION_EL1_SERROR	1
+#define ARM_EXCEPTION_TRAP		2
+#define ARM_EXCEPTION_IL		3
+/* The hyp-stub will return this for any kvm_call_hyp() call */
+#define ARM_EXCEPTION_HYP_GONE		HVC_STUB_ERR
+
+#define kvm_arm_exception_type					\
+	{ARM_EXCEPTION_IRQ,		"IRQ"		},	\
+	{ARM_EXCEPTION_EL1_SERROR,	"SERROR"	},	\
+	{ARM_EXCEPTION_TRAP,		"TRAP"		},	\
+	{ARM_EXCEPTION_IL,		"ILLEGAL"	},	\
+	{ARM_EXCEPTION_HYP_GONE,	"HYP_GONE"	}
+
+/* Per asm/esr.h */
+#define ESR_ELx_EC_UNKNOWN	(0x00)
+#define ESR_ELx_EC_WFx		(0x01)
+/* Unallocated EC: 0x02 */
+#define ESR_ELx_EC_CP15_32	(0x03)
+#define ESR_ELx_EC_CP15_64	(0x04)
+#define ESR_ELx_EC_CP14_MR	(0x05)
+#define ESR_ELx_EC_CP14_LS	(0x06)
+#define ESR_ELx_EC_FP_ASIMD	(0x07)
+#define ESR_ELx_EC_CP10_ID	(0x08)	/* EL2 only */
+#define ESR_ELx_EC_PAC		(0x09)	/* EL2 and above */
+/* Unallocated EC: 0x0A - 0x0B */
+#define ESR_ELx_EC_CP14_64	(0x0C)
+/* Unallocated EC: 0x0d */
+#define ESR_ELx_EC_ILL		(0x0E)
+/* Unallocated EC: 0x0F - 0x10 */
+#define ESR_ELx_EC_SVC32	(0x11)
+#define ESR_ELx_EC_HVC32	(0x12)	/* EL2 only */
+#define ESR_ELx_EC_SMC32	(0x13)	/* EL2 and above */
+/* Unallocated EC: 0x14 */
+#define ESR_ELx_EC_SVC64	(0x15)
+#define ESR_ELx_EC_HVC64	(0x16)	/* EL2 and above */
+#define ESR_ELx_EC_SMC64	(0x17)	/* EL2 and above */
+#define ESR_ELx_EC_SYS64	(0x18)
+#define ESR_ELx_EC_SVE		(0x19)
+#define ESR_ELx_EC_ERET		(0x1a)	/* EL2 only */
+/* Unallocated EC: 0x1b - 0x1E */
+#define ESR_ELx_EC_IMP_DEF	(0x1f)	/* EL3 only */
+#define ESR_ELx_EC_IABT_LOW	(0x20)
+#define ESR_ELx_EC_IABT_CUR	(0x21)
+#define ESR_ELx_EC_PC_ALIGN	(0x22)
+/* Unallocated EC: 0x23 */
+#define ESR_ELx_EC_DABT_LOW	(0x24)
+#define ESR_ELx_EC_DABT_CUR	(0x25)
+#define ESR_ELx_EC_SP_ALIGN	(0x26)
+/* Unallocated EC: 0x27 */
+#define ESR_ELx_EC_FP_EXC32	(0x28)
+/* Unallocated EC: 0x29 - 0x2B */
+#define ESR_ELx_EC_FP_EXC64	(0x2C)
+/* Unallocated EC: 0x2D - 0x2E */
+#define ESR_ELx_EC_SERROR	(0x2F)
+#define ESR_ELx_EC_BREAKPT_LOW	(0x30)
+#define ESR_ELx_EC_BREAKPT_CUR	(0x31)
+#define ESR_ELx_EC_SOFTSTP_LOW	(0x32)
+#define ESR_ELx_EC_SOFTSTP_CUR	(0x33)
+#define ESR_ELx_EC_WATCHPT_LOW	(0x34)
+#define ESR_ELx_EC_WATCHPT_CUR	(0x35)
+/* Unallocated EC: 0x36 - 0x37 */
+#define ESR_ELx_EC_BKPT32	(0x38)
+/* Unallocated EC: 0x39 */
+#define ESR_ELx_EC_VECTOR32	(0x3A)	/* EL2 only */
+/* Unallocated EC: 0x3B */
+#define ESR_ELx_EC_BRK64	(0x3C)
+/* Unallocated EC: 0x3D - 0x3F */
+#define ESR_ELx_EC_MAX		(0x3F)
+
+#define ECN(x) { ESR_ELx_EC_##x, #x }
+
+#define kvm_arm_exception_class \
+	ECN(UNKNOWN), ECN(WFx), ECN(CP15_32), ECN(CP15_64), ECN(CP14_MR), \
+	ECN(CP14_LS), ECN(FP_ASIMD), ECN(CP10_ID), ECN(PAC), ECN(CP14_64), \
+	ECN(SVC64), ECN(HVC64), ECN(SMC64), ECN(SYS64), ECN(SVE), \
+	ECN(IMP_DEF), ECN(IABT_LOW), ECN(IABT_CUR), \
+	ECN(PC_ALIGN), ECN(DABT_LOW), ECN(DABT_CUR), \
+	ECN(SP_ALIGN), ECN(FP_EXC32), ECN(FP_EXC64), ECN(SERROR), \
+	ECN(BREAKPT_LOW), ECN(BREAKPT_CUR), ECN(SOFTSTP_LOW), \
+	ECN(SOFTSTP_CUR), ECN(WATCHPT_LOW), ECN(WATCHPT_CUR), \
+	ECN(BKPT32), ECN(VECTOR32), ECN(BRK64)
+
+#endif /* ARCH_PERF_ARM64_EXCEPTION_TYPES_H */
diff --git a/tools/perf/arch/arm64/util/kvm-stat.c b/tools/perf/arch/arm64/util/kvm-stat.c
new file mode 100644
index 000000000000..50376b9062c1
--- /dev/null
+++ b/tools/perf/arch/arm64/util/kvm-stat.c
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <errno.h>
+#include <memory.h>
+#include "../../util/evsel.h"
+#include "../../util/kvm-stat.h"
+#include "arm64_exception_types.h"
+#include "debug.h"
+
+define_exit_reasons_table(arm64_exit_reasons, kvm_arm_exception_type);
+define_exit_reasons_table(arm64_trap_exit_reasons, kvm_arm_exception_class);
+
+const char *kvm_trap_exit_reason = "esr_ec";
+const char *vcpu_id_str = "id";
+const int decode_str_len = 20;
+const char *kvm_exit_reason = "ret";
+const char *kvm_entry_trace = "kvm:kvm_entry";
+const char *kvm_exit_trace = "kvm:kvm_exit";
+
+const char *kvm_events_tp[] = {
+	"kvm:kvm_entry",
+	"kvm:kvm_exit",
+	NULL,
+};
+
+static void event_get_key(struct evsel *evsel,
+			  struct perf_sample *sample,
+			  struct event_key *key)
+{
+	key->info = 0;
+	key->key = evsel__intval(evsel, sample, kvm_exit_reason);
+	key->exit_reasons = arm64_exit_reasons;
+
+	/*
+	 * TRAP exceptions carry exception class info in esr_ec field
+	 * and, hence, we need to use a different exit_reasons table to
+	 * properly decode event's est_ec.
+	 */
+	if (key->key == ARM_EXCEPTION_TRAP) {
+		key->key = evsel__intval(evsel, sample, kvm_trap_exit_reason);
+		key->exit_reasons = arm64_trap_exit_reasons;
+	}
+}
+
+static bool event_begin(struct evsel *evsel,
+			struct perf_sample *sample __maybe_unused,
+			struct event_key *key __maybe_unused)
+{
+	return !strcmp(evsel->name, kvm_entry_trace);
+}
+
+static bool event_end(struct evsel *evsel,
+		      struct perf_sample *sample,
+		      struct event_key *key)
+{
+	if (!strcmp(evsel->name, kvm_exit_trace)) {
+		event_get_key(evsel, sample, key);
+		return true;
+	}
+	return false;
+}
+
+static struct kvm_events_ops exit_events = {
+	.is_begin_event = event_begin,
+	.is_end_event	= event_end,
+	.decode_key	= exit_event_decode_key,
+	.name		= "VM-EXIT"
+};
+
+struct kvm_reg_events_ops kvm_reg_events_ops[] = {
+	{
+		.name	= "vmexit",
+		.ops	= &exit_events,
+	},
+	{ NULL },
+};
+
+const char * const kvm_skip_events[] = {
+	NULL,
+};
+
+int cpu_isa_init(struct perf_kvm_stat *kvm, const char *cpuid __maybe_unused)
+{
+	kvm->exit_reasons_isa = "arm64";
+	return 0;
+}
-- 
2.28.0

