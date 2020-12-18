Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3B12DEA99
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 21:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgLRUzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 15:55:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbgLRUzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 15:55:36 -0500
Received: from leonov.paulk.fr (vpn-0-22.aquilenet.fr [IPv6:2a0c:e300:4:22::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9EB6C0617B0;
        Fri, 18 Dec 2020 12:54:55 -0800 (PST)
Received: from gagarine.paulk.fr (gagarine [192.168.1.127])
        by leonov.paulk.fr (Postfix) with ESMTPS id 1E307C0121;
        Fri, 18 Dec 2020 21:54:53 +0100 (CET)
Received: by gagarine.paulk.fr (Postfix, from userid 114)
        id 842DBC1D26; Fri, 18 Dec 2020 21:54:52 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on gagarine.paulk.fr
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=none autolearn=unavailable
        autolearn_force=no version=3.4.2
Received: from localhost.localdomain (collins [192.168.1.129])
        by gagarine.paulk.fr (Postfix) with ESMTP id 0ACE7C1D22;
        Fri, 18 Dec 2020 21:54:37 +0100 (CET)
From:   Paul Kocialkowski <contact@paulk.fr>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Paul Kocialkowski <contact@paulk.fr>
Subject: [PATCH v2 1/2] dt-bindings: pwm: allwinner: Add V3s compatible description
Date:   Fri, 18 Dec 2020 21:54:35 +0100
Message-Id: <20201218205436.2326872-1-contact@paulk.fr>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce bindings description for the V3s PWM, which is
register-compatible with the A20 PWM.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 .../devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml       | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml b/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml
index 7dcab2bf8128..04ff708fdc86 100644
--- a/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml
@@ -24,6 +24,9 @@ properties:
       - items:
           - const: allwinner,sun8i-a83t-pwm
           - const: allwinner,sun8i-h3-pwm
+      - items:
+          - const: allwinner,sun8i-v3s-pwm
+          - const: allwinner,sun7i-a20-pwm
       - items:
           - const: allwinner,sun50i-a64-pwm
           - const: allwinner,sun5i-a13-pwm
-- 
2.29.2

