Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7DF726DDEF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 16:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbgIQOMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 10:12:49 -0400
Received: from mga05.intel.com ([192.55.52.43]:3614 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727356AbgIQOLV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 10:11:21 -0400
IronPort-SDR: 73TDc76BmINIsYmtfe5bxBKh279i3kTiBc8Y6822tD9paet11VtojrbuZeGohQkrATgim8x70j
 2tui+7iL/1Qg==
X-IronPort-AV: E=McAfee;i="6000,8403,9746"; a="244532742"
X-IronPort-AV: E=Sophos;i="5.76,437,1592895600"; 
   d="scan'208";a="244532742"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2020 06:53:40 -0700
IronPort-SDR: uejv6rVOqNdgvOQq78PFJQ/Fgb3VaCRACDAdNTuYQ0xb3YFVC2t408+y0KASJG25Y+E4AvxcCJ
 0TpV52ACjy6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,437,1592895600"; 
   d="scan'208";a="380543132"
Received: from labuser-ice-lake-client-platform.jf.intel.com ([10.54.55.65])
  by orsmga001.jf.intel.com with ESMTP; 17 Sep 2020 06:53:40 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, eranian@google.com, ak@linux.intel.com,
        dave.hansen@intel.com, kirill.shutemov@linux.intel.com,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V7 2/4] perf/x86/intel: Support PERF_SAMPLE_DATA_PAGE_SIZE
Date:   Thu, 17 Sep 2020 06:52:35 -0700
Message-Id: <20200917135237.2857-3-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200917135237.2857-1-kan.liang@linux.intel.com>
References: <20200917135237.2857-1-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The new sample type, PERF_SAMPLE_DATA_PAGE_SIZE, requires the virtual
address. Update the data->addr if the sample type is set.

The large PEBS is disabled with the sample type, because perf doesn't
support munmap tracking yet. The PEBS buffer for large PEBS cannot be
flushed for each munmap. Wrong page size may be calculated. The large
PEBS can be enabled later separately when munmap tracking is supported.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/ds.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 404315df1e16..444e5f061d04 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -959,7 +959,8 @@ static void adaptive_pebs_record_size_update(void)
 
 #define PERF_PEBS_MEMINFO_TYPE	(PERF_SAMPLE_ADDR | PERF_SAMPLE_DATA_SRC |   \
 				PERF_SAMPLE_PHYS_ADDR | PERF_SAMPLE_WEIGHT | \
-				PERF_SAMPLE_TRANSACTION)
+				PERF_SAMPLE_TRANSACTION |		     \
+				PERF_SAMPLE_DATA_PAGE_SIZE)
 
 static u64 pebs_update_adaptive_cfg(struct perf_event *event)
 {
@@ -1335,6 +1336,10 @@ static u64 get_data_src(struct perf_event *event, u64 aux)
 	return val;
 }
 
+#define PERF_SAMPLE_ADDR_TYPE	(PERF_SAMPLE_ADDR |		\
+				 PERF_SAMPLE_PHYS_ADDR |	\
+				 PERF_SAMPLE_DATA_PAGE_SIZE)
+
 static void setup_pebs_fixed_sample_data(struct perf_event *event,
 				   struct pt_regs *iregs, void *__pebs,
 				   struct perf_sample_data *data,
@@ -1449,7 +1454,7 @@ static void setup_pebs_fixed_sample_data(struct perf_event *event,
 	}
 
 
-	if ((sample_type & (PERF_SAMPLE_ADDR | PERF_SAMPLE_PHYS_ADDR)) &&
+	if ((sample_type & PERF_SAMPLE_ADDR_TYPE) &&
 	    x86_pmu.intel_cap.pebs_format >= 1)
 		data->addr = pebs->dla;
 
@@ -1577,7 +1582,7 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
 		if (sample_type & PERF_SAMPLE_DATA_SRC)
 			data->data_src.val = get_data_src(event, meminfo->aux);
 
-		if (sample_type & (PERF_SAMPLE_ADDR | PERF_SAMPLE_PHYS_ADDR))
+		if (sample_type & PERF_SAMPLE_ADDR_TYPE)
 			data->addr = meminfo->address;
 
 		if (sample_type & PERF_SAMPLE_TRANSACTION)
-- 
2.17.1

