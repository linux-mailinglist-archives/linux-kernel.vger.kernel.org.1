Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD09280099
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 15:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732390AbgJAN72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 09:59:28 -0400
Received: from mga11.intel.com ([192.55.52.93]:21913 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732099AbgJAN7W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 09:59:22 -0400
IronPort-SDR: 94uDNVw2gagmCAn/mkSqEG9JncRJZ5o1hldhw8XjPBiJhEU8hkBqXSGDCbTBkystxg1s2vBVVp
 6IksXcz8BcYQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9760"; a="160059667"
X-IronPort-AV: E=Sophos;i="5.77,323,1596524400"; 
   d="scan'208";a="160059667"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 06:59:22 -0700
IronPort-SDR: /nak0sKXzM2mrkiJ1755/wXlByBIw9D7C9y2p0XULasBBN2HV4D6EmOww9iOII5reYWKReNchM
 UDzXE21QqPxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,323,1596524400"; 
   d="scan'208";a="308639193"
Received: from labuser-ice-lake-client-platform.jf.intel.com ([10.54.55.65])
  by orsmga003.jf.intel.com with ESMTP; 01 Oct 2020 06:59:22 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, eranian@google.com, ak@linux.intel.com,
        dave.hansen@intel.com, kirill.shutemov@linux.intel.com,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V9 3/4] powerpc/perf: Support PERF_SAMPLE_DATA_PAGE_SIZE
Date:   Thu,  1 Oct 2020 06:57:48 -0700
Message-Id: <20201001135749.2804-4-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201001135749.2804-1-kan.liang@linux.intel.com>
References: <20201001135749.2804-1-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The new sample type, PERF_SAMPLE_DATA_PAGE_SIZE, requires the virtual
address. Update the data->addr if the sample type is set.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/powerpc/perf/core-book3s.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 78fe34986594..ce22bd23082d 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -2065,6 +2065,9 @@ static struct pmu power_pmu = {
 	.sched_task	= power_pmu_sched_task,
 };
 
+#define PERF_SAMPLE_ADDR_TYPE  (PERF_SAMPLE_ADDR |		\
+				PERF_SAMPLE_PHYS_ADDR |		\
+				PERF_SAMPLE_DATA_PAGE_SIZE)
 /*
  * A counter has overflowed; update its count and record
  * things if requested.  Note that interrupts are hard-disabled
@@ -2120,8 +2123,7 @@ static void record_and_restart(struct perf_event *event, unsigned long val,
 
 		perf_sample_data_init(&data, ~0ULL, event->hw.last_period);
 
-		if (event->attr.sample_type &
-		    (PERF_SAMPLE_ADDR | PERF_SAMPLE_PHYS_ADDR))
+		if (event->attr.sample_type & PERF_SAMPLE_ADDR_TYPE)
 			perf_get_data_addr(event, regs, &data.addr);
 
 		if (event->attr.sample_type & PERF_SAMPLE_BRANCH_STACK) {
-- 
2.17.1

