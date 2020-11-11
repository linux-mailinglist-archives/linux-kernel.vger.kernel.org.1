Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8904D2AE9AA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 08:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgKKHVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 02:21:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbgKKHOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 02:14:09 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C819C061A49
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 23:13:20 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id s2so505023plr.9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 23:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FvQtRzyLUoFsssU/sYVgndI63ocRjL7T01zL9HYsx3E=;
        b=VBPNzXyrHzSexNjjVaVHQZ++Skf0ptF6ybbsQjdZKRvZwGLUtNIz4gdCE8OFe0WYUN
         PCXZ09M50CLf4Rg9aDjnvcjS/XyeC7FQrpOUGYmYS9dbAeIbQXVKFk6wCDyw6H5QrROS
         yO52/YcU6Lu+ppmZ+4qmn/rtljtEfU79Xw4C5P/ewF4PexdurVZCnwLj7OsXXfqfUE5y
         szOBu6y5OF+teoPdFBYIsB1qkLrQMmY/3qThNnkgKIhWAla1HhSL+miD1NVo3Xfm4PmA
         J7yVruuKX+9KgRJMo+fzQqL20a/3ArtWIHHt1XTFJoFCHPql5aBoeWx2U4q40MBlQ7N+
         35PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FvQtRzyLUoFsssU/sYVgndI63ocRjL7T01zL9HYsx3E=;
        b=BkkttudncZe5YDh7/xx+qHBzcSYqwneut19UM+K+YbIJb3jfCLS4mKURgd9dvPVv8A
         gwJWFhS5pg2As1NZZeBvly2jDz511m+t4sxcRQoMyFzeVIAI7JwJqOWh2KnDFv8kt+t1
         B3nhQhfTpMRExeGa99cgQ5wmeikCMicqM10JboK+BTIOgge9ilczZZ8n4oZJorJTMh45
         doI2U+Z+hLyEdOM8lYHj8H/H/KvsbYcKGkDpVN63yJ2fCxYY5lXnM6Mi6xJIck+jytcu
         avg56+Q7+pROhz4V4SYXbmxRxs6gO6H3bqiB04x5rpLuqrjs7JvubzAfm26+oVhW/d+a
         zvmA==
X-Gm-Message-State: AOAM531A8l0XP8B/0K/6G9qKbAMIc1sSpVoHFbk2mAvfp3vONireMIwO
        qWXeyAU5NslltxaW3UVDnpqm/g==
X-Google-Smtp-Source: ABdhPJyWCuEX/uItvYdDiZ/WsIlxaBb9kR36FJw/SLhhEvoGwDJTrqIP3IUF7OjM7tMDQQs9gXRKIw==
X-Received: by 2002:a17:90a:7f81:: with SMTP id m1mr2618993pjl.197.1605078799936;
        Tue, 10 Nov 2020 23:13:19 -0800 (PST)
Received: from localhost ([45.137.216.7])
        by smtp.gmail.com with ESMTPSA id t12sm1326825pfq.79.2020.11.10.23.13.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Nov 2020 23:13:19 -0800 (PST)
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
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v8 16/22] perf arm-spe: Refactor event type handling
Date:   Wed, 11 Nov 2020 15:11:43 +0800
Message-Id: <20201111071149.815-17-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201111071149.815-1-leo.yan@linaro.org>
References: <20201111071149.815-1-leo.yan@linaro.org>
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
index af87d3c8cb50..2ebbd75d9b6a 100644
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

