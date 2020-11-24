Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF4712C3237
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 21:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728616AbgKXUw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 15:52:58 -0500
Received: from mga01.intel.com ([192.55.52.88]:40533 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728587AbgKXUw4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 15:52:56 -0500
IronPort-SDR: gKf9taLMljM48bu1FRHrkl2F642EVYHtEIAXOXlpg8+qgNtbkhUpfc/kJpiUMqy/7DYeLphZHO
 OVjXKN57d7dQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9815"; a="190147117"
X-IronPort-AV: E=Sophos;i="5.78,367,1599548400"; 
   d="scan'208";a="190147117"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2020 12:52:54 -0800
IronPort-SDR: GhUo2tVYCTZxBio6KAnmPa8VQVro2QeDml3vPqi+B1VJWIluDS8TO5ZUPYqEo4CnlojkHA/PDv
 WLMbNJ//CvEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,367,1599548400"; 
   d="scan'208";a="432729551"
Received: from otcwcpicx6.sc.intel.com ([172.25.55.29])
  by fmsmga001.fm.intel.com with ESMTP; 24 Nov 2020 12:52:54 -0800
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
Subject: [PATCH v4 4/4] Documentation/admin-guide: Change doc for split_lock_detect parameter
Date:   Tue, 24 Nov 2020 20:52:45 +0000
Message-Id: <20201124205245.4164633-5-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201124205245.4164633-1-fenghua.yu@intel.com>
References: <20201124205245.4164633-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since #DB for bus lock detect changes the split_lock_detect parameter,
update the documentation for the changes.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
---
Change Log:
v4:
- Fix a ratelimit wording issue in the doc (Randy).
- Patch 4 is acked by Randy (Randy).

v3:
- Enable Bus Lock Detection when fatal to handle bus lock from non-WB
  (PeterZ).

v1:
- Fix a few wording issues (Randy).

RFC v2:
- Simplify the documentation (Randy).

 .../admin-guide/kernel-parameters.txt         | 30 +++++++++++++++----
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 44fde25bb221..28228539b02a 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5051,27 +5051,45 @@
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
+				  exception. If both features are enabled in
+				  hardware, split lock triggers #AC and bus
+				  lock from non-WB triggers #DB.
+
+			ratelimit:N -
+				  Set rate limit to N bus locks per second
+				  for bus lock detection. 0 < N <= HZ/2.
+				  Only applied to non-root users.
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

