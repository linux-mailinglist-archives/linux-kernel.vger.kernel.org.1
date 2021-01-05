Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF892EB3E2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 21:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731181AbhAEUC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 15:02:57 -0500
Received: from mga04.intel.com ([192.55.52.120]:12058 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728507AbhAEUC4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 15:02:56 -0500
IronPort-SDR: aQQfpjY8YpwJcHR83f1m2l9bdwaQLem2SeuW5zIJqIc+f3LQt8lZmPWIVk/kvNK1yuh1482DkC
 CJIzLn8h1YAA==
X-IronPort-AV: E=McAfee;i="6000,8403,9855"; a="174594277"
X-IronPort-AV: E=Sophos;i="5.78,477,1599548400"; 
   d="scan'208";a="174594277"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2021 11:58:36 -0800
IronPort-SDR: wGdXAXJk25Z+0PBxIT6JblQkQDyAvR368ScmBTC7LdNY6wn5ze9kKiFHj1JQ8MAnFWhJtZbaKa
 vGvkBKHj3uGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,477,1599548400"; 
   d="scan'208";a="421901296"
Received: from ssp-iclu-cdi187.jf.intel.com ([10.54.55.67])
  by orsmga001.jf.intel.com with ESMTP; 05 Jan 2021 11:58:36 -0800
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, mingo@kernel.org, linux-kernel@vger.kernel.org
Cc:     jolsa@redhat.com, namhyung@kernel.org, eranian@google.com,
        ak@linux.intel.com, mark.rutland@arm.com, will@kernel.org,
        mpe@ellerman.id.au
Subject: [PATCH V4 6/6] perf test: Add test case for PERF_SAMPLE_CODE_PAGE_SIZE
Date:   Tue,  5 Jan 2021 11:57:52 -0800
Message-Id: <20210105195752.43489-7-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210105195752.43489-1-kan.liang@linux.intel.com>
References: <20210105195752.43489-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephane Eranian <eranian@google.com>

Extend sample-parsing test cases to support new sample type
PERF_SAMPLE_CODE_PAGE_SIZE.

Acked-by: Namhyung Kim <namhyung@kernel.org>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Signed-off-by: Stephane Eranian <eranian@google.com>
---
 tools/perf/tests/sample-parsing.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/tests/sample-parsing.c b/tools/perf/tests/sample-parsing.c
index 2393916f6128..e93d0689a27b 100644
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
 		.data_page_size = 115,
+		.code_page_size = 116,
 		.aux_sample	= {
 			.size	= sizeof(aux_data),
 			.data	= (void *)aux_data,
-- 
2.25.1

