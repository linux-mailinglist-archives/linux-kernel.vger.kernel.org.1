Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20A8921133A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jul 2020 21:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbgGATHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jul 2020 15:07:25 -0400
Received: from foss.arm.com ([217.140.110.172]:39784 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725875AbgGATHW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 15:07:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B7A2D6E;
        Wed,  1 Jul 2020 12:07:21 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7C8BA3F68F;
        Wed,  1 Jul 2020 12:07:20 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com
Subject: [PATCH v3 1/7] sched/topology: Split out SD_* flags declaration to its own file
Date:   Wed,  1 Jul 2020 20:06:49 +0100
Message-Id: <20200701190656.10126-2-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200701190656.10126-1-valentin.schneider@arm.com>
References: <20200701190656.10126-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To associate the SD flags with some metadata, we need some more structure
in the way they are declared.

Rather than shove that in a free-standing macro list, move the declaration
in a separate file that can be re-imported with different SD_FLAG
definitions, inspired by what we do with syscalls and unistd.h.

No change in functionality.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 include/linux/sched/sd_flags.h | 33 +++++++++++++++++++++++++++++++++
 include/linux/sched/topology.h | 18 ++++--------------
 2 files changed, 37 insertions(+), 14 deletions(-)
 create mode 100644 include/linux/sched/sd_flags.h

diff --git a/include/linux/sched/sd_flags.h b/include/linux/sched/sd_flags.h
new file mode 100644
index 000000000000..685bbe736945
--- /dev/null
+++ b/include/linux/sched/sd_flags.h
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * sched-domains (multiprocessor balancing) flag declarations.
+ */
+
+/* Balance when about to become idle */
+SD_FLAG(SD_BALANCE_NEWIDLE,     0)
+/* Balance on exec */
+SD_FLAG(SD_BALANCE_EXEC,        1)
+/* Balance on fork, clone */
+SD_FLAG(SD_BALANCE_FORK,        2)
+/* Balance on wakeup */
+SD_FLAG(SD_BALANCE_WAKE,        3)
+/* Wake task to waking CPU */
+SD_FLAG(SD_WAKE_AFFINE,         4)
+/* Domain members have different CPU capacities */
+SD_FLAG(SD_ASYM_CPUCAPACITY,    5)
+/* Domain members share CPU capacity */
+SD_FLAG(SD_SHARE_CPUCAPACITY,   6)
+/* Domain members share power domain */
+SD_FLAG(SD_SHARE_POWERDOMAIN,   7)
+/* Domain members share CPU pkg resources */
+SD_FLAG(SD_SHARE_PKG_RESOURCES, 8)
+/* Only a single load balancing instance */
+SD_FLAG(SD_SERIALIZE,           9)
+/* Place busy groups earlier in the domain */
+SD_FLAG(SD_ASYM_PACKING,        10)
+/* Prefer to place tasks in a sibling domain */
+SD_FLAG(SD_PREFER_SIBLING,      11)
+/* sched_domains of this level overlap */
+SD_FLAG(SD_OVERLAP,             12)
+/* cross-node balancing */
+SD_FLAG(SD_NUMA,                13)
diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index fb11091129b3..f274eca282de 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -11,20 +11,10 @@
  */
 #ifdef CONFIG_SMP
 
-#define SD_BALANCE_NEWIDLE	0x0001	/* Balance when about to become idle */
-#define SD_BALANCE_EXEC		0x0002	/* Balance on exec */
-#define SD_BALANCE_FORK		0x0004	/* Balance on fork, clone */
-#define SD_BALANCE_WAKE		0x0008  /* Balance on wakeup */
-#define SD_WAKE_AFFINE		0x0010	/* Wake task to waking CPU */
-#define SD_ASYM_CPUCAPACITY	0x0020  /* Domain members have different CPU capacities */
-#define SD_SHARE_CPUCAPACITY	0x0040	/* Domain members share CPU capacity */
-#define SD_SHARE_POWERDOMAIN	0x0080	/* Domain members share power domain */
-#define SD_SHARE_PKG_RESOURCES	0x0100	/* Domain members share CPU pkg resources */
-#define SD_SERIALIZE		0x0200	/* Only a single load balancing instance */
-#define SD_ASYM_PACKING		0x0400  /* Place busy groups earlier in the domain */
-#define SD_PREFER_SIBLING	0x0800	/* Prefer to place tasks in a sibling domain */
-#define SD_OVERLAP		0x1000	/* sched_domains of this level overlap */
-#define SD_NUMA			0x2000	/* cross-node balancing */
+/* Generate SD_FOO = VALUE */
+#define SD_FLAG(name, idx) static const unsigned int name = BIT(idx);
+#include <linux/sched/sd_flags.h>
+#undef SD_FLAG
 
 #ifdef CONFIG_SCHED_SMT
 static inline int cpu_smt_flags(void)
-- 
2.27.0

