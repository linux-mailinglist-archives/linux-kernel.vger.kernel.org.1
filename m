Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3D52E77D7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 11:45:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgL3KnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 05:43:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbgL3KnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 05:43:22 -0500
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [IPv6:2001:67c:2050::465:102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E04C06179B;
        Wed, 30 Dec 2020 02:42:42 -0800 (PST)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4D5SXw699LzQlL9;
        Wed, 30 Dec 2020 11:42:40 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dylanvanassche.be;
        s=MBO0001; t=1609324959;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=zE9pI7w9PT09zHh3YcbHzixaUp3L5pqMDzMi2qR2V+U=;
        b=D7wAb4FaZtHTYXfF/S5xjFBZqIedHIkH+BmkFkDvmmzaVBiViw+EaliPMSiu7wODqUG5zG
        JOztw4vuZkmLEKLFOpUgznsiYO4k38wooYZRR32Iez7B7gLJ+dGaxqEDN9k5FzVMQBsodD
        euMxj4pemsMz8xs8/IJrXEdXR35+E0//0+dXEtDQqZh4JI6cLJYe4hG0Ft5Bt5PmA0FZ/G
        2hNe7r3yVgyuxEL9lfw31hzUZKFzC3vgDYrjfytssRBM69JM7B4hUSo5RRtO50oCwxH+aJ
        IdQWnYsLkuFUN47KvyjbowfkJ3u0VECv/4eRnEJ+GeVpgn6tkzjeG7x7sTUqBg==
Received: from smtp1.mailbox.org ([80.241.60.240])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id 6c2pRnYmJIOU; Wed, 30 Dec 2020 11:42:34 +0100 (CET)
From:   Dylan Van Assche <me@dylanvanassche.be>
To:     robh+dt@kernel.org, mripard@kernel.org, wens@csie.org,
        jernej.skrabec@siol.net, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Dylan Van Assche <me@dylanvanassche.be>
Subject: [PATCH v2] arm64: dts: sun50i-a64-pinephone: add 'pine64, pinephone' to the compatible list
Date:   Wed, 30 Dec 2020 11:42:05 +0100
Message-Id: <20201230104205.5592-1-me@dylanvanassche.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-SPAM-Probability: *
X-Rspamd-Score: 1.28 / 15.00 / 15.00
X-Rspamd-Queue-Id: CF1BF1825
X-Rspamd-UID: 03c25c
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All revisions of the PinePhone share most of the hardware.
This patch makes it easier to detect PinePhone hardware without
having to check for each possible revision.

Signed-off-by: Dylan Van Assche <me@dylanvanassche.be>
---
v2 updates the devicetree documentation as well.

 Documentation/devicetree/bindings/arm/sunxi.yaml           | 3 +++
 arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.0.dts | 2 +-
 arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.1.dts | 2 +-
 arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.2.dts | 2 +-
 4 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documentation/devicetree/bindings/arm/sunxi.yaml
index 6db32fbf813f..b6e0eb235101 100644
--- a/Documentation/devicetree/bindings/arm/sunxi.yaml
+++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
@@ -683,16 +683,19 @@ properties:
       - description: Pine64 PinePhone Developer Batch (1.0)
         items:
           - const: pine64,pinephone-1.0
+          - const: pine64,pinephone
           - const: allwinner,sun50i-a64
 
       - description: Pine64 PinePhone Braveheart (1.1)
         items:
           - const: pine64,pinephone-1.1
+          - const: pine64,pinephone
           - const: allwinner,sun50i-a64
 
       - description: Pine64 PinePhone (1.2)
         items:
           - const: pine64,pinephone-1.2
+          - const: pine64,pinephone
           - const: allwinner,sun50i-a64
 
       - description: Pine64 PineTab
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.0.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.0.dts
index 3d5a2ae9aa39..fb65319a3bd3 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.0.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.0.dts
@@ -7,7 +7,7 @@
 
 / {
 	model = "Pine64 PinePhone Developer Batch (1.0)";
-	compatible = "pine64,pinephone-1.0", "allwinner,sun50i-a64";
+	compatible = "pine64,pinephone-1.0", "pine64,pinephone", "allwinner,sun50i-a64";
 };
 
 &sgm3140 {
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.1.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.1.dts
index c9b9f6e9ee8c..5e59d3752178 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.1.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.1.dts
@@ -7,7 +7,7 @@
 
 / {
 	model = "Pine64 PinePhone Braveheart (1.1)";
-	compatible = "pine64,pinephone-1.1", "allwinner,sun50i-a64";
+	compatible = "pine64,pinephone-1.1", "pine64,pinephone", "allwinner,sun50i-a64";
 };
 
 &backlight {
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.2.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.2.dts
index acc0ab53b9c1..4e7e237cb46a 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.2.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.2.dts
@@ -7,7 +7,7 @@
 
 / {
 	model = "Pine64 PinePhone (1.2)";
-	compatible = "pine64,pinephone-1.2", "allwinner,sun50i-a64";
+	compatible = "pine64,pinephone-1.2", "pine64,pinephone", "allwinner,sun50i-a64";
 
 	wifi_pwrseq: wifi-pwrseq {
 		compatible = "mmc-pwrseq-simple";
-- 
2.26.2

