Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 562F7297D64
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 18:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762230AbgJXQ0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Oct 2020 12:26:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:45544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1760460AbgJXQZ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Oct 2020 12:25:59 -0400
Received: from wens.tw (mirror2.csie.ntu.edu.tw [140.112.30.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 743E920A8B;
        Sat, 24 Oct 2020 16:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603556758;
        bh=HxvS3g0S2mjIzj0EuHVkbxHyM3oroosXZefPveoKsJc=;
        h=From:To:Cc:Subject:Date:From;
        b=DHlQnsAd/aNkXXgpD0wUoDjGpF5p3QcUqpruafu2PFBaUUkKN3Dj5dSSJTghbSbE+
         XX6T3q/QQGUrqJwV4qNXsspjEgZjp2xfyZglWMF1pK3N8+xqlgXVjx/AYLkT71ZDkk
         bAe3dofHBLaj6wLVvo12QfvzbfqkhYsDE19g3a8w=
Received: by wens.tw (Postfix, from userid 1000)
        id 859865FDAF; Sun, 25 Oct 2020 00:25:46 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Maxime Ripard <mripard@kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     linux-sunxi@googlegroups.com, Chen-Yu Tsai <wens@csie.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/10] Revert "arm: sun8i: orangepi-pc-plus: Set EMAC activity LEDs to active high"
Date:   Sun, 25 Oct 2020 00:25:06 +0800
Message-Id: <20201024162515.30032-1-wens@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

This reverts commit 75ee680cbd2e4d0156b94f9fec50076361ab12f2.

Turns out the activity and link LEDs on the RJ45 port are active low,
just like on the Orange Pi PC.

Revert the commit that says otherwise.

Fixes: 75ee680cbd2e ("arm: sun8i: orangepi-pc-plus: Set EMAC activity LEDs to active high")
Fixes: 4904337fe34f ("ARM: dts: sunxi: Restore EMAC changes (boards)")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
If you have this board, please help test it.

For me, the correct lighting of the LEDs is both LEDs should be lit
when connected at 100 Mbps.
---
 arch/arm/boot/dts/sun8i-h3-orangepi-pc-plus.dts | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-pc-plus.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-pc-plus.dts
index 71fb73208939..babf4cf1b2f6 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-pc-plus.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-pc-plus.dts
@@ -53,11 +53,6 @@ aliases {
 	};
 };
 
-&emac {
-	/* LEDs changed to active high on the plus */
-	/delete-property/ allwinner,leds-active-low;
-};
-
 &mmc1 {
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
-- 
2.28.0

