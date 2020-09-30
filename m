Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9961727F249
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 21:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730753AbgI3TC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 15:02:59 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:47460 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729806AbgI3TC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 15:02:59 -0400
X-Greylist: delayed 324 seconds by postgrey-1.27 at vger.kernel.org; Wed, 30 Sep 2020 15:02:58 EDT
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id 6F246A13C6;
        Wed, 30 Sep 2020 18:57:34 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at emo05-pco.easydns.vpn
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo05-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id mixK6SbgLMhN; Wed, 30 Sep 2020 18:57:34 +0000 (UTC)
Received: from jupiter.simonsouth.net (unknown [108.162.141.195])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id 6BED9A13B2;
        Wed, 30 Sep 2020 18:57:18 +0000 (UTC)
From:   Simon South <simon@simonsouth.net>
To:     robh+dt@kernel.org, heiko@sntech.de, smoch@web.de,
        t.schramm@manjaro.org, jbx6244@gmail.com, katsuhiro@katsuster.net,
        sigmaris@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Simon South <simon@simonsouth.net>
Subject: [PATCH] arm64: dts: rockchip: Pinebook Pro: Use supported PCIe link speed
Date:   Wed, 30 Sep 2020 14:56:27 -0400
Message-Id: <20200930185627.5918-1-simon@simonsouth.net>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Pinebook Pro laptops with an NVMe SSD installed, prevent random
crashes in the NVMe driver by not attempting to use a PCIe link speed
higher than that supported by the RK3399 SoC.

See commit 712fa1777207 ("arm64: dts: rockchip: add max-link-speed for
rk3399").

Fixes: 5a65505a6988 ("arm64: dts: rockchip: Add initial support for Pinebook Pro")
Signed-off-by: Simon South <simon@simonsouth.net>
---
 arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts b/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
index 06d48338c836..219b7507a10f 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
@@ -790,7 +790,6 @@ &pcie_phy {
 &pcie0 {
 	bus-scan-delay-ms = <1000>;
 	ep-gpios = <&gpio2 RK_PD4 GPIO_ACTIVE_HIGH>;
-	max-link-speed = <2>;
 	num-lanes = <4>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pcie_clkreqn_cpm>;
-- 
2.28.0

