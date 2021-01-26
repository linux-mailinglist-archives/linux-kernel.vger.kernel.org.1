Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 609B6304646
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 19:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393121AbhAZRpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 12:45:24 -0500
Received: from mga05.intel.com ([192.55.52.43]:6423 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389659AbhAZIKJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 03:10:09 -0500
IronPort-SDR: eoDhxz2Mc321mRnTBAK2iZcL3DOnGrkHAxM+sWrB+c0bdZAvgHPP8XKdnjeedLiu64sX1wbYrD
 T1mTT4uSnabw==
X-IronPort-AV: E=McAfee;i="6000,8403,9875"; a="264688809"
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="264688809"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2021 00:06:33 -0800
IronPort-SDR: Ls4TMIdyeImP0viNg2nwhJz5Flw+DJnoYqN9idZ2iERjMCBTrTXbL+bfIsePSaYNngx032p6nj
 BCf5PMmSLbRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="572855841"
Received: from nntpdsd52-183.inn.intel.com ([10.125.52.183])
  by orsmga005.jf.intel.com with ESMTP; 26 Jan 2021 00:06:30 -0800
From:   Alexander Antonov <alexander.antonov@linux.intel.com>
To:     acme@kernel.org
Cc:     linux-kernel@vger.kernel.org, jolsa@redhat.com, ak@linux.intel.com,
        alexander.shishkin@linux.intel.com, mark.rutland@arm.com,
        namhyung@kernel.org, irogers@google.com, mingo@redhat.com,
        peterz@infradead.org, alexander.antonov@linux.intel.com
Subject: [PATCH v3 3/5] perf stat: Helper functions for PCIe root ports list in iostat mode
Date:   Tue, 26 Jan 2021 11:06:17 +0300
Message-Id: <20210126080619.30275-4-alexander.antonov@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20210126080619.30275-1-alexander.antonov@linux.intel.com>
References: <20210126080619.30275-1-alexander.antonov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce helper functions to control PCIe root ports list.
These helpers will be used in the follow-up patch.

Signed-off-by: Alexander Antonov <alexander.antonov@linux.intel.com>
---
 tools/perf/arch/x86/util/iostat.c | 127 ++++++++++++++++++++++++++++++
 1 file changed, 127 insertions(+)
 create mode 100644 tools/perf/arch/x86/util/iostat.c

diff --git a/tools/perf/arch/x86/util/iostat.c b/tools/perf/arch/x86/util/iostat.c
new file mode 100644
index 000000000000..3ef727f9da63
--- /dev/null
+++ b/tools/perf/arch/x86/util/iostat.c
@@ -0,0 +1,127 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * perf iostat
+ *
+ * Copyright (C) 2020, Intel Corporation
+ *
+ * Authors: Alexander Antonov <alexander.antonov@linux.intel.com>
+ */
+
+#include <api/fs/fs.h>
+#include <linux/kernel.h>
+#include <linux/err.h>
+#include <limits.h>
+#include <stdio.h>
+#include <string.h>
+#include <errno.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <dirent.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <regex.h>
+#include "util/cpumap.h"
+#include "util/debug.h"
+#include "util/iostat.h"
+#include "util/counts.h"
+#include "path.h"
+
+struct iio_root_port {
+	u32 domain;
+	u8 bus;
+	u8 die;
+	u8 pmu_idx;
+	int idx;
+};
+
+struct iio_root_ports_list {
+	struct iio_root_port **rps;
+	int nr_entries;
+};
+
+static void iio_root_port_show(FILE *output,
+			       const struct iio_root_port * const rp)
+{
+	if (output && rp)
+		fprintf(output, "S%d-uncore_iio_%d<%04x:%02x>\n",
+			rp->die, rp->pmu_idx, rp->domain, rp->bus);
+}
+
+static struct iio_root_port *iio_root_port_new(u32 domain, u8 bus,
+					       u8 die, u8 pmu_idx)
+{
+	struct iio_root_port *p = calloc(1, sizeof(*p));
+
+	if (p) {
+		p->domain = domain;
+		p->bus = bus;
+		p->die = die;
+		p->pmu_idx = pmu_idx;
+	}
+	return p;
+}
+
+static struct iio_root_ports_list *iio_root_ports_list_new(void)
+{
+	struct iio_root_ports_list *list = calloc(1, sizeof(*list));
+
+	if (list) {
+		list->rps = calloc(1, sizeof(struct iio_root_port *));
+		if (!list->rps) {
+			free(list);
+			list = NULL;
+		}
+	}
+
+	return list;
+}
+
+static void iio_root_ports_list_free(struct iio_root_ports_list *list)
+{
+	int idx;
+
+	if (list) {
+		for (idx = 0; idx < list->nr_entries; idx++)
+			free(list->rps[idx]);
+		free(list->rps);
+		free(list);
+	}
+}
+
+static struct iio_root_port *iio_root_port_find_by_notation(
+	const struct iio_root_ports_list * const list, u32 domain, u8 bus)
+{
+	int idx;
+	struct iio_root_port *rp;
+
+	if (list) {
+		for (idx = 0; idx < list->nr_entries; idx++) {
+			rp = list->rps[idx];
+			if (rp && rp->domain == domain && rp->bus == bus)
+				return rp;
+		}
+	}
+	return NULL;
+}
+
+static int iio_root_ports_list_insert(struct iio_root_ports_list *list,
+				      struct iio_root_port * const rp)
+{
+	struct iio_root_port **tmp_buf;
+
+	if (list && rp) {
+		rp->idx = list->nr_entries++;
+		/* One more for NULL.*/
+		tmp_buf = realloc(list->rps,
+				  (list->nr_entries + 1) * sizeof(*list->rps));
+		if (!tmp_buf) {
+			pr_err("Failed to realloc memory\n");
+			return -ENOMEM;
+		}
+		tmp_buf[rp->idx] = rp;
+		tmp_buf[list->nr_entries] = NULL;
+		list->rps = tmp_buf;
+	}
+	return 0;
+}
-- 
2.19.1

