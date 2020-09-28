Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA9F527B18E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 18:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgI1QOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 12:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbgI1QOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 12:14:19 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A77C7C0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 09:14:18 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id d4so1718673wmd.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 09:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vbHHP40xkg2uYk/UH9HSDIAS1kguxIesOVY207PSNWM=;
        b=FNsS1JaCt6m6mE/WfI8++x/y/+lxIpJoJGF+TsZB7s2VnQlOiprldL24g4EEBMhIdy
         pnZySMRZ91Rnxw8DhYbli2oDrlt/yfizs5leKTyZTtrLVjQVEsA4YoxPrtH8LtCPWE6F
         WtC37v5DzATeRgAGn9bfM8Iuw6HOBVgpTlswzf5QNYoDruGAsPupPfRvUDGCsL+YeAVT
         E9U25/3fjIddYm3az2X4p7/xeazYapF4KNfMDiGpQbUnZdYDnXNL60W83gjKuUWkq8JN
         hMpJLyNXdvsc9VRFFQehVCnOiw95MvMihshOxAi8s1ueIg6qZ6m5Aagp6fPid5/kCdF2
         g83A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vbHHP40xkg2uYk/UH9HSDIAS1kguxIesOVY207PSNWM=;
        b=tYyldLqtz/tulihXF3nBlYbl0NJ+uTr2ZyJWXUrWim6mwNPE9oGu80MbOlGcBPeJho
         fMvKylfNXS4CJj/K6a6Gfunzr6avW4f0BD1mPIriYqXuoMW1rBUxaHWsprTpawewjgQY
         JZ7AHmjqe7pIlyQ6T/FlZhRjN0icctm3jZZeb4etBUW8wYCxSI6kY2oww/FxnmwdVczb
         SPC0xb/9Kqd+tRZbyXUQJ/+/IrYewxjTbpVGEMcSchRTO7jZk0lo6GxSBvG1DYYI05JH
         awLXBNDZZbrsYmoo17AmyaH40jieAlzmI7NK6VU/d827mwygE/soznJGECeZkhDUUNW4
         CFoQ==
X-Gm-Message-State: AOAM531xdmclzZHhIoHtGP629WV8agF4n0e7IvlUHmmEU1HhHDi9Kb0D
        icZpbDjBAt/SkTARaUO7b9K13w==
X-Google-Smtp-Source: ABdhPJz2Xorp3vXaFUhQ6uWGhTbeVdxJs51CEXnFKiSt47Nj3cKxXsEMNjeoSd7oepsFB9yy40noNg==
X-Received: by 2002:a7b:c848:: with SMTP id c8mr2254953wml.184.1601309657138;
        Mon, 28 Sep 2020 09:14:17 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e35:2ec0:82b0:19c2:a71d:5af8:dbf6])
        by smtp.gmail.com with ESMTPSA id n4sm2004867wrp.61.2020.09.28.09.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 09:14:16 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     hverkuil-cisco@xs4all.nl, devicetree@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-media@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] dt-bindings: media: Add bindings for the Amlogic GE2D Accelerator Unit
Date:   Mon, 28 Sep 2020 18:14:08 +0200
Message-Id: <20200928161411.323581-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200928161411.323581-1-narmstrong@baylibre.com>
References: <20200928161411.323581-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GE2D is a 2D accelerator with various features like configurable blitter
with alpha blending, frame rotation, scaling, format conversion and colorspace
conversion.

This adds the bindings for the GE2D version found in the AXG SoCs Family.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../bindings/media/amlogic,axg-ge2d.yaml      | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/amlogic,axg-ge2d.yaml

diff --git a/Documentation/devicetree/bindings/media/amlogic,axg-ge2d.yaml b/Documentation/devicetree/bindings/media/amlogic,axg-ge2d.yaml
new file mode 100644
index 000000000000..bee93bd84771
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/amlogic,axg-ge2d.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2020 BayLibre, SAS
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/media/amlogic,axg-ge2d.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Amlogic GE2D Acceleration Unit
+
+maintainers:
+  - Neil Armstrong <narmstrong@baylibre.com>
+
+properties:
+  compatible:
+    enum:
+      - amlogic,axg-ge2d
+
+  interrupts:
+    minItems: 1
+
+  reg:
+    minItems: 1
+
+  resets:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - resets
+
+additionalProperties: false
+
+examples:
+  - |
+    ge2d: ge2d@ff940000 {
+          compatible = "amlogic,axg-ge2d";
+          reg = <0xff940000 0x10000>;
+          interrupts = <150>;
+          clocks = <&clk_ge2d>;
+          resets = <&reset_ge2d>;
+    };
-- 
2.25.1

