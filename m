Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF22A241253
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Aug 2020 23:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbgHJV2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Aug 2020 17:28:06 -0400
Received: from mga01.intel.com ([192.55.52.88]:25837 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727005AbgHJV15 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 17:27:57 -0400
IronPort-SDR: FzWF1w88oVpM4TMrp/l3hAHWQK3O8o0Tb9qkEU8siaxnP8/Mcs3xMfP9b1LBOm0kNpcx1qT1vJ
 Zy1jZpSLq6AQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9709"; a="171665984"
X-IronPort-AV: E=Sophos;i="5.75,458,1589266800"; 
   d="scan'208";a="171665984"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2020 14:27:56 -0700
IronPort-SDR: nJEPCL+0D0o3Iuwc5bo4X+WBzTTgHR+Rm8gVkJPa2PpnOxpl4HbCLYcjQhONMRk7xNbjFIe1hh
 B4kRipN1+KKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,458,1589266800"; 
   d="scan'208";a="469196841"
Received: from ssp-icl-u-210.jf.intel.com ([10.54.55.52])
  by orsmga005.jf.intel.com with ESMTP; 10 Aug 2020 14:27:56 -0700
From:   Kan Liang <kan.liang@linux.intel.com>
To:     peterz@infradead.org, acme@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, eranian@google.com, ak@linux.intel.com,
        dave.hansen@intel.com, kirill.shutemov@linux.intel.com
Subject: [PATCH V6 16/16] perf test: Add test case for PERF_SAMPLE_CODE_PAGE_SIZE
Date:   Mon, 10 Aug 2020 14:24:36 -0700
Message-Id: <20200810212436.8026-17-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200810212436.8026-1-kan.liang@linux.intel.com>
References: <20200810212436.8026-1-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephane Eranian <eranian@google.com>

Extend sample-parsing test cases to support new sample type
PERF_SAMPLE_CODE_PAGE_SIZE.

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

