Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 078AD1A8545
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Apr 2020 18:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404813AbgDNQkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 12:40:17 -0400
Received: from mail.manjaro.org ([176.9.38.148]:47510 "EHLO mail.manjaro.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404434AbgDNQkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 12:40:07 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.manjaro.org (Postfix) with ESMTP id EB76F3742B37;
        Tue, 14 Apr 2020 18:40:04 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at manjaro.org
Received: from mail.manjaro.org ([127.0.0.1])
        by localhost (manjaro.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ZezH5E-GdSNM; Tue, 14 Apr 2020 18:40:02 +0200 (CEST)
From:   Tobias Schramm <t.schramm@manjaro.org>
To:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc:     devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Tobias Schramm <t.schramm@manjaro.org>
Subject: [PATCH 2/2] arm64: dts: rockchip: enable DC charger detection pullup
Date:   Tue, 14 Apr 2020 18:39:52 +0200
Message-Id: <20200414163952.1093784-3-t.schramm@manjaro.org>
In-Reply-To: <20200414163952.1093784-1-t.schramm@manjaro.org>
References: <20200414163952.1093784-1-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the Pinebook Pro the DC charger is detected via an open collector
transistor attached to a GPIO. This GPIO requires its pullup to be
enabled for the detection to work reliably.

Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>
---
 arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts b/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
index c3f15f5bd550..294d21bf45f5 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
@@ -788,7 +788,7 @@ lidbtn_gpio: lidbtn-gpio {
 
 	dc-charger {
 		dc_det_gpio: dc-det-gpio {
-			rockchip,pins = <4 RK_PD0 RK_FUNC_GPIO &pcfg_pull_none>;
+			rockchip,pins = <4 RK_PD0 RK_FUNC_GPIO &pcfg_pull_up>;
 		};
 	};
 
-- 
2.26.0

