Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF2520AA05
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jun 2020 02:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbgFZA4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jun 2020 20:56:07 -0400
Received: from vps.xff.cz ([195.181.215.36]:44928 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726607AbgFZA4F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 20:56:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1593132964; bh=V8lg3QrmlL/+ORB8+T8iagnNb4aO75aHpHs9Ov8wOuQ=;
        h=From:To:Cc:Subject:Date:References:From;
        b=bSmun+ESjXhcDEqOkhLNm1NAZ++s5RpXAHg8rTW4A40AhIaqSjzpfzK0URfP7B+RT
         CMQAQ4rl0aOcy+oOwAcjw0ghRJNBZFPCNfVN6CWU1G9nBWsWQh94u/e07W6zdavgFJ
         BiElb3ruXWfyLdTrd96NEk+CxebeepNO/oes36TQ=
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
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Samuel Holland <samuel@sholland.org>,
        Martijn Braam <martijn@brixit.nl>, Luca Weiss <luca@z3ntu.xyz>,
        Bhushan Shah <bshah@kde.org>,
        Ondrej Jirman <megous@megous.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v5 01/13] dt-bindings: vendor-prefixes: Add Xingbangda
Date:   Fri, 26 Jun 2020 02:55:49 +0200
Message-Id: <20200626005601.241022-2-megous@megous.com>
In-Reply-To: <20200626005601.241022-1-megous@megous.com>
References: <20200626005601.241022-1-megous@megous.com>
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
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 9aeab66be85f..740b116b179f 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1157,6 +1157,8 @@ patternProperties:
     description: Xiaomi Technology Co., Ltd.
   "^xillybus,.*":
     description: Xillybus Ltd.
+  "^xingbangda,.*":
+    description: Shenzhen Xingbangda Display Technology Co., Ltd
   "^xinpeng,.*":
     description: Shenzhen Xinpeng Technology Co., Ltd
   "^xlnx,.*":
-- 
2.27.0

