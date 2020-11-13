Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 228E82B24A5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 20:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbgKMThP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 14:37:15 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:12179 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgKMTg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 14:36:56 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5faee05b0003>; Fri, 13 Nov 2020 11:36:59 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 13 Nov
 2020 19:36:55 +0000
Received: from skomatineni-linux.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Fri, 13 Nov 2020 19:36:54 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <skomatineni@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-ide@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/6] arm64: tegra: Change order of SATA resets for Tegra132 and Tegra210
Date:   Fri, 13 Nov 2020 11:36:54 -0800
Message-ID: <1605296218-2510-3-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1605296218-2510-1-git-send-email-skomatineni@nvidia.com>
References: <1605296218-2510-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605296219; bh=SLZacxLfX/pGcVfjMiInWAU35sGZ4t2qKkQO58UkiuE=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:X-NVConfidentiality:MIME-Version:Content-Type;
        b=Z8/0BidlnCn+W9OE5K6oJMUHagbS+G0f9d1VuZAgrMk5CnkZAGDg0Uji2ezyYfgEm
         xOrIOSZfmJMrnvaB1KvRvfLofDWKPrL6CKDefzs9t25B5TkeU9dihKy7KHkQQW0m6o
         0BUTUk7lP1QtAS91H/2HTwn/8gTzW/4OquFapo8WovvWvA5OtXFsVuJQeF6C4kxD9W
         JpfE6+MBi6iImL6LveEBmFDpc4DDQT9aHD0r1lu/kjSPpQVNF6thjFQhmOi4Gl6pG8
         pzccuSmTB4iJhtZ0nD2wKKYiF3jquWe1LoB4ot77eQvW3MgX4rJUBbsR/ijXzJR0kp
         93Z3CB1hP/wBg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra AHCI dt-binding doc is converted from text based to yaml based.

dtbs_check valdiation strictly follows reset-names order specified
in yaml dt-binding.

Tegra124 thru Tegra210 has 3 resets sata, sata-oob and sata-cold.
Tegra186 has 2 resets sata and sata-cold.

This patch changes order of SATA resets to maintain proper resets
order for commonly available resets across Tegra124 thru Tegra186
for dtbs_check to pass.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra132.dtsi | 6 +++---
 arch/arm64/boot/dts/nvidia/tegra210.dtsi | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra132.dtsi b/arch/arm64/boot/dts/nvidia/tegra132.dtsi
index e402815..93647fa 100644
--- a/arch/arm64/boot/dts/nvidia/tegra132.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra132.dtsi
@@ -629,9 +629,9 @@
 			 <&tegra_car TEGRA124_CLK_PLL_E>;
 		clock-names = "sata", "sata-oob", "cml1", "pll_e";
 		resets = <&tegra_car 124>,
-			 <&tegra_car 123>,
-			 <&tegra_car 129>;
-		reset-names = "sata", "sata-oob", "sata-cold";
+			 <&tegra_car 129>,
+			 <&tegra_car 123>;
+		reset-names = "sata", "sata-cold", "sata-oob";
 		status = "disabled";
 	};
 
diff --git a/arch/arm64/boot/dts/nvidia/tegra210.dtsi b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
index d47c889..31022ba 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
@@ -979,9 +979,9 @@
 			 <&tegra_car TEGRA210_CLK_SATA_OOB>;
 		clock-names = "sata", "sata-oob";
 		resets = <&tegra_car 124>,
-			 <&tegra_car 123>,
-			 <&tegra_car 129>;
-		reset-names = "sata", "sata-oob", "sata-cold";
+			 <&tegra_car 129>,
+			 <&tegra_car 123>;
+		reset-names = "sata", "sata-cold", "sata-oob";
 		status = "disabled";
 	};
 
-- 
2.7.4

