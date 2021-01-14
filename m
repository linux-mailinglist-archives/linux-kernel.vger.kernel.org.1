Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01E3A2F649B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 16:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729357AbhANP3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 10:29:40 -0500
Received: from mga14.intel.com ([192.55.52.115]:7040 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726259AbhANP3j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 10:29:39 -0500
IronPort-SDR: AGhfs9MEFqnXZX9N9IdMX5gmBGtFEkemHapAFSwBWwDzbjNQkkwsLHBhWXkCNCu70S5Sdtvb5u
 tRSXJUEf1/0A==
X-IronPort-AV: E=McAfee;i="6000,8403,9864"; a="177604677"
X-IronPort-AV: E=Sophos;i="5.79,347,1602572400"; 
   d="scan'208";a="177604677"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 07:28:46 -0800
IronPort-SDR: 5g3V5QAFOVvJOiwuicI7o4ju8thIa/KcAkcpOLGDM8bwESzPiJcm6Ga3vR7B/WSnN3s4gDvl/x
 BzMZXHhMmxwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,347,1602572400"; 
   d="scan'208";a="568193622"
Received: from zulkifl3-ilbpg0.png.intel.com ([10.88.229.114])
  by orsmga005.jf.intel.com with ESMTP; 14 Jan 2021 07:28:43 -0800
From:   Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
To:     ulf.hansson@linaro.org, broonie@kernel.org, lgirdwood@gmail.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        adrian.hunter@intel.com, michal.simek@xilinx.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     andriy.shevchenko@intel.com, Rashmi.A@intel.com,
        mahesh.r.vaidya@intel.com, muhammad.husaini.zulkifli@intel.com
Subject: [PATCH v1 6/9] dt-bindings: mmc: Update phy and regulator supply for Keem Bay SOC
Date:   Thu, 14 Jan 2021 23:26:57 +0800
Message-Id: <20210114152700.21916-7-muhammad.husaini.zulkifli@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210114152700.21916-1-muhammad.husaini.zulkifli@intel.com>
References: <20210114152700.21916-1-muhammad.husaini.zulkifli@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT bindings of vmmc, vqmmc and sdvrail supplies of regulator
and phys for the phandle of sd0_phy which contain additional property
for otap delay and sel_clk_buffer.

Signed-off-by: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml b/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
index 37a5fe7b26dc..b77a1ff37afa 100644
--- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
@@ -83,7 +83,7 @@ properties:
       - const: intel,keembay-sdhci-5.1-sd       # Intel Keem Bay SD controller
         description:
           For this device it is strongly suggested to include
-          arasan,soc-ctl-syscon.
+          arasan,soc-ctl-syscon, phys, vmmc-supply, vqmmc-supply and sdvrail-supply.
       - const: intel,keembay-sdhci-5.1-sdio     # Intel Keem Bay SDIO controller
         description:
           For this device it is strongly suggested to include
@@ -299,5 +299,10 @@ examples:
           clock-names = "clk_xin", "clk_ahb";
           clocks = <&scmi_clk KEEM_BAY_PSS_AUX_SD0>,
                    <&scmi_clk KEEM_BAY_PSS_SD0>;
+          phys = <&sd0_phy>;
+          phy-names = "phy_arasan";
           arasan,soc-ctl-syscon = <&sd0_phy_syscon>;
+          vmmc-supply = <&reg_sd0_vcc>;
+          vqmmc-supply = <&reg_sd0_vqcc>;
+          sdvrail-supply = <&regulator_rail>;
     };
-- 
2.17.1

