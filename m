Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62CA72B409F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 11:19:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728797AbgKPKQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 05:16:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728703AbgKPKQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 05:16:53 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC02C0613D1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 02:16:53 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id 23so18014342wrc.8
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 02:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ceCydoW0taXspmLSuwqkIqJ7k7CBWNdOO4aazBAUNz0=;
        b=SG2Ndhe6APWjlDn6wFEvBZ3ehJOUWLlIgfiAYzAPABdH4U5rx/TjUyvoLtMsvnGE5T
         qMjURWhDpgFHkUkTBxhkQE9JtPrwJ+btN6BDoOVcNzqeaPGq3Am1WfKnVjT8ZUQZofZ3
         /C2l8KmcE+5vQ3kL4ls01KicfLYWdQD1v8brhkdP50/OEjppXABLw95IHG5oDr2AcNDW
         JAhh0dCaGfmVGNOcoKS1AW+q5DlGgv3XIIy2wHQ/j2AJjA6YuNjU4PN2U7vItiShRmsX
         kBoSI4+bSJZ1Sy/2zBXWdcXqe0kRgMaBQK4khGLgB18ZzXVVzp8xOiwGw0d8cQCogixs
         AXsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ceCydoW0taXspmLSuwqkIqJ7k7CBWNdOO4aazBAUNz0=;
        b=baQzrgn3TUNzMMOYYrJXh9pa2LRVd25lONxeK1iv242eQjYcA1a1WeIwiKfuckCfWB
         65KW2sl9MTVJOW55Q1bFeqI7+8TWDXdxN33BuX39izYNX4lAWGZU4pd7HZruvCMwo3w5
         H/1iZMnBNOhACqpLumFO0SEIIzD+nJ2WOhOoEelY1gQuNI/NNXDP5u9sM9SuGHD3WpWi
         VmFpuBJJKNl8LimejWPF1Q/bfVpL9buUe0hfgiEHLOaqdMozA0QJ4k6c0LDOdFFcgkX2
         xqC6pZWfhOaqtTjM0ZG0K5W0n+YpoQZB9VgzgH9IdR5zHOdWQocTk72jrJp967Eg8Mic
         +LfA==
X-Gm-Message-State: AOAM530kAeVWyexm5dPPzsCRC6fXV/IVyUv4vQdl0e27VTDgIC+v7/Yg
        /MnSZl2gNAFew0FPwKyjIa3i9A==
X-Google-Smtp-Source: ABdhPJy7bRH4MB0eF2todERkHKwsqav6ZT/Sr2okUSKCVRiGHZhZZuaJo0eIDZb+4P8SU1UrHOLHhQ==
X-Received: by 2002:adf:8382:: with SMTP id 2mr18405195wre.227.1605521812097;
        Mon, 16 Nov 2020 02:16:52 -0800 (PST)
Received: from localhost.localdomain ([2a01:e35:2ec0:82b0:edb9:72a:9e35:6eb])
        by smtp.gmail.com with ESMTPSA id c17sm22265131wro.19.2020.11.16.02.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 02:16:51 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     kishon@ti.com, repk@triplefau.lt, devicetree@vger.kernel.org,
        vkoul@kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: [RESEND PATCH v3 1/3] dt-bindings: phy: amlogic,meson-axg-mipi-pcie-analog: remove reg attribute
Date:   Mon, 16 Nov 2020 11:16:45 +0100
Message-Id: <20201116101647.73448-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201116101647.73448-1-narmstrong@baylibre.com>
References: <20201116101647.73448-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Acked-by: Rob Herring <robh@kernel.org>
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
2.25.1

