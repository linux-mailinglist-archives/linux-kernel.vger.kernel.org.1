Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1C902B9625
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 16:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728627AbgKSPZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 10:25:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728520AbgKSPZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 10:25:35 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 343FBC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 07:25:35 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id b63so4792012pfg.12
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 07:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NC222K+cGQKva98GzUZdk80DNSIuisvetERGatg8i5c=;
        b=z4bDwHa05GsmN5ScoOiD0MkNzNfW1WusYaO6aj2teQmBw+P7d9SNja5dyr1gZpXQ0M
         qLeb69npysEZPYBWKGdYIZOuiKh+8KBCZ2xejnAS6mqNZOYSnUM1bxW98bIhskcyrmX2
         UtOiOWQVRrmt80Cz5cMDjwWtyMn3TNCMOM9NMN1fiQhHZTYsRvqycfR0kgIZfBhD3gWL
         5kfmfLRQJXO8T/kTWnXKEe35mETKXwJ6kf0ETbJJNx7XvloMUrjJhi9l6/glzqMq6FrF
         s2gEgmiiYbhYzIkH7sDNDRafZnFzVmV9MryYCf5l3bde5ojcCQzFygUtOc45SGjFsiqd
         UmoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NC222K+cGQKva98GzUZdk80DNSIuisvetERGatg8i5c=;
        b=jQ3jDY/+5ps38EFQRdq4swXPcLUbOZ6M4KMAvSC8HDk3FaZR1B0Y5z5oVqsyhPsSSW
         APl9uC8W0NyrkvP3Cdu45XGetRXOAgnZMdHSynDhVYSl4jn1e6+y4xxSIysmHnkcJSRW
         g83h+2gewYMHEn7DpHBJe3mQ7QjVDE/ywP0YCO7NW8HfEJaKZJgmjl3lUZkSH+y8CmI+
         ezsZQjEorH2BMBT1YLG1XoIX3jG3pAmf2QDpqnOR+EX0OToU1dNdHCpy3/+A2X3TrmeG
         7bT+fHi6YGAfNlE2w7BjODKVe3VDkgyBgcFQF3FXPSVtDi1OIb5+5A60u+PIIdEbXei2
         3MAA==
X-Gm-Message-State: AOAM533OyhkUTrh3p3lM2/m+zwVlnVTItYgSCauY+8ZOcWNjPXH7sjRN
        vBaEMBM1NTAtJopeAlIE+3pOcQ==
X-Google-Smtp-Source: ABdhPJybgL8LkbXNBysClTUYPEcuPm57WFDpqKJnl/wqe6CZk8JLJ8uG0/lmESii8eH9eH3Zdqr7tQ==
X-Received: by 2002:a17:90a:8a8e:: with SMTP id x14mr3922330pjn.193.1605799534758;
        Thu, 19 Nov 2020 07:25:34 -0800 (PST)
Received: from localhost ([45.137.216.7])
        by smtp.gmail.com with ESMTPSA id y3sm7904322pjb.18.2020.11.19.07.25.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Nov 2020 07:25:34 -0800 (PST)
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
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v9 10/16] perf arm-spe: Refactor event type handling
Date:   Thu, 19 Nov 2020 23:24:35 +0800
Message-Id: <20201119152441.6972-11-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201119152441.6972-1-leo.yan@linaro.org>
References: <20201119152441.6972-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the enums of event types to arm-spe-pkt-decoder.h, thus function
arm_spe_pkt_desc_event() can use them for bitmasks.

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
index da6b9f76739c..3f30b2937715 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -295,28 +295,28 @@ static int arm_spe_pkt_desc_event(const struct arm_spe_pkt *packet,
 
 	arm_spe_pkt_out_string(&err, &buf, &buf_len, "EV");
 
-	if (payload & 0x1)
+	if (payload & BIT(EV_EXCEPTION_GEN))
 		arm_spe_pkt_out_string(&err, &buf, &buf_len, " EXCEPTION-GEN");
-	if (payload & 0x2)
+	if (payload & BIT(EV_RETIRED))
 		arm_spe_pkt_out_string(&err, &buf, &buf_len, " RETIRED");
-	if (payload & 0x4)
+	if (payload & BIT(EV_L1D_ACCESS))
 		arm_spe_pkt_out_string(&err, &buf, &buf_len, " L1D-ACCESS");
-	if (payload & 0x8)
+	if (payload & BIT(EV_L1D_REFILL))
 		arm_spe_pkt_out_string(&err, &buf, &buf_len, " L1D-REFILL");
-	if (payload & 0x10)
+	if (payload & BIT(EV_TLB_ACCESS))
 		arm_spe_pkt_out_string(&err, &buf, &buf_len, " TLB-ACCESS");
-	if (payload & 0x20)
+	if (payload & BIT(EV_TLB_WALK))
 		arm_spe_pkt_out_string(&err, &buf, &buf_len, " TLB-REFILL");
-	if (payload & 0x40)
+	if (payload & BIT(EV_NOT_TAKEN))
 		arm_spe_pkt_out_string(&err, &buf, &buf_len, " NOT-TAKEN");
-	if (payload & 0x80)
+	if (payload & BIT(EV_MISPRED))
 		arm_spe_pkt_out_string(&err, &buf, &buf_len, " MISPRED");
 	if (packet->index > 1) {
-		if (payload & 0x100)
+		if (payload & BIT(EV_LLC_ACCESS))
 			arm_spe_pkt_out_string(&err, &buf, &buf_len, " LLC-ACCESS");
-		if (payload & 0x200)
+		if (payload & BIT(EV_LLC_MISS))
 			arm_spe_pkt_out_string(&err, &buf, &buf_len, " LLC-REFILL");
-		if (payload & 0x400)
+		if (payload & BIT(EV_REMOTE_ACCESS))
 			arm_spe_pkt_out_string(&err, &buf, &buf_len, " REMOTE-ACCESS");
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

