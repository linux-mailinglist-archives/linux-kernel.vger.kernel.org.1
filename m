Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1DD2C4F91
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 08:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388599AbgKZHdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 02:33:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:45264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730896AbgKZHdr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 02:33:47 -0500
Received: from wens.tw (mirror2.csie.ntu.edu.tw [140.112.30.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D12F21D93;
        Thu, 26 Nov 2020 07:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606376026;
        bh=CX6BU1Zni/drTwYoTIuGnFbbK6HsOMzc5TdCbHxmoMQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DaZ/H3PaGS3CLckuKq8ZAXKPcg3LTvmGKlHW71zN+g3CwgMxcq3IrpaWeuUkM7Cue
         PUaEWNDfZrZ1fYsVHAwop47RuSc/nsuVXFhEi2y64zFDf5sHptNNWWJnlDjpukLptk
         jfnobTkQddMUJXip8aQoI/PQDlUMWKjKO6CjSb00=
Received: by wens.tw (Postfix, from userid 1000)
        id E60805FA83; Thu, 26 Nov 2020 15:33:42 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] arm64: dts: rockchip: rk3328-roc-cc: Enable HDMI audio
Date:   Thu, 26 Nov 2020 15:33:35 +0800
Message-Id: <20201126073336.30794-3-wens@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201126073336.30794-1-wens@kernel.org>
References: <20201126073336.30794-1-wens@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

The RK3328-ROC-CC already has HDMI display output enabled. Now that
audio for the HDMI controller is supported, it can be enabled as well.

Enable the simple-audio-card, and the I2S interface the audio is fed
from.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts b/arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts
index b76282e704de..697fce709031 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts
@@ -161,6 +161,10 @@ &hdmiphy {
 	status = "okay";
 };
 
+&hdmi_sound {
+	status = "okay";
+};
+
 &i2c1 {
 	status = "okay";
 
@@ -270,6 +274,10 @@ regulator-state-mem {
 	};
 };
 
+&i2s0 {
+	status = "okay";
+};
+
 &io_domains {
 	status = "okay";
 
-- 
2.29.2

