Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 431E7285760
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 05:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbgJGDvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 23:51:14 -0400
Received: from mga09.intel.com ([134.134.136.24]:23340 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726730AbgJGDvI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 23:51:08 -0400
IronPort-SDR: wIbNe+cJfEvxYdfKMdzrfjC95k7pkZBEWOf5ycS+C/ttsOpJEhoYRSQ9y/7V2REGVZ5IoW8rD4
 HozaEwpC5GDw==
X-IronPort-AV: E=McAfee;i="6000,8403,9766"; a="164942590"
X-IronPort-AV: E=Sophos;i="5.77,345,1596524400"; 
   d="scan'208";a="164942590"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2020 20:51:06 -0700
IronPort-SDR: 5dYsJNbgj56RZVk66SQIJ9CcP4NHYMJPmmtitErelUn82UhPezGH86lrPLZOyB/S7QGW+5mSj3
 GvUnsNyThd6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,345,1596524400"; 
   d="scan'208";a="461144889"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 06 Oct 2020 20:51:06 -0700
Received: from debox1-desk2.jf.intel.com (debox1-desk2.jf.intel.com [10.54.75.16])
        by linux.intel.com (Postfix) with ESMTP id B7007580867;
        Tue,  6 Oct 2020 20:51:06 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     irenic.rajneesh@gmail.com, david.e.box@intel.com,
        dvhart@infradead.org, andy@infradead.org, gayatri.kammela@intel.com
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Rui Zhang <rui.zhang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>
Subject: [PATCH 1/4] platform/x86: intel_pmc_core: Clean up: Remove the duplicate comments and reorganize
Date:   Tue,  6 Oct 2020 20:51:05 -0700
Message-Id: <20201007035108.31078-2-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201007035108.31078-1-david.e.box@linux.intel.com>
References: <20201007035108.31078-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gayatri Kammela <gayatri.kammela@intel.com>

Some of the Cannon Lake PCH IPs are reused by most of the platforms
such as Ice Lake, Tiger Lake, Elkhart Lake, Jasper Lake and can be
reused by future platforms as well. The same was mentioned via comments
not once but twice in an array of bit map structs for Cannon Lake
(cnp_pfear_map).

Hence, remove the duplicate comments and reorganize them.

Cc: Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: David E. Box <david.e.box@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Rui Zhang <rui.zhang@intel.com>
Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Gayatri Kammela <gayatri.kammela@intel.com>
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 drivers/platform/x86/intel_pmc_core.c | 32 +++++++++++++++++----------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
index 338ea5222555..d959fa698ec5 100644
--- a/drivers/platform/x86/intel_pmc_core.c
+++ b/drivers/platform/x86/intel_pmc_core.c
@@ -118,6 +118,10 @@ static const struct pmc_bit_map spt_pfear_map[] = {
 };
 
 static const struct pmc_bit_map *ext_spt_pfear_map[] = {
+	/*
+	 * Check intel_pmc_core_ids[] users of spt_reg_map for
+	 * a list of core SoCs using this.
+	 */
 	spt_pfear_map,
 	NULL
 };
@@ -166,7 +170,6 @@ static const struct pmc_reg_map spt_reg_map = {
 
 /* Cannon Lake: PGD PFET Enable Ack Status Register(s) bitmap */
 static const struct pmc_bit_map cnp_pfear_map[] = {
-	/* Reserved for Cannon Lake but valid for Comet Lake */
 	{"PMC",                 BIT(0)},
 	{"OPI-DMI",             BIT(1)},
 	{"SPI/eSPI",            BIT(2)},
@@ -192,10 +195,6 @@ static const struct pmc_bit_map cnp_pfear_map[] = {
 	{"SDX",                 BIT(4)},
 	{"SPE",                 BIT(5)},
 	{"Fuse",                BIT(6)},
-	/*
-	 * Reserved for Cannon Lake but valid for Ice Lake, Comet Lake,
-	 * Tiger Lake, Elkhart Lake and Jasper Lake.
-	 */
 	{"SBR8",		BIT(7)},
 
 	{"CSME_FSC",            BIT(0)},
@@ -239,10 +238,6 @@ static const struct pmc_bit_map cnp_pfear_map[] = {
 	{"HDA_PGD4",            BIT(2)},
 	{"HDA_PGD5",            BIT(3)},
 	{"HDA_PGD6",            BIT(4)},
-	/*
-	 * Reserved for Cannon Lake but valid for Ice Lake, Comet Lake,
-	 * Tiger Lake, ELkhart Lake and Jasper Lake.
-	 */
 	{"PSF6",		BIT(5)},
 	{"PSF7",		BIT(6)},
 	{"PSF8",		BIT(7)},
@@ -250,12 +245,15 @@ static const struct pmc_bit_map cnp_pfear_map[] = {
 };
 
 static const struct pmc_bit_map *ext_cnp_pfear_map[] = {
+	/*
+	 * Check intel_pmc_core_ids[] users of cnp_reg_map for
+	 * a list of core SoCs using this.
+	 */
 	cnp_pfear_map,
 	NULL
 };
 
 static const struct pmc_bit_map icl_pfear_map[] = {
-	/* Ice Lake and Jasper Lake generation onwards only */
 	{"RES_65",		BIT(0)},
 	{"RES_66",		BIT(1)},
 	{"RES_67",		BIT(2)},
@@ -268,13 +266,16 @@ static const struct pmc_bit_map icl_pfear_map[] = {
 };
 
 static const struct pmc_bit_map *ext_icl_pfear_map[] = {
+	/*
+	 * Check intel_pmc_core_ids[] users of icl_reg_map for
+	 * a list of core SoCs using this.
+	 */
 	cnp_pfear_map,
 	icl_pfear_map,
 	NULL
 };
 
 static const struct pmc_bit_map tgl_pfear_map[] = {
-	/* Tiger Lake and Elkhart Lake generation onwards only */
 	{"PSF9",		BIT(0)},
 	{"RES_66",		BIT(1)},
 	{"RES_67",		BIT(2)},
@@ -286,6 +287,10 @@ static const struct pmc_bit_map tgl_pfear_map[] = {
 };
 
 static const struct pmc_bit_map *ext_tgl_pfear_map[] = {
+	/*
+	 * Check intel_pmc_core_ids[] users of tgl_reg_map for
+	 * a list of core SoCs using this.
+	 */
 	cnp_pfear_map,
 	tgl_pfear_map,
 	NULL
@@ -369,7 +374,10 @@ static const struct pmc_bit_map cnp_ltr_show_map[] = {
 	{"ISH",			CNP_PMC_LTR_ISH},
 	{"UFSX2",		CNP_PMC_LTR_UFSX2},
 	{"EMMC",		CNP_PMC_LTR_EMMC},
-	/* Reserved for Cannon Lake but valid for Ice Lake */
+	/*
+	 * Check intel_pmc_core_ids[] users of cnp_reg_map for
+	 * a list of core SoCs using this.
+	 */
 	{"WIGIG",		ICL_PMC_LTR_WIGIG},
 	/* Below two cannot be used for LTR_IGNORE */
 	{"CURRENT_PLATFORM",	CNP_PMC_LTR_CUR_PLT},
-- 
2.20.1

