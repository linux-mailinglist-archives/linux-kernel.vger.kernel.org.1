Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD1D019F0F4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Apr 2020 09:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgDFHkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Apr 2020 03:40:43 -0400
Received: from mga04.intel.com ([192.55.52.120]:19763 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726475AbgDFHkm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 03:40:42 -0400
IronPort-SDR: JPEJU5kyUdGGTMmoQQvuQpNnaXvKX4hQQZbavUJCq+ziw9AMSEhHGMp5LI4QetiVqRIrt7ar+Z
 8TC2FKPFpqHg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2020 00:40:41 -0700
IronPort-SDR: 4LqIUnstuoUiDs0/jlOOuXmmm8Y0i1qtA76hbZtTB8dsDh5GloNkVmJY4KSTz0f/pJOK2GHEHF
 aHO6+G/exwNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,350,1580803200"; 
   d="scan'208";a="296590352"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by FMSMGA003.fm.intel.com with ESMTP; 06 Apr 2020 00:40:39 -0700
From:   Dilip Kota <eswara.kota@linux.intel.com>
To:     linux-kernel@vger.kernel.org, kishon@ti.com,
        devicetree@vger.kernel.org, lee.jones@linaro.org, arnd@arndb.de
Cc:     robh@kernel.org, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com, yixin.zhu@intel.com,
        Dilip Kota <eswara.kota@linux.intel.com>
Subject: [RESEND PATCH v6 2/4] dt-bindings: phy: Add PHY_TYPE_XPCS definition
Date:   Mon,  6 Apr 2020 15:39:54 +0800
Message-Id: <6091f0d2a1046f1e3656d9e33b6cc433d5465eaf.1585889042.git.eswara.kota@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1585889042.git.eswara.kota@linux.intel.com>
References: <cover.1585889042.git.eswara.kota@linux.intel.com>
In-Reply-To: <cover.1585889042.git.eswara.kota@linux.intel.com>
References: <cover.1585889042.git.eswara.kota@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add definition for Ethernet PCS phy type.

Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
Acked-by: Rob Herring <robh@kernel.org>
---
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

