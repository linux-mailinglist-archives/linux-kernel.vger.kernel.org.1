Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A48DA28B5FC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 15:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388924AbgJLNTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 09:19:41 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:56920 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388890AbgJLNTi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 09:19:38 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A97ABE762066B92B16EE;
        Mon, 12 Oct 2020 21:19:35 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.134) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Mon, 12 Oct 2020 21:19:26 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 06/11] arm64: dts: hisilicon: normalize the node name of the SMMU devices
Date:   Mon, 12 Oct 2020 21:17:34 +0800
Message-ID: <20201012131739.1655-7-thunder.leizhen@huawei.com>
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

Change the node name of the SMMU devices to match "^iommu@[0-9a-f]*".
Otherwise, the errors similar to the following will be reported by
arm,smmu-v3.yaml.

smmu_pcie: $nodename:0: 'smmu_pcie' does not match '^iommu@[0-9a-f]*'

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 arch/arm64/boot/dts/hisilicon/hip06.dtsi |  2 +-
 arch/arm64/boot/dts/hisilicon/hip07.dtsi | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hip06.dtsi b/arch/arm64/boot/dts/hisilicon/hip06.dtsi
index 941d527dcb8668c..2f1930d4457fe1b 100644
--- a/arch/arm64/boot/dts/hisilicon/hip06.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hip06.dtsi
@@ -330,7 +330,7 @@
 	 *  when iommu-map entry is used along with the PCIe node.
 	 *  Refer:https://www.spinics.net/lists/arm-kernel/msg602812.html
 	 */
-	smmu0: smmu_pcie {
+	smmu0: iommu@a0040000 {
 		compatible = "arm,smmu-v3";
 		reg = <0x0 0xa0040000 0x0 0x20000>;
 		#iommu-cells = <1>;
diff --git a/arch/arm64/boot/dts/hisilicon/hip07.dtsi b/arch/arm64/boot/dts/hisilicon/hip07.dtsi
index 36a873d150897b8..ba90b25853555b7 100644
--- a/arch/arm64/boot/dts/hisilicon/hip07.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hip07.dtsi
@@ -1161,7 +1161,7 @@
 	 *  when iommu-map entry is used along with the PCIe node.
 	 *  Refer:https://www.spinics.net/lists/arm-kernel/msg602812.html
 	 */
-	smmu0: smmu_pcie {
+	smmu0: iommu@a0040000 {
 		compatible = "arm,smmu-v3";
 		reg = <0x0 0xa0040000 0x0 0x20000>;
 		#iommu-cells = <1>;
@@ -1170,7 +1170,7 @@
 		hisilicon,broken-prefetch-cmd;
 		status = "disabled";
 	};
-	p0_smmu_alg_a: smmu_alg@d0040000 {
+	p0_smmu_alg_a: iommu@d0040000 {
 		compatible = "arm,smmu-v3";
 		reg = <0x0 0xd0040000 0x0 0x20000>;
 		interrupt-parent = <&p0_mbigen_smmu_alg_a>;
@@ -1183,7 +1183,7 @@
 		hisilicon,broken-prefetch-cmd;
 		/* smmu-cb-memtype = <0x0 0x1>;*/
 	};
-	p0_smmu_alg_b: smmu_alg@8,d0040000 {
+	p0_smmu_alg_b: iommu@8d0040000 {
 		compatible = "arm,smmu-v3";
 		reg = <0x8 0xd0040000 0x0 0x20000>;
 		interrupt-parent = <&p0_mbigen_smmu_alg_b>;
@@ -1196,7 +1196,7 @@
 		hisilicon,broken-prefetch-cmd;
 		/* smmu-cb-memtype = <0x0 0x1>;*/
 	};
-	p1_smmu_alg_a: smmu_alg@400,d0040000 {
+	p1_smmu_alg_a: iommu@400d0040000 {
 		compatible = "arm,smmu-v3";
 		reg = <0x400 0xd0040000 0x0 0x20000>;
 		interrupt-parent = <&p1_mbigen_smmu_alg_a>;
@@ -1209,7 +1209,7 @@
 		hisilicon,broken-prefetch-cmd;
 		/* smmu-cb-memtype = <0x0 0x1>;*/
 	};
-	p1_smmu_alg_b: smmu_alg@408,d0040000 {
+	p1_smmu_alg_b: iommu@408d0040000 {
 		compatible = "arm,smmu-v3";
 		reg = <0x408 0xd0040000 0x0 0x20000>;
 		interrupt-parent = <&p1_mbigen_smmu_alg_b>;
-- 
1.8.3


