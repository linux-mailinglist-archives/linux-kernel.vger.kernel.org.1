Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4C052693FB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 19:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbgINRrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 13:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgINMD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 08:03:56 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D78C061352
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 04:55:10 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id c196so12571759pfc.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 04:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IaSLSMOw5IWqW5et4rXV7onS1Eb2MpKZtJ8PkFCqqpQ=;
        b=jN2Nodok2f44UjLuI6RwmJ6F0perVG/SjqBnoUwC14KhAruCkNXi+YxMeOdX8u4NWH
         UsPwjBotAmgdqlLbFIyyTW9fsMOjd50OZl98z4E6QkIK6alfixogirPR2gSa9Yb5MRR5
         FFheGNClwqk7XkwySM2Ch7pJPJZ2XjnEf4sFiiJw+9iJD7XDgY28BDA3rgDgfvZkmAli
         Am7B4vRVE8veGc4eXGHnbFC3o2SnUF9jM9bozjpV/DKSfiDmza1FMqDn2LLZeuteUOYY
         Z+y7wCujYbA4agwP0/7c1SQRfiaPyJlBdrEoTOTY1COrqhxd89tnp4+dzux96fj0Ll8e
         XZpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IaSLSMOw5IWqW5et4rXV7onS1Eb2MpKZtJ8PkFCqqpQ=;
        b=ni7y2pw3mlgprpXqTvbZOt1IRLI2w1V50KDu4F9Y+NKLCvstJ1ktGI2+mVq8v5+AKm
         Y17/+zOTZUBraLHGJZanFvfl437dVTPXMRHJS/X7/LUy897C+HbQFiJf+CVIq2A2G3Pf
         DFPlds7kAVUtbcCPBruKXfGZGVbG3E+QdlEuHJP94MhU9HnLiwno4J5ur/d8YDY/535Y
         3swYmITBX91Gkp05DnQhRY5ntyyI+OdQqy+pjw94Eu/DsLN1MppgmnB1MWqHKIH/3czC
         N3tXW1fmGUBLo9dIxB6Oh7aUI/4XP9RzFQkcz0la0CPSgv6bkXyb8Vn/122WR1308g7Y
         Iy0w==
X-Gm-Message-State: AOAM5327JcJYq+qCONFu/1qCV5lVv5bcRHRrF5TqWxEedWOED3tKlUfp
        TOo+UDXYC9X+7hs0BbAAq+Orcg==
X-Google-Smtp-Source: ABdhPJwGkXwVhJDWvoVTteJpq/PxlhK3ELJ97elqqV4V+nd3pbnJxnqmo5HPRgvGZLjIOmRBPYQ/Uw==
X-Received: by 2002:a63:4e52:: with SMTP id o18mr10419275pgl.171.1600084509540;
        Mon, 14 Sep 2020 04:55:09 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id n2sm9583614pja.41.2020.09.14.04.55.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Sep 2020 04:55:09 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kemeng Shi <shikemeng@huawei.com>,
        Ian Rogers <irogers@google.com>,
        Remi Bernon <rbernon@codeweavers.com>,
        Nick Gasson <nick.gasson@arm.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Steve MacLean <Steve.MacLean@Microsoft.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Zou Wei <zou_wei@huawei.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v4 2/6] perf tsc: Add rdtsc() for Arm64
Date:   Mon, 14 Sep 2020 19:53:07 +0800
Message-Id: <20200914115311.2201-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200914115311.2201-1-leo.yan@linaro.org>
References: <20200914115311.2201-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The system register CNTVCT_EL0 can be used to retrieve the counter from
user space.  Add rdtsc() for Arm64.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/arch/arm64/util/Build |  1 +
 tools/perf/arch/arm64/util/tsc.c | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+)
 create mode 100644 tools/perf/arch/arm64/util/tsc.c

diff --git a/tools/perf/arch/arm64/util/Build b/tools/perf/arch/arm64/util/Build
index 5c13438c7bd4..b53294d74b01 100644
--- a/tools/perf/arch/arm64/util/Build
+++ b/tools/perf/arch/arm64/util/Build
@@ -1,6 +1,7 @@
 perf-y += header.o
 perf-y += machine.o
 perf-y += perf_regs.o
+perf-y += tsc.o
 perf-$(CONFIG_DWARF)     += dwarf-regs.o
 perf-$(CONFIG_LOCAL_LIBUNWIND) += unwind-libunwind.o
 perf-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
diff --git a/tools/perf/arch/arm64/util/tsc.c b/tools/perf/arch/arm64/util/tsc.c
new file mode 100644
index 000000000000..cc85bd9e73f1
--- /dev/null
+++ b/tools/perf/arch/arm64/util/tsc.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/types.h>
+
+#include "../../../util/tsc.h"
+
+u64 rdtsc(void)
+{
+	u64 val;
+
+	/*
+	 * According to ARM DDI 0487F.c, from Armv8.0 to Armv8.5 inclusive, the
+	 * system counter is at least 56 bits wide; from Armv8.6, the counter
+	 * must be 64 bits wide.  So the system counter could be less than 64
+	 * bits wide and it is attributed with the flag 'cap_user_time_short'
+	 * is true.
+	 */
+	asm volatile("mrs %0, cntvct_el0" : "=r" (val));
+
+	return val;
+}
-- 
2.17.1

