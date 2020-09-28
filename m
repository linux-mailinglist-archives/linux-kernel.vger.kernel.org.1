Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D71B27AE06
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 14:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbgI1MkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 08:40:00 -0400
Received: from mga02.intel.com ([134.134.136.20]:13363 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726291AbgI1MkA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 08:40:00 -0400
IronPort-SDR: zTE+w2IbjUHC6vXmrN6XbjwRMWsLV8fbtZX8Zla/COBu1pIE9xMubHPEE+qUZs8pHq8AYMQETN
 G4oX4iVZXgug==
X-IronPort-AV: E=McAfee;i="6000,8403,9757"; a="149647992"
X-IronPort-AV: E=Sophos;i="5.77,313,1596524400"; 
   d="scan'208";a="149647992"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2020 05:40:00 -0700
IronPort-SDR: 8zmYw9uNDCISin84kNa2f60EZssACxetV8oBjInFJBtDv5bXAwhhEyweBdIQMJ1HGX8kwMTt5F
 BrLY9zfDLBPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,313,1596524400"; 
   d="scan'208";a="488562582"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga005.jf.intel.com with ESMTP; 28 Sep 2020 05:40:00 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [RESEND PATCH 1/2] perf/x86/intel: Add Jasper Lake support
Date:   Mon, 28 Sep 2020 05:30:41 -0700
Message-Id: <1601296242-32763-1-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The Jasper Lake processor is also a Tremont microarchitecture. From the
perspective of Intel PMU, there is nothing changed compared with
Elkhart Lake.
Share the perf code with Elkhart Lake.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index c72e490..75dea67 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5135,6 +5135,7 @@ __init int intel_pmu_init(void)
 
 	case INTEL_FAM6_ATOM_TREMONT_D:
 	case INTEL_FAM6_ATOM_TREMONT:
+	case INTEL_FAM6_ATOM_TREMONT_L:
 		x86_pmu.late_ack = true;
 		memcpy(hw_cache_event_ids, glp_hw_cache_event_ids,
 		       sizeof(hw_cache_event_ids));
-- 
2.7.4

