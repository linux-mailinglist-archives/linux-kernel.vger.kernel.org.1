Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4057286C9F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 04:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbgJHCM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 22:12:56 -0400
Received: from mga02.intel.com ([134.134.136.20]:31771 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727345AbgJHCMy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 22:12:54 -0400
IronPort-SDR: U/xZOmv43itVUDtR12sIRQSWPD/0yMVupjbzuxChMh7Kazf6ydJSCRZyQyrAnmOcub5rgdzwLn
 KT789X5Al8OQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9767"; a="152154704"
X-IronPort-AV: E=Sophos;i="5.77,349,1596524400"; 
   d="scan'208";a="152154704"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2020 19:12:53 -0700
IronPort-SDR: +8u5tLhidznlV/PYy90DzgZG8sUR2WkaTwogTL+L2tj4DbD4GQ626dhy8RacSMWHBFUNzFzfjH
 2MYT8niVjX1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,349,1596524400"; 
   d="scan'208";a="355211196"
Received: from zulkifl3-ilbpg0.png.intel.com ([10.88.229.114])
  by orsmga007.jf.intel.com with ESMTP; 07 Oct 2020 19:12:50 -0700
From:   muhammad.husaini.zulkifli@intel.com
To:     adrian.hunter@intel.com, michal.simek@xilinx.com,
        andriy.shevchenko@intel.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     lakshmi.bai.raja.subramanian@intel.com,
        wan.ahmad.zainie.wan.mohamad@intel.com,
        muhammad.husaini.zulkifli@intel.com, arnd@arndb.de
Subject: [PATCH v4 2/4] dt-bindings: mmc: Add uhs-gpio for Keem Bay UHS-1 Support
Date:   Thu,  8 Oct 2020 10:09:34 +0800
Message-Id: <20201008020936.19894-3-muhammad.husaini.zulkifli@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201008020936.19894-1-muhammad.husaini.zulkifli@intel.com>
References: <20201008020936.19894-1-muhammad.husaini.zulkifli@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>

Add DT bindings of uhs-gpio for Keem Bay SOC UHS Mode Support

Signed-off-by: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
---
 Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml b/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
index 58fe9d02a781..320566a673f0 100644
--- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
@@ -83,7 +83,7 @@ properties:
       - const: intel,keembay-sdhci-5.1-sd       # Intel Keem Bay SD controller
         description:
           For this device it is strongly suggested to include
-          arasan,soc-ctl-syscon.
+          arasan,soc-ctl-syscon and uhs-gpio.
       - const: intel,keembay-sdhci-5.1-sdio     # Intel Keem Bay SDIO controller
         description:
           For this device it is strongly suggested to include
@@ -152,6 +152,11 @@ properties:
     description:
       The MIO bank number in which the command and data lines are configured.
 
+  uhs-gpio:
+    description:
+      The power mux input will be configure using the GPIO provided
+      to generate either 1.8v or 3.3v output.
+
 dependencies:
   clock-output-names: [ '#clock-cells' ]
   '#clock-cells': [ clock-output-names ]
@@ -300,4 +305,5 @@ examples:
           clocks = <&scmi_clk KEEM_BAY_PSS_AUX_SD0>,
                    <&scmi_clk KEEM_BAY_PSS_SD0>;
           arasan,soc-ctl-syscon = <&sd0_phy_syscon>;
+          uhs-gpio = <&pca0 17 0>;
     };
-- 
2.17.1

