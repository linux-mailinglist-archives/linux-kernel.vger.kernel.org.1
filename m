Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD08021095F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jul 2020 12:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730050AbgGAKbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jul 2020 06:31:47 -0400
Received: from vps.xff.cz ([195.181.215.36]:42084 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729986AbgGAKbe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 06:31:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1593599490; bh=Oj0dUcmJMqbWWnEM4fT6FFb2wi7F4yzS6GdUL1tM2bs=;
        h=From:To:Cc:Subject:Date:References:From;
        b=aj5FfPDT0tbje9T8LJ/JVemDlV8qwX4buTrZYBVUe2NjFwJqfb6beTFTvEJxHF9sr
         T0FmM0fWsf+BmqQeQFZ8NLTR6WwV9h4PSpWNef4q2Kthrj6FinV1Lwf4PPJmfWSaRH
         qXmRhOZfrWMMDyOOUtJCpRcN05hFlmuUIzNmkgHw=
From:   Ondrej Jirman <megous@megous.com>
To:     linux-sunxi@googlegroups.com,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Purism Kernel Team <kernel@puri.sm>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Icenowy Zheng <icenowy@aosc.io>
Cc:     Ondrej Jirman <megous@megous.com>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Samuel Holland <samuel@sholland.org>,
        Martijn Braam <martijn@brixit.nl>, Luca Weiss <luca@z3ntu.xyz>,
        Bhushan Shah <bshah@kde.org>
Subject: [PATCH v6 03/13] dt-bindings: panel: Add compatible for Xingbangda XBD599 panel
Date:   Wed,  1 Jul 2020 12:31:16 +0200
Message-Id: <20200701103126.1512615-4-megous@megous.com>
In-Reply-To: <20200701103126.1512615-1-megous@megous.com>
References: <20200701103126.1512615-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xingbangda XBD599 is a 5.99" 720x1440 MIPI-DSI LCD panel. It is based on
Sitronix ST7703 LCD controller just like rocktech,jh057n00900. It is
used in PinePhone.

Add a compatible for it.

Signed-off-by: Ondrej Jirman <megous@megous.com>
---
 .../bindings/display/panel/rocktech,jh057n00900.yaml        | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.yaml b/Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.yaml
index 928ba42e7f8d..a6985cd947fb 100644
--- a/Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.yaml
+++ b/Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.yaml
@@ -18,7 +18,11 @@ allOf:
 
 properties:
   compatible:
-    const: rocktech,jh057n00900
+    enum:
+        # Rocktech JH057N00900 5.5" 720x1440 TFT LCD panel
+      - rocktech,jh057n00900
+        # Xingbangda XBD599 5.99" 720x1440 TFT LCD panel
+      - xingbangda,xbd599
 
   reg:
     maxItems: 1
-- 
2.27.0

