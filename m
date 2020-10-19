Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FDA8292A8B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 17:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730284AbgJSPgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 11:36:21 -0400
Received: from mga18.intel.com ([134.134.136.126]:27594 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730201AbgJSPgS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 11:36:18 -0400
IronPort-SDR: +qRpG5zdlkC9BSgDYrqLwJz/RQAku7C5nr5zkSeG0ku5TFE9EnyVQ4//kVmtptKatI3xqCNsQK
 KvQApu55Ot0g==
X-IronPort-AV: E=McAfee;i="6000,8403,9778"; a="154839782"
X-IronPort-AV: E=Sophos;i="5.77,394,1596524400"; 
   d="scan'208";a="154839782"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2020 08:36:16 -0700
IronPort-SDR: OCXLXEPBLFLZBtyfAkP+k4y7lqMc6B6l+xCSXZTJcroUTv5CctxrC7AVPnLOIxGCFuG7J4UAr7
 K3SKvhCMWX2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,394,1596524400"; 
   d="scan'208";a="465569439"
Received: from ssp-rkls-cdi470.jf.intel.com ([10.54.55.84])
  by orsmga004.jf.intel.com with ESMTP; 19 Oct 2020 08:36:17 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 3/4] perf/x86/msr: Add Rocket Lake CPU support
Date:   Mon, 19 Oct 2020 08:35:27 -0700
Message-Id: <20201019153528.13850-3-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201019153528.13850-1-kan.liang@linux.intel.com>
References: <20201019153528.13850-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Like Ice Lake and Tiger Lake, PPERF and SMI_COUNT MSRs are also
supported by Rocket Lake.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/msr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/msr.c b/arch/x86/events/msr.c
index 4be8f9cabd07..680404c58cb1 100644
--- a/arch/x86/events/msr.c
+++ b/arch/x86/events/msr.c
@@ -99,6 +99,7 @@ static bool test_intel(int idx, void *data)
 	case INTEL_FAM6_ICELAKE_D:
 	case INTEL_FAM6_TIGERLAKE_L:
 	case INTEL_FAM6_TIGERLAKE:
+	case INTEL_FAM6_ROCKETLAKE:
 		if (idx == PERF_MSR_SMI || idx == PERF_MSR_PPERF)
 			return true;
 		break;
-- 
2.25.1

