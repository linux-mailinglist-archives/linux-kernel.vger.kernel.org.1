Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3291C285762
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 05:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbgJGDvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 23:51:19 -0400
Received: from mga12.intel.com ([192.55.52.136]:16759 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727234AbgJGDvI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 23:51:08 -0400
IronPort-SDR: 8Bwh/6b+u9E0Daz09RUlJ75xEdRmUmfa7Oi1r/v2bksZv/GXrbHwlhk1MlracvaNanBgIcplSF
 /Ilca/OQfctw==
X-IronPort-AV: E=McAfee;i="6000,8403,9766"; a="144198375"
X-IronPort-AV: E=Sophos;i="5.77,345,1596524400"; 
   d="scan'208";a="144198375"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2020 20:51:07 -0700
IronPort-SDR: G19farci06MZvGQDIeLpKWrC61pIqRDNsZ2sNMiI2sZyJjTcxjMBt3tDn4n+Q46LRJKaOYvRob
 TZGSmfehegnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,345,1596524400"; 
   d="scan'208";a="354717405"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 06 Oct 2020 20:51:06 -0700
Received: from debox1-desk2.jf.intel.com (debox1-desk2.jf.intel.com [10.54.75.16])
        by linux.intel.com (Postfix) with ESMTP id D9ECD580867;
        Tue,  6 Oct 2020 20:51:06 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     irenic.rajneesh@gmail.com, david.e.box@intel.com,
        dvhart@infradead.org, andy@infradead.org, gayatri.kammela@intel.com
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>
Subject: [PATCH 3/4] platform/x86: intel_pmc_core: fix: Replace dev_dbg macro with dev_info()
Date:   Tue,  6 Oct 2020 20:51:07 -0700
Message-Id: <20201007035108.31078-4-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201007035108.31078-1-david.e.box@linux.intel.com>
References: <20201007035108.31078-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gayatri Kammela <gayatri.kammela@intel.com>

dev_dbg macro is used to dump the debug registers in resume from an S0ix
failure. However, when CONFIG_DYNAMIC_DEBUG is not set, the user may not be
able to find the debug dump on an S0ix failure which defeats the purpose.
The output of these messages is already controlled by a module parameter,
warn_on_s0ix_failures, making it a 2 step process to enable anyway when
CONFIG_DYNAMIC_DEBUG is set.

Hence, replace dev_dbg with dev_info, allowing the control of the messages
solely through the module parameter which is N by default.

Fixes commit 913f984a8347 ("platform/x86: intel_pmc_core: Add an
additional parameter to pmc_core_lpm_display()")

Cc: Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: David E. Box <david.e.box@linux.intel.com>
Signed-off-by: Gayatri Kammela <gayatri.kammela@intel.com>
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 drivers/platform/x86/intel_pmc_core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
index f0347ee8a4d6..a2d6f9a66428 100644
--- a/drivers/platform/x86/intel_pmc_core.c
+++ b/drivers/platform/x86/intel_pmc_core.c
@@ -636,7 +636,7 @@ static void pmc_core_slps0_display(struct pmc_dev *pmcdev, struct device *dev,
 		offset += 4;
 		while (map->name) {
 			if (dev)
-				dev_dbg(dev, "SLP_S0_DBG: %-32s\tState: %s\n",
+				dev_info(dev, "SLP_S0_DBG: %-32s\tState: %s\n",
 					map->name,
 					data & map->bit_mask ? "Yes" : "No");
 			if (s)
@@ -679,7 +679,7 @@ static void pmc_core_lpm_display(struct pmc_dev *pmcdev, struct device *dev,
 
 	for (idx = 0; idx < arr_size; idx++) {
 		if (dev)
-			dev_dbg(dev, "\nLPM_%s_%d:\t0x%x\n", str, idx,
+			dev_info(dev, "\nLPM_%s_%d:\t0x%x\n", str, idx,
 				lpm_regs[idx]);
 		if (s)
 			seq_printf(s, "\nLPM_%s_%d:\t0x%x\n", str, idx,
@@ -687,7 +687,7 @@ static void pmc_core_lpm_display(struct pmc_dev *pmcdev, struct device *dev,
 		for (index = 0; maps[idx][index].name && index < len; index++) {
 			bit_mask = maps[idx][index].bit_mask;
 			if (dev)
-				dev_dbg(dev, "%-30s %-30d\n",
+				dev_info(dev, "%-30s %-30d\n",
 					maps[idx][index].name,
 					lpm_regs[idx] & bit_mask ? 1 : 0);
 			if (s)
-- 
2.20.1

