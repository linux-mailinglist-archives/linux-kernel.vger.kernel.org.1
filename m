Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F03622A8651
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 19:45:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732065AbgKESp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 13:45:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:50340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731972AbgKESpU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 13:45:20 -0500
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch [84.226.167.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D9CB2087D;
        Thu,  5 Nov 2020 18:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604601919;
        bh=+Dt16E8Ek5gVL25Y/McPO/BHqpKp4fHskfY27/LJOhw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=SgTF1/qYntz9h5MCzTCGL7Xf6I/jpTqvr6MYMJrc/4JeXFmwML1Gn7kPVhA7vy0/v
         MIC3XdnfZqse4mRiduKcT1zORdJdkLTe8JjGwTIjvjX2iSrftEIjnkbrToxShD0bcr
         JYl7kBx6vVEPC9BiPmFV68h+Eux2fx4+sJfIrJnQ=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] ARM: dts: exynos: use hyphens in MFC reserved memory node names
Date:   Thu,  5 Nov 2020 19:45:05 +0100
Message-Id: <20201105184506.215648-5-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201105184506.215648-1-krzk@kernel.org>
References: <20201105184506.215648-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use hyphens instead of underscores in the MFC reserved memory node names
which is expected by naming convention, multiple dtschema files and
pointed out by dtc W=2 builds.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos-mfc-reserved-memory.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/exynos-mfc-reserved-memory.dtsi b/arch/arm/boot/dts/exynos-mfc-reserved-memory.dtsi
index 1dbf3bbff8d3..597ade3e252f 100644
--- a/arch/arm/boot/dts/exynos-mfc-reserved-memory.dtsi
+++ b/arch/arm/boot/dts/exynos-mfc-reserved-memory.dtsi
@@ -11,14 +11,14 @@ reserved-memory {
 		#size-cells = <1>;
 		ranges;
 
-		mfc_left: region_mfc_left {
+		mfc_left: region-mfc-left {
 			compatible = "shared-dma-pool";
 			no-map;
 			size = <0x2400000>;
 			alignment = <0x100000>;
 		};
 
-		mfc_right: region_mfc_right {
+		mfc_right: region-mfc-right {
 			compatible = "shared-dma-pool";
 			no-map;
 			size = <0x800000>;
-- 
2.25.1

