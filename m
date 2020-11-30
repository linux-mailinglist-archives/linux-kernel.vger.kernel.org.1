Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74E672C8B3D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 18:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387716AbgK3Rfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 12:35:43 -0500
Received: from mga12.intel.com ([192.55.52.136]:3528 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387505AbgK3Rfm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 12:35:42 -0500
IronPort-SDR: usygnX2VPOPSQ+jSZB//BSDU0y6GXFJbL3QRksbxUWxAFzdFx4FB4lT4QrQJBl4ePwGw8dTM5F
 EYbt+hdNadFQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9821"; a="151926537"
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="151926537"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2020 09:29:11 -0800
IronPort-SDR: Df1xLU92xCVKDD4g7cdrMMfdfDkZzl8PLLh7SViY3LOdUEk/9V7ysC7t5ax07xx/jD1Z61LKft
 QQBGSQ+c1fCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="334736343"
Received: from unknown (HELO labuser-Ice-Lake-Client-Platform.jf.intel.com) ([10.54.55.65])
  by orsmga006.jf.intel.com with ESMTP; 30 Nov 2020 09:29:11 -0800
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, mingo@kernel.org, jolsa@redhat.com
Cc:     linux-kernel@vger.kernel.org, namhyung@kernel.org,
        eranian@google.com, ak@linux.intel.com, mark.rutland@arm.com,
        will@kernel.org, mpe@ellerman.id.au
Subject: [PATCH V2 12/12] perf test: Add test case for PERF_SAMPLE_CODE_PAGE_SIZE
Date:   Mon, 30 Nov 2020 09:28:03 -0800
Message-Id: <20201130172803.2676-13-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201130172803.2676-1-kan.liang@linux.intel.com>
References: <20201130172803.2676-1-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephane Eranian <eranian@google.com>

Extend sample-parsing test cases to support new sample type
PERF_SAMPLE_CODE_PAGE_SIZE.

Acked-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Stephane Eranian <eranian@google.com>
---
 tools/perf/tests/sample-parsing.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/sample-parsing.c b/tools/perf/tests/sample-parsing.c
index 6baed165c850..5e780b85d952 100644
--- a/tools/perf/tests/sample-parsing.c
+++ b/tools/perf/tests/sample-parsing.c
@@ -157,6 +157,9 @@ static bool samples_same(const struct perf_sample *s1,
 	if (type & PERF_SAMPLE_DATA_PAGE_SIZE)
 		COMP(data_page_size);
 
+	if (type & PERF_SAMPLE_CODE_PAGE_SIZE)
+		COMP(code_page_size);
+
 	if (type & PERF_SAMPLE_AUX) {
 		COMP(aux_sample.size);
 		if (memcmp(s1->aux_sample.data, s2->aux_sample.data,
@@ -238,6 +241,7 @@ static int do_test(u64 sample_type, u64 sample_regs, u64 read_format)
 		.phys_addr	= 113,
 		.cgroup		= 114,
 		.data_page_size	= 4096,
+		.code_page_size	= 4096,
 		.aux_sample	= {
 			.size	= sizeof(aux_data),
 			.data	= (void *)aux_data,
@@ -344,7 +348,7 @@ int test__sample_parsing(struct test *test __maybe_unused, int subtest __maybe_u
 	 * were added.  Please actually update the test rather than just change
 	 * the condition below.
 	 */
-	if (PERF_SAMPLE_MAX > PERF_SAMPLE_DATA_PAGE_SIZE << 1) {
+	if (PERF_SAMPLE_MAX > PERF_SAMPLE_CODE_PAGE_SIZE << 1) {
 		pr_debug("sample format has changed, some new PERF_SAMPLE_ bit was introduced - test needs updating\n");
 		return -1;
 	}
-- 
2.17.1

