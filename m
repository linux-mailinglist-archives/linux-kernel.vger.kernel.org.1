Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB3AF27AF21
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 15:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbgI1NeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 09:34:15 -0400
Received: from mga17.intel.com ([192.55.52.151]:54763 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726420AbgI1NeO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 09:34:14 -0400
IronPort-SDR: vxSnopkENrAIPwR3gVjNKFVc1jz+cJuhZ7vUaqOEkYISK7q1ujaq+sJLJbEOvScIqhWo3IeelY
 cI3PDUkgz6SA==
X-IronPort-AV: E=McAfee;i="6000,8403,9757"; a="142009390"
X-IronPort-AV: E=Sophos;i="5.77,313,1596524400"; 
   d="scan'208";a="142009390"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2020 06:34:14 -0700
IronPort-SDR: eKLQ/P/wadyTCwf6Sf93+dNynUTjpUqWprvFvtoSu8GPkZe5NHOi5b0xq4sjBLeEDL6qDwN5Wq
 sRzAI4QcmRJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,313,1596524400"; 
   d="scan'208";a="456825098"
Received: from unknown (HELO labuser-Ice-Lake-Client-Platform.jf.intel.com) ([10.54.55.65])
  by orsmga004.jf.intel.com with ESMTP; 28 Sep 2020 06:34:14 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH] perf/x86/intel/uncore: Fix the scale of the IMC free-running events
Date:   Mon, 28 Sep 2020 06:32:40 -0700
Message-Id: <20200928133240.12977-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The "MiB" result of the IMC free-running bandwidth events,
uncore_imc_free_running/read/ and uncore_imc_free_running/write/ are 16
times too small.

The "MiB" value equals the raw IMC free-running bandwidth counter value
times a "scale" which is inaccurate.

The IMC free-running bandwidth events should be incremented per 64B
cache line, not DWs (4 bytes). The "scale" should be 6.103515625e-5.
Fix the "scale" for both Snow Ridge and Ice Lake.

Fixes: 2b3b76b5ec67 ("perf/x86/intel/uncore: Add Ice Lake server uncore support")
Fixes: ee49532b38dd ("perf/x86/intel/uncore: Add IMC uncore support for Snow Ridge")
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/uncore_snbep.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 495056fbc273..c3818bfc66a9 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -4804,10 +4804,10 @@ static struct uncore_event_desc snr_uncore_imc_freerunning_events[] = {
 	INTEL_UNCORE_EVENT_DESC(dclk,		"event=0xff,umask=0x10"),
 
 	INTEL_UNCORE_EVENT_DESC(read,		"event=0xff,umask=0x20"),
-	INTEL_UNCORE_EVENT_DESC(read.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(read.scale,	"6.103515625e-5"),
 	INTEL_UNCORE_EVENT_DESC(read.unit,	"MiB"),
 	INTEL_UNCORE_EVENT_DESC(write,		"event=0xff,umask=0x21"),
-	INTEL_UNCORE_EVENT_DESC(write.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(write.scale,	"6.103515625e-5"),
 	INTEL_UNCORE_EVENT_DESC(write.unit,	"MiB"),
 	{ /* end: all zeroes */ },
 };
@@ -5265,17 +5265,17 @@ static struct uncore_event_desc icx_uncore_imc_freerunning_events[] = {
 	INTEL_UNCORE_EVENT_DESC(dclk,			"event=0xff,umask=0x10"),
 
 	INTEL_UNCORE_EVENT_DESC(read,			"event=0xff,umask=0x20"),
-	INTEL_UNCORE_EVENT_DESC(read.scale,		"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(read.scale,		"6.103515625e-5"),
 	INTEL_UNCORE_EVENT_DESC(read.unit,		"MiB"),
 	INTEL_UNCORE_EVENT_DESC(write,			"event=0xff,umask=0x21"),
-	INTEL_UNCORE_EVENT_DESC(write.scale,		"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(write.scale,		"6.103515625e-5"),
 	INTEL_UNCORE_EVENT_DESC(write.unit,		"MiB"),
 
 	INTEL_UNCORE_EVENT_DESC(ddrt_read,		"event=0xff,umask=0x30"),
-	INTEL_UNCORE_EVENT_DESC(ddrt_read.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(ddrt_read.scale,	"6.103515625e-5"),
 	INTEL_UNCORE_EVENT_DESC(ddrt_read.unit,		"MiB"),
 	INTEL_UNCORE_EVENT_DESC(ddrt_write,		"event=0xff,umask=0x31"),
-	INTEL_UNCORE_EVENT_DESC(ddrt_write.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(ddrt_write.scale,	"6.103515625e-5"),
 	INTEL_UNCORE_EVENT_DESC(ddrt_write.unit,	"MiB"),
 	{ /* end: all zeroes */ },
 };
-- 
2.17.1

