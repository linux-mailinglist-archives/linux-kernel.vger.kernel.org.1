Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71D11292A03
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 17:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729852AbgJSPGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 11:06:32 -0400
Received: from mga06.intel.com ([134.134.136.31]:20958 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729223AbgJSPGb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 11:06:31 -0400
IronPort-SDR: OlI+/wDvaIeQpwE4N+jkxNm+3YEEdO3hTFe7fQ52gQ+j5iiOLHRpSvMLUDXHVZkG6yhxZSU6MM
 NQtD17zqdOag==
X-IronPort-AV: E=McAfee;i="6000,8403,9778"; a="228683634"
X-IronPort-AV: E=Sophos;i="5.77,394,1596524400"; 
   d="scan'208";a="228683634"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2020 08:06:31 -0700
IronPort-SDR: oMJ87bZUoO7EtLwDd2ybLq4I4U7+E++/GvItZx2NEe+1l45QvK7gWao8FDXDNZb6FnjfpmOBM2
 /y7fZHRi2U5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,394,1596524400"; 
   d="scan'208";a="465559318"
Received: from ssp-icl-u-210.jf.intel.com ([10.54.55.52])
  by orsmga004.jf.intel.com with ESMTP; 19 Oct 2020 08:06:30 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH] perf/x86/intel: Add event constraint for CYCLE_ACTIVITY.STALLS_MEM_ANY
Date:   Mon, 19 Oct 2020 08:01:58 -0700
Message-Id: <20201019150158.31635-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The event CYCLE_ACTIVITY.STALLS_MEM_ANY (0x14a3) should be available on
all 8 GP counters on ICL, but it's only scheduled on the first four
counters due to the current ICL constraint table.

Add a line for the CYCLE_ACTIVITY.STALLS_MEM_ANY event in the ICL
constraint table.
Correct the comments for the CYCLE_ACTIVITY.CYCLES_MEM_ANY event.

Reported-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index c72e4904e056..b31ebb5f7fc4 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -257,7 +257,8 @@ static struct event_constraint intel_icl_event_constraints[] = {
 	INTEL_EVENT_CONSTRAINT_RANGE(0x48, 0x54, 0xf),
 	INTEL_EVENT_CONSTRAINT_RANGE(0x60, 0x8b, 0xf),
 	INTEL_UEVENT_CONSTRAINT(0x04a3, 0xff),  /* CYCLE_ACTIVITY.STALLS_TOTAL */
-	INTEL_UEVENT_CONSTRAINT(0x10a3, 0xff),  /* CYCLE_ACTIVITY.STALLS_MEM_ANY */
+	INTEL_UEVENT_CONSTRAINT(0x10a3, 0xff),  /* CYCLE_ACTIVITY.CYCLES_MEM_ANY */
+	INTEL_UEVENT_CONSTRAINT(0x14a3, 0xff),  /* CYCLE_ACTIVITY.STALLS_MEM_ANY */
 	INTEL_EVENT_CONSTRAINT(0xa3, 0xf),      /* CYCLE_ACTIVITY.* */
 	INTEL_EVENT_CONSTRAINT_RANGE(0xa8, 0xb0, 0xf),
 	INTEL_EVENT_CONSTRAINT_RANGE(0xb7, 0xbd, 0xf),
-- 
2.17.1

