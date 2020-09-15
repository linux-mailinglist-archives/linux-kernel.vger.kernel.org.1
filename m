Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 971DE26A5ED
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 15:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbgIONIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 09:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbgIONDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 09:03:49 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA53C06178B
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 06:03:48 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id t10so3274272wrv.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 06:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vX0wBDrE7Wq2nn//WJkF8Dib3IdNVyaQg55krU2+RVM=;
        b=A7lEcSG1nV7HMk7A+Uu53yjsYr5DLG+1EpZ4q6Dn1Cx/Ji3lFJxQs8oaImhJJQ9u9y
         ixDePh/08rw1xISVpdes394uXJ/0HJJcJduTAmU/R7d0yaKDifsaDN/UB1aTTYQmyOTd
         UHCL+8AMefTcUimMTIA/gUEI//EcgubNCl92z3purFPSVtDceorGEpKBbhkVfGRO9T49
         v+LRMX4uo1m/dGDM019SYQ3vBbApwrlm7KMAXE6sdPKpB8h0YoNAU1n9KpEkJiFNf+0t
         RvaJr6PMvKM1ST5av6kere346Z/PsC9jM9i41bQ+01kv23+yg3Lfgt+JoiYh5//WHlc7
         0U2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vX0wBDrE7Wq2nn//WJkF8Dib3IdNVyaQg55krU2+RVM=;
        b=YZiA5vaif/QzVYBr16N7Clf6FZFYlCGHLHzWtOPEQ5dlYwnMct/OgAJDm831sDejKG
         64O1KZMniEeMTrwQQWVfy5n2iHZeEejjrsM97LEDnLU+7XlxucC1U9D4PxIWQgG61Wsu
         UICfxWnUw8rflTpbNmFEo6fac5XaWleYiqcuRw3NKVmyflJjjGAkWbMHoG/QC7ZjcfR5
         FXNKF1pMHXTblKClDBWAozxMXnkawvMYXDeOSZIfoGDn7Q/FT23Lk9sT5qleR80GFyX9
         sR3bynvH1kiTaRWQJE6TcPXPeIS26cs97TiP0V3OlyJahgyUig6zvUPikUrwncqvFZ1z
         uoew==
X-Gm-Message-State: AOAM532ikWJduxSMBmtrI6Tg+hcALqUtilOykcO2f6WRQYvcu1gqg5mm
        6JIuJRWmYZRcXNab8z2JEX48Mg==
X-Google-Smtp-Source: ABdhPJyKxH0J77Hul2dQeLgqOmwvCF5xpY9DSjomP+D9iu8BXUX25mVUUXGQPbyHdi9Juw7YY8a4/Q==
X-Received: by 2002:adf:f6c8:: with SMTP id y8mr22850767wrp.217.1600175026747;
        Tue, 15 Sep 2020 06:03:46 -0700 (PDT)
Received: from bender.baylibre.local (home.beaume.starnux.net. [82.236.8.43])
        by smtp.gmail.com with ESMTPSA id t16sm27098671wrm.57.2020.09.15.06.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 06:03:46 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     kishon@ti.com, repk@triplefau.lt, devicetree@vger.kernel.org
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 2/3] dt-bindings: phy: amlogic,meson-axg-mipi-pcie-analog: remove phy cell parameter
Date:   Tue, 15 Sep 2020 15:03:38 +0200
Message-Id: <20200915130339.11079-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200915130339.11079-1-narmstrong@baylibre.com>
References: <20200915130339.11079-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Amlogic AXG MIPI + PCIe Analog PHY provides function for both PCIe and
MIPI DSI at the same time, and is not exclusive.

Thus remove the invalid phy cell parameter.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../bindings/phy/amlogic,meson-axg-mipi-pcie-analog.yaml      | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/amlogic,meson-axg-mipi-pcie-analog.yaml b/Documentation/devicetree/bindings/phy/amlogic,meson-axg-mipi-pcie-analog.yaml
index 702763a84dac..4d01f3124e1c 100644
--- a/Documentation/devicetree/bindings/phy/amlogic,meson-axg-mipi-pcie-analog.yaml
+++ b/Documentation/devicetree/bindings/phy/amlogic,meson-axg-mipi-pcie-analog.yaml
@@ -24,7 +24,7 @@ properties:
     const: amlogic,axg-mipi-pcie-analog-phy
 
   "#phy-cells":
-    const: 1
+    const: 0
 
 required:
   - compatible
@@ -36,5 +36,5 @@ examples:
   - |
     mpphy: phy {
           compatible = "amlogic,axg-mipi-pcie-analog-phy";
-          #phy-cells = <1>;
+          #phy-cells = <0>;
     };
-- 
2.22.0

