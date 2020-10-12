Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD97C28AE29
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 08:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727396AbgJLGNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 02:13:05 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:33582 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727266AbgJLGM5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 02:12:57 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D72AB7DCE0BB0075B647;
        Mon, 12 Oct 2020 14:12:45 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.134) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Mon, 12 Oct 2020 14:12:37 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v2 04/10] ARM: dts: hisilicon: fix errors detected by simple-bus.yaml
Date:   Mon, 12 Oct 2020 14:12:19 +0800
Message-ID: <20201012061225.1597-5-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20201012061225.1597-1-thunder.leizhen@huawei.com>
References: <20201012061225.1597-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.134]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change bus node name from "amba" to "amba-bus" to match
'^([a-z][a-z0-9\\-]+-bus|bus|soc|axi|ahb|apb)(@[0-9a-f]+)?$'

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 arch/arm/boot/dts/hi3620-hi4511.dts | 2 +-
 arch/arm/boot/dts/hi3620.dtsi       | 2 +-
 arch/arm/boot/dts/hip01.dtsi        | 2 +-
 arch/arm/boot/dts/hisi-x5hd2.dtsi   | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/hi3620-hi4511.dts b/arch/arm/boot/dts/hi3620-hi4511.dts
index 1c62bdcca647a9a..29eedc7fef9861e 100644
--- a/arch/arm/boot/dts/hi3620-hi4511.dts
+++ b/arch/arm/boot/dts/hi3620-hi4511.dts
@@ -22,7 +22,7 @@
 		reg = <0x40000000 0x20000000>;
 	};
 
-	amba {
+	amba-bus {
 		dual_timer0: dual_timer@800000 {
 			status = "ok";
 		};
diff --git a/arch/arm/boot/dts/hi3620.dtsi b/arch/arm/boot/dts/hi3620.dtsi
index d41378391e4cc36..905900bf3e82040 100644
--- a/arch/arm/boot/dts/hi3620.dtsi
+++ b/arch/arm/boot/dts/hi3620.dtsi
@@ -63,7 +63,7 @@
 		};
 	};
 
-	amba {
+	amba-bus {
 
 		#address-cells = <1>;
 		#size-cells = <1>;
diff --git a/arch/arm/boot/dts/hip01.dtsi b/arch/arm/boot/dts/hip01.dtsi
index fd09e6d9309c755..2a796360539002b 100644
--- a/arch/arm/boot/dts/hip01.dtsi
+++ b/arch/arm/boot/dts/hip01.dtsi
@@ -35,7 +35,7 @@
 		interrupt-parent = <&gic>;
 		ranges = <0 0x10000000 0x20000000>;
 
-		amba {
+		amba-bus {
 			#address-cells = <1>;
 			#size-cells = <1>;
 			compatible = "simple-bus";
diff --git a/arch/arm/boot/dts/hisi-x5hd2.dtsi b/arch/arm/boot/dts/hisi-x5hd2.dtsi
index 0c1708945813346..8fdfde492919407 100644
--- a/arch/arm/boot/dts/hisi-x5hd2.dtsi
+++ b/arch/arm/boot/dts/hisi-x5hd2.dtsi
@@ -30,7 +30,7 @@
 		interrupt-parent = <&gic>;
 		ranges = <0 0xf8000000 0x8000000>;
 
-		amba {
+		amba-bus {
 			#address-cells = <1>;
 			#size-cells = <1>;
 			compatible = "simple-bus";
-- 
1.8.3


