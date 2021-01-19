Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 508232FC18E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 21:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403844AbhASUtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 15:49:14 -0500
Received: from mga07.intel.com ([134.134.136.100]:26409 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392020AbhASUrK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 15:47:10 -0500
IronPort-SDR: L3yZxD8n5h6IRY1eA+4NKoM2cMDI3+HZnomqqjIui88M6F3V6Av6gqoKBmVaJucRLNbxq32eTA
 jeFmtyNdXpnA==
X-IronPort-AV: E=McAfee;i="6000,8403,9869"; a="243064933"
X-IronPort-AV: E=Sophos;i="5.79,359,1602572400"; 
   d="scan'208";a="243064933"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2021 12:42:06 -0800
IronPort-SDR: IFEzzs7QnlGg43d0nWBSpRY+vQyxLPykJ7kapMWjQ3ekj2JPvPG5GUk7skiiMO8fP2CCI9kRSs
 V5S5KBtxjOQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,359,1602572400"; 
   d="scan'208";a="365990802"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga002.jf.intel.com with ESMTP; 19 Jan 2021 12:42:06 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     eranian@google.com, namhyung@kernel.org, jolsa@redhat.com,
        ak@linux.intel.com, yao.jin@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 05/12] tools headers uapi: Update tools's copy of linux/perf_event.h
Date:   Tue, 19 Jan 2021 12:38:24 -0800
Message-Id: <1611088711-17177-6-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1611088711-17177-1-git-send-email-kan.liang@linux.intel.com>
References: <1611088711-17177-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

To get the changes in:

    ("perf/core: Add PERF_SAMPLE_WEIGHT_EXT")

This cures the following warning during perf's build:

        Warning: Kernel ABI header at
'tools/include/uapi/linux/perf_event.h' differs from latest version at
'include/uapi/linux/perf_event.h'
        diff -u tools/include/uapi/linux/perf_event.h
include/uapi/linux/perf_event.h

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/include/uapi/linux/perf_event.h | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index b15e344..17f19cc 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -145,8 +145,9 @@ enum perf_event_sample_format {
 	PERF_SAMPLE_CGROUP			= 1U << 21,
 	PERF_SAMPLE_DATA_PAGE_SIZE		= 1U << 22,
 	PERF_SAMPLE_CODE_PAGE_SIZE		= 1U << 23,
+	PERF_SAMPLE_WEIGHT_EXT			= 1U << 24,
 
-	PERF_SAMPLE_MAX = 1U << 24,		/* non-ABI */
+	PERF_SAMPLE_MAX = 1U << 25,		/* non-ABI */
 
 	__PERF_SAMPLE_CALLCHAIN_EARLY		= 1ULL << 63, /* non-ABI; internal use */
 };
@@ -900,6 +901,13 @@ enum perf_event_type {
 	 *	  char			data[size]; } && PERF_SAMPLE_AUX
 	 *	{ u64			data_page_size;} && PERF_SAMPLE_DATA_PAGE_SIZE
 	 *	{ u64			code_page_size;} && PERF_SAMPLE_CODE_PAGE_SIZE
+	 *	{ union {
+	 *		u64		weight_ext;
+	 *		struct {
+	 *			u64	instr_latency:16,
+	 *				reserved:48;
+	 *		};
+	 *	} && PERF_SAMPLE_WEIGHT_EXT
 	 * };
 	 */
 	PERF_RECORD_SAMPLE			= 9,
@@ -1127,14 +1135,16 @@ union perf_mem_data_src {
 			mem_lvl_num:4,	/* memory hierarchy level number */
 			mem_remote:1,   /* remote */
 			mem_snoopx:2,	/* snoop mode, ext */
-			mem_rsvd:24;
+			mem_blk:3,	/* access blocked */
+			mem_rsvd:21;
 	};
 };
 #elif defined(__BIG_ENDIAN_BITFIELD)
 union perf_mem_data_src {
 	__u64 val;
 	struct {
-		__u64	mem_rsvd:24,
+		__u64	mem_rsvd:21,
+			mem_blk:3,	/* access blocked */
 			mem_snoopx:2,	/* snoop mode, ext */
 			mem_remote:1,   /* remote */
 			mem_lvl_num:4,	/* memory hierarchy level number */
@@ -1217,6 +1227,12 @@ union perf_mem_data_src {
 #define PERF_MEM_TLB_OS		0x40 /* OS fault handler */
 #define PERF_MEM_TLB_SHIFT	26
 
+/* Access blocked */
+#define PERF_MEM_BLK_NA		0x01 /* not available */
+#define PERF_MEM_BLK_DATA	0x02 /* data could not be forwarded */
+#define PERF_MEM_BLK_ADDR	0x04 /* address conflict */
+#define PERF_MEM_BLK_SHIFT	40
+
 #define PERF_MEM_S(a, s) \
 	(((__u64)PERF_MEM_##a##_##s) << PERF_MEM_##a##_SHIFT)
 
@@ -1248,4 +1264,12 @@ struct perf_branch_entry {
 		reserved:40;
 };
 
+union perf_weight_ext {
+	__u64		val;
+	struct {
+		__u64	instr_latency:16,
+			reserved:48;
+	};
+};
+
 #endif /* _UAPI_LINUX_PERF_EVENT_H */
-- 
2.7.4

