Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC311276A9E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 09:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbgIXHTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 03:19:54 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:45684 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727030AbgIXHTl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 03:19:41 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E2A5B6417747A76B4C8A;
        Thu, 24 Sep 2020 15:19:37 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.253) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Thu, 24 Sep 2020 15:19:28 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Alexey Brodkin" <abrodkin@synopsys.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-snps-arc <linux-snps-arc@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Haoyu Lv <lvhaoyu@huawei.com>, Libin <huawei.libin@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v6 4/6] dt-bindings: dw-apb-ictl: support hierarchy irq domain
Date:   Thu, 24 Sep 2020 15:17:52 +0800
Message-ID: <20200924071754.4509-5-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20200924071754.4509-1-thunder.leizhen@huawei.com>
References: <20200924071754.4509-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to use dw-apb-ictl as primary interrupt controller.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/interrupt-controller/snps,dw-apb-ictl.txt     | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/snps,dw-apb-ictl.txt b/Documentation/devicetree/bindings/interrupt-controller/snps,dw-apb-ictl.txt
index 086ff08322db94f..2db59df9408f4c6 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/snps,dw-apb-ictl.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/snps,dw-apb-ictl.txt
@@ -2,7 +2,8 @@ Synopsys DesignWare APB interrupt controller (dw_apb_ictl)
 
 Synopsys DesignWare provides interrupt controller IP for APB known as
 dw_apb_ictl. The IP is used as secondary interrupt controller in some SoCs with
-APB bus, e.g. Marvell Armada 1500.
+APB bus, e.g. Marvell Armada 1500. It can also be used as primary interrupt
+controller in some SoCs, e.g. Hisilicon SD5203.
 
 Required properties:
 - compatible: shall be "snps,dw-apb-ictl"
@@ -10,6 +11,8 @@ Required properties:
   region starting with ENABLE_LOW register
 - interrupt-controller: identifies the node as an interrupt controller
 - #interrupt-cells: number of cells to encode an interrupt-specifier, shall be 1
+
+Additional required property when it's used as secondary interrupt controller:
 - interrupts: interrupt reference to primary interrupt controller
 
 The interrupt sources map to the corresponding bits in the interrupt
@@ -21,6 +24,7 @@ registers, i.e.
 - (optional) fast interrupts start at 64.
 
 Example:
+	/* dw_apb_ictl is used as secondary interrupt controller */
 	aic: interrupt-controller@3000 {
 		compatible = "snps,dw-apb-ictl";
 		reg = <0x3000 0xc00>;
@@ -29,3 +33,11 @@ Example:
 		interrupt-parent = <&gic>;
 		interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
 	};
+
+	/* dw_apb_ictl is used as primary interrupt controller */
+	vic: interrupt-controller@10130000 {
+		compatible = "snps,dw-apb-ictl";
+		reg = <0x10130000 0x1000>;
+		interrupt-controller;
+		#interrupt-cells = <1>;
+	};
-- 
1.8.3


