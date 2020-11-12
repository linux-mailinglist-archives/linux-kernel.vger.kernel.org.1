Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA482B008E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 08:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbgKLHw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 02:52:28 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:53539 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725860AbgKLHwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 02:52:19 -0500
X-UUID: ac6a2d402efa47e5a9c2886a796b2657-20201112
X-UUID: ac6a2d402efa47e5a9c2886a796b2657-20201112
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <wenbin.mei@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 128975411; Thu, 12 Nov 2020 15:52:13 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 12 Nov 2020 15:52:11 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 12 Nov 2020 15:52:10 +0800
From:   Wenbin Mei <wenbin.mei@mediatek.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        <irq-linux@rere.qmqm.pl>, Wenbin Mei <wenbin.mei@mediatek.com>,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Ludovic Barre <ludovic.barre@st.com>,
        Krishna Konda <kkonda@codeaurora.org>,
        Bradley Bolen <bradleybolen@gmail.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <srv_heupstream@mediatek.com>
Subject: [PATCH v1 1/3] dt-bindings: mmc: Add optional cqe off properties
Date:   Thu, 12 Nov 2020 15:52:06 +0800
Message-ID: <20201112075208.28183-2-wenbin.mei@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201112075208.28183-1-wenbin.mei@mediatek.com>
References: <20201112075208.28183-1-wenbin.mei@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add optional properties for cqe hosts which are used to set cqe off
during suspend flow.

Signed-off-by: Wenbin Mei <wenbin.mei@mediatek.com>
---
 Documentation/devicetree/bindings/mmc/mmc-controller.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
index b96da0c7f819..457c9a84b988 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
+++ b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
@@ -164,6 +164,13 @@ properties:
     description:
       enable SDIO IRQ signalling on this interface
 
+  cqe-off-in-suspend:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      After suspend, the mmc host is powered off by HW, and bring CQE register
+      to default state, so we add the flag to re-init CQE register after resume
+      back.
+
   full-pwr-cycle:
     $ref: /schemas/types.yaml#/definitions/flag
     description:
-- 
2.18.0

