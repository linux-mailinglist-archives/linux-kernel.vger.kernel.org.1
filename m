Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C24E20E51A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jun 2020 00:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730880AbgF2Vcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jun 2020 17:32:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:60640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728680AbgF2SlE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:41:04 -0400
Received: from localhost.localdomain (unknown [194.230.155.195])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D2B62336D;
        Mon, 29 Jun 2020 08:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593418671;
        bh=GXYdB00Xh9Ytcy3fLEs6rg5v+9F5AZvA4JiNgbEGPhM=;
        h=From:To:Subject:Date:From;
        b=tZ0NIsu8qQ3b3uls0XBWOROfHzhTPBaDkP9SSgmIdgnEwUgE4VZk62Mxy5ztDcjdn
         /T30E9GKmvj9CBMbN2TcGmHjVcUvY0DQqAAnOvSWIkCy4XKtPlh0PDlDoXwMbwHP0+
         6LrE4XrBnLgRBFQICRqaQSbfntNkDcGGQzbw5ci4=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Nava kishore Manne <nava.manne@xilinx.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kalyani Akula <kalyani.akula@xilinx.com>,
        Manish Narani <manish.narani@xilinx.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: xilinx: Align IOMMU nodename with dtschema
Date:   Mon, 29 Jun 2020 10:17:44 +0200
Message-Id: <20200629081744.13916-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix dtschema validator warnings like:
    smmu@fd800000: $nodename:0: 'smmu@fd800000' does not match '^iommu@[0-9a-f]*'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 9174ddc76bdc..2b82206eba02 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -601,7 +601,7 @@
 			power-domains = <&zynqmp_firmware PD_SD_1>;
 		};
 
-		smmu: smmu@fd800000 {
+		smmu: iommu@fd800000 {
 			compatible = "arm,mmu-500";
 			reg = <0x0 0xfd800000 0x0 0x20000>;
 			status = "disabled";
-- 
2.17.1

