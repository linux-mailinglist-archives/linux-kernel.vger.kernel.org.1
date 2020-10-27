Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1248229BFF8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 18:10:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1816892AbgJ0RKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 13:10:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:38408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1816877AbgJ0RKR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 13:10:17 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.184])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBD4620809;
        Tue, 27 Oct 2020 17:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603818616;
        bh=tpenYGq8xvh7I5sdHua+iw+/Z5oTM/rhvS5aejvfafY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KY/Etw4rl6U4yAYpCiSaUrshY3BldZO8lV2PfCLCYjZIVsgg1F09yKevIT/bCka8y
         Mlud//bkoxI0Q7v4NGdFvDIQKPFQAclskrlDzi4ebq21z9p+6tNshEcV2q0rzEsLB3
         67M9pGs8Fug06SyeSjhOHD0RBJVWZySq4htho0pk=
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
Subject: [PATCH v2 07/12] ARM: dts: exynos: adjust node names to DT spec in Odroid XU
Date:   Tue, 27 Oct 2020 18:09:42 +0100
Message-Id: <20201027170947.132725-8-krzk@kernel.org>
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
 arch/arm/boot/dts/exynos5410-odroidxu.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos5410-odroidxu.dts b/arch/arm/boot/dts/exynos5410-odroidxu.dts
index 75b4150c26d7..03dcd4e0a2f1 100644
--- a/arch/arm/boot/dts/exynos5410-odroidxu.dts
+++ b/arch/arm/boot/dts/exynos5410-odroidxu.dts
@@ -498,7 +498,7 @@ ldo35_reg: LDO35 {
 
 &i2c_1 {
 	status = "okay";
-	max98090: max98090@10 {
+	max98090: audio-codec@10 {
 		compatible = "maxim,max98090";
 		reg = <0x10>;
 		interrupt-parent = <&gpj3>;
-- 
2.25.1

