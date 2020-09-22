Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6A5F273F45
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 12:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgIVKMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 06:12:37 -0400
Received: from foss.arm.com ([217.140.110.172]:32956 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726419AbgIVKMg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 06:12:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 52CEB1396;
        Tue, 22 Sep 2020 03:12:36 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.cambridge.arm.com [10.1.195.35])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 540E53F718;
        Tue, 22 Sep 2020 03:12:34 -0700 (PDT)
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
Subject: [PATCH 2/5] perf: arm_spe: Add new event packet bits
Date:   Tue, 22 Sep 2020 11:12:22 +0100
Message-Id: <20200922101225.183554-3-andre.przywara@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200922101225.183554-1-andre.przywara@arm.com>
References: <20200922101225.183554-1-andre.przywara@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ARMv8.3-SPE extension adds some new bits to the event packet
fields.

Handle bits 11 (alignment), 17 and 18 (SVE predication) when decoding
the SPE buffer content.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 .../util/arm-spe-decoder/arm-spe-pkt-decoder.c  | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index b94001b756c7..e633bb5b8e65 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -346,6 +346,23 @@ int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
 				buf += ret;
 				blen -= ret;
 			}
+			if (payload & BIT(11)) {
+				ret = snprintf(buf, buf_len, " ALIGNMENT");
+				buf += ret;
+				blen -= ret;
+			}
+		}
+		if (idx > 2) {
+			if (payload & BIT(17)) {
+				ret = snprintf(buf, buf_len, " SVE-PARTIAL-PRED");
+				buf += ret;
+				blen -= ret;
+			}
+			if (payload & BIT(18)) {
+				ret = snprintf(buf, buf_len, " SVE-EMPTY-PRED");
+				buf += ret;
+				blen -= ret;
+			}
 		}
 		if (ret < 0)
 			return ret;
-- 
2.17.1

