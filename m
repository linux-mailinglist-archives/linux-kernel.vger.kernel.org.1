Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4432EA157
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 01:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbhAEAMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 19:12:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726625AbhAEAMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 19:12:20 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FBA0C061798
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 16:11:40 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id be12so15425861plb.4
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jan 2021 16:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iIOxwRKuhHymsIpzTy5z9PcoEZ/PEx0lJ3uU4FYFr3k=;
        b=dXNP2gmNI5tB6JUO6iNPcR87fSW6UqEnHqLX3343UNHXotTDXpx/PEMG3bg0a64UkF
         hh5dEBf6XSCut6hfeQDKHDIAGK2wnpcRG1Zo7MOaVsVL8iOn8AE/n85ANWlhD65ZOSXn
         cGL5NFbebs19QVAX4/SwESvl7Vai5UrnI8H/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iIOxwRKuhHymsIpzTy5z9PcoEZ/PEx0lJ3uU4FYFr3k=;
        b=rpbljlJ5B9Rv8bObrTHd1sdjDuj2gLFq4RpYGGNrfpohpKpaEEnGpcfIaVKUlpa3Uk
         WrxiC5tnbSboqJ0zTGMJ0TZSI9Q1P7zsJ3vJ6T2/NhroZ6E/r+9IgR2C81HoQyedcWy6
         dEYm0EfXzRRjeqrrNbLreOnpnFVyEj5BoIF4GEiUWAgFqamDM10Y/zo0OUfAwghAGwN2
         XcaoVanp12IFSTGtIAmXPaQLY2KxgbmP/aOABXXSxZX5bTGN1aZSYDMbCBn4TACh0ytt
         oBc6NOxvCq0IzFJFpK66hEmqe8xmLHQJx6lP/b8zkYp/PM0M6yLVfOJC2ILtI+gd9LCn
         QAAw==
X-Gm-Message-State: AOAM531sbCiNf0+5XsT7hgY4Oeghh0IlsLLQLEBkmXzWQxYjY/adXTRy
        BHsxOcQVywinXIexHSSd1JBuEQ==
X-Google-Smtp-Source: ABdhPJyBJjIRXHDrXV1bkJfJwg71OPsxDv4EXm0yAXVTlTDPkFU2JGpPkmkhU3UlP5FXMeagOcnQug==
X-Received: by 2002:a17:90a:ae02:: with SMTP id t2mr1311186pjq.169.1609805499885;
        Mon, 04 Jan 2021 16:11:39 -0800 (PST)
Received: from drinkcat2.tpe.corp.google.com ([2401:fa00:1:b:7220:84ff:fe09:41dc])
        by smtp.gmail.com with ESMTPSA id bf3sm465620pjb.45.2021.01.04.16.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 16:11:39 -0800 (PST)
From:   Nicolas Boichat <drinkcat@chromium.org>
To:     Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Cc:     hsinyi@chromium.org, hoegsberg@chromium.org, fshao@chromium.org,
        boris.brezillon@collabora.com,
        Nicolas Boichat <drinkcat@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v6 1/4] dt-bindings: gpu: mali-bifrost: Add Mediatek MT8183
Date:   Tue,  5 Jan 2021 08:11:16 +0800
Message-Id: <20210105081111.v6.1.Ie74d3355761aab202d4825ac6f66d990bba0130e@changeid>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
In-Reply-To: <20210105001119.2129559-1-drinkcat@chromium.org>
References: <20210105001119.2129559-1-drinkcat@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define a compatible string for the Mali Bifrost GPU found in
Mediatek's MT8183 SoCs.

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
Reviewed-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
---

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

 .../bindings/gpu/arm,mali-bifrost.yaml        | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
index 184492162e7e..71b613ee5bd7 100644
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
@@ -87,6 +88,30 @@ allOf:
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
+        sram-supply: true
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
+
+      required:
+        - sram-supply
+        - power-domains
+        - power-domains-names
 
 examples:
   - |
-- 
2.29.2.729.g45daf8777d-goog

