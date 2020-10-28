Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 091BA29E306
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 03:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729892AbgJ2Coc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 22:44:32 -0400
Received: from mga14.intel.com ([192.55.52.115]:47178 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726583AbgJ1Ve3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:34:29 -0400
IronPort-SDR: ofYcoGZcB+n8lU0zhvO4SzILSO+F6If3V06yAY1oOOnRf97a/McFv6Vk0IO/7cV2z8w65mur5s
 PtqdskJcjUWA==
X-IronPort-AV: E=McAfee;i="6000,8403,9788"; a="167551732"
X-IronPort-AV: E=Sophos;i="5.77,428,1596524400"; 
   d="scan'208";a="167551732"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2020 13:28:16 -0700
IronPort-SDR: SFG7HTid7wqrQJCsF+ljZA3BpGC2I0gxvYesRLCSYfz7ZV7x10k7ETzDE6B0yrBAJOcv+2d7EX
 pcckhknQkmEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,428,1596524400"; 
   d="scan'208";a="526467877"
Received: from otcwcpicx6.sc.intel.com ([172.25.55.29])
  by fmsmga005.fm.intel.com with ESMTP; 28 Oct 2020 13:28:16 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Borislav Petkov" <bp@alien8.de>, "Ingo Molnar" <mingo@redhat.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Tony Luck" <tony.luck@intel.com>,
        "Christopherson Sean J" <sean.j.christopherson@intel.com>,
        "Ashok Raj" <ashok.raj@intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        "x86" <x86@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH RFC v2 4/4] Documentation: Change doc for split_lock_detect parameter
Date:   Wed, 28 Oct 2020 20:28:04 +0000
Message-Id: <20201028202804.3562179-5-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201028202804.3562179-1-fenghua.yu@intel.com>
References: <20201028202804.3562179-1-fenghua.yu@intel.com>
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
 .../admin-guide/kernel-parameters.txt         | 47 +++++++++++++++----
 1 file changed, 39 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 526d65d8573a..51312484c2b6 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5044,27 +5044,58 @@
 	spia_peddr=
 
 	split_lock_detect=
-			[X86] Enable split lock detection
+			[X86] Enable split lock detection or bus lock detection
 
 			When enabled (and if hardware support is present), atomic
 			instructions that access data across cache line
-			boundaries will result in an alignment check exception.
+			boundaries will result in an alignment check exception
+			for split lock detection or an debug exception for
+			bus lock detection.
 
 			off	- not enabled
 
-			warn	- the kernel will emit rate limited warnings
-				  about applications triggering the #AC
-				  exception. This mode is the default on CPUs
-				  that supports split lock detection.
+			warn	- Default mode.
 
-			fatal	- the kernel will send SIGBUS to applications
-				  that trigger the #AC exception.
+				  If split lock detection is enabled in
+				  hardware, the kernel will emit rate limited
+				  warnings about applications triggering the #AC
+				  exception.
+
+				  If bus lock detection is enabled in hardware,
+				  the kernel will emit rate limited warnings
+				  about applications triggering the #DB
+				  exception.
+
+				  Default behavior is from bus lock detection
+				  if both features are enabled in hardware.
+
+			fatal	- If split lock detection is enabled in
+				  hardware, the kernel will send SIGBUS to
+				  applications that trigger the #AC exception.
+
+				  If bus lock detection is enabled in hardware,
+				  the kernel will send SIGBUS to application
+				  that trigger the #DB exception.
+
+				  Default behavior is from split lock detection
+				  if both are enabled in hardware.
+
+			ratelimit:N
+				  Set rate limit to N bus locks per second
+				  for bus lock detection. 0 < N <= HZ/2 and
+				  N is approximate. Only applied to non root
+				  user.
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
2.29.0

