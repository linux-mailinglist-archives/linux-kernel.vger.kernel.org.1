Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEC9028AAA8
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 23:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387516AbgJKVPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 17:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387503AbgJKVPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 17:15:49 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 362C0C0613CE;
        Sun, 11 Oct 2020 14:15:49 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id f21so3274457qko.5;
        Sun, 11 Oct 2020 14:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BGMwpCPny3RgndL/RIfUXJU62LlywzivkVat0IltLS0=;
        b=jdC+7BpTtu+cTAPkIlP5w1k/ZxUanuqPnx+HTUIFtDadlji8eC41pYfxEtZqOMGNIc
         7iyS8Lyp9M/aFuKXpl3pROF1WVIkl1svN3Gp1p9P+UJhntOvgxhIHvC0ulGpqVgFG4qD
         qj3KaHMRt8HK/vHilc2UUpaeAqpK5dOuHn2Jp6M4nd4DPlq+qF2DyePKxdJI/wGJZjli
         gqhcqOZCLHolUs9LwZI0uBUg3JDv0wou/A8NJTbKn15NI8YaIRVUj+ZfKThTg1MVA+2o
         nGVneKa/qXI1Ppn+eq8Fd0wKFKK3LS33YPwdyQTxQmvSohYXl98KZK0iC17YTN49yDZI
         6b5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BGMwpCPny3RgndL/RIfUXJU62LlywzivkVat0IltLS0=;
        b=Y9QFEm3TySc5B50PHzsG/X95Q98Gooke8oJ3lApnW7D6uPwWyG1hhUVAklli5qd2EK
         EHi7r0UcQyUq1H1Gup4TS15+z+fUpPh6dGtD8MaSvsbg6uaSJchwdr5DX+6eB9rPGjkj
         Z8lNua5IWm7/DkmJSd6A3/Tc1VzxI7DiipIeYw2yUSo9XmEvJmJei3I5WNoWZtTYh3bG
         ptOC4T9gsAhZEu73kd+1yJg013P5te0XzIc9XihmUZaIt5laW11kqLpedKxqsq2BqZnb
         /XlN513mEjerk3mH2G+ODXGBEvDHcxXTGs+tzB4yHT8a2Y03+G5V2P4wWyrKi1oWm7ZW
         +/Ow==
X-Gm-Message-State: AOAM532TKBZqn3Z1yI24CjlU2BGZE2IyG44W0gu1ZWr8dRVcTJPNvtfR
        ctsMyW2hYKS5PF5ZYfBHYfw=
X-Google-Smtp-Source: ABdhPJwF+SsHvmQPe51fldj5gcTyxH6Xvw9hwU6GdQyA5xDUVx06mCaJcjs3HYhYKH1bE3w1tY6wDA==
X-Received: by 2002:a05:620a:1212:: with SMTP id u18mr7304858qkj.434.1602450948374;
        Sun, 11 Oct 2020 14:15:48 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id z69sm11606403qkb.7.2020.10.11.14.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2020 14:15:47 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: sound: sun8i-a33-codec: Add Allwinner A64 codec compatible fallback
Date:   Sun, 11 Oct 2020 23:15:42 +0200
Message-Id: <20201011211543.155561-1-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

make dtbs_check report a warning because the documentation
for the A64 codec compatible is missing.

The A64 codec compatible is actually a simple fallback to the A33.

Reflect this in the dt-bindings Documentation.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 .../bindings/sound/allwinner,sun8i-a33-codec.yaml           | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/allwinner,sun8i-a33-codec.yaml b/Documentation/devicetree/bindings/sound/allwinner,sun8i-a33-codec.yaml
index 55d28268d2f4..e78a22496e7c 100644
--- a/Documentation/devicetree/bindings/sound/allwinner,sun8i-a33-codec.yaml
+++ b/Documentation/devicetree/bindings/sound/allwinner,sun8i-a33-codec.yaml
@@ -15,7 +15,11 @@ properties:
     const: 0
 
   compatible:
-    const: allwinner,sun8i-a33-codec
+    oneOf:
+      - const: allwinner,sun8i-a33-codec
+      - items:
+        - const: allwinner,sun50i-a64-codec
+        - const: allwinner,sun8i-a33-codec
 
   reg:
     maxItems: 1
-- 
2.25.1

