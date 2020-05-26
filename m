Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C46A41A7612
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Apr 2020 10:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436837AbgDNI35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 04:29:57 -0400
Received: from gloria.sntech.de ([185.11.138.130]:38210 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436814AbgDNI3z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 04:29:55 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1jOGx5-0007Fi-9I; Tue, 14 Apr 2020 10:29:51 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-rockchip@lists.infradead.org
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        mark.rutland@arm.com, christoph.muellner@theobroma-systems.com,
        robin.murphy@arm.com, heiko@sntech.de,
        linux-arm-kernel@lists.infradead.org, kever.yang@rock-chips.com,
        linux-kernel@vger.kernel.org, jbx6244@gmail.com,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 2/3] dt-bindings: Add binding for Hardkernel Odroid Go Advance
Date:   Tue, 14 Apr 2020 10:29:37 +0200
Message-Id: <20200414082938.2977572-2-heiko@sntech.de>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200414082938.2977572-1-heiko@sntech.de>
References: <20200414082938.2977572-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>

Add a compatible for the Odroid Go Advance from Hardkernel.
The compatible used by the vendor already is odroid-go2, to distinguish
it from the previous (microcontroller-based) Odroid Go, so we're keeping
that, also to not cause unnecessary incompatibilites.

Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Acked-by: Rob Herring <robh@kernel.org>
---
changes in v3:
- add Rob's Ack

 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 715586dea9bb..d4a4045092df 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -358,6 +358,11 @@ properties:
           - const: haoyu,marsboard-rk3066
           - const: rockchip,rk3066a
 
+      - description: Hardkernel Odroid Go Advance
+        items:
+          - const: hardkernel,rk3326-odroid-go2
+          - const: rockchip,rk3326
+
       - description: Hugsun X99 TV Box
         items:
           - const: hugsun,x99
-- 
2.24.1

