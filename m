Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADE79273F49
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 12:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgIVKMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 06:12:46 -0400
Received: from foss.arm.com ([217.140.110.172]:32980 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726473AbgIVKMj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 06:12:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 854BC143B;
        Tue, 22 Sep 2020 03:12:38 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.cambridge.arm.com [10.1.195.35])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 86FBF3F718;
        Tue, 22 Sep 2020 03:12:36 -0700 (PDT)
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
Subject: [PATCH 3/5] perf: arm_spe: Add nested virt event decoding
Date:   Tue, 22 Sep 2020 11:12:23 +0100
Message-Id: <20200922101225.183554-4-andre.przywara@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200922101225.183554-1-andre.przywara@arm.com>
References: <20200922101225.183554-1-andre.przywara@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ARMv8.4 nested virtualisation extension can redirect system register
accesses to a memory page controlled by the hypervisor. The SPE
profiling feature in newer implementations can tag those memory accesses
accordingly.

Add the bit pattern describing this load/store type, so that the perf
tool can decode it properly.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index e633bb5b8e65..943e4155b246 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -398,6 +398,10 @@ int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
 					buf += ret;
 					blen -= ret;
 				}
+			} else if ((payload & 0xfe) == 0x30) {
+				ret = snprintf(buf, buf_len, " NV-SYSREG");
+				buf += ret;
+				blen -= ret;
 			} else if (payload & 0x4) {
 				ret = snprintf(buf, buf_len, " SIMD-FP");
 				buf += ret;
-- 
2.17.1

