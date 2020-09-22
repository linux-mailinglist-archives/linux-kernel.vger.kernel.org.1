Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36343273F48
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 12:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbgIVKMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 06:12:44 -0400
Received: from foss.arm.com ([217.140.110.172]:33004 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726518AbgIVKMl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 06:12:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BD700147A;
        Tue, 22 Sep 2020 03:12:40 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.cambridge.arm.com [10.1.195.35])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B88803F718;
        Tue, 22 Sep 2020 03:12:38 -0700 (PDT)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        James Clark <james.clark@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] perf: arm_spe: Decode memory tagging properties
Date:   Tue, 22 Sep 2020 11:12:24 +0100
Message-Id: <20200922101225.183554-5-andre.przywara@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200922101225.183554-1-andre.przywara@arm.com>
References: <20200922101225.183554-1-andre.przywara@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When SPE records a physical address, it can additionally tag the event
with information from the Memory Tagging architecture extension.

Decode the two additional fields in the SPE event payload.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 .../util/arm-spe-decoder/arm-spe-pkt-decoder.c  | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index 943e4155b246..a033f34846a6 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -8,13 +8,14 @@
 #include <string.h>
 #include <endian.h>
 #include <byteswap.h>
+#include <linux/bits.h>
 
 #include "arm-spe-pkt-decoder.h"
 
-#define BIT(n)		(1ULL << (n))
-
 #define NS_FLAG		BIT(63)
 #define EL_FLAG		(BIT(62) | BIT(61))
+#define CH_FLAG		BIT(62)
+#define PAT_FLAG	GENMASK_ULL(59, 56)
 
 #define SPE_HEADER0_PAD			0x0
 #define SPE_HEADER0_END			0x1
@@ -447,10 +448,16 @@ int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
 			return snprintf(buf, buf_len, "%s 0x%llx el%d ns=%d",
 				        (idx == 1) ? "TGT" : "PC", payload, el, ns);
 		case 2:	return snprintf(buf, buf_len, "VA 0x%llx", payload);
-		case 3:	ns = !!(packet->payload & NS_FLAG);
+		case 3:	{
+			int ch = !!(packet->payload & CH_FLAG);
+			int pat = (packet->payload & PAT_FLAG) >> 56;
+
+			ns = !!(packet->payload & NS_FLAG);
 			payload &= ~(0xffULL << 56);
-			return snprintf(buf, buf_len, "PA 0x%llx ns=%d",
-					payload, ns);
+			return snprintf(buf, buf_len,
+					"PA 0x%llx ns=%d ch=%d, pat=%x",
+					payload, ns, ch, pat);
+			}
 		default: return 0;
 		}
 	case ARM_SPE_CONTEXT:
-- 
2.17.1

