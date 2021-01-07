Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E45F32ECC24
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 10:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbhAGJBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 04:01:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727248AbhAGJBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 04:01:14 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A2CC0612FA
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 01:00:32 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id d2so3464808pfq.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 01:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uW2DZ7++hBKvfAfIb4cUFZ4hOVC2XsuncgcT5bF8JnM=;
        b=ceuRr2vCLfwVkTOq/VcGBU7S8g5DI6OExSxZXsevbMkMlUFTTtEoeSBdVJiKtsvpm9
         XXPR8oHJ/8FQKMWzYReFMSnjifWFx645G8tahx+ROxzworGzNcS5/oXqxCY8UDFGpHIS
         hHwliIjmTsby+Z8mXe3qcenaPnCKy3dd3McuQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uW2DZ7++hBKvfAfIb4cUFZ4hOVC2XsuncgcT5bF8JnM=;
        b=QFNpDh670JzIMpILDnQSIwNTpbAVVGP7xx+SAGsAmQ059lD0X2L+w/zK7zyNpPje94
         ySdFB8TFY6ta2ZqOyhjhdQDFa/uC6m7si2JxeEV2qIlEb5Xw5VM1u8j3/TO+pkSza0Y+
         LkQ7VmsSG0bY5iY2S8frWUl3rhmjg53xm2SYaJSXyzecWj129wdng+RxmREXk1P1E2bx
         Tde4ARludANcMeHmekb6TD91MMNBnH++YQ6lZh3c/yzoQrVu//qQriivWFoF7riGDRTd
         YNgBQHYmiDtGi203vjSS155rjA1o3K+l7t7fP1q0q7XoE9R4Wq31R3+0QfwK5tvbWPnv
         I70Q==
X-Gm-Message-State: AOAM530+cWKwxxujir6aWuRQn7tGZ2tF8IBMnjnYt8KPb9fvvGFZ1O/f
        hJxSi/ig5L+7Aw9knmk/6sfcnQ==
X-Google-Smtp-Source: ABdhPJzNJimZ3cRtHZh+r/SU68IFYZuuwWPhKHKnlEFoewT1OQ4PW/o2cLbm4VXer0U6Lblk0QToRQ==
X-Received: by 2002:aa7:8d12:0:b029:1ae:4344:3b4f with SMTP id j18-20020aa78d120000b02901ae43443b4fmr7649594pfe.16.1610010032321;
        Thu, 07 Jan 2021 01:00:32 -0800 (PST)
Received: from drinkcat2.tpe.corp.google.com ([2401:fa00:1:b:7220:84ff:fe09:41dc])
        by smtp.gmail.com with ESMTPSA id a29sm5022421pfr.73.2021.01.07.01.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 01:00:31 -0800 (PST)
From:   Nicolas Boichat <drinkcat@chromium.org>
To:     Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Cc:     hsinyi@chromium.org, hoegsberg@chromium.org,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        boris.brezillon@collabora.com, fshao@chromium.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v8 1/4] dt-bindings: gpu: mali-bifrost: Add Mediatek MT8183
Date:   Thu,  7 Jan 2021 17:00:19 +0800
Message-Id: <20210107170017.v8.1.Ie74d3355761aab202d4825ac6f66d990bba0130e@changeid>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
In-Reply-To: <20210107090022.3536550-1-drinkcat@chromium.org>
References: <20210107090022.3536550-1-drinkcat@chromium.org>
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

(no changes since v6)

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

