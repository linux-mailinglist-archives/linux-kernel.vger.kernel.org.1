Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B16E228B5FA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 15:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388915AbgJLNTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 09:19:39 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:41240 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388218AbgJLNTc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 09:19:32 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id AC974AEEC860769E8AED;
        Mon, 12 Oct 2020 21:19:30 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.134) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Mon, 12 Oct 2020 21:19:24 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 03/11] arm64: dts: hisilicon: write the values of property-units into a uint32 array
Date:   Mon, 12 Oct 2020 21:17:31 +0800
Message-ID: <20201012131739.1655-4-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20201012131739.1655-1-thunder.leizhen@huawei.com>
References: <20201012131739.1655-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.134]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use <> to separate the values of property-units will be treated as
multiple arrays. The errors similar to the following will be reported by
property-units.yaml.

ufs@ff3c0000: freq-table-hz: [[0, 0], [0, 0]] is too long

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi      | 3 ++-
 arch/arm64/boot/dts/hisilicon/hi3670.dtsi      | 3 ++-
 arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi | 9 ++++-----
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
index 994140fbc916eea..3f6b1715835af06 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -1045,7 +1045,8 @@
 			clocks = <&crg_ctrl HI3660_CLK_GATE_UFSIO_REF>,
 				<&crg_ctrl HI3660_CLK_GATE_UFSPHY_CFG>;
 			clock-names = "ref_clk", "phy_clk";
-			freq-table-hz = <0 0>, <0 0>;
+			freq-table-hz = <0 0
+					 0 0>;
 			/* offset: 0x84; bit: 12 */
 			resets = <&crg_rst 0x84 12>;
 			reset-names = "rst";
diff --git a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
index 2dcffa3ed2189eb..668977d1acba94c 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
@@ -667,7 +667,8 @@
 			clocks = <&crg_ctrl HI3670_CLK_GATE_UFSIO_REF>,
 				<&crg_ctrl HI3670_CLK_GATE_UFS_SUBSYS>;
 			clock-names = "ref_clk", "phy_clk";
-			freq-table-hz = <0 0>, <0 0>;
+			freq-table-hz = <0 0
+					 0 0>;
 			/* offset: 0x84; bit: 12 */
 			resets = <&crg_rst 0x84 12>;
 			reset-names = "rst";
diff --git a/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi b/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi
index 12bc1d3ed4243f5..993998ac27c503c 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi
@@ -91,11 +91,10 @@
 			gmacphyrst: reset-controller {
 				compatible = "ti,syscon-reset";
 				#reset-cells = <1>;
-				ti,reset-bits =
-					<0xcc 12 0xcc 12 0 0 (ASSERT_CLEAR |
-					 DEASSERT_SET|STATUS_NONE)>,
-					<0xcc 13 0xcc 13 0 0 (ASSERT_CLEAR |
-					 DEASSERT_SET|STATUS_NONE)>;
+				ti,reset-bits = <
+					0xcc 12 0xcc 12 0 0 (ASSERT_CLEAR | DEASSERT_SET | STATUS_NONE)
+					0xcc 13 0xcc 13 0 0 (ASSERT_CLEAR | DEASSERT_SET | STATUS_NONE)
+				>;
 			};
 		};
 
-- 
1.8.3


