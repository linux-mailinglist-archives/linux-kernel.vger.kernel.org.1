Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED1D52C4F90
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 08:34:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731052AbgKZHdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 02:33:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:45218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730149AbgKZHdq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 02:33:46 -0500
Received: from wens.tw (mirror2.csie.ntu.edu.tw [140.112.30.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B384F20DD4;
        Thu, 26 Nov 2020 07:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606376025;
        bh=k//4bcHWV3nCxnjDrzlPndrPPL6OH6Rfq6mk/LsgvYA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nQ25SNWDPvlhULo5y/v3hZxy0D5Y5KnvPzF6ryvoGEEIByVcu4bW1oAsdH3EagQdg
         y3loBePWgef3x4D+CNfLNXR3MC3zq5Il6RFzNlG9Jgx/hbFWeHnkzylSuQe2DiYlR5
         7ZucM2vxRUlABizcyz8aPLTBJlliJY0g517QjgA0=
Received: by wens.tw (Postfix, from userid 1000)
        id F103C5FA9D; Thu, 26 Nov 2020 15:33:42 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] arm64: dts: rockchip: rk3328-roc-cc: Enable analog audio
Date:   Thu, 26 Nov 2020 15:33:36 +0800
Message-Id: <20201126073336.30794-4-wens@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201126073336.30794-1-wens@kernel.org>
References: <20201126073336.30794-1-wens@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

Now that driver support for the RK3328's audio codec, and the plumbing
is defined at the SoC level, we can enable analog audio at the board
level.

Enable analog audio by enabling the codec and the I2S interface
connected and the simple-audio-card that binds them together.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts b/arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts
index 697fce709031..19959bfba451 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts
@@ -104,6 +104,14 @@ user_led: led-1 {
 	};
 };
 
+&analog_sound {
+	status = "okay";
+};
+
+&codec {
+	status = "okay";
+};
+
 &cpu0 {
 	cpu-supply = <&vdd_arm>;
 };
@@ -278,6 +286,10 @@ &i2s0 {
 	status = "okay";
 };
 
+&i2s1 {
+	status = "okay";
+};
+
 &io_domains {
 	status = "okay";
 
-- 
2.29.2

