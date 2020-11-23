Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65FC62BFECD
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 04:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbgKWDrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 22:47:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbgKWDrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 22:47:15 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49436C0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 22 Nov 2020 19:47:14 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id 62so12977378pgg.12
        for <linux-kernel@vger.kernel.org>; Sun, 22 Nov 2020 19:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NBFTSOV5X132dLJFilDGPY0gccuN+TXfuq0RMp4Oqzw=;
        b=JEuH55PhaK7IO9cw/CxjGzrdcTknRer/qrRcyHH+scTgYPXovzkSmgH5n9ZJp9T1uY
         JrbUAqwU2aZHbvaHIjeg5DFe5fhzeBWqivQEKX1vCZNnUKADweCUN0hQuZSeRIzAwKnI
         pZ8aiN5SLHO6+CQEKtN1cBrHrsfXgAsiSF4QI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NBFTSOV5X132dLJFilDGPY0gccuN+TXfuq0RMp4Oqzw=;
        b=NX+IgG58P3Up0UWRxQ0zE7QcK5/CzJLptIN29w/bxYk4e3UL+a9KYrpbEUWy1c/lk0
         hQ7az1ojKAm0WoRZ/21M0ZDK+vVrdUU+1AYYooPnK/UTyPHkA1v63rGPPstWPFK4bWFX
         sxNQBPvO1z/eHMG9qAwG/Z7SBioAJwP4GzS5x77W0fd/HcPLkIhinFVgPiyhYqpk20nb
         KqSX0ZFz1Dki0L+avv+9Bwl3B2sU8jpzT/bAybU30gnRHDTIpkmwLgpugXEDgnPaNLea
         JSOs8Yu9tLerJ4g1QUFxPDzdzfGsLChdvcWnTnIZaLx/ZSBDJ6HU+s3bGrFYbEKKpwLp
         vmpQ==
X-Gm-Message-State: AOAM531AESWArM3rKrQRk9NAIQAIYj9n+8UDDkbjzfGo49hSplzBqDME
        y2uOA+HNq3z7lX+q3Mt7rTo5/g==
X-Google-Smtp-Source: ABdhPJzpgoMOf+q/nprXjb6p03ctbOnQTmYQujTxfTsmLUeR6e38hwpr+BcyG1jJ5h09Ok3ZKHNC6w==
X-Received: by 2002:a17:90b:3647:: with SMTP id nh7mr7221696pjb.114.1606103233806;
        Sun, 22 Nov 2020 19:47:13 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:1a60:24ff:fe89:3e93])
        by smtp.gmail.com with ESMTPSA id m13sm149245pfa.115.2020.11.22.19.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2020 19:47:12 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Xin Ji <xji@analogixsemi.com>, Sam Ravnborg <sam@ravnborg.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Subject: [PATCH v2 1/2] dt-bindings: drm/bridge: anx7625: Add power supplies
Date:   Mon, 23 Nov 2020 11:46:52 +0800
Message-Id: <20201123034652.3660584-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

anx7625 requires 3 power supply regulators.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
Change:
v2: remove maxItems for supplies
---
 .../bindings/display/bridge/analogix,anx7625.yaml | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml b/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
index 60585a4fc22b..3ae97d9523e5 100644
--- a/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
@@ -34,6 +34,15 @@ properties:
     description: used for reset chip control, RESET_N pin B7.
     maxItems: 1
 
+  vdd10-supply:
+    description: Regulator that provides the supply 1.0V power.
+
+  vdd18-supply:
+    description: Regulator that provides the supply 1.8V power.
+
+  vdd33-supply:
+    description: Regulator that provides the supply 3.3V power.
+
   ports:
     type: object
 
@@ -55,6 +64,9 @@ properties:
 required:
   - compatible
   - reg
+  - vdd10-supply
+  - vdd18-supply
+  - vdd33-supply
   - ports
 
 additionalProperties: false
@@ -72,6 +84,9 @@ examples:
             reg = <0x58>;
             enable-gpios = <&pio 45 GPIO_ACTIVE_HIGH>;
             reset-gpios = <&pio 73 GPIO_ACTIVE_HIGH>;
+            vdd10-supply = <&pp1000_mipibrdg>;
+            vdd18-supply = <&pp1800_mipibrdg>;
+            vdd33-supply = <&pp3300_mipibrdg>;
 
             ports {
                 #address-cells = <1>;
-- 
2.29.2.454.gaff20da3a2-goog

