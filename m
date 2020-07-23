Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42A7B22B456
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jul 2020 19:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730080AbgGWRLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jul 2020 13:11:52 -0400
Received: from mga05.intel.com ([192.55.52.43]:6574 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730052AbgGWRLp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 13:11:45 -0400
IronPort-SDR: NA2K+W0/qGF/KVXrrqozrsvzBFV4jIB4UP8HZQQMZHRmDWFdxf5KhsRu4in6ksz8VUQ41sSGfb
 XViiMLeOxQgg==
X-IronPort-AV: E=McAfee;i="6000,8403,9691"; a="235456742"
X-IronPort-AV: E=Sophos;i="5.75,387,1589266800"; 
   d="scan'208";a="235456742"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2020 10:11:44 -0700
IronPort-SDR: Rv/ctLY06Inpal65cnPr+PIGki198ioPi3/XgRTjYw0MviPoZqaJUhaFVZ34rvDvVZ4yGvXt1c
 bkV7Ur65hZaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,387,1589266800"; 
   d="scan'208";a="488904267"
Received: from labuser-ice-lake-client-platform.jf.intel.com ([10.54.55.65])
  by fmsmga005.fm.intel.com with ESMTP; 23 Jul 2020 10:11:44 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@redhat.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        like.xu@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V7 05/14] perf/x86/intel: Fix the name of perf METRICS
Date:   Thu, 23 Jul 2020 10:11:08 -0700
Message-Id: <20200723171117.9918-6-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200723171117.9918-1-kan.liang@linux.intel.com>
References: <20200723171117.9918-1-kan.liang@linux.intel.com>
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

