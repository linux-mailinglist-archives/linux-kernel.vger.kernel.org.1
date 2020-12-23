Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5A3E2E2215
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 22:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729191AbgLWVan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 16:30:43 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:50599 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729110AbgLWVam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 16:30:42 -0500
X-Originating-IP: 93.29.109.196
Received: from localhost.localdomain (196.109.29.93.rev.sfr.net [93.29.109.196])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id F297D20008;
        Wed, 23 Dec 2020 21:29:59 +0000 (UTC)
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v8 2/4] dt-bindings: mfd: logicvc: Add patternProperties for the display
Date:   Wed, 23 Dec 2020 22:29:45 +0100
Message-Id: <20201223212947.160565-3-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201223212947.160565-1-paul.kocialkowski@bootlin.com>
References: <20201223212947.160565-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The LogiCVC multi-function device has a display part which is now
described in its binding. Add a patternProperties match for it.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 Documentation/devicetree/bindings/mfd/xylon,logicvc.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/xylon,logicvc.yaml b/Documentation/devicetree/bindings/mfd/xylon,logicvc.yaml
index 8a1a6625c782..9efd49c39bd2 100644
--- a/Documentation/devicetree/bindings/mfd/xylon,logicvc.yaml
+++ b/Documentation/devicetree/bindings/mfd/xylon,logicvc.yaml
@@ -46,6 +46,9 @@ patternProperties:
   "^gpio@[0-9a-f]+$":
     $ref: /schemas/gpio/xylon,logicvc-gpio.yaml#
 
+  "^display@[0-9a-f]+$":
+    $ref: /schemas/display/xylon,logicvc-display.yaml#
+
 required:
   - compatible
   - reg
-- 
2.29.2

