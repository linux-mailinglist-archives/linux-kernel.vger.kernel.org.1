Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEE7826A5F1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 15:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbgIONJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 09:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbgIONDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 09:03:49 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9164C061788
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 06:03:46 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id z9so3396990wmk.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 06:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hTMmw7cDb/Q8xHmIbpSzi8XliWIPH8G939s4NmbDgjs=;
        b=OPNLQs9bObumhLvVLyYmqL5evLWsMZSh3I09yJYb6WV+4xFmDXcR74QfOG3wAtcdDM
         cV60Bp2v8vzOch8MOLB0HWE2oY1q4i02nHWirILnLII1tGJYr+23zqZkeeLb07fLBklZ
         y3yB4tckZ/axNi+Tupn/DteDRvKRPQ/ajpHYyNzL0LFK1YJLV97V7dyjbVsOGDUeipT7
         ngpWbrvDx/p7OEbdn+6+X1n2Q3CBQYhI3Mv37/JyhrYacSBSE/lKP/1hqoeeAosahcJm
         BsuOjDUk6p4QM/EOOYpnwSISyyJa1Ow17lx88F40J4orXVbBnuM3ERBORmaLU+C3M1tO
         xkOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hTMmw7cDb/Q8xHmIbpSzi8XliWIPH8G939s4NmbDgjs=;
        b=ORZ3U7w6yaRoy0GYeZa86oVDJyOEBlqIIYTgpLfCvPXevEnjz1YqdCWqXlkRkqSe+k
         MTb5XkWA9q85F1eYnunMF4TtTWR5sCSvMTTsjuTjaETRF7s5g5U/9h97Mzrfvo+3PQaR
         pZjW13YVYW2OThvXdfeRqVU2qM2il+xxcSWEQqRNfTj6SivNGaSWJVcLKSIcMlxGLEGo
         QERIpFgm/APDGl5HePDWrgEmVNvCy9s9/VW+NfJ+K6GYzu1MrP3AQ4Cu5uaafNIdchVp
         Vs23VKAK2XKCyvoEEmPiwqF+M+vKCFNOsal5FjYIbV7B2MsKc7eZOq+DDApoeeJ0m0dq
         Zi2w==
X-Gm-Message-State: AOAM532bPXd321+EJ4WntjR/Tf/DmKG4dpOIo9UtfXb/S2x27JoAJ86u
        VWuyCZpU321bwf5j9rekYLFBqA==
X-Google-Smtp-Source: ABdhPJyr+qSNFVd6jRIg7M8zkUejJULi6GDU8qVcdpcAcd9/G9WIiLkoNZXXOe2hBywHmuAKX3EdOg==
X-Received: by 2002:a1c:3bd7:: with SMTP id i206mr4714210wma.162.1600175025305;
        Tue, 15 Sep 2020 06:03:45 -0700 (PDT)
Received: from bender.baylibre.local (home.beaume.starnux.net. [82.236.8.43])
        by smtp.gmail.com with ESMTPSA id t16sm27098671wrm.57.2020.09.15.06.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 06:03:44 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     kishon@ti.com, repk@triplefau.lt, devicetree@vger.kernel.org
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 1/3] dt-bindings: phy: amlogic,meson-axg-mipi-pcie-analog: remove reg attribute
Date:   Tue, 15 Sep 2020 15:03:37 +0200
Message-Id: <20200915130339.11079-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200915130339.11079-1-narmstrong@baylibre.com>
References: <20200915130339.11079-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PHY registers happens to be at the beginning of a large zone containing
interleaved system registers (mainly clocks, power management, PHY control..),
found in all Amlogic SoC so far.

The goal is to model it the same way as the other "features" of this zone,
like Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt
and Documentation/devicetree/bindings/power/amlogic,meson-ee-pwrc.yaml
and have a coherent bindings scheme over the Amlogic SoCs.

This update the description, removed the reg attribute then updates the example
accordingly.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../phy/amlogic,meson-axg-mipi-pcie-analog.yaml | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/amlogic,meson-axg-mipi-pcie-analog.yaml b/Documentation/devicetree/bindings/phy/amlogic,meson-axg-mipi-pcie-analog.yaml
index 18c1ec5e19ad..702763a84dac 100644
--- a/Documentation/devicetree/bindings/phy/amlogic,meson-axg-mipi-pcie-analog.yaml
+++ b/Documentation/devicetree/bindings/phy/amlogic,meson-axg-mipi-pcie-analog.yaml
@@ -9,27 +9,32 @@ title: Amlogic AXG shared MIPI/PCIE analog PHY
 maintainers:
   - Remi Pommarel <repk@triplefau.lt>
 
+description: |+
+  The Everything-Else Power Domains node should be the child of a syscon
+  node with the required property:
+
+  - compatible: Should be the following:
+                "amlogic,meson-gx-hhi-sysctrl", "simple-mfd", "syscon"
+
+  Refer to the the bindings described in
+  Documentation/devicetree/bindings/mfd/syscon.yaml
+
 properties:
   compatible:
     const: amlogic,axg-mipi-pcie-analog-phy
 
-  reg:
-    maxItems: 1
-
   "#phy-cells":
     const: 1
 
 required:
   - compatible
-  - reg
   - "#phy-cells"
 
 additionalProperties: false
 
 examples:
   - |
-    mpphy: phy@0 {
+    mpphy: phy {
           compatible = "amlogic,axg-mipi-pcie-analog-phy";
-          reg = <0x0 0xc>;
           #phy-cells = <1>;
     };
-- 
2.22.0

