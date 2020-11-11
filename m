Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5651B2AF8E2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 20:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbgKKTVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 14:21:25 -0500
Received: from mga09.intel.com ([134.134.136.24]:50570 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727073AbgKKTVR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 14:21:17 -0500
IronPort-SDR: gH2Nskzehx1mU62mqB9/gA1CpKxYaLHBr/UOdulysLRHSKwbtKdSXf2peJi1xTP9PFkX2ldn1/
 PLJaJ0gt3Gfg==
X-IronPort-AV: E=McAfee;i="6000,8403,9802"; a="170367984"
X-IronPort-AV: E=Sophos;i="5.77,470,1596524400"; 
   d="scan'208";a="170367984"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2020 11:21:17 -0800
IronPort-SDR: iXtFreZNQGM5+LD/hopyLhAFay2HSFvITb8fMSsOQSaWV6UqDZDHTdGryZB9W8z4gVO4c2Z3kN
 FCjSbnI28xiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,470,1596524400"; 
   d="scan'208";a="354942665"
Received: from otcwcpicx6.sc.intel.com ([172.25.55.29])
  by orsmga008.jf.intel.com with ESMTP; 11 Nov 2020 11:21:16 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Borislav Petkov" <bp@alien8.de>, "Ingo Molnar" <mingo@redhat.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Tony Luck" <tony.luck@intel.com>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        "Xiaoyao Li " <xiaoyao.li@intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        "x86" <x86@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v2 4/4] Documentation/admin-guide: Change doc for split_lock_detect parameter
Date:   Wed, 11 Nov 2020 19:20:48 +0000
Message-Id: <20201111192048.2602065-5-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201111192048.2602065-1-fenghua.yu@intel.com>
References: <20201111192048.2602065-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since #DB for bus lock detect changes the split_lock_detect parameter,
update the documentation for the changes.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
Change Log:
v1:
- Fix a few wording issues (Randy).

RFC v2:
- Simplify the documentation (Randy).

 .../admin-guide/kernel-parameters.txt         | 30 +++++++++++++++----
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 526d65d8573a..215e119f6ca7 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5044,27 +5044,45 @@
 	spia_peddr=
 
 	split_lock_detect=
-			[X86] Enable split lock detection
+			[X86] Enable split lock detection or bus lock detection
 
 			When enabled (and if hardware support is present), atomic
 			instructions that access data across cache line
-			boundaries will result in an alignment check exception.
+			boundaries will result in an alignment check exception
+			for split lock detection or a debug exception for
+			bus lock detection.
 
 			off	- not enabled
 
-			warn	- the kernel will emit rate limited warnings
+			warn	- the kernel will emit rate-limited warnings
 				  about applications triggering the #AC
-				  exception. This mode is the default on CPUs
-				  that supports split lock detection.
+				  exception or the #DB exception. This mode is
+				  the default on CPUs that support split lock
+				  detection or bus lock detection. Default
+				  behavior is by #DB if both features are
+				  enabled in hardware.
 
 			fatal	- the kernel will send SIGBUS to applications
-				  that trigger the #AC exception.
+				  that trigger the #AC exception or the #DB
+				  exception. Default behavior is by #AC
+				  if both features are enabled in hardware.
+
+			ratelimit:N -
+				  Set rate limit to N bus locks per second
+				  for bus lock detection. 0 < N <= HZ/2 and
+				  N is approximate. Only applied to non-root
+				  users.
+
+				  N/A for split lock detection.
 
 			If an #AC exception is hit in the kernel or in
 			firmware (i.e. not while executing in user mode)
 			the kernel will oops in either "warn" or "fatal"
 			mode.
 
+			#DB exception for bus lock is triggered only when
+			CPL > 0.
+
 	srbds=		[X86,INTEL]
 			Control the Special Register Buffer Data Sampling
 			(SRBDS) mitigation.
-- 
2.29.2

