Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40BC22DC6E2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 20:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733066AbgLPTFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 14:05:23 -0500
Received: from mga14.intel.com ([192.55.52.115]:53480 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733062AbgLPTFX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 14:05:23 -0500
IronPort-SDR: tt3KIfISsY5/O1UCTTbl5ppIE6pQbwgiakHvA6/E+BzXhWHsUYFuyZ2Ueyp61Cys96R+LvqL1P
 WVaFKegBDXhg==
X-IronPort-AV: E=McAfee;i="6000,8403,9837"; a="174349573"
X-IronPort-AV: E=Sophos;i="5.78,425,1599548400"; 
   d="scan'208";a="174349573"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2020 10:59:44 -0800
IronPort-SDR: RMDUHJCfg8R+cV8l5SagF/rfk2k1iB8CJ2icUv4IEzh5j8IL4wTfixdzqsnkuSzEqQEXyirG9I
 cHA4qU6jogjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,425,1599548400"; 
   d="scan'208";a="342165180"
Received: from labuser-ice-lake-client-platform.jf.intel.com ([10.54.55.65])
  by orsmga006.jf.intel.com with ESMTP; 16 Dec 2020 10:59:44 -0800
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, mingo@kernel.org, jolsa@redhat.com
Cc:     linux-kernel@vger.kernel.org, namhyung@kernel.org,
        eranian@google.com, ak@linux.intel.com, mark.rutland@arm.com,
        will@kernel.org, mpe@ellerman.id.au
Subject: [PATCH V3 9/9] perf test: Add test case for PERF_SAMPLE_CODE_PAGE_SIZE
Date:   Wed, 16 Dec 2020 10:58:05 -0800
Message-Id: <20201216185805.9981-10-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201216185805.9981-1-kan.liang@linux.intel.com>
References: <20201216185805.9981-1-kan.liang@linux.intel.com>
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
2.17.1

