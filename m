Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A444127954A
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 01:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729658AbgIYX7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 19:59:10 -0400
Received: from mail.v3.sk ([167.172.186.51]:38102 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729505AbgIYX7K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 19:59:10 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id E8EA5DFA4B;
        Fri, 25 Sep 2020 23:57:31 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id s66_NbpUWK-p; Fri, 25 Sep 2020 23:57:31 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 39509DFA70;
        Fri, 25 Sep 2020 23:57:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id SI4gShezDkHK; Fri, 25 Sep 2020 23:57:31 +0000 (UTC)
Received: from localhost (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 0625EDFA4B;
        Fri, 25 Sep 2020 23:57:31 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>,
        Rob Herring <robh@kernel.org>
Subject: [RESEND 2 PATCH v3 1/3] dt-bindings: phy: Drop reset-gpios from marvell,mmp3-hsic-phy
Date:   Sat, 26 Sep 2020 01:58:27 +0200
Message-Id: <20200925235828.228626-2-lkundrak@v3.sk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200925235828.228626-1-lkundrak@v3.sk>
References: <20200925235828.228626-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This has been added in error -- the PHY block doesn't have a reset pin.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Reviewed-by: Rob Herring <robh@kernel.org>

---
Changes since v2:
- Add Rob's Reviewed-by tag

 .../devicetree/bindings/phy/marvell,mmp3-hsic-phy.yaml     | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/marvell,mmp3-hsic-phy.=
yaml b/Documentation/devicetree/bindings/phy/marvell,mmp3-hsic-phy.yaml
index 00609ace677c9..30e290c579308 100644
--- a/Documentation/devicetree/bindings/phy/marvell,mmp3-hsic-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/marvell,mmp3-hsic-phy.yaml
@@ -18,27 +18,20 @@ properties:
     maxItems: 1
     description: base address of the device
=20
-  reset-gpios:
-    maxItems: 1
-    description: GPIO connected to reset
-
   "#phy-cells":
     const: 0
=20
 required:
   - compatible
   - reg
-  - reset-gpios
   - "#phy-cells"
=20
 additionalProperties: false
=20
 examples:
   - |
-    #include <dt-bindings/gpio/gpio.h>
     hsic-phy@f0001800 {
             compatible =3D "marvell,mmp3-hsic-phy";
             reg =3D <0xf0001800 0x40>;
-            reset-gpios =3D <&gpio 63 GPIO_ACTIVE_HIGH>;
             #phy-cells =3D <0>;
     };
--=20
2.26.2

