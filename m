Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E092A2D5620
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 10:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730794AbgLJJIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 04:08:36 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:56623 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726579AbgLJJIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 04:08:32 -0500
X-UUID: 034ab192568940ea9a2a7aa20f9fb13b-20201210
X-UUID: 034ab192568940ea9a2a7aa20f9fb13b-20201210
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 500325579; Thu, 10 Dec 2020 17:07:46 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 10 Dec 2020 17:07:44 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 10 Dec 2020 17:07:44 +0800
From:   Yongqiang Niu <yongqiang.niu@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>
Subject: [PATCH v8, 1/6] dt-bindings: mediatek: add rdma_fifo_size description for mt8183 display
Date:   Thu, 10 Dec 2020 17:07:37 +0800
Message-ID: <1607591262-21736-2-git-send-email-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1607591262-21736-1-git-send-email-yongqiang.niu@mediatek.com>
References: <1607591262-21736-1-git-send-email-yongqiang.niu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rdma fifo size may be different even in same SOC, add this
property to the corresponding rdma

Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
---
 .../bindings/display/mediatek/mediatek,disp.txt          | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
index 1212207..64c64ee 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
@@ -66,6 +66,13 @@ Required properties (DMA function blocks):
   argument, see Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
   for details.
 
+Optional properties (RDMA function blocks):
+- mediatek,rdma_fifo_size: rdma fifo size may be different even in same SOC, add this
+  property to the corresponding rdma
+  the value is the Max value which defined in hardware data sheet.
+  rdma_fifo_size of rdma0 in mt8183 is 5120
+  rdma_fifo_size of rdma1 in mt8183 is 2048
+
 Examples:
 
 mmsys: clock-controller@14000000 {
@@ -207,3 +214,12 @@ od@14023000 {
 	power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
 	clocks = <&mmsys CLK_MM_DISP_OD>;
 };
+
+rdma1: rdma@1400c000 {
+	compatible = "mediatek,mt8183-disp-rdma";
+	reg = <0 0x1400c000 0 0x1000>;
+	interrupts = <GIC_SPI 229 IRQ_TYPE_LEVEL_LOW>;
+	power-domains = <&scpsys MT8183_POWER_DOMAIN_DISP>;
+	clocks = <&mmsys CLK_MM_DISP_RDMA1>;
+	mediatek,rdma_fifo_size = <2048>;
+};
-- 
1.8.1.1.dirty

