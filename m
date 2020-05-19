Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58BAA1DA4B8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 May 2020 00:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbgESWmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 May 2020 18:42:17 -0400
Received: from v6.sk ([167.172.42.174]:58594 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728194AbgESWmL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 18:42:11 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id CD2CD612F6;
        Tue, 19 May 2020 22:42:09 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v3 09/13] dt-bindings: clock: Make marvell,mmp2-clock a power controller
Date:   Wed, 20 May 2020 00:41:47 +0200
Message-Id: <20200519224151.2074597-10-lkundrak@v3.sk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200519224151.2074597-1-lkundrak@v3.sk>
References: <20200519224151.2074597-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a binding for the MMP2 power management units. As such apart from
providing the clocks, they also manage the power islands.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

---
Changes since v2:
- Added this patch

 .../devicetree/bindings/clock/marvell,mmp2-clock.yaml        | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/marvell,mmp2-clock.yaml b/Documentation/devicetree/bindings/clock/marvell,mmp2-clock.yaml
index e2b6ac96bbcb..d68f0d196e7d 100644
--- a/Documentation/devicetree/bindings/clock/marvell,mmp2-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/marvell,mmp2-clock.yaml
@@ -42,12 +42,16 @@ properties:
   '#reset-cells':
     const: 1
 
+  '#power-domain-cells':
+    const: 1
+
 required:
   - compatible
   - reg
   - reg-names
   - '#clock-cells'
   - '#reset-cells'
+  - '#power-domain-cells'
 
 additionalProperties: false
 
@@ -61,4 +65,5 @@ examples:
       reg-names = "mpmu", "apmu", "apbc";
       #clock-cells = <1>;
       #reset-cells = <1>;
+      #power-domain-cells = <1>;
     };
-- 
2.26.2

