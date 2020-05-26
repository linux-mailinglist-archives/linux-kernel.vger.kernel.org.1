Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5441D20E8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 May 2020 23:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728916AbgEMVY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 May 2020 17:24:57 -0400
Received: from vps.xff.cz ([195.181.215.36]:33754 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728691AbgEMVY5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 17:24:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1589405095; bh=Ap6uK8wlRlwEQ6ApFkn0vpW/EZbdw2PESAGeDr+TkRw=;
        h=From:To:Cc:Subject:Date:References:From;
        b=JS4QEg9gGvHX5mB6d9B2VoKl9rJ/eEHbteW48SZGf3jaO8PiYkrltWf7IoEdF8v9D
         1AzjXK/tWow3XK+s2LJM4PKqx/eZSupVDWcMRH0m5y2ThrEk8wDjKx4mMThzAXNN4J
         1iTQScpJH7ias8EAfKZMtDNhG9iSMngH3veLUK3E=
From:   Ondrej Jirman <megous@megous.com>
To:     linux-sunxi@googlegroups.com,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Icenowy Zheng <icenowy@aosc.io>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Samuel Holland <samuel@sholland.org>,
        Martijn Braam <martijn@brixit.nl>, Luca Weiss <luca@z3ntu.xyz>,
        Bhushan Shah <bshah@kde.org>, Ondrej Jirman <megous@megous.com>
Subject: [PATCH v3 1/5] dt-bindings: vendor-prefixes: Add Xingbangda
Date:   Wed, 13 May 2020 23:24:47 +0200
Message-Id: <20200513212451.1919013-2-megous@megous.com>
In-Reply-To: <20200513212451.1919013-1-megous@megous.com>
References: <20200513212451.1919013-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Icenowy Zheng <icenowy@aosc.io>

Shenzhen Xingbangda Display Technology Co., Ltd is a company which
produces LCD modules. It supplies the LCD panels for the PinePhone.

Add the vendor prefix of it.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Signed-off-by: Ondrej Jirman <megous@megous.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 442579a4c837..7504440dba36 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1139,6 +1139,8 @@ patternProperties:
     description: Xiaomi Technology Co., Ltd.
   "^xillybus,.*":
     description: Xillybus Ltd.
+  "^xingbangda,.*":
+    description: Shenzhen Xingbangda Display Technology Co., Ltd
   "^xinpeng,.*":
     description: Shenzhen Xinpeng Technology Co., Ltd
   "^xlnx,.*":
-- 
2.26.2

