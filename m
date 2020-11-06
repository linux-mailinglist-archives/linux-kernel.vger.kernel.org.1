Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 802C22A8C41
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 02:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733227AbgKFBnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 20:43:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732220AbgKFBnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 20:43:39 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62EEEC0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 17:43:38 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id w65so2867589pfd.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 17:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5LswkEbaOwvmULFJNErnEVIllZi8AcssGmyPFbn5YAc=;
        b=B8rJuJ8HrmA7AHY5Sq0g2ZeZ44+crSVHr/AqwA8APoNVAtqkpIzTGlEkDJcAP/6BWA
         GtixZQifYYPDyV7fkY9WTU1Sk2a8JVu9BxhvL3wWwEUfmE/1XLdsbtilaZw4zD9zq+1Z
         YAgd8s+NFP0ZaX2HRgW8lmA0M4w0h6sknmgoGM0CeIkwgVPm8SppRW5fq9zq8MeLHNqd
         v7F7KmMS6pkvgdjw0In4ug44+JcUboe5r+mt5G9/eSuTYh8yl5JraM8YEGDElO7wzWEM
         Ewg5OkCQsyQtA3a3YJFd+TjgmkYER7ZjOl+E52YnU1Yr/JklM9L6K/pBE62WK+7Cv+28
         BOXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5LswkEbaOwvmULFJNErnEVIllZi8AcssGmyPFbn5YAc=;
        b=qvD8cWV5+hrA7x0xvkZr2qtt7m9VWG85pLLKksv07pMqUUkPBNRWitK3PdomizkCZN
         zBBtpcPcTco++HNzQwnUaICkIdBh3+RH+goYgkwZbJmWJNp+eK2nqNHjDn0p07/Dy1dP
         B9NZGoRN9U3A9rSlAuEBFWU8CXKT7l5P3CScIwNXYwCgCypcP/GIomKz/za0Ew0kJI4u
         nStLnBrNYBtCGWTR+1sl60GB4ZdcfoGXvlssjp1nX7IcYqBU8VhLbWA7heRk7lDJVgFT
         oN/mAgqcEUgjUM6jBZi/AzoaGDYcHwhqaLhLKXI7mlgcF0hgZ13v58ANJihcwazMuYEa
         jAHw==
X-Gm-Message-State: AOAM5337Jv/GvMOAh8OzDmmwGR6nKv0cHSJIvtYBkPQ6dPeQ64cLvplt
        WGlwDeupaQZbJNLFk76UVtB2KQ==
X-Google-Smtp-Source: ABdhPJz2Cl/jDnUHFcqsNC02jU11Xc08FJC6ujrSbYZJIjVGkzDZ/7l6qhBM7n7KFuzURYImMCElqQ==
X-Received: by 2002:a62:1c47:0:b029:18b:9e22:593e with SMTP id c68-20020a621c470000b029018b9e22593emr2520765pfc.42.1604627017922;
        Thu, 05 Nov 2020 17:43:37 -0800 (PST)
Received: from localhost ([2400:8904::f03c:91ff:fe8a:adf7])
        by smtp.gmail.com with ESMTPSA id o13sm3525481pjq.19.2020.11.05.17.43.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Nov 2020 17:43:37 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Al Grant <Al.Grant@arm.com>, Wei Li <liwei391@huawei.com>,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v7 16/22] perf arm-spe: Refactor event type handling
Date:   Fri,  6 Nov 2020 09:41:30 +0800
Message-Id: <20201106014136.14103-17-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201106014136.14103-1-leo.yan@linaro.org>
References: <20201106014136.14103-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the enums of event types to arm-spe-pkt-decoder.h, thus function
arm_spe_pkt_desc() can them for bitmasks.

Suggested-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
---
 .../util/arm-spe-decoder/arm-spe-decoder.h    | 17 --------------
 .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 22 +++++++++----------
 .../arm-spe-decoder/arm-spe-pkt-decoder.h     | 18 +++++++++++++++
 3 files changed, 29 insertions(+), 28 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
index a5111a8d4360..24727b8ca7ff 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
@@ -13,23 +13,6 @@
 
 #include "arm-spe-pkt-decoder.h"
 
