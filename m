Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 230B2272F4B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 18:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730080AbgIUQ4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 12:56:03 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:39484 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729307AbgIUQz6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 12:55:58 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 1C5B3FB02;
        Mon, 21 Sep 2020 18:55:56 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id LDczi--xHyzy; Mon, 21 Sep 2020 18:55:55 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 11CD7457CD; Mon, 21 Sep 2020 18:55:53 +0200 (CEST)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 3/3] dt-binding: display: Require two rests on mantix panel
Date:   Mon, 21 Sep 2020 18:55:52 +0200
Message-Id: <71a9108f3472ba9af4bead01b1b770d1e73eb08e.1600707235.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1600707235.git.agx@sigxcpu.org>
References: <cover.1600707235.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need to reset both for the panel to show an image.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
---
 .../bindings/display/panel/mantix,mlaf057we51-x.yaml       | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/panel/mantix,mlaf057we51-x.yaml b/Documentation/devicetree/bindings/display/panel/mantix,mlaf057we51-x.yaml
index 937323cc9aaa..ba5a18fac9f9 100644
--- a/Documentation/devicetree/bindings/display/panel/mantix,mlaf057we51-x.yaml
+++ b/Documentation/devicetree/bindings/display/panel/mantix,mlaf057we51-x.yaml
@@ -35,7 +35,9 @@ properties:
   vddi-supply:
     description: 1.8V I/O voltage supply
 
-  reset-gpios: true
+  reset-gpios:
+    minItems: 2
+    maxItems: 2
 
   backlight: true
 
@@ -62,7 +64,8 @@ examples:
             avdd-supply = <&reg_avdd>;
             avee-supply = <&reg_avee>;
             vddi-supply = <&reg_1v8_p>;
-            reset-gpios = <&gpio1 29 GPIO_ACTIVE_LOW>;
+            reset-gpios = <&gpio1 29 GPIO_ACTIVE_LOW>,
+                          <&gpio1 24 GPIO_ACTIVE_LOW>;
             backlight = <&backlight>;
         };
     };
-- 
2.26.2

