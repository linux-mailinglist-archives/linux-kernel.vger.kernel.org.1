Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9C532B6F7B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 20:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731580AbgKQT5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 14:57:49 -0500
Received: from mga09.intel.com ([134.134.136.24]:4016 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731512AbgKQT5i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 14:57:38 -0500
IronPort-SDR: zluDHZ47/cc/IC3ILH2q4/75yj9Akj9XudDP1tWHCX7JXwRtD1u9tEJFQCO1JbRmWX/1Dn4qtP
 5g6jzo5ybDRQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9808"; a="171169275"
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="171169275"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 11:57:34 -0800
IronPort-SDR: 4xI9Gor5EQWN82txjrx3F407SFwc8nUgnhs5vN43eJi90s0rDV5boZKLwK01NxQGQ8OCvkHdGr
 wbwXWgSGTtTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="544188148"
Received: from labuser-ice-lake-client-platform.jf.intel.com ([10.54.55.65])
  by orsmga005.jf.intel.com with ESMTP; 17 Nov 2020 11:57:34 -0800
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, mingo@kernel.org, jolsa@redhat.com
Cc:     linux-kernel@vger.kernel.org, namhyung@kernel.org,
        eranian@google.com, ak@linux.intel.com, mark.rutland@arm.com,
        will@kernel.org, mpe@ellerman.id.au,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 08/12] perf test: Add test case for PERF_SAMPLE_DATA_PAGE_SIZE
Date:   Tue, 17 Nov 2020 11:56:33 -0800
Message-Id: <20201117195637.6499-9-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201117195637.6499-1-kan.liang@linux.intel.com>
References: <20201117195637.6499-1-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Extend sample-parsing test cases to support new sample type
PERF_SAMPLE_DATA_PAGE_SIZE.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/tests/sample-parsing.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/sample-parsing.c b/tools/perf/tests/sample-parsing.c
index a0bdaf390ac8..6baed165c850 100644
--- a/tools/perf/tests/sample-parsing.c
+++ b/tools/perf/tests/sample-parsing.c
@@ -154,6 +154,9 @@ static bool samples_same(const struct perf_sample *s1,
 	if (type & PERF_SAMPLE_CGROUP)
 		COMP(cgroup);
 
+	if (type & PERF_SAMPLE_DATA_PAGE_SIZE)
+		COMP(data_page_size);
+
 	if (type & PERF_SAMPLE_AUX) {
 		COMP(aux_sample.size);
 		if (memcmp(s1->aux_sample.data, s2->aux_sample.data,
@@ -234,6 +237,7 @@ static int do_test(u64 sample_type, u64 sample_regs, u64 read_format)
 		},
 		.phys_addr	= 113,
 		.cgroup		= 114,
+		.data_page_size	= 4096,
 		.aux_sample	= {
 			.size	= sizeof(aux_data),
 			.data	= (void *)aux_data,
@@ -340,7 +344,7 @@ int test__sample_parsing(struct test *test __maybe_unused, int subtest __maybe_u
 	 * were added.  Please actually update the test rather than just change
 	 * the condition below.
 	 */
-	if (PERF_SAMPLE_MAX > PERF_SAMPLE_CGROUP << 1) {
+	if (PERF_SAMPLE_MAX > PERF_SAMPLE_DATA_PAGE_SIZE << 1) {
 		pr_debug("sample format has changed, some new PERF_SAMPLE_ bit was introduced - test needs updating\n");
 		return -1;
 	}
-- 
2.17.1

