Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 922852B307A
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 21:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgKNUBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 15:01:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbgKNUBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 15:01:50 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59523C0613D1;
        Sat, 14 Nov 2020 12:01:50 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id b6so14112962wrt.4;
        Sat, 14 Nov 2020 12:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GleviSu04Uw5FP7oMT3FdU05y/KDRd1HVYUy7Aq3GME=;
        b=pveyCBiKT0pSGp9hA0nzwCwtFLXJh/FT+NU6HwZPvE7afs9OfNqqQ51ac4Xmrk30fz
         MGpgfdzutTiyHEprGv3b6QHuJlME0WIsbPiar56RICQjQON1G5FEszLmXZ4CpCBlGivG
         7vdNZkqrW2pBEACXCyx1gDXxKRQ6Vmmz9mUhPpXOnT37oY9sR98al66y4wKtD+dQYDei
         nWeRjzPE3UCwLkljsETYZdUAYun2RKxlYrTrruyHH33spZsOIhzqTeUlfOYaaO5nQztS
         kZciFjLHzi1hvKHUup5QSO7xC401gwm4aSeFsBPkElEcJoZqhD8xULvXQUcWuMdCswXM
         JpJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GleviSu04Uw5FP7oMT3FdU05y/KDRd1HVYUy7Aq3GME=;
        b=qpNWUPi0etnFZDDB7ZVk9gKZb9MTgCh3VE69ZPEyQmW4DgUF+Ln/LhtG0qjt6Bs7AR
         ZR/+0ANNxd+6N8oaFSkaf0WI8KxUCP+4lRmgwh57sdINS8h6jBC3ZqLweM8vQTsGemwd
         LxjpMk1Mwl8+rTKpFGq0HwnCEzdxW2iPE3bandnJ2cS33V0jRIePxBj5PZUmBmo3XVDG
         NQT/eZXg7hgByH3+qjtgKf2FHoNjHfvEDpLTRZ0uYV0MhqDXb0NCho0LLudJGc/Fn3Qd
         s1qL4CAVAGcHCktOsC4lmI8dYmovqg3h8ukYCsymLN6BRj3+NLKhUp7cOho/GFviSd4x
         OERg==
X-Gm-Message-State: AOAM5321bY5SoWROfEwWTBsSUz7UUpSvUgJ2mBYZQkdakNtNoUl/3vTX
        KVR9XG2SZTK2/o+Q2yE1Hzkonn+OJDChXQ==
X-Google-Smtp-Source: ABdhPJwt9EMOX8eniG1+m0e565ea4vN9hkA+N6zCjnJQ3h/G9ouh60yZTq841c/nXKTxWP5OBto66g==
X-Received: by 2002:a5d:548b:: with SMTP id h11mr11143264wrv.306.1605384109053;
        Sat, 14 Nov 2020 12:01:49 -0800 (PST)
Received: from localhost.localdomain (p4fc3ea77.dip0.t-ipconnect.de. [79.195.234.119])
        by smtp.googlemail.com with ESMTPSA id g138sm14342953wme.39.2020.11.14.12.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2020 12:01:48 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     davem@davemloft.net, kuba@kernel.org,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org
Cc:     jianxin.pan@amlogic.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, khilman@baylibre.com,
        narmstrong@baylibre.com, jbrunet@baylibre.com, andrew@lunn.ch,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH RFC v1 1/4] dt-bindings: net: dwmac-meson: use picoseconds for the RGMII RX delay
Date:   Sat, 14 Nov 2020 21:01:01 +0100
Message-Id: <20201114200104.4148283-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201114200104.4148283-1-martin.blumenstingl@googlemail.com>
References: <20201114200104.4148283-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Amlogic Meson G12A, G12B and SM1 SoCs have a more advanced RGMII RX
delay register which allows picoseconds precision. Deprecate the old
"amlogic,rx-delay-ns" in favour of a new "amlogic,rgmii-rx-delay-ps"
property.

For older SoCs the only known supported values were 0ns and 2ns. The new
SoCs have 200ps precision and support RGMII RX delays between 0ps and
3000ps.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 .../bindings/net/amlogic,meson-dwmac.yaml     | 52 ++++++++++++++++++-
 1 file changed, 51 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml b/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
index 6b057b117aa0..bafde1194193 100644
--- a/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
@@ -74,18 +74,68 @@ allOf:
             Any configuration is ignored when the phy-mode is set to "rmii".
 
         amlogic,rx-delay-ns:
+          deprecated: true
           enum:
             - 0
             - 2
           default: 0
+          description:
+            The internal RGMII RX clock delay in nanoseconds. Deprecated, use
+            amlogic,rgmii-rx-delay-ps instead.
+
+        amlogic,rgmii-rx-delay-ps:
+          default: 0
           description:
             The internal RGMII RX clock delay (provided by this IP block) in
-            nanoseconds. When phy-mode is set to "rgmii" then the RX delay
+            picoseconds. When phy-mode is set to "rgmii" then the RX delay
             should be explicitly configured. When the phy-mode is set to
             either "rgmii-id" or "rgmii-rxid" the RX clock delay is already
             provided by the PHY. Any configuration is ignored when the
             phy-mode is set to "rmii".
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - amlogic,meson8b-dwmac
+              - amlogic,meson8m2-dwmac
+              - amlogic,meson-gxbb-dwmac
+              - amlogic,meson-axg-dwmac
+    then:
+      properties:
+        amlogic,rgmii-rx-delay-ps:
+          enum:
+            - 0
+            - 2000
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - amlogic,meson-g12a-dwmac
+    then:
+      properties:
+        amlogic,rgmii-rx-delay-ps:
+          enum:
+            - 0
+            - 200
+            - 400
+            - 600
+            - 800
+            - 1000
+            - 1200
+            - 1400
+            - 1600
+            - 1800
+            - 2000
+            - 2200
+            - 2400
+            - 2600
+            - 2800
+            - 3000
+
 properties:
   compatible:
     additionalItems: true
-- 
2.29.2

