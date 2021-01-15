Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2FB2F7371
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 08:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731098AbhAOHDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 02:03:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726886AbhAOHDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 02:03:42 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1700FC061757
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 23:03:02 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id n7so5447033pgg.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 23:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rU651G1q8SPGxvy1RlE5EGkWyPFzSWihmuiOJwz0Sb0=;
        b=UiPe/K8OEIfEc+DaQYUt/imBoVx48hzIE4EuvFN5bSYro7pRpKZ/V+ScLTWxzaG9Dp
         QGOkdL4tbMdnjHEr5/+fQOv0zQlbMzudRg3ByfTIFLTqZVwHdFUpZFz5pOoHo9BfQ2L4
         PdlnbVHqBY8mtTqp7AMHnzwYmjtGZQVf/N/C0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rU651G1q8SPGxvy1RlE5EGkWyPFzSWihmuiOJwz0Sb0=;
        b=mC0EdhhcZauTal4yfbOG4wq+uZj9BPapymKZtaWlKmu8181G9UF1A7yg7d81PCRgsR
         RA51kqdeF9v4/82USz8Ra+ckmmGvfNFxGt0OSFK+RCjSnWArtbXPK5ZHd6aZ9I3pU8kE
         BurW0SYv114QhLGnXetqQ6pmUiX6UOTaz17EauYktg/jTL4Pr7WN14HbSA0BCkBYD86s
         dywSiPB1vmOcaMbbBn5cIZrvZmL8FBsV4NIPzlJlnxpiEEqRK0EdqmAXaZyN28lkbIk3
         svdc0xAv0z6YkvaypskyXMp/k1LnPrWpOSdS1g0YURLJVHa3mj9+A/mg7+7cw0eU85fk
         sEqA==
X-Gm-Message-State: AOAM530zPS/4uhFVyoFapoYWbLvWhQ6UBMXMQgCnP83flCs/8FkO4HZJ
        qPK5Bkr7SGkNgVYVanhKpNNHiQ==
X-Google-Smtp-Source: ABdhPJwwnHBqKTxgk9dBqJY8K268Shf+AZRV+hcUdg8NVF2FkJLIhWDbWyQZX6vKfEEIWEih66QInQ==
X-Received: by 2002:a63:5642:: with SMTP id g2mr11276841pgm.434.1610694181339;
        Thu, 14 Jan 2021 23:03:01 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:1a60:24ff:fe89:3e93])
        by smtp.gmail.com with ESMTPSA id x12sm7101064pfj.25.2021.01.14.23.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 23:03:00 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Xin Ji <xji@analogixsemi.com>, David Airlie <airlied@linux.ie>
Cc:     Sam Ravnborg <sam@ravnborg.org>, Rob Herring <robh+dt@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Subject: [PATCH v3 1/2] dt-bindings: drm/bridge: anx7625: Add power supplies
Date:   Fri, 15 Jan 2021 15:02:50 +0800
Message-Id: <20210115070250.2271571-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

anx7625 requires 3 power supply regulators.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Reviewed-by: Rob Herring <robh@kernel.org>
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
2.30.0.284.gd98b1dd5eaa7-goog

