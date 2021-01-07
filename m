Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF0FA2ECBBA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 09:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbhAGI1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 03:27:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbhAGI1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 03:27:47 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91343C0612F9
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 00:27:07 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 15so4338452pgx.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 00:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XpndNtEhPNiPnJlNZJY14B7qFPqqFru+Jd25xhO0eCA=;
        b=CCIqzTVbaqQ4xH2qjUNPXVmi3/8fMX6PZZ9aRDj7LN3QiX7o5wP18sPAnYp/cQqw2l
         zWArJJlt/c1XprpPe/fibef8DtWX+l0eiohRN0M/6SMOwm5PXqi72F4kELz93iIb9Usg
         cL97G4vq2WyRMDgPBlO++jamO95iUbcGNFPl4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XpndNtEhPNiPnJlNZJY14B7qFPqqFru+Jd25xhO0eCA=;
        b=RYNUkzGTe1LrdMdzxQ3QtHN59LRV9KCm42HtMF56U1xWXzDRguAz0sjuOx4WihY9Ao
         183dFYSgHarjyFiDCInstx7bY715okF1Q8B65dOipiZvm1SOiJyGgT4AnowU4yjzSzjt
         Gt9BQ8sO5zET4Bs6W5f6O8tuRAGX+cvAMXv/xpbGLGLeKLJaG9Lb9ZEjKcDPw8Zq/2un
         bVQnBfCwTqpglo8vgWZ4trQ1LkUoNzFxgmuOdvMCj7woCcv6hu9jnMyVkoOM8juhNfBf
         oqIJ2CzLU8OKqSgCVd4JXmvKsC616Kd75s2RpoUP2YrUHkGpJmwtDQI+2CKiN2SuTDih
         R+Hg==
X-Gm-Message-State: AOAM5319DIlp31UdM9ZiDaD+sOH79FZPbFry9lG2lmPUS76TfeNbsaew
        jhfb8HxxUJ5ymANjQa7R6xTOEyqo6nq6ew==
X-Google-Smtp-Source: ABdhPJyDRvZwDRdfn6gwo/sWqjBrwSNaAvcRYBsmcZtej2I+KzJ+rQjSlJkbD6E2xtI6RP8hdgHDDA==
X-Received: by 2002:a63:2fc5:: with SMTP id v188mr748878pgv.243.1610008027155;
        Thu, 07 Jan 2021 00:27:07 -0800 (PST)
Received: from drinkcat2.tpe.corp.google.com ([2401:fa00:1:b:7220:84ff:fe09:41dc])
        by smtp.gmail.com with ESMTPSA id o14sm5825580pgr.44.2021.01.07.00.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 00:27:06 -0800 (PST)
From:   Nicolas Boichat <drinkcat@chromium.org>
To:     Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Cc:     hoegsberg@chromium.org, fshao@chromium.org, hsinyi@chromium.org,
        boris.brezillon@collabora.com,
        Nicolas Boichat <drinkcat@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v7 1/4] dt-bindings: gpu: mali-bifrost: Add Mediatek MT8183
Date:   Thu,  7 Jan 2021 16:26:50 +0800
Message-Id: <20210107162632.v7.1.Ie74d3355761aab202d4825ac6f66d990bba0130e@changeid>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
In-Reply-To: <20210107082653.3519337-1-drinkcat@chromium.org>
References: <20210107082653.3519337-1-drinkcat@chromium.org>
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

Changes in v7:
 - Fix GPU ID in commit message

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

