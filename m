Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6FFD2FC191
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 21:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729261AbhASUuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 15:50:15 -0500
Received: from mga07.intel.com ([134.134.136.100]:26412 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729580AbhASUst (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 15:48:49 -0500
IronPort-SDR: tzMut0B06DAqXTFtxMoMX3rOi3J007R3voQrjFRzMwCclipQcrXU6KNSur5tTLdXrxRKwcrFDx
 51c7ZJ6bB+Pg==
X-IronPort-AV: E=McAfee;i="6000,8403,9869"; a="243064944"
X-IronPort-AV: E=Sophos;i="5.79,359,1602572400"; 
   d="scan'208";a="243064944"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2021 12:42:11 -0800
IronPort-SDR: fmzOFHUJxEEl78mA6BY1Ppcj9IyTwIBzaiRWPR5l5TEwobYLAUjIEal5ImvH5wEg77OWr3xFGj
 L/9O6I/JME2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,359,1602572400"; 
   d="scan'208";a="365990813"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga002.jf.intel.com with ESMTP; 19 Jan 2021 12:42:11 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     eranian@google.com, namhyung@kernel.org, jolsa@redhat.com,
        ak@linux.intel.com, yao.jin@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 10/12] perf test: Support PERF_SAMPLE_WEIGHT_EXT
Date:   Tue, 19 Jan 2021 12:38:29 -0800
Message-Id: <1611088711-17177-11-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1611088711-17177-1-git-send-email-kan.liang@linux.intel.com>
References: <1611088711-17177-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Support the new sample type for sample-parsing test case.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/tests/sample-parsing.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/sample-parsing.c b/tools/perf/tests/sample-parsing.c
index 2393916..7f428b0 100644
--- a/tools/perf/tests/sample-parsing.c
+++ b/tools/perf/tests/sample-parsing.c
@@ -238,6 +238,7 @@ static int do_test(u64 sample_type, u64 sample_regs, u64 read_format)
 		.phys_addr	= 113,
 		.cgroup		= 114,
 		.data_page_size = 115,
+		.weight_ext.val = 116,
 		.aux_sample	= {
 			.size	= sizeof(aux_data),
 			.data	= (void *)aux_data,
@@ -344,7 +345,7 @@ int test__sample_parsing(struct test *test __maybe_unused, int subtest __maybe_u
 	 * were added.  Please actually update the test rather than just change
 	 * the condition below.
 	 */
-	if (PERF_SAMPLE_MAX > PERF_SAMPLE_CODE_PAGE_SIZE << 1) {
+	if (PERF_SAMPLE_MAX > PERF_SAMPLE_WEIGHT_EXT << 1) {
 		pr_debug("sample format has changed, some new PERF_SAMPLE_ bit was introduced - test needs updating\n");
 		return -1;
 	}
-- 
2.7.4

