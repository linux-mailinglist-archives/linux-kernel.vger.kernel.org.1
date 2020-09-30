Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F336927DE5A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 04:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729512AbgI3CNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 22:13:24 -0400
Received: from mga02.intel.com ([134.134.136.20]:21945 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729322AbgI3CNY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 22:13:24 -0400
IronPort-SDR: +6sorWsdRE4X4Lz1oMWD7s6AgZYRshBq2cZxIDAu5kCQhePMg0uwlz3ZUKHkBnRlFqFt636tTf
 9tbdjy+KCHEw==
X-IronPort-AV: E=McAfee;i="6000,8403,9759"; a="149992004"
X-IronPort-AV: E=Sophos;i="5.77,320,1596524400"; 
   d="scan'208";a="149992004"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2020 19:13:21 -0700
IronPort-SDR: 02JeEEdObr6oqAev+KYol8agpx3MuvpHLIsnHLaJjGBZOF2SFVz9Di1xcuC7Zz8KSmkDxRcl22
 9WlR5q7uTC6g==
X-IronPort-AV: E=Sophos;i="5.77,320,1596524400"; 
   d="scan'208";a="457486648"
Received: from agluck-desk2.sc.intel.com ([10.3.52.68])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2020 19:13:21 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Youquan Song <youquan.song@intel.com>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] x86/mce: Add Skylake quirk for patrol scrub reported errors
Date:   Tue, 29 Sep 2020 19:13:12 -0700
Message-Id: <20200930021313.31810-2-tony.luck@intel.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200930021313.31810-1-tony.luck@intel.com>
References: <20200927221917.GB4746@zn.tnic>
 <20200930021313.31810-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@alien8.de>

The patrol scrubber in Skylake and Cascade Lake systems can be configured
to report uncorrected errors using a special signature in the machine
check bank and to signal using CMCI instead of machine check.

Update the severity calculation mechanism to allow specifying the model,
minimum stepping and range of machine check bank numbers.

Add a new rule to detect the special signature (on model 0x55, stepping
>=4 in any of the memory controller banks).

Suggested-by: Youquan Song <youquan.song@intel.com>
Rewritten-by: Borislav Petkov <bp@alien8.de>
Co-developed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/mce/severity.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
index e1da619add19..567ce09a0286 100644
--- a/arch/x86/kernel/cpu/mce/severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -9,9 +9,11 @@
 #include <linux/seq_file.h>
 #include <linux/init.h>
 #include <linux/debugfs.h>
-#include <asm/mce.h>
 #include <linux/uaccess.h>
 
+#include <asm/mce.h>
+#include <asm/intel-family.h>
+
 #include "internal.h"
 
 /*
@@ -40,9 +42,14 @@ static struct severity {
 	unsigned char context;
 	unsigned char excp;
 	unsigned char covered;
+	unsigned char cpu_model;
+	unsigned char cpu_minstepping;
+	unsigned char bank_lo, bank_hi;
 	char *msg;
 } severities[] = {
 #define MCESEV(s, m, c...) { .sev = MCE_ ## s ## _SEVERITY, .msg = m, ## c }
+#define BANK_RANGE(l, h) .bank_lo = l, .bank_hi = h
+#define MODEL_STEPPING(m, s) .cpu_model = m, .cpu_minstepping = s
 #define  KERNEL		.context = IN_KERNEL
 #define  USER		.context = IN_USER
 #define  KERNEL_RECOV	.context = IN_KERNEL_RECOV
@@ -97,7 +104,6 @@ static struct severity {
 		KEEP, "Corrected error",
 		NOSER, BITCLR(MCI_STATUS_UC)
 		),
-
 	/*
 	 * known AO MCACODs reported via MCE or CMC:
 	 *
@@ -113,6 +119,18 @@ static struct severity {
 		AO, "Action optional: last level cache writeback error",
 		SER, MASK(MCI_UC_AR|MCACOD, MCI_STATUS_UC|MCACOD_L3WB)
 		),
+	/*
+	 * Quirk for Skylake/Cascade Lake. Patrol scrubber may be configured
+	 * to report uncorrected errors using CMCI with a special signature.
+	 * UC=0, MSCOD=0x0010, MCACOD=binary(000X 0000 1100 XXXX) reported
+	 * in one of the memory controller banks.
+	 * Set severity to "AO" for same action as normal patrol scrub error.
+	 */
+	MCESEV(
+		AO, "Uncorrected Patrol Scrub Error",
+		SER, MASK(MCI_STATUS_UC|MCI_ADDR|0xffffeff0, MCI_ADDR|0x001000c0),
+		MODEL_STEPPING(INTEL_FAM6_SKYLAKE_X, 4), BANK_RANGE(13, 18)
+	),
 
 	/* ignore OVER for UCNA */
 	MCESEV(
@@ -324,6 +342,12 @@ static int mce_severity_intel(struct mce *m, int tolerant, char **msg, bool is_e
 			continue;
 		if (s->excp && excp != s->excp)
 			continue;
+		if (s->cpu_model && boot_cpu_data.x86_model != s->cpu_model)
+			continue;
+		if (s->cpu_minstepping && boot_cpu_data.x86_stepping < s->cpu_minstepping)
+			continue;
+		if (s->bank_lo && (m->bank < s->bank_lo || m->bank > s->bank_hi))
+			continue;
 		if (msg)
 			*msg = s->msg;
 		s->covered = 1;
-- 
2.21.1

