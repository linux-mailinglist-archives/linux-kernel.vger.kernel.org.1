Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4B0D2789EE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 15:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728824AbgIYNud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 09:50:33 -0400
Received: from mga17.intel.com ([192.55.52.151]:49095 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728365AbgIYNuc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 09:50:32 -0400
IronPort-SDR: x18NXrxhsb05o7ZAMWUIk4tpb6w7CaVoASgOiBuPdLR1beDpSZ7fyftEcsyiEBWKPOPOe/YX8M
 pyTVzPEBQ/Nw==
X-IronPort-AV: E=McAfee;i="6000,8403,9754"; a="141546642"
X-IronPort-AV: E=Sophos;i="5.77,302,1596524400"; 
   d="scan'208";a="141546642"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2020 06:50:31 -0700
IronPort-SDR: 5YckPMQxtbZ4n66syUtNBVll/Hr5P31dA4eEQsZoSdl9qEjCHcm9iVj8N44A/derQ/OFuPEpr3
 zZBSIbwyZbBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,302,1596524400"; 
   d="scan'208";a="310824574"
Received: from unknown (HELO labuser-Ice-Lake-Client-Platform.jf.intel.com) ([10.54.55.65])
  by orsmga006.jf.intel.com with ESMTP; 25 Sep 2020 06:50:31 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, asit.k.mallick@intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 3/3] perf/x86/intel/uncore: Reduce the number of CBOX counters
Date:   Fri, 25 Sep 2020 06:49:05 -0700
Message-Id: <20200925134905.8839-3-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200925134905.8839-1-kan.liang@linux.intel.com>
References: <20200925134905.8839-1-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

An oops is triggered by the fuzzy test.

[  327.853081] unchecked MSR access error: RDMSR from 0x70c at rIP:
0xffffffffc082c820 (uncore_msr_read_counter+0x10/0x50 [intel_uncore])
[  327.853083] Call Trace:
[  327.853085]  <IRQ>
[  327.853089]  uncore_pmu_event_start+0x85/0x170 [intel_uncore]
[  327.853093]  uncore_pmu_event_add+0x1a4/0x410 [intel_uncore]
[  327.853097]  ? event_sched_in.isra.118+0xca/0x240

There are 2 GP counters for each CBOX, but the current code claims 4
counters. Accessing the invalid registers triggers the oops.

Fixes: 6e394376ee89 ("perf/x86/intel/uncore: Add Intel Icelake uncore support")
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/uncore_snb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
index 2bdfcf80b434..de3d9621b694 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -325,7 +325,7 @@ static struct intel_uncore_ops icl_uncore_msr_ops = {
 
 static struct intel_uncore_type icl_uncore_cbox = {
 	.name		= "cbox",
-	.num_counters   = 4,
+	.num_counters   = 2,
 	.perf_ctr_bits	= 44,
 	.perf_ctr	= ICL_UNC_CBO_0_PER_CTR0,
 	.event_ctl	= SNB_UNC_CBO_0_PERFEVTSEL0,
-- 
2.17.1

