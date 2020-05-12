Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 261F91D01F4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 May 2020 00:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731634AbgELWWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 May 2020 18:22:15 -0400
Received: from vps.xff.cz ([195.181.215.36]:41446 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728314AbgELWWM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 18:22:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1589322129; bh=2kuqCfvBiBgSUuWgI49jTz7T7hYvoNkypGtcPc22suM=;
        h=From:To:Cc:Subject:Date:References:From;
        b=ZSclaWceGXKK8TlazmlVyjxbImVQl2CTSVLPfxDhZubC8op+g/z54lqTVRl1P09F4
         uM2G1V54TCT6q3NccRezPMtaEHcgOZz1Wr44lX2RsUU3eC1KaVrPftGaFUnlFHBif4
         DE/DEM5xwqDkELhUm0Az/4xdozKgpM9tkh8rH1p4=
From:   Ondrej Jirman <megous@megous.com>
To:     linux-sunxi@googlegroups.com,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     Ondrej Jirman <megous@megous.com>, Luca Weiss <luca@z3ntu.xyz>,
        Tomas Novotny <tomas@novotny.cz>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Rob Herring <robh@kernel.org>
Subject: [PATCH v2 1/4] dt-bindings: input: gpio-vibrator: Don't require enable-gpios
Date:   Wed, 13 May 2020 00:22:02 +0200
Message-Id: <20200512222205.1456300-2-megous@megous.com>
In-Reply-To: <20200512222205.1456300-1-megous@megous.com>
References: <20200512222205.1456300-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is possible to turn the motor on/off just by enabling/disabling
the vcc-supply.

Signed-off-by: Ondrej Jirman <megous@megous.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/input/gpio-vibrator.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/input/gpio-vibrator.yaml b/Documentation/devicetree/bindings/input/gpio-vibrator.yaml
index 2384465eaa19..c700b640bd53 100644
--- a/Documentation/devicetree/bindings/input/gpio-vibrator.yaml
+++ b/Documentation/devicetree/bindings/input/gpio-vibrator.yaml
@@ -24,7 +24,6 @@ properties:
 
 required:
   - compatible
-  - enable-gpios
 
 additionalProperties: false
 
-- 
2.26.2

