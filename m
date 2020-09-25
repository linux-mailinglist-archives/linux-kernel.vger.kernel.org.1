Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7F9278B29
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 16:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729056AbgIYOqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 10:46:38 -0400
Received: from mga17.intel.com ([192.55.52.151]:53612 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728436AbgIYOqi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 10:46:38 -0400
IronPort-SDR: WK5Koke1kmSHVWGcNvCbmhQEw33HvHgDIx2aW3vq1x6P34V0J8CtJx/g4y6eC0io0DXi3oFbQA
 B3v/r2Pq4iAw==
X-IronPort-AV: E=McAfee;i="6000,8403,9754"; a="141546632"
X-IronPort-AV: E=Sophos;i="5.77,302,1596524400"; 
   d="scan'208";a="141546632"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2020 06:50:28 -0700
IronPort-SDR: aIC3Frnz4ck9SmTtRmRaSj3bz2RFRGSWVMCEfgblm0CTqtgff2XmMTsJ3ewUVFWTkQGgz+B6zq
 oXpDcY3mZgvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,302,1596524400"; 
   d="scan'208";a="310824559"
Received: from unknown (HELO labuser-Ice-Lake-Client-Platform.jf.intel.com) ([10.54.55.65])
  by orsmga006.jf.intel.com with ESMTP; 25 Sep 2020 06:50:28 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, asit.k.mallick@intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 1/3] perf/x86/intel/uncore: Split the Ice Lake and Tiger Lake MSR uncore support
Date:   Fri, 25 Sep 2020 06:49:03 -0700
Message-Id: <20200925134905.8839-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Previously, the MSR uncore for the Ice Lake and Tiger Lake are
identical. The code path is shared. However, with recent update, the
global MSR_UNC_PERF_GLOBAL_CTRL register and ARB uncore unit are changed
for the Ice Lake. Split the Ice Lake and Tiger Lake MSR uncore support.

The changes only impact the MSR ops() and the ARB uncore unit. Other
codes can still be shared between the Ice Lake and the Tiger Lake.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/uncore.c     |  4 ++--
 arch/x86/events/intel/uncore.h     |  1 +
 arch/x86/events/intel/uncore_snb.c | 16 ++++++++++++++++
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index d5c6d3b340c5..c999945bfda1 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1478,12 +1478,12 @@ static const struct intel_uncore_init_fun icl_uncore_init __initconst = {
 };
 
 static const struct intel_uncore_init_fun tgl_uncore_init __initconst = {
-	.cpu_init = icl_uncore_cpu_init,
+	.cpu_init = tgl_uncore_cpu_init,
 	.mmio_init = tgl_uncore_mmio_init,
 };
 
 static const struct intel_uncore_init_fun tgl_l_uncore_init __initconst = {
-	.cpu_init = icl_uncore_cpu_init,
+	.cpu_init = tgl_uncore_cpu_init,
 	.mmio_init = tgl_l_uncore_mmio_init,
 };
 
diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index 105fdc69825e..267f46cb487b 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -567,6 +567,7 @@ void snb_uncore_cpu_init(void);
 void nhm_uncore_cpu_init(void);
 void skl_uncore_cpu_init(void);
 void icl_uncore_cpu_init(void);
+void tgl_uncore_cpu_init(void);
 void tgl_uncore_mmio_init(void);
 void tgl_l_uncore_mmio_init(void);
 int snb_pci2phy_map_init(int devid);
diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
index cb94ba86efd2..d2d43b6d6946 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -377,6 +377,22 @@ void icl_uncore_cpu_init(void)
 	snb_uncore_arb.ops = &skl_uncore_msr_ops;
 }
 
+static struct intel_uncore_type *tgl_msr_uncores[] = {
+	&icl_uncore_cbox,
+	&snb_uncore_arb,
+	&icl_uncore_clockbox,
+	NULL,
+};
+
+void tgl_uncore_cpu_init(void)
+{
+	uncore_msr_uncores = tgl_msr_uncores;
+	icl_uncore_cbox.num_boxes = icl_get_cbox_num();
+	icl_uncore_cbox.ops = &skl_uncore_msr_ops;
+	icl_uncore_clockbox.ops = &skl_uncore_msr_ops;
+	snb_uncore_arb.ops = &skl_uncore_msr_ops;
+}
+
 enum {
 	SNB_PCI_UNCORE_IMC,
 };
-- 
2.17.1

