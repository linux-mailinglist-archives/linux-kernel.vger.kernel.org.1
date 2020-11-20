Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 449DB2BA0C9
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 04:07:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbgKTDGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 22:06:21 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:51536 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726485AbgKTDGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 22:06:21 -0500
X-UUID: 2a29a68fdc314804a1f67d0599b59c43-20201120
X-UUID: 2a29a68fdc314804a1f67d0599b59c43-20201120
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <jiaxin.yu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 130192700; Fri, 20 Nov 2020 11:06:18 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 20 Nov 2020 11:06:17 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 20 Nov 2020 11:06:16 +0800
From:   Jiaxin Yu <jiaxin.yu@mediatek.com>
To:     <broonie@kernel.org>, <tiwai@suse.com>, <matthias.bgg@gmail.com>,
        <tzungbi@google.com>, <alsa-devel@alsa-project.org>,
        <robh+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <shane.chien@mediatek.com>, <Trevor.Wu@mediatek.com>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>
Subject: [PATCH 2/2] dt-bindings: mediatek: mt6359: remove unused property for mt6359
Date:   Fri, 20 Nov 2020 11:06:13 +0800
Message-ID: <1605841573-1442-3-git-send-email-jiaxin.yu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1605841573-1442-1-git-send-email-jiaxin.yu@mediatek.com>
References: <1605841573-1442-1-git-send-email-jiaxin.yu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: DDC9A826DC1B14BDD756F49287CC87C9B10F08EA4E9D16A937B0F009B1940D902000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 08651373808e16b01d3b12207f52504c17b6774c.
("dt-bindings: mediatek: mt6359: Add new property for mt6359")

Remove unused property "LDO_VAUD18-supply" in mt6359codec.

Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
---
 Documentation/devicetree/bindings/sound/mt6359.yaml | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/mt6359.yaml b/Documentation/devicetree/bindings/sound/mt6359.yaml
index ef027c79032f..a54f466f769d 100644
--- a/Documentation/devicetree/bindings/sound/mt6359.yaml
+++ b/Documentation/devicetree/bindings/sound/mt6359.yaml
@@ -17,11 +17,6 @@ description: |
   Must be a child node of PMIC wrapper.
 
 properties:
-  LDO_VAUD18-supply:
-    $ref: /schemas/types.yaml#/definitions/phandle
-    description: |
-      Regulator of LDO VAUD18 at 1.8V.
-
   mediatek,dmic-mode:
     $ref: /schemas/types.yaml#/definitions/uint32
     description: |
@@ -54,15 +49,11 @@ properties:
     description: |
       Specifies the type of mic type connected to adc2
 
-required:
-  - LDO_VAUD18-supply
-
 additionalProperties: false
 
 examples:
   - |
     mt6359codec: mt6359codec {
-      LDO_VAUD18-supply = <&mt6359p_vaud18_reg>;
       mediatek,dmic-mode = <0>;
       mediatek,mic-type-0 = <2>;
     };
-- 
2.18.0

