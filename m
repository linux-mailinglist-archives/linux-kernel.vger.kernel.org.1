Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA3E2800BC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 16:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732363AbgJAOBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 10:01:50 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35774 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732662AbgJAOBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 10:01:31 -0400
Received: by mail-ot1-f65.google.com with SMTP id s66so5491788otb.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 07:01:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hEK3psBWYVpGsyGTRdmYNWgiavHp54wPxYJ3tZKCLfo=;
        b=hH8pipbPKusvY6K51DfhsbjCupbymh7Vq8arIRufB33bstz79ESwLXnwESU3WRUQEG
         oEYtlGQP/KJmRq7vMMkn/3O9yq3w3drg5LnnlohifjJ9EaqAH35zWOjwf8W5lA1sCYup
         ZAFBIsfS8ETFlHbiBuE9reCkTjesRZ+1+o1X3eYDf/mY1Y5sFMg1cL2W5kh+Nz03d2de
         Rh2dZuld4q3JP0rajZOqL2A6DF3/LOLe2pY6wtC0q+YVijMiy22CJTnWAlgoucaxJKA2
         VrNfLeMuebfXoyM6ylksbHrJYx/jymoEzh5JFOYCVbop3Nnp31SwFO4GG6257bU/Iakm
         jcfA==
X-Gm-Message-State: AOAM530XhW7favNehDRiy4haQh3VNJq+Sga+fXrkIGcNjI7fBoHoPyZ+
        VzuWvISCYypQNohEhMsguw==
X-Google-Smtp-Source: ABdhPJxCNJ+6zqclrVkrloguJK/u4M1XmNXnWlyfLHYtLGL3sCe9oqigqTROZZmmFwKqlZ4lkhWUeA==
X-Received: by 2002:a9d:be4:: with SMTP id 91mr5234629oth.248.1601560889947;
        Thu, 01 Oct 2020 07:01:29 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id q81sm1032138oia.46.2020.10.01.07.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 07:01:29 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Raphael Gault <raphael.gault@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ian Rogers <irogers@google.com>, honnappa.nagarahalli@arm.com,
        Itaru Kitayama <itaru.kitayama@gmail.com>
Subject: [PATCH v4 7/9] libperf: Add arm64 support to perf_mmap__read_self()
Date:   Thu,  1 Oct 2020 09:01:14 -0500
Message-Id: <20201001140116.651970-8-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201001140116.651970-1-robh@kernel.org>
References: <20201001140116.651970-1-robh@kernel.org>
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
index cb07969cfdbf..6cf939aae6b6 100644
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
2.25.1

