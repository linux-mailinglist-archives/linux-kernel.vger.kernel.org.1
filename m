Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 510362F4460
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 07:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbhAMGIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 01:08:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbhAMGIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 01:08:22 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701FFC061794
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 22:07:42 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id x18so478008pln.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 22:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y4TBp5q5xBws0la/+DZ2ckUg4m79Non3qFa6SgDcWGg=;
        b=cDWSghPuufn3T/EV4JMXVWkh1S3fdRZCrnlPlTRZ16a14aNsXdZDxwWefE0Xp2/i+j
         I8I9yNwSp696MaDC4TjhRJzfP08lzdEYiByq63mRxRM6LmQ2/4dpovkrZkOH71TdzI9c
         OFE8vud+3hPk2DXiUW4WFGyysg9gj2TiPRvv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y4TBp5q5xBws0la/+DZ2ckUg4m79Non3qFa6SgDcWGg=;
        b=rKYbmRfH1eA8BWldGyPlk5lTas5nYWfmEE9EIh8boU1R99YdsJzcqLCGpNZFws6aHo
         2oXWkm5CgcORUXeU8xzfnB9TRuN0TxtqE6LCxyd2U6JOC6grX6Mugsr61HL24b5e4lCU
         da4szbgTp3lS+ntOKFJiCZzKmnuMAwfeayAWN/oHdM26iwEZzKXpVG4rLSgLRs5N8iil
         D/mOHrsDth6RPk0Jo0WMfcxaAuaOE8HMBTeI/UCidgX0nRMCqim+4KAe6746J2tlVvjc
         zhJpE5FbtblSiC6QHu5nYSTqUmgdML+RpfgknJIUrTYj7HeE6Wdjs2eUBcJZKH6SYq3v
         xs+w==
X-Gm-Message-State: AOAM531HHfhVpHGTjTmtYt4x7JT3ME67zwxezzG0n5adrwSquaFL5TmO
        Bf6fcQIy+OhvStmwIynOnlzpUQ==
X-Google-Smtp-Source: ABdhPJwqMhVQ0Txr7qf6NuMmSKMEj9dyClnXj9xuJtJgQ8aqhJwQ6WKmInVyh+8BthBlx3DeNuntPQ==
X-Received: by 2002:a17:90a:e28c:: with SMTP id d12mr543887pjz.236.1610518062063;
        Tue, 12 Jan 2021 22:07:42 -0800 (PST)
Received: from drinkcat2.tpe.corp.google.com ([2401:fa00:1:b:7220:84ff:fe09:41dc])
        by smtp.gmail.com with ESMTPSA id y21sm1263556pfr.90.2021.01.12.22.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 22:07:41 -0800 (PST)
From:   Nicolas Boichat <drinkcat@chromium.org>
To:     Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Cc:     Tomeu Vizoso <tomeu.vizoso@collabora.com>, fshao@chromium.org,
        boris.brezillon@collabora.com, hsinyi@chromium.org,
        hoegsberg@chromium.org, Nicolas Boichat <drinkcat@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v10 1/4] dt-bindings: gpu: mali-bifrost: Add Mediatek MT8183
Date:   Wed, 13 Jan 2021 14:07:00 +0800
Message-Id: <20210113140546.v10.1.Ie74d3355761aab202d4825ac6f66d990bba0130e@changeid>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
In-Reply-To: <20210113060703.3122661-1-drinkcat@chromium.org>
References: <20210113060703.3122661-1-drinkcat@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define a compatible string for the Mali Bifrost GPU found in
Mediatek's MT8183 SoCs.

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
---

Changes in v10:
 - Fix the binding to make sure sram-supply property can be provided.

Changes in v6:
 - Rebased, actually tested with recent mesa driver.
 - No change

Changes in v5:
 - Rename "2d" power domain to "core2"

Changes in v4:
 - Add power-domain-names description
   (kept Alyssa's reviewed-by as the change is minor)

Changes in v3:
 - No change

 .../bindings/gpu/arm,mali-bifrost.yaml        | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
index 184492162e7e..eac561582063 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
@@ -17,6 +17,7 @@ properties:
     items:
       - enum:
           - amlogic,meson-g12a-mali
+          - mediatek,mt8183-mali
           - realtek,rtd1619-mali
           - rockchip,px30-mali
       - const: arm,mali-bifrost # Mali Bifrost GPU model/revision is fully discoverable
@@ -41,6 +42,8 @@ properties:
 
   mali-supply: true
 
+  sram-supply: true
+
   operating-points-v2: true
 
   power-domains:
@@ -87,6 +90,31 @@ allOf:
     then:
       required:
         - resets
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: mediatek,mt8183-mali
+    then:
+      properties:
+        power-domains:
+          description:
+            List of phandle and PM domain specifier as documented in
+            Documentation/devicetree/bindings/power/power_domain.txt
+          minItems: 3
+          maxItems: 3
+        power-domain-names:
+          items:
+            - const: core0
+            - const: core1
+            - const: core2
+      required:
+        - sram-supply
+        - power-domains
+        - power-domains-names
+    else:
+      properties:
+        sram-supply: false
 
 examples:
   - |
-- 
2.30.0.284.gd98b1dd5eaa7-goog