-enum arm_spe_events {
-	EV_EXCEPTION_GEN	= 0,
-	EV_RETIRED		= 1,
-	EV_L1D_ACCESS		= 2,
-	EV_L1D_REFILL		= 3,
-	EV_TLB_ACCESS		= 4,
-	EV_TLB_WALK		= 5,
-	EV_NOT_TAKEN		= 6,
-	EV_MISPRED		= 7,
-	EV_LLC_ACCESS		= 8,
-	EV_LLC_MISS		= 9,
-	EV_REMOTE_ACCESS	= 10,
-	EV_ALIGNMENT		= 11,
-	EV_PARTIAL_PREDICATE	= 17,
-	EV_EMPTY_PREDICATE	= 18,
-};
-
 enum arm_spe_sample_type {
 	ARM_SPE_L1D_ACCESS	= 1 << 0,
 	ARM_SPE_L1D_MISS	= 1 << 1,
diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index a1fd7d58bf83..6df3f18d1a5f 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -295,28 +295,28 @@ static int arm_spe_pkt_desc_event(const struct arm_spe_pkt *packet,
 
 	arm_spe_pkt_snprintf(&err, &buf, &buf_len, "EV");
 
-	if (payload & 0x1)
+	if (payload & BIT(EV_EXCEPTION_GEN))
 		arm_spe_pkt_snprintf(&err, &buf, &buf_len, " EXCEPTION-GEN");
-	if (payload & 0x2)
+	if (payload & BIT(EV_RETIRED))
 		arm_spe_pkt_snprintf(&err, &buf, &buf_len, " RETIRED");
-	if (payload & 0x4)
+	if (payload & BIT(EV_L1D_ACCESS))
 		arm_spe_pkt_snprintf(&err, &buf, &buf_len, " L1D-ACCESS");
-	if (payload & 0x8)
+	if (payload & BIT(EV_L1D_REFILL))
 		arm_spe_pkt_snprintf(&err, &buf, &buf_len, " L1D-REFILL");
-	if (payload & 0x10)
+	if (payload & BIT(EV_TLB_ACCESS))
 		arm_spe_pkt_snprintf(&err, &buf, &buf_len, " TLB-ACCESS");
-	if (payload & 0x20)
+	if (payload & BIT(EV_TLB_WALK))
 		arm_spe_pkt_snprintf(&err, &buf, &buf_len, " TLB-REFILL");
-	if (payload & 0x40)
+	if (payload & BIT(EV_NOT_TAKEN))
 		arm_spe_pkt_snprintf(&err, &buf, &buf_len, " NOT-TAKEN");
-	if (payload & 0x80)
+	if (payload & BIT(EV_MISPRED))
 		arm_spe_pkt_snprintf(&err, &buf, &buf_len, " MISPRED");
 	if (packet->index > 1) {
-		if (payload & 0x100)
+		if (payload & BIT(EV_LLC_ACCESS))
 			arm_spe_pkt_snprintf(&err, &buf, &buf_len, " LLC-ACCESS");
-		if (payload & 0x200)
+		if (payload & BIT(EV_LLC_MISS))
 			arm_spe_pkt_snprintf(&err, &buf, &buf_len, " LLC-REFILL");
-		if (payload & 0x400)
+		if (payload & BIT(EV_REMOTE_ACCESS))
 			arm_spe_pkt_snprintf(&err, &buf, &buf_len, " REMOTE-ACCESS");
 	}
 
diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
index 7d8e34e35f05..42ed4e61ede2 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
@@ -87,6 +87,24 @@ struct arm_spe_pkt {
 #define SPE_CNT_PKT_HDR_INDEX_ISSUE_LAT		0x1
 #define SPE_CNT_PKT_HDR_INDEX_TRANS_LAT		0x2
 
+/* Event packet payload */
+enum arm_spe_events {
+	EV_EXCEPTION_GEN	= 0,
+	EV_RETIRED		= 1,
+	EV_L1D_ACCESS		= 2,
+	EV_L1D_REFILL		= 3,
+	EV_TLB_ACCESS		= 4,
+	EV_TLB_WALK		= 5,
+	EV_NOT_TAKEN		= 6,
+	EV_MISPRED		= 7,
+	EV_LLC_ACCESS		= 8,
+	EV_LLC_MISS		= 9,
+	EV_REMOTE_ACCESS	= 10,
+	EV_ALIGNMENT		= 11,
+	EV_PARTIAL_PREDICATE	= 17,
+	EV_EMPTY_PREDICATE	= 18,
+};
+
 const char *arm_spe_pkt_name(enum arm_spe_pkt_type);
 
 int arm_spe_get_packet(const unsigned char *buf, size_t len,
-- 
2.17.1

