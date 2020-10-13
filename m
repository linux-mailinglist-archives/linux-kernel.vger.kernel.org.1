Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84C6228CBBA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 12:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387546AbgJMKdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 06:33:04 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:45950 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730456AbgJMKcz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 06:32:55 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 17B76FB03;
        Tue, 13 Oct 2020 12:32:53 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 0HSCc21tTcpC; Tue, 13 Oct 2020 12:32:51 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 9A9CF40309; Tue, 13 Oct 2020 12:32:48 +0200 (CEST)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] dt-binding: display: Require two resets on mantix panel
Date:   Tue, 13 Oct 2020 12:32:48 +0200
Message-Id: <15d3dc7eb4e031f380be1298ed3ac9085626f26b.1602584953.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1602584953.git.agx@sigxcpu.org>
References: <cover.1602584953.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need to reset both for the panel to show an image.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
---
 .../bindings/display/panel/mantix,mlaf057we51-x.yaml          | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/mantix,mlaf057we51-x.yaml b/Documentation/devicetree/bindings/display/panel/mantix,mlaf057we51-x.yaml
index 937323cc9aaa..51f423297ec8 100644
--- a/Documentation/devicetree/bindings/display/panel/mantix,mlaf057we51-x.yaml
+++ b/Documentation/devicetree/bindings/display/panel/mantix,mlaf057we51-x.yaml
@@ -37,6 +37,9 @@ properties:
 
   reset-gpios: true
 
+  'mantix,tp-rstn-gpios':
+    description: second reset line that triggers DSI config load
+
   backlight: true
 
 required:
@@ -63,6 +66,7 @@ examples:
             avee-supply = <&reg_avee>;
             vddi-supply = <&reg_1v8_p>;
             reset-gpios = <&gpio1 29 GPIO_ACTIVE_LOW>;
+            mantix,tp-rstn-gpios = <&gpio1 24 GPIO_ACTIVE_LOW>;
             backlight = <&backlight>;
         };
     };
-- 
2.28.0

