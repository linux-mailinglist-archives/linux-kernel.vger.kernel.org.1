Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDA9E2CD51B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 13:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730336AbgLCMDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 07:03:39 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:9365 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbgLCMDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 07:03:38 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CmvbR64ftz7861;
        Thu,  3 Dec 2020 20:02:27 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.9) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Thu, 3 Dec 2020 20:02:44 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Wei Xu <xuwei5@hisilicon.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Chen Feng <puck.chen@hisilicon.com>,
        "Manivannan Sadhasivam" <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 2/4] arm64: dts: correct vendor prefix hisi to hisilicon
Date:   Thu, 3 Dec 2020 20:02:10 +0800
Message-ID: <20201203120212.1105-3-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20201203120212.1105-1-thunder.leizhen@huawei.com>
References: <20201203120212.1105-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.9]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vendor prefix of "Hisilicon Limited" is "hisilicon", it is clearly
stated in "vendor-prefixes.yaml".

Fixes: 35ca8168133c ("arm64: dts: Add dts files for Hisilicon Hi3660 SoC")
Fixes: dd8c7b78c11b ("arm64: dts: Add devicetree for Hisilicon Hi3670 SoC")
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Cc: Chen Feng <puck.chen@hisilicon.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 4 ++--
 arch/arm64/boot/dts/hisilicon/hi3670.dtsi | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
index 49c19c6879f95ce..bfb1375426d2b58 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -345,7 +345,7 @@
 		crg_rst: crg_rst_controller {
 			compatible = "hisilicon,hi3660-reset";
 			#reset-cells = <2>;
-			hisi,rst-syscon = <&crg_ctrl>;
+			hisilicon,rst-syscon = <&crg_ctrl>;
 		};
 
 
@@ -376,7 +376,7 @@
 
 		iomcu_rst: reset {
 			compatible = "hisilicon,hi3660-reset";
-			hisi,rst-syscon = <&iomcu>;
+			hisilicon,rst-syscon = <&iomcu>;
 			#reset-cells = <2>;
 		};
 
diff --git a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
index 85b0dfb35d6d396..5c5a5dc964ea848 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
@@ -155,7 +155,7 @@
 			compatible = "hisilicon,hi3670-reset",
 				     "hisilicon,hi3660-reset";
 			#reset-cells = <2>;
-			hisi,rst-syscon = <&crg_ctrl>;
+			hisilicon,rst-syscon = <&crg_ctrl>;
 		};
 
 		pctrl: pctrl@e8a09000 {
-- 
1.8.3


