Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8D82EC8E7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 04:13:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbhAGDMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 22:12:12 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:44907 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726092AbhAGDMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 22:12:12 -0500
X-UUID: 2ff67c3ec6a8448dbe331a53cfeb546e-20210107
X-UUID: 2ff67c3ec6a8448dbe331a53cfeb546e-20210107
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 976730749; Thu, 07 Jan 2021 11:11:27 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 7 Jan 2021 11:11:25 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 7 Jan 2021 11:11:24 +0800
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
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>
Subject: [PATCH v9, 01/11] dt-bindings: mediatek: add rdma-fifo-size description for mt8183 display
Date:   Thu, 7 Jan 2021 11:11:11 +0800
Message-ID: <1609989081-29353-2-git-send-email-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1609989081-29353-1-git-send-email-yongqiang.niu@mediatek.com>
References: <1609989081-29353-1-git-send-email-yongqiang.niu@mediatek.com>
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
 .../devicetree/bindings/display/mediatek/mediatek,disp.txt       | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
index 33977e1..b07881e 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
@@ -66,6 +66,14 @@ Required properties (DMA function blocks):
   argument, see Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
   for details.
 
+Optional properties (RDMA function blocks):
+- mediatek,rdma-fifo-size: rdma fifo size may be different even in same SOC, add this
+  property to the corresponding rdma
+  the value is the Max value which defined in hardware data sheet.
+  mediatek,rdma-fifo-size of mt8173-rdma0 is 8K
+  mediatek,rdma-fifo-size of mt8183-rdma0 is 5K
+  mediatek,rdma-fifo-size of mt8183-rdma1 is 2K
+
 Examples:
 
 mmsys: clock-controller@14000000 {
@@ -103,6 +111,7 @@ rdma0: rdma@1400e000 {
 	clocks = <&mmsys CLK_MM_DISP_RDMA0>;
 	iommus = <&iommu M4U_PORT_DISP_RDMA0>;
 	mediatek,larb = <&larb0>;
+	mediatek,rdma-fifosize = <8192>;
 };
 
 rdma1: rdma@1400f000 {
-- 
1.8.1.1.dirty

