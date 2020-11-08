Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 890502AA913
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 05:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbgKHE3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 23:29:43 -0500
Received: from mga14.intel.com ([192.55.52.115]:27416 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726607AbgKHE3k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 23:29:40 -0500
IronPort-SDR: G4kjsxqUxWIUIhTqtH0Hhu8RoAU6VZXBex9TLdP3Xote9PmRsrh61lO5Nz8Ant752DP4LbvkBD
 MNVdwFoMK98w==
X-IronPort-AV: E=McAfee;i="6000,8403,9798"; a="168900976"
X-IronPort-AV: E=Sophos;i="5.77,460,1596524400"; 
   d="scan'208";a="168900976"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2020 20:29:38 -0800
IronPort-SDR: 2k7IFovx7mVJVQc/CKRHPIXUnxRtpg+dBWXddR78h33l4Q74BIcw9/en11zhp9DA3VChausuVV
 KeUVHNmim4oQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,460,1596524400"; 
   d="scan'208";a="307244989"
Received: from otcwcpicx6.sc.intel.com ([172.25.55.29])
  by fmsmga008.fm.intel.com with ESMTP; 07 Nov 2020 20:29:38 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Borislav Petkov" <bp@alien8.de>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Tony Luck" <tony.luck@intel.com>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        "Xiaoyao Li " <xiaoyao.li@intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        "x86" <x86@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH 4/4] Documentation/admin-guide: Change doc for split_lock_detect parameter
Date:   Sun,  8 Nov 2020 04:29:18 +0000
Message-Id: <20201108042918.1011889-5-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201108042918.1011889-1-fenghua.yu@intel.com>
References: <20201108042918.1011889-1-fenghua.yu@intel.com>
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

