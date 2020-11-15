Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A98F52B3A7A
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Nov 2020 23:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbgKOWyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 17:54:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbgKOWyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 17:54:46 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DFF6C0613CF;
        Sun, 15 Nov 2020 14:54:46 -0800 (PST)
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 368F722F99;
        Sun, 15 Nov 2020 23:54:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1605480880;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=5IYmtrwNrffuEO24QOGmuJZWmuOyIjGYeeOlbsSgu2M=;
        b=pEetpn7uEE8AJxY1CJZ1CsC9oRNsJDfPtHGPud1UMU5Uyq4gj8jdSPYkhHdArHRXwktcCW
        C2Mz2NeHOl36flMOrzjQE6KFS8pXS2AVP62oMmESHAWBJLB7trKhhShPOr0+xRFgmKrBoL
        yh/Bwx0M2u5gXJkUgnzAWvST2EG9Vhw=
From:   Michael Walle <michael@walle.cc>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH] arm64: dts: freescale: sl28: combine SPI MTD partitions
Date:   Sun, 15 Nov 2020 23:54:35 +0100
Message-Id: <20201115225435.8529-1-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The upstream port, doesn't really follow the vendor partitioning. The
bootloader partition has one U-Boot FIT image containing all needed
bits and pieces. Even today the bootloader is already larger than the
current "bootloader" partition. Thus, fold all the partitions into one
and keep the environment one. The latter is still valid.
We keep the failsafe partitions because the first half of the SPI flash
is preinstalled by the vendor and immutable.

Fixes: 815364d0424e ("arm64: dts: freescale: add Kontron sl28 support")
Signed-off-by: Michael Walle <michael@walle.cc>
---
 .../boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts  | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts
index 54ff6f7c2477..fbaecf285d05 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts
@@ -159,20 +159,10 @@
 		};
 
 		partition@210000 {
-			reg = <0x210000 0x0f0000>;
+			reg = <0x210000 0x1d0000>;
 			label = "bootloader";
 		};
 
-		partition@300000 {
-			reg = <0x300000 0x040000>;
-			label = "DP firmware";
-		};
-
-		partition@340000 {
-			reg = <0x340000 0x0a0000>;
-			label = "trusted firmware";
-		};
-
 		partition@3e0000 {
 			reg = <0x3e0000 0x020000>;
 			label = "bootloader environment";
-- 
2.20.1

