Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F25962F57D0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 04:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730205AbhANCHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 21:07:40 -0500
Received: from mail-ot1-f46.google.com ([209.85.210.46]:43958 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730143AbhANCG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 21:06:59 -0500
Received: by mail-ot1-f46.google.com with SMTP id q25so3867776otn.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 18:06:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s1wy/6w1d7kEybhQtPfH/2ykzP9iJ2VgjNl1TdZoTCs=;
        b=YDmoMibMHzgdukdczlObcFbwa9BkJrmbV8S0hrBolsZJoFLtIyzjhJuXtYIjncMTip
         B5P2FZ+E9whcCTnxFbMfcGFwgQ6JArpRNhtAAE1qRefq5mD/eCf7NM7w3UYmlP1UO1+T
         2+d3Hz4RDaeQnLDmBdinvO6PYXqAZJALUAv1hoWbM6lrfcDNlXhxU9+B2g/l6bjbEXHU
         RqHgh7OH4qPG5MhHlgG0On94WS+4BhmanWRAtUGM/YI4lJFPlRF6c7O6JZpsCK8yHi8P
         xOHZ9W00husJ0KRV0+iyFyHFLd8DRW0+MWXlhXm/wJSUjEPQOQTttvpsJzucTApLo5Pr
         dtgw==
X-Gm-Message-State: AOAM533BQuMuqi/oHK5Dg6obHOLUokX1sNGcCFxc8hYMhpX3c6X3s6aS
        LrNfzhsIQ0G4mGUXafhEXA==
X-Google-Smtp-Source: ABdhPJzSAmZIOKdE3izd1ZZ+StgXNq9Zyaddh1pAm9iHsrBD0L+ivKCL0UqEsVyaN1zwWvW/yGyR+g==
X-Received: by 2002:a9d:2c43:: with SMTP id f61mr3030897otb.329.1610589978497;
        Wed, 13 Jan 2021 18:06:18 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id x20sm814272oov.33.2021.01.13.18.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 18:06:17 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Raphael Gault <raphael.gault@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ian Rogers <irogers@google.com>, honnappa.nagarahalli@arm.com,
        Itaru Kitayama <itaru.kitayama@gmail.com>
Subject: [PATCH v5 7/9] libperf: Add arm64 support to perf_mmap__read_self()
Date:   Wed, 13 Jan 2021 20:06:03 -0600
Message-Id: <20210114020605.3943992-8-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210114020605.3943992-1-robh@kernel.org>
References: <20210114020605.3943992-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the arm64 variants for read_perf_counter() and read_timestamp().
Unfortunately the counter number is encoded into the instruction, so the
code is a bit verbose to enumerate all possible counters.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 tools/lib/perf/mmap.c | 98 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/tools/lib/perf/mmap.c b/tools/lib/perf/mmap.c
index 915469f00cf4..216e6c6212a2 100644
--- a/tools/lib/perf/mmap.c
+++ b/tools/lib/perf/mmap.c
@@ -13,6 +13,7 @@
 #include <internal/lib.h>
 #include <linux/kernel.h>
 #include <linux/math64.h>
+#include <linux/stringify.h>
 #include "internal.h"
 
 void perf_mmap__init(struct perf_mmap *map, struct perf_mmap *prev,
@@ -294,6 +295,103 @@ static u64 read_timestamp(void)
 
 	return low | ((u64)high) << 32;
 }
+#elif defined(__aarch64__)
+#define read_sysreg(r) ({						\
+	u64 __val;							\
+	asm volatile("mrs %0, " __stringify(r) : "=r" (__val));		\
+	__val;								\
+})
+
+static u64 read_pmccntr(void)
+{
+	return read_sysreg(pmccntr_el0);
+}
+
+#define PMEVCNTR_READ(idx)					\
+	static u64 read_pmevcntr_##idx(void) {			\
+		return read_sysreg(pmevcntr##idx##_el0);	\
+	}
+
+PMEVCNTR_READ(0);
+PMEVCNTR_READ(1);
+PMEVCNTR_READ(2);
+PMEVCNTR_READ(3);
+PMEVCNTR_READ(4);
+PMEVCNTR_READ(5);
+PMEVCNTR_READ(6);
+PMEVCNTR_READ(7);
+PMEVCNTR_READ(8);
+PMEVCNTR_READ(9);
+PMEVCNTR_READ(10);
+PMEVCNTR_READ(11);
+PMEVCNTR_READ(12);
+PMEVCNTR_READ(13);
+PMEVCNTR_READ(14);
+PMEVCNTR_READ(15);
+PMEVCNTR_READ(16);
+PMEVCNTR_READ(17);
+PMEVCNTR_READ(18);
+PMEVCNTR_READ(19);
+PMEVCNTR_READ(20);
+PMEVCNTR_READ(21);
+PMEVCNTR_READ(22);
+PMEVCNTR_READ(23);
+PMEVCNTR_READ(24);
+PMEVCNTR_READ(25);
+PMEVCNTR_READ(26);
+PMEVCNTR_READ(27);
+PMEVCNTR_READ(28);
+PMEVCNTR_READ(29);
+PMEVCNTR_READ(30);
+
+/*
+ * Read a value direct from PMEVCNTR<idx>
+ */
+static u64 read_perf_counter(unsigned int counter)
+{
+	static u64 (* const read_f[])(void) = {
+		read_pmevcntr_0,
+		read_pmevcntr_1,
+		read_pmevcntr_2,
+		read_pmevcntr_3,
+		read_pmevcntr_4,
+		read_pmevcntr_5,
+		read_pmevcntr_6,
+		read_pmevcntr_7,
+		read_pmevcntr_8,
+		read_pmevcntr_9,
+		read_pmevcntr_10,
+		read_pmevcntr_11,
+		read_pmevcntr_13,
+		read_pmevcntr_12,
+		read_pmevcntr_14,
+		read_pmevcntr_15,
+		read_pmevcntr_16,
+		read_pmevcntr_17,
+		read_pmevcntr_18,
+		read_pmevcntr_19,
+		read_pmevcntr_20,
+		read_pmevcntr_21,
+		read_pmevcntr_22,
+		read_pmevcntr_23,
+		read_pmevcntr_24,
+		read_pmevcntr_25,
+		read_pmevcntr_26,
+		read_pmevcntr_27,
+		read_pmevcntr_28,
+		read_pmevcntr_29,
+		read_pmevcntr_30,
+		read_pmccntr
+	};
+
+	if (counter < ARRAY_SIZE(read_f))
+		return (read_f[counter])();
+
+	return 0;
+}
+
+static u64 read_timestamp(void) { return read_sysreg(cntvct_el0); }
+
 #else
 static u64 read_perf_counter(unsigned int counter) { return 0; }
 static u64 read_timestamp(void) { return 0; }
-- 
2.27.0

