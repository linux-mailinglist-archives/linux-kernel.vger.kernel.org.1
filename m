Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1202F74FB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 10:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730131AbhAOJLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 04:11:37 -0500
Received: from mga11.intel.com ([192.55.52.93]:49684 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727170AbhAOJL3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 04:11:29 -0500
IronPort-SDR: El5BhExyKHDp9JVWI/vSjM5tzLkteg0VFOU/CCLkOh+HONkgutF4JIA9EdQ2Nh/zqK67/g4PY2
 MCO9lXdAbM9g==
X-IronPort-AV: E=McAfee;i="6000,8403,9864"; a="175016669"
X-IronPort-AV: E=Sophos;i="5.79,349,1602572400"; 
   d="scan'208";a="175016669"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2021 01:10:44 -0800
IronPort-SDR: Ar+mDOeshHLj+0KVD97/iQaLwuuuaOKpLyNAo4FUrOsHZ4LoqJ9fCwG7YUb7IsXNzyfPRtNxDN
 HibI49tWilUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,349,1602572400"; 
   d="scan'208";a="382597777"
Received: from power-sh.sh.intel.com ([10.239.48.130])
  by orsmga008.jf.intel.com with ESMTP; 15 Jan 2021 01:10:41 -0800
From:   Zhang Rui <rui.zhang@intel.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org
Cc:     mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        kan.liang@linux.intel.com, ak@linux.intel.com
Subject: [PATCH 1/3] perf/x86/rapl: Add msr mask support
Date:   Fri, 15 Jan 2021 17:22:06 +0800
Message-Id: <20210115092208.20866-1-rui.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some cases, when probing a perf MSR, we're probing certain bits of the
MSR instead of the whole register, thus only these bits should be checked.

For example, for RAPL ENERGY_STATUS MSR, only the lower 32 bits represents
the energy counter, and the higher 32bits are reserved.

Introduce a new mask field in struct perf_msr to allow probing certain
bits of a MSR.

This change is transparent to the current perf_msr_probe() users.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
---
 arch/x86/events/probe.c | 5 ++++-
 arch/x86/events/probe.h | 7 ++++---
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/probe.c b/arch/x86/events/probe.c
index 136a1e847254..a0a19c404cb5 100644
--- a/arch/x86/events/probe.c
+++ b/arch/x86/events/probe.c
@@ -28,6 +28,7 @@ perf_msr_probe(struct perf_msr *msr, int cnt, bool zero, void *data)
 	for (bit = 0; bit < cnt; bit++) {
 		if (!msr[bit].no_check) {
 			struct attribute_group *grp = msr[bit].grp;
+			u64 mask;
 
 			/* skip entry with no group */
 			if (!grp)
@@ -44,8 +45,10 @@ perf_msr_probe(struct perf_msr *msr, int cnt, bool zero, void *data)
 			/* Virt sucks; you cannot tell if a R/O MSR is present :/ */
 			if (rdmsrl_safe(msr[bit].msr, &val))
 				continue;
+
+			mask = msr[bit].mask ? msr[bit].mask : U64_MAX;
 			/* Disable zero counters if requested. */
-			if (!zero && !val)
+			if (!zero && !(val & mask))
 				continue;
 
 			grp->is_visible = NULL;
diff --git a/arch/x86/events/probe.h b/arch/x86/events/probe.h
index 4c8e0afc5fb5..261b9bda24e3 100644
--- a/arch/x86/events/probe.h
+++ b/arch/x86/events/probe.h
@@ -4,10 +4,11 @@
 #include <linux/sysfs.h>
 
 struct perf_msr {
-	u64			  msr;
-	struct attribute_group	 *grp;
+	u64			msr;
+	struct attribute_group	*grp;
 	bool			(*test)(int idx, void *data);
-	bool			  no_check;
+	bool			no_check;
+	u64			mask;
 };
 
 unsigned long
-- 
2.17.1

