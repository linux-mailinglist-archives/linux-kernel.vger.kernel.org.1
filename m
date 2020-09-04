Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9096225DC5D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Sep 2020 16:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730321AbgIDOyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Sep 2020 10:54:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:48198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730547AbgIDOxq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 10:53:46 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33F8320770;
        Fri,  4 Sep 2020 14:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599231225;
        bh=UjRtVFsweDhdIycF+lr5Y7PJSCnETWb4dsCJaI8sfOs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PPxEWezNOGZYmltiUWHVmUwGk5JWUsPhpuQztj0jmVyeUlbcwaWDuCoAjFT/uc6pk
         rhg8b6XJsBA4hMB0M66EA3VuV5wTxP8GxbjXfnGr3VIUKYj+RBFGSgbzorz2PREnNA
         udPsE5krYoExke8rvpA8i3HVDgMz0OMB+CUohAKU=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sam Ravnborg <sam@ravnborg.org>, Li Yang <leoyang.li@nxp.com>,
        Robert Chiras <robert.chiras@nxp.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, etnaviv@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 04/13] dt-bindings: gpu: vivante,gc: Add common properties
Date:   Fri,  4 Sep 2020 16:53:03 +0200
Message-Id: <20200904145312.10960-5-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200904145312.10960-1-krzk@kernel.org>
References: <20200904145312.10960-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add common properties appearing in DTSes (cooling-cells, assigned-clocks
and others) to fix dtbs_check warnings like:

  arch/arm64/boot/dts/freescale/imx8mq-evk.dt.yaml: gpu@38000000:
    '#cooling-cells', 'assigned-clock-parents', 'assigned-clock-rates', 'assigned-clocks' do not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 Documentation/devicetree/bindings/gpu/vivante,gc.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpu/vivante,gc.yaml b/Documentation/devicetree/bindings/gpu/vivante,gc.yaml
index 4843df1ddbb6..67b71cad7b3b 100644
--- a/Documentation/devicetree/bindings/gpu/vivante,gc.yaml
+++ b/Documentation/devicetree/bindings/gpu/vivante,gc.yaml
@@ -21,6 +21,13 @@ properties:
   interrupts:
     maxItems: 1
 
+  '#cooling-cells':
+    const: 2
+
+  assigned-clock-parents: true
+  assigned-clock-rates: true
+  assigned-clocks: true
+
   clocks:
     items:
       - description: AXI/master interface clock
-- 
2.17.1

