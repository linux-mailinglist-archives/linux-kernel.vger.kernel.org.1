Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B14BA26881B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 11:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbgINJRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 05:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726123AbgINJRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 05:17:21 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5611DC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 02:17:21 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id v196so12235443pfc.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 02:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=utf50Tjw+FCxxoCkV3mSWLhpE/pmE7sABWHJHEffG9E=;
        b=rBPjWRE4T5WVAF5H1I8FREaCJKQ1XUHsFzAm3F4NhBpNMshmPbnpctW4gyN/HWtX7c
         GBZBPIl4MT8JLlZoYFCl3F/NjGoWpq2gpC3S1CX6ss1zocxpZ1+Qp54I6Cyqp2WFeQIy
         GumBvNzR3uTcVsILG3JrK3wkWayq/AiGPiqHNnu2svmV7bcOhkWdaYqO8HitFNqCD09q
         B4BhTCNflzY3/2/Wxb6iuHvxwB2Tn3FkvKBh8RRdjxXwPu6ZMQgnfCxzvlvU8/wIV0K3
         dmXkzfOe172KzIlf24SQtIertRGJQLqW7v0/rCZjwUgP2+pikkpDETf4qjFztQXc7ZML
         3U4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=utf50Tjw+FCxxoCkV3mSWLhpE/pmE7sABWHJHEffG9E=;
        b=h6mSadi66Nrgb4P0VNzibf2FIeVs/jhU/c0O7NCjjTSYrfix7SO7zg8Q1hvi3co6VK
         dYkrRwdYsUlQ63BB7WY4sXqMxMonVIQoeb741035+2YUlP85zqjsMcTu4XQybRwd4P7F
         BBmxXozqUFi1R/D85bZMLxw/AAkzXsRSk0UqR9PrIlUCiUkrvzIRpW6vpjOlc1r6cvnF
         ZFm17fgRulPlOE8JfroiF80T4B0D8HOD6iAAzidF+3piTMLSeu/GyY2LyUYezGNIpkqM
         HHz3ssTkjXaLfp42yaxTIIeIbywdfMRFj9q45AJyNqV1PijMcmSHBaOsoXNT7K6veLFg
         aqVQ==
X-Gm-Message-State: AOAM532yHVCJk1tCaVmOShPhN/nFTnrBPbmkK5Wd9+gAn2xVbTODnl0V
        tpg/RDrszN11h/4fdfSYNxw=
X-Google-Smtp-Source: ABdhPJwibBaZ+T6FmkrldSjrpF/Vh+ImFboJDvXjdAduwV5JXUt1Cu1JFKX6iWekmrZIxEF4Gs6/FQ==
X-Received: by 2002:a63:5656:: with SMTP id g22mr9831920pgm.44.1600075040800;
        Mon, 14 Sep 2020 02:17:20 -0700 (PDT)
Received: from localhost.localdomain ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id p11sm8677096pjz.44.2020.09.14.02.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 02:17:19 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     John Garry <john.garry@huawei.com>, Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Suleiman Souhlal <suleiman@google.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: [PATCH] perf kvm: add kvm-stat for arm64
Date:   Mon, 14 Sep 2020 18:17:13 +0900
Message-Id: <20200914091713.1485250-1-sergey.senozhatsky@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial support for perf kvm stat on arm64 platform.

Example:
 # perf kvm stat report
 Analyze events for all VMs, all VCPUs:

   VM-EXIT    Samples  Samples%     Time%    Min Time    Max Time         Avg time

       IRQ      44110    79.55%     0.51%      0.93us   8364.85us     10.16us ( +-   8.66% )
      TRAP      11337    20.45%    99.49%      1.31us 3999985.95us   7761.21us ( +-  13.23% )

 Total Samples:55447, Total events handled time:88437041.52us.

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
---
 tools/perf/arch/arm64/Makefile                |  1 +
 tools/perf/arch/arm64/util/Build              |  1 +
 .../arch/arm64/util/arm64_exception_types.h   | 22 +++++++++
 tools/perf/arch/arm64/util/kvm-stat.c         | 46 +++++++++++++++++++
 4 files changed, 70 insertions(+)
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
index 000000000000..224774ac34c2
--- /dev/null
+++ b/tools/perf/arch/arm64/util/arm64_exception_types.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 */
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
+	{ARM_EXCEPTION_HYP_GONE,	"HYP_GONE"	}
+
+#endif /* ARCH_PERF_ARM64_EXCEPTION_TYPES_H */
diff --git a/tools/perf/arch/arm64/util/kvm-stat.c b/tools/perf/arch/arm64/util/kvm-stat.c
new file mode 100644
index 000000000000..3c642057a0fe
--- /dev/null
+++ b/tools/perf/arch/arm64/util/kvm-stat.c
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <errno.h>
+#include "../../util/evsel.h"
+#include "../../util/kvm-stat.h"
+#include "arm64_exception_types.h"
+#include "debug.h"
+
+define_exit_reasons_table(arm64_exit_reasons, kvm_arm_exception_type);
+
+static struct kvm_events_ops exit_events = {
+	.is_begin_event = exit_event_begin,
+	.is_end_event	= exit_event_end,
+	.decode_key	= exit_event_decode_key,
+	.name		= "VM-EXIT"
+};
+
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
+	kvm->exit_reasons = arm64_exit_reasons;
+	kvm->exit_reasons_isa = "arm64";
+	return 0;
+}
-- 
2.28.0

