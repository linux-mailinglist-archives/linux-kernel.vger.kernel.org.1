Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1B329C010
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 18:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1816927AbgJ0RKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 13:10:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:38690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1816910AbgJ0RKa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 13:10:30 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.184])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10C29221F8;
        Tue, 27 Oct 2020 17:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603818629;
        bh=KApyVe39+tX3pYLnAPgNjOWbYuqQ5EG8GIfyKGGv2YQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y504ibIj916euy3gW8C8CpLJ1liiCaJCQk1dKxFEtqbbb3JSj1vf67HNAvRLysc0i
         Mj7NfCfF0aN1dglRPHKKY9Uo5rZTcd/jv5Q0VLzHqzuc1BMBHHj2W1edPEDVnpBBLu
         budOLw2LEj5HGQAbRdCfcXMOm/Fy/EIy0Y/yvd+o=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v2 11/12] arm64: dts: exynos: adjust node names to DT spec in Exynos7 Espresso
Date:   Tue, 27 Oct 2020 18:09:46 +0100
Message-Id: <20201027170947.132725-12-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201027170947.132725-1-krzk@kernel.org>
References: <20201027170947.132725-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Devicetree specification expects device node names to have a generic
name, representing the class of a device.  Also the convention for node
names is to use hyphens, not underscores.

No functional changes.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/exynos/exynos7-espresso.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos7-espresso.dts b/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
index 92fecc539c6c..695d4c140646 100644
--- a/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
+++ b/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
@@ -87,7 +87,7 @@ &hsi2c_4 {
 	samsung,i2c-max-bus-freq = <200000>;
 	status = "okay";
 
-	s2mps15_pmic@66 {
+	pmic@66 {
 		compatible = "samsung,s2mps15-pmic";
 		reg = <0x66>;
 		interrupts = <2 IRQ_TYPE_NONE>;
-- 
2.25.1

