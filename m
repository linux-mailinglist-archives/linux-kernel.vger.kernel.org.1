Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42AC5273F4A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 12:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgIVKMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 06:12:51 -0400
Received: from foss.arm.com ([217.140.110.172]:33026 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726552AbgIVKMn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 06:12:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EDD1613D5;
        Tue, 22 Sep 2020 03:12:42 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.cambridge.arm.com [10.1.195.35])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F03373F718;
        Tue, 22 Sep 2020 03:12:40 -0700 (PDT)
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
Subject: [PATCH 5/5] perf: arm_spe: Decode SVE events
Date:   Tue, 22 Sep 2020 11:12:25 +0100
Message-Id: <20200922101225.183554-6-andre.przywara@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200922101225.183554-1-andre.przywara@arm.com>
References: <20200922101225.183554-1-andre.przywara@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Scalable Vector Extension (SVE) is an ARMv8 architecture extension
that introduces very long vector operations (up to 2048 bits).
The SPE profiling feature can tag SVE instructions with additional
properties like predication or the effective vector length.

Decode the new operation type bits in the SPE decoder to allow the perf
tool to correctly report about SVE instructions.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 48 ++++++++++++++++++-
 1 file changed, 47 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index a033f34846a6..f0c369259554 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -372,8 +372,35 @@ int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
 	}
 	case ARM_SPE_OP_TYPE:
 		switch (idx) {
-		case 0:	return snprintf(buf, buf_len, "%s", payload & 0x1 ?
+		case 0: {
+			size_t blen = buf_len;
+
+			if ((payload & 0x89) == 0x08) {
+				ret = snprintf(buf, buf_len, "SVE");
+				buf += ret;
+				blen -= ret;
+				if (payload & 0x2)
+					ret = snprintf(buf, buf_len, " FP");
+				else
+					ret = snprintf(buf, buf_len, " INT");
+				buf += ret;
+				blen -= ret;
+				if (payload & 0x4) {
+					ret = snprintf(buf, buf_len, " PRED");
+					buf += ret;
+					blen -= ret;
+				}
+				/* Bits [7..4] encode the vector length */
+				ret = snprintf(buf, buf_len, " EVLEN%d",
+					       32 << ((payload >> 4) & 0x7));
+				buf += ret;
+				blen -= ret;
+				return buf_len - blen;
+			}
+
+			return snprintf(buf, buf_len, "%s", payload & 0x1 ?
 					"COND-SELECT" : "INSN-OTHER");
+			}
 		case 1:	{
 			size_t blen = buf_len;
 
@@ -403,6 +430,25 @@ int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
 				ret = snprintf(buf, buf_len, " NV-SYSREG");
 				buf += ret;
 				blen -= ret;
+			} else if ((payload & 0x0a) == 0x08) {
+				ret = snprintf(buf, buf_len, " SVE");
+				buf += ret;
+				blen -= ret;
+				if (payload & 0x4) {
+					ret = snprintf(buf, buf_len, " PRED");
+					buf += ret;
+					blen -= ret;
+				}
+				if (payload & 0x80) {
+					ret = snprintf(buf, buf_len, " SG");
+					buf += ret;
+					blen -= ret;
+				}
+				/* Bits [7..4] encode the vector length */
+				ret = snprintf(buf, buf_len, " EVLEN%d",
+					       32 << ((payload >> 4) & 0x7));
+				buf += ret;
+				blen -= ret;
 			} else if (payload & 0x4) {
 				ret = snprintf(buf, buf_len, " SIMD-FP");
 				buf += ret;
-- 
2.17.1

