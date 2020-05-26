Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59CB21D449F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 May 2020 06:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbgEOEbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 May 2020 00:31:43 -0400
Received: from mga02.intel.com ([134.134.136.20]:30186 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725616AbgEOEbm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 00:31:42 -0400
IronPort-SDR: 2z7VorPfS4cDXRI5RWaC4Ws4J7qPvRimaIjf/uba+HRVzJEjJ/V+zd3X7VpVdVcvt3Rp+immsN
 LqJZ/rcXDZwA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2020 21:31:42 -0700
IronPort-SDR: id6fwVDOj83N1gHDSB1lrK/vVWo6Zx8icfyR1nqS+mtsNaNvQV+mzQXYjPXW3x96jOKoa9xTky
 OEm/aRZ0YMjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,393,1583222400"; 
   d="scan'208";a="341855665"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by orsmga001.jf.intel.com with ESMTP; 14 May 2020 21:31:39 -0700
From:   Dilip Kota <eswara.kota@linux.intel.com>
To:     linux-kernel@vger.kernel.org, kishon@ti.com, vkoul@kernel.org,
        devicetree@vger.kernel.org
Cc:     robh@kernel.org, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com, yixin.zhu@intel.com,
        Dilip Kota <eswara.kota@linux.intel.com>
Subject: [PATCH v8 1/3] dt-bindings: phy: Add PHY_TYPE_XPCS definition
Date:   Fri, 15 May 2020 12:30:24 +0800
Message-Id: <6091f0d2a1046f1e3656d9e33b6cc433d5465eaf.1589516297.git.eswara.kota@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1589516297.git.eswara.kota@linux.intel.com>
References: <cover.1589516297.git.eswara.kota@linux.intel.com>
In-Reply-To: <cover.1589516297.git.eswara.kota@linux.intel.com>
References: <cover.1589516297.git.eswara.kota@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add definition for Ethernet PCS phy type.

Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
Acked-by: Rob Herring <robh@kernel.org>
---
Changes on v8:
  No Change

Changes on v7:
  No Change

Changes on v6:
  Add Acked-by: Rob Herring <robh@kernel.org>

 include/dt-bindings/phy/phy.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/phy/phy.h b/include/dt-bindings/phy/phy.h
index 1f3f866fae7b..3727ef72138b 100644
--- a/include/dt-bindings/phy/phy.h
+++ b/include/dt-bindings/phy/phy.h
@@ -17,5 +17,6 @@
 #define PHY_TYPE_USB3		4
 #define PHY_TYPE_UFS		5
 #define PHY_TYPE_DP		6
+#define PHY_TYPE_XPCS		7
 
 #endif /* _DT_BINDINGS_PHY */
-- 
2.11.0

