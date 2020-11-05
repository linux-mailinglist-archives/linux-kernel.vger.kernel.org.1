Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51BBE2A8656
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 19:45:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731944AbgKESpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 13:45:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:50232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731860AbgKESpQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 13:45:16 -0500
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch [84.226.167.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2508A21D81;
        Thu,  5 Nov 2020 18:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604601915;
        bh=pMNuyOWICpEbtC5xkpQ1lN6+Mh8kbWyGj+1VpzBt8cA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=S5PkdWflSfTi01gz+M/dL/+v61G0SZNhqA5ll19buBcs+Zl4zrTtLjEgY0aTXttPN
         UNJwG8YyIYNiZ92TbSj2bTkZS2wsNfrzWSTICrbkfoE3zTDN568y6KAqOOgQ3sz53b
         vhlkiRN56Quk66Esrp0h+gvmhFFGN6XdM9AtPLq0=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] ARM: dts: exynos: use generic name for max77693 motor in Midas
Date:   Thu,  5 Nov 2020 19:45:03 +0100
Message-Id: <20201105184506.215648-3-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201105184506.215648-1-krzk@kernel.org>
References: <20201105184506.215648-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a generic name for the max77693 motor driver in Exynos4412 Midas
boards to align with Devicetree specification naming convention.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos4412-midas.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos4412-midas.dtsi b/arch/arm/boot/dts/exynos4412-midas.dtsi
index 97db6e4a39a7..0889f081efd2 100644
--- a/arch/arm/boot/dts/exynos4412-midas.dtsi
+++ b/arch/arm/boot/dts/exynos4412-midas.dtsi
@@ -192,7 +192,7 @@ charger_reg: CHARGER {
 				};
 			};
 
-			max77693_haptic {
+			motor-driver {
 				compatible = "maxim,max77693-haptic";
 				haptic-supply = <&ldo26_reg>;
 				pwms = <&pwm 0 38022 0>;
-- 
2.25.1

