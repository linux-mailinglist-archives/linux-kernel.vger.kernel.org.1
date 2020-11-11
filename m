Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5653A2AEACE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 09:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgKKIFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 03:05:34 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:38606 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725929AbgKKIFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 03:05:34 -0500
X-UUID: 69970f2a4a424d2b89a8c6475aeb7f1f-20201111
X-UUID: 69970f2a4a424d2b89a8c6475aeb7f1f-20201111
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <jiaxin.yu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1177359857; Wed, 11 Nov 2020 16:05:27 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 11 Nov 2020 16:05:21 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 11 Nov 2020 16:05:21 +0800
From:   Jiaxin Yu <jiaxin.yu@mediatek.com>
To:     <broonie@kernel.org>, <matthias.bgg@gmail.com>,
        <tzungbi@google.com>, <alsa-devel@alsa-project.org>,
        <robh+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <shane.chien@mediatek.com>, <Trevor.Wu@mediatek.com>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>
Subject: [PATCH] dt-bindings: mediatek: mt8192: revert "add audio afe document"
Date:   Wed, 11 Nov 2020 16:05:20 +0800
Message-ID: <1605081920-11848-1-git-send-email-jiaxin.yu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: B6B60659D593C4E89EEF10AE1AB27A634A2912B517692252360D8B9598ABDC582000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 1afc60e00de3abbb6c559da409c5c1bb8c1d98ec.

Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
---
 https://mailman.alsa-project.org/pipermail/alsa-devel/2020-November/176873.html
 These dependency are continuing to upstream, I will revert this patch first.
 After the dependencies are merged, I will send 'mt8192-afe-pcm.yaml' again.

 .../bindings/sound/mt8192-afe-pcm.yaml        | 100 ------------------
 1 file changed, 100 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/mt8192-afe-pcm.yaml

diff --git a/Documentation/devicetree/bindings/sound/mt8192-afe-pcm.yaml b/Documentation/devicetree/bindings/sound/mt8192-afe-pcm.yaml
deleted file mode 100644
index 0170c93802d29..0000000000000
--- a/Documentation/devicetree/bindings/sound/mt8192-afe-pcm.yaml
+++ /dev/null
@@ -1,100 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/sound/mt8192-afe-pcm.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: Mediatek AFE PCM controller for mt8192
-
-maintainers:
-   - Jiaxin Yu <jiaxin.yu@mediatek.com>
-   - Shane Chien <shane.chien@mediatek.com>
-
-properties:
-  compatible:
-      const: mediatek,mt8192-audio
-
-  interrupts:
-    maxItems: 1
-
-  resets:
-    maxItems: 1
-
-  reset-names:
-    const: audiosys
-
-  mediatek,apmixedsys:
-    $ref: "/schemas/types.yaml#/definitions/phandle"
-    description: The phandle of the mediatek apmixedsys controller
-
-  mediatek,infracfg:
-    $ref: "/schemas/types.yaml#/definitions/phandle"
-    description: The phandle of the mediatek infracfg controller
-
-  mediatek,topckgen:
-    $ref: "/schemas/types.yaml#/definitions/phandle"
-    description: The phandle of the mediatek topckgen controller
-
-  power-domains:
-    maxItems: 1
-
-  clocks:
-    items:
-      - description: AFE clock
-      - description: ADDA DAC clock
-      - description: ADDA DAC pre-distortion clock
-      - description: audio infra sys clock
-      - description: audio infra 26M clock
-
-  clock-names:
-    items:
-      - const: aud_afe_clk
-      - const: aud_dac_clk
-      - const: aud_dac_predis_clk
-      - const: aud_infra_clk
-      - const: aud_infra_26m_clk
-
-required:
-  - compatible
-  - interrupts
-  - resets
-  - reset-names
-  - mediatek,apmixedsys
-  - mediatek,infracfg
-  - mediatek,topckgen
-  - power-domains
-  - clocks
-  - clock-names
-
-additionalProperties: false
-
-examples:
-  - |
-    #include <dt-bindings/clock/mt8192-clk.h>
-    #include <dt-bindings/interrupt-controller/arm-gic.h>
-    #include <dt-bindings/interrupt-controller/irq.h>
-    #include <dt-bindings/power/mt8192-power.h>
-    #include <dt-bindings/reset-controller/mt8192-resets.h>
-
-    afe: mt8192-afe-pcm {
-        compatible = "mediatek,mt8192-audio";
-        interrupts = <GIC_SPI 202 IRQ_TYPE_LEVEL_HIGH>;
-        resets = <&watchdog MT8192_TOPRGU_AUDIO_SW_RST>;
-        reset-names = "audiosys";
-        mediatek,apmixedsys = <&apmixedsys>;
-        mediatek,infracfg = <&infracfg>;
-        mediatek,topckgen = <&topckgen>;
-        power-domains = <&scpsys MT8192_POWER_DOMAIN_AUDIO>;
-        clocks = <&audsys CLK_AUD_AFE>,
-                 <&audsys CLK_AUD_DAC>,
-                 <&audsys CLK_AUD_DAC_PREDIS>,
-                 <&infracfg CLK_INFRA_AUDIO>,
-                 <&infracfg CLK_INFRA_AUDIO_26M_B>;
-        clock-names = "aud_afe_clk",
-                      "aud_dac_clk",
-                      "aud_dac_predis_clk",
-                      "aud_infra_clk",
-                      "aud_infra_26m_clk";
-    };
-
-...
-- 
2.18.0

