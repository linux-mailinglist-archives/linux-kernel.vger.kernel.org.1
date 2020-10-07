Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB2A628575B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 05:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbgJGDvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 23:51:08 -0400
Received: from mga12.intel.com ([192.55.52.136]:16759 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726709AbgJGDvH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 23:51:07 -0400
IronPort-SDR: bLV2T7iAdhoZzG8vy9tBNdyP6Elxg3ecCo1iB7FfRrUTRLmGEEgPSzyM2Ng6Akb+h464yjfzIL
 fFxZNvJ4ZUMA==
X-IronPort-AV: E=McAfee;i="6000,8403,9766"; a="144198374"
X-IronPort-AV: E=Sophos;i="5.77,345,1596524400"; 
   d="scan'208";a="144198374"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2020 20:51:07 -0700
IronPort-SDR: 8LRSjMClxPmRJWAvKFffCyGSDGt47IIrzB7MNZ1VWFM1nfB5dA4SmFv1DI32LfkF8mHjOESLo6
 6nRPSqb89nZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,345,1596524400"; 
   d="scan'208";a="354717403"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 06 Oct 2020 20:51:06 -0700
Received: from debox1-desk2.jf.intel.com (debox1-desk2.jf.intel.com [10.54.75.16])
        by linux.intel.com (Postfix) with ESMTP id C836D58087A;
        Tue,  6 Oct 2020 20:51:06 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     irenic.rajneesh@gmail.com, david.e.box@intel.com,
        dvhart@infradead.org, andy@infradead.org, gayatri.kammela@intel.com
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Rui Zhang <rui.zhang@intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>
Subject: [PATCH 2/4] platform/x86: intel_pmc_core: Add Intel RocketLake (RKL) support
Date:   Tue,  6 Oct 2020 20:51:06 -0700
Message-Id: <20201007035108.31078-3-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201007035108.31078-1-david.e.box@linux.intel.com>
References: <20201007035108.31078-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gayatri Kammela <gayatri.kammela@intel.com>

Add RocketLake to the list of the platforms that intel_pmc_core driver
supports for pmc_core device. RocketLake reuses all the TigerLake PCH IPs.

Cc: Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: David E. Box <david.e.box@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Rui Zhang <rui.zhang@intel.com>
Signed-off-by: Gayatri Kammela <gayatri.kammela@intel.com>
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 drivers/platform/x86/intel_pmc_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
index d959fa698ec5..f0347ee8a4d6 100644
--- a/drivers/platform/x86/intel_pmc_core.c
+++ b/drivers/platform/x86/intel_pmc_core.c
@@ -1155,6 +1155,7 @@ static const struct x86_cpu_id intel_pmc_core_ids[] = {
 	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE,		&tgl_reg_map),
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT,	&tgl_reg_map),
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_L,	&icl_reg_map),
+	X86_MATCH_INTEL_FAM6_MODEL(ROCKETLAKE,		&tgl_reg_map),
 	{}
 };
 
-- 
2.20.1

