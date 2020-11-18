Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DEC52B78C4
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 09:34:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbgKRIaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 03:30:09 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:53658 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727685AbgKRIaF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 03:30:05 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 9C0D7FB07;
        Wed, 18 Nov 2020 09:30:02 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id UZEnq6OT2nTX; Wed, 18 Nov 2020 09:30:01 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id C3FB443F73; Wed, 18 Nov 2020 09:29:53 +0100 (CET)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Ondrej Jirman <megous@megous.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        allen <allen.chen@ite.com.tw>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/6] dt-binding: display: mantix: Add compatible for panel from YS
Date:   Wed, 18 Nov 2020 09:29:53 +0100
Message-Id: <eb2a0e50cbb8cfebc27d259607e543fedb8c6b27.1605688147.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1605688147.git.agx@sigxcpu.org>
References: <cover.1605688147.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This panel from Shenzhen Yashi Changhua Intelligent Technology Co
uses the same driver IC but a different LCD.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 .../devicetree/bindings/display/panel/mantix,mlaf057we51-x.yaml  | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/panel/mantix,mlaf057we51-x.yaml b/Documentation/devicetree/bindings/display/panel/mantix,mlaf057we51-x.yaml
index 51f423297ec8..9e78f2e60f99 100644
--- a/Documentation/devicetree/bindings/display/panel/mantix,mlaf057we51-x.yaml
+++ b/Documentation/devicetree/bindings/display/panel/mantix,mlaf057we51-x.yaml
@@ -20,6 +20,7 @@ properties:
   compatible:
     enum:
       - mantix,mlaf057we51-x
+      - ys,ys57pss36bh5gq
 
   port: true
   reg:
-- 
2.29.2

