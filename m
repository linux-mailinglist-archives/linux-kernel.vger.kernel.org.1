Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41A312854C0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 00:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbgJFWr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 18:47:27 -0400
Received: from mga06.intel.com ([134.134.136.31]:58474 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726771AbgJFWrS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 18:47:18 -0400
IronPort-SDR: 5VV/tE81a+UyBRolGtnxlOzYp47nWIwC1upwooVkC2g8YBKX5qnFh0Cyo0lFxmdkaphXvrY6k3
 WwQQBNp694GA==
X-IronPort-AV: E=McAfee;i="6000,8403,9766"; a="226322925"
X-IronPort-AV: E=Sophos;i="5.77,343,1596524400"; 
   d="scan'208";a="226322925"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2020 15:47:17 -0700
IronPort-SDR: h8LUdMvKCoU946GVttFz5YaG+eatJicmT6jQ6orrNMZnwLmEZIjFG5o4XZ1TwhJydV1cRdbj5u
 05/CazjyFnDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,343,1596524400"; 
   d="scan'208";a="388105338"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 06 Oct 2020 15:47:17 -0700
Received: from debox1-desk2.jf.intel.com (debox1-desk2.jf.intel.com [10.54.75.16])
        by linux.intel.com (Postfix) with ESMTP id 197B7580867;
        Tue,  6 Oct 2020 15:47:17 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     dvhart@infradead.org, andy@infradead.org, gayatri.kammela@intel.com
Cc:     "David E. Box" <david.e.box@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 1/3] platform/x86: pmc_core: Use descriptive names for LPM registers
Date:   Tue,  6 Oct 2020 15:47:00 -0700
Message-Id: <20201006224702.12697-2-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201006224702.12697-1-david.e.box@linux.intel.com>
References: <20201006224702.12697-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TigerLake Lower Power Mode (LPM) registers are grouped by functionality
but were given simple enumerated names in the code (lpm0, lpm1, ...).
Instead, give the register blocks names that describe their usage.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 drivers/platform/x86/intel_pmc_core.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
index 338ea5222555..ed9fdf7c8928 100644
--- a/drivers/platform/x86/intel_pmc_core.c
+++ b/drivers/platform/x86/intel_pmc_core.c
@@ -409,7 +409,7 @@ static const struct pmc_reg_map icl_reg_map = {
 	.ltr_ignore_max = ICL_NUM_IP_IGN_ALLOWED,
 };
 
-static const struct pmc_bit_map tgl_lpm0_map[] = {
+static const struct pmc_bit_map tgl_clocksource_status_map[] = {
 	{"USB2PLL_OFF_STS",			BIT(18)},
 	{"PCIe/USB3.1_Gen2PLL_OFF_STS",		BIT(19)},
 	{"PCIe_Gen3PLL_OFF_STS",		BIT(20)},
@@ -425,7 +425,7 @@ static const struct pmc_bit_map tgl_lpm0_map[] = {
 	{}
 };
 
-static const struct pmc_bit_map tgl_lpm1_map[] = {
+static const struct pmc_bit_map tgl_power_gating_status_map[] = {
 	{"SPI_PG_STS",				BIT(2)},
 	{"xHCI_PG_STS",				BIT(3)},
 	{"PCIe_Ctrller_A_PG_STS",		BIT(4)},
@@ -453,7 +453,7 @@ static const struct pmc_bit_map tgl_lpm1_map[] = {
 	{}
 };
 
-static const struct pmc_bit_map tgl_lpm2_map[] = {
+static const struct pmc_bit_map tgl_d3_status_map[] = {
 	{"ADSP_D3_STS",				BIT(0)},
 	{"SATA_D3_STS",				BIT(1)},
 	{"xHCI0_D3_STS",			BIT(2)},
@@ -468,7 +468,7 @@ static const struct pmc_bit_map tgl_lpm2_map[] = {
 	{}
 };
 
-static const struct pmc_bit_map tgl_lpm3_map[] = {
+static const struct pmc_bit_map tgl_vnn_req_status_map[] = {
 	{"GPIO_COM0_VNN_REQ_STS",		BIT(1)},
 	{"GPIO_COM1_VNN_REQ_STS",		BIT(2)},
 	{"GPIO_COM2_VNN_REQ_STS",		BIT(3)},
@@ -493,7 +493,7 @@ static const struct pmc_bit_map tgl_lpm3_map[] = {
 	{}
 };
 
-static const struct pmc_bit_map tgl_lpm4_map[] = {
+static const struct pmc_bit_map tgl_vnn_misc_status_map[] = {
 	{"CPU_C10_REQ_STS_0",			BIT(0)},
 	{"PCIe_LPM_En_REQ_STS_3",		BIT(3)},
 	{"ITH_REQ_STS_5",			BIT(5)},
@@ -509,7 +509,7 @@ static const struct pmc_bit_map tgl_lpm4_map[] = {
 	{}
 };
 
-static const struct pmc_bit_map tgl_lpm5_map[] = {
+static const struct pmc_bit_map tgl_signal_status_map[] = {
 	{"LSX_Wake0_En_STS",			BIT(0)},
 	{"LSX_Wake0_Pol_STS",			BIT(1)},
 	{"LSX_Wake1_En_STS",			BIT(2)},
@@ -546,12 +546,12 @@ static const struct pmc_bit_map tgl_lpm5_map[] = {
 };
 
 static const struct pmc_bit_map *tgl_lpm_maps[] = {
-	tgl_lpm0_map,
-	tgl_lpm1_map,
-	tgl_lpm2_map,
-	tgl_lpm3_map,
-	tgl_lpm4_map,
-	tgl_lpm5_map,
+	tgl_clocksource_status_map,
+	tgl_power_gating_status_map,
+	tgl_d3_status_map,
+	tgl_vnn_req_status_map,
+	tgl_vnn_misc_status_map,
+	tgl_signal_status_map,
 	NULL
 };
 
-- 
2.20.1

