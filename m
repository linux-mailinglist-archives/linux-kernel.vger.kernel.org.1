Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F40692AB39B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 10:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729022AbgKIJah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 04:30:37 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:32866 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726423AbgKIJaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 04:30:35 -0500
X-UUID: 17a307c7281f4e85ba8846965a849e5a-20201109
X-UUID: 17a307c7281f4e85ba8846965a849e5a-20201109
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <shane.chien@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 27773945; Mon, 09 Nov 2020 17:30:32 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 9 Nov 2020 17:30:31 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 9 Nov 2020 17:30:30 +0800
From:   Shane Chien <shane.chien@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, <jiaxin.yu@mediatek.com>,
        <chipeng.chang@mediatek.com>, <shane.chien@mediatek.com>
Subject: [PATCH v2 2/2] dt-bindings: mediatek: mt6359: Add new property for mt6359
Date:   Mon, 9 Nov 2020 17:30:09 +0800
Message-ID: <1604914209-9174-3-git-send-email-shane.chien@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1604914209-9174-1-git-send-email-shane.chien@mediatek.com>
References: <1604914209-9174-1-git-send-email-shane.chien@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Shane.Chien" <shane.chien@mediatek.com>

This patch add "LDO_VAUD18-supply" property to
control vaud18 regulator. It is labeled as required
due to mt6359 audio path always need to enable vaud18.

Signed-off-by: Shane.Chien <shane.chien@mediatek.com>
---
 .../devicetree/bindings/sound/mt6359.yaml          |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/mt6359.yaml b/Documentation/devicetree/bindings/sound/mt6359.yaml
index a54f466..7ccaa8c 100644
--- a/Documentation/devicetree/bindings/sound/mt6359.yaml
+++ b/Documentation/devicetree/bindings/sound/mt6359.yaml
@@ -17,6 +17,11 @@ description: |
   Must be a child node of PMIC wrapper.
 
 properties:
+  LDO_VAUD18-supply:
+    ref: /schemas/types.yaml#/definitions/phandle
+    description: |
+      Regulator of LDO VAUD18 at 1.8V.
+
   mediatek,dmic-mode:
     $ref: /schemas/types.yaml#/definitions/uint32
     description: |
@@ -49,11 +54,15 @@ properties:
     description: |
       Specifies the type of mic type connected to adc2
 
+required:
+  - LDO_VAUD18-supply
+
 additionalProperties: false
 
 examples:
   - |
     mt6359codec: mt6359codec {
+      LDO_VAUD18-supply = <&mt6359p_vaud18_reg>;
       mediatek,dmic-mode = <0>;
       mediatek,mic-type-0 = <2>;
     };
-- 
1.7.9.5

