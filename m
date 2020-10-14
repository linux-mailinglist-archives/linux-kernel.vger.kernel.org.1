Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B90228E621
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 20:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387781AbgJNSQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 14:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbgJNSQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 14:16:02 -0400
Received: from hera.iit.uni-miskolc.hu (hera.iit.uni-miskolc.hu [IPv6:2001:738:6001:500::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E516AC061755;
        Wed, 14 Oct 2020 11:16:01 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by hera.iit.uni-miskolc.hu (Postfix) with ESMTP id 6DAAA13E;
        Wed, 14 Oct 2020 19:56:50 +0200 (CEST)
X-Virus-Scanned: Kamavis at iit.uni-miskolc.hu
Received: from hera.iit.uni-miskolc.hu ([127.0.0.1])
        by localhost (hera.iit.uni-miskolc.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id S3eFa0kWtMZr; Wed, 14 Oct 2020 19:56:44 +0200 (CEST)
Received: from titan.hitronhub.home (unknown [IPv6:2a02:8109:a180:908:226:9eff:fe30:2af8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: szucst@iit.uni-miskolc.hu)
        by hera.iit.uni-miskolc.hu (Postfix) with ESMTPSA id 8DFCF13F;
        Wed, 14 Oct 2020 19:56:38 +0200 (CEST)
From:   =?UTF-8?q?Tam=C3=A1s=20Sz=C5=B1cs?= <tszucs@protonmail.ch>
To:     Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        JC Kuo <jckuo@nvidia.com>, Vidya Sagar <vidyas@nvidia.com>,
        Sameer Pujar <spujar@nvidia.com>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Tam=C3=A1s=20Sz=C5=B1cs?= <tszucs@protonmail.ch>
Subject: [PATCH v3 2/5] arm64: tegra: Specify sdhci clock parent for Tegra194 SDMMC1 and SDMMC3
Date:   Wed, 14 Oct 2020 19:56:24 +0200
Message-Id: <20201014175627.5585-3-tszucs@protonmail.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201014175627.5585-1-tszucs@protonmail.ch>
References: <20201014175627.5585-1-tszucs@protonmail.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use PLLC4_MUXED as clock source for SDMMC1 and SDMMC3 core clocks. This enables
more suitable interface clocks for higher data rate modes.

Signed-off-by: Tamás Szűcs <tszucs@protonmail.ch>
---
 arch/arm64/boot/dts/nvidia/tegra194.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index 058fdb1ffa1a..7e3ceeb5bc43 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -701,6 +701,9 @@
 			clocks = <&bpmp TEGRA194_CLK_SDMMC1>,
 				 <&bpmp TEGRA194_CLK_SDMMC_LEGACY_TM>;
 			clock-names = "sdhci", "tmclk";
+			assigned-clocks = <&bpmp TEGRA194_CLK_SDMMC1>,
+					  <&bpmp TEGRA194_CLK_PLLC4_MUXED>;
+			assigned-clock-parents = <&bpmp TEGRA194_CLK_PLLC4_MUXED>;
 			resets = <&bpmp TEGRA194_RESET_SDMMC1>;
 			reset-names = "sdhci";
 			interconnects = <&mc TEGRA194_MEMORY_CLIENT_SDMMCRA &emc>,
@@ -739,6 +742,9 @@
 			clocks = <&bpmp TEGRA194_CLK_SDMMC3>,
 				 <&bpmp TEGRA194_CLK_SDMMC_LEGACY_TM>;
 			clock-names = "sdhci", "tmclk";
+			assigned-clocks = <&bpmp TEGRA194_CLK_SDMMC3>,
+					  <&bpmp TEGRA194_CLK_PLLC4_MUXED>;
+			assigned-clock-parents = <&bpmp TEGRA194_CLK_PLLC4_MUXED>;
 			resets = <&bpmp TEGRA194_RESET_SDMMC3>;
 			reset-names = "sdhci";
 			interconnects = <&mc TEGRA194_MEMORY_CLIENT_SDMMCR &emc>,
-- 
2.20.1

