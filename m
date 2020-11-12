Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43C592B0145
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 09:37:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbgKLIhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 03:37:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgKLIhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 03:37:13 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E295BC0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 00:37:12 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id k7so2426354plk.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 00:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zaUoYSUdJvqs+oll9H2A29HKqXrBBwjsOfx6mYBumWY=;
        b=ZIy2GJjcCFwfpMy4062YJvaK8zi7aYisftRctVk23KTPa3ygyvwW66WOCvtqPsaigT
         hEdxxfH4ogvdpV784/xVKofdQEIdDBvODGryVZX2nUzd6D+Ib3vP9ENoKqsxhg9PGFcd
         9fDP3/og/lYko6eh0JgM/HAm6rSMSGFIbu+eg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zaUoYSUdJvqs+oll9H2A29HKqXrBBwjsOfx6mYBumWY=;
        b=CukKfW2GA/SpuMCTf4NGQ0LvAkkzicyk7hK5GHM9QfTvo4v5izwP8y9SkT4j17Mdx8
         uacePaTrNCRNUGuE8y4RXoD/YTiBt739Kmen7tUCETjpXUQshA7SEstOqRHtOZLdyIAC
         E3SUmfrv2w0pYzNwxAI7Wyq3uo0VQQ45MQu+qGkZtNODO4pySHY2f4jbG3hWi/hXtqbA
         c4LUkK1fEo6H60O8FjWjKenrZGPVm5xpHqfR6BgUI7EVVqpYk4idZBsev5t5W5vvKSnM
         bFvCpVIYVCcc+YSR8XNkCPUIUzxdI+gAtF44LVz01/xWQA5mTHZ/zLpiDmHr0ohN9cn8
         CC7Q==
X-Gm-Message-State: AOAM530qzr4xpkaIxiUlGNYJMuteFRp0vK/DWGjSEC6UVTQE2h1oCp9S
        pPe9XLRU1zhMcnb0SCqh7KrTPA==
X-Google-Smtp-Source: ABdhPJy7XEDWu/EeS5RAKL2jFwMrhKq4BgMz3vXq/F1wjzEjdEFSG4EeubSX7/hJRR+IOJD+bpF1bg==
X-Received: by 2002:a17:902:7c14:b029:d4:d894:7eed with SMTP id x20-20020a1709027c14b02900d4d8947eedmr22255515pll.81.1605170232380;
        Thu, 12 Nov 2020 00:37:12 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:1a60:24ff:fe89:3e93])
        by smtp.gmail.com with ESMTPSA id a8sm4328404pfa.132.2020.11.12.00.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 00:37:11 -0800 (PST)
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
Subject: [PATCH 1/2] dt-bindings: drm/bridge: anx7625: Add power supplies
Date:   Thu, 12 Nov 2020 16:37:03 +0800
Message-Id: <20201112083704.1173908-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

anx7625 requires 3 power supply regulators.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 .../display/bridge/analogix,anx7625.yaml       | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml b/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
index 60585a4fc22b..1aa08f10d894 100644
--- a/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
@@ -34,6 +34,18 @@ properties:
     description: used for reset chip control, RESET_N pin B7.
     maxItems: 1
 
+  vdd10-supply:
+    description: Regulator that provides the supply 1.0V power.
+    maxItems: 1
+
+  vdd18-supply:
+    description: Regulator that provides the supply 1.8V power.
+    maxItems: 1
+
+  vdd33-supply:
+    description: Regulator that provides the supply 3.3V power.
+    maxItems: 1
+
   ports:
     type: object
 
@@ -55,6 +67,9 @@ properties:
 required:
   - compatible
   - reg
+  - vdd10-supply
+  - vdd18-supply
+  - vdd33-supply
   - ports
 
 additionalProperties: false
@@ -72,6 +87,9 @@ examples:
             reg = <0x58>;
             enable-gpios = <&pio 45 GPIO_ACTIVE_HIGH>;
             reset-gpios = <&pio 73 GPIO_ACTIVE_HIGH>;
+            vdd10-supply = <&pp1000_mipibrdg>;
+            vdd18-supply = <&pp1800_mipibrdg>;
+            vdd33-supply = <&pp3300_mipibrdg>;
 
             ports {
                 #address-cells = <1>;
-- 
2.29.2.222.g5d2a92d10f8-goog

