Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC6B223DCA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jul 2020 16:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbgGQOIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jul 2020 10:08:10 -0400
Received: from mga01.intel.com ([192.55.52.88]:11825 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727971AbgGQOH0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 10:07:26 -0400
IronPort-SDR: B/ViiSt8xVMpZuLwXr2M4YJBgf7pQP6y0HUKFB1qSR/R0Wdbz/3kOwIbDdimicYEviIHx52Hri
 kgI+jBWnL3yA==
X-IronPort-AV: E=McAfee;i="6000,8403,9684"; a="167722791"
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800"; 
   d="scan'208";a="167722791"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2020 07:07:24 -0700
IronPort-SDR: dKnv8/Mvm8i3A8VWBV5Otp+KSGneJrERPsqS7GMfra9YV99nd7is64JoiGeWAXGLvtIj5xqezo
 bue/XKbwQmhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800"; 
   d="scan'208";a="460856480"
Received: from labuser-ice-lake-client-platform.jf.intel.com ([10.54.55.65])
  by orsmga005.jf.intel.com with ESMTP; 17 Jul 2020 07:07:24 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@redhat.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V6 05/14] perf/x86/intel: Fix the name of perf METRICS
Date:   Fri, 17 Jul 2020 07:05:45 -0700
Message-Id: <20200717140554.22863-6-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200717140554.22863-1-kan.liang@linux.intel.com>
References: <20200717140554.22863-1-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Bit 15 of the PERF_CAPABILITIES MSR indicates that the perf METRICS
feature is supported. The perf METRICS is not a PEBS feature.

Rename pebs_metrics_available perf_metrics.

The bit is not used in the current code. It will be used in a later
patch.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/perf_event.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 7b68ab5f19e7..5d453da8cfa6 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -537,7 +537,7 @@ union perf_capabilities {
 		 */
 		u64	full_width_write:1;
 		u64     pebs_baseline:1;
-		u64	pebs_metrics_available:1;
+		u64	perf_metrics:1;
 		u64	pebs_output_pt_available:1;
 	};
 	u64	capabilities;
-- 
2.17.1

