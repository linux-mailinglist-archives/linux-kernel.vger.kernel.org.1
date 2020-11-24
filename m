Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF84A2C3292
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 22:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731443AbgKXVVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 16:21:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731414AbgKXVVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 16:21:43 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1B3C0613D6;
        Tue, 24 Nov 2020 13:21:43 -0800 (PST)
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id F0F9D23E3F;
        Tue, 24 Nov 2020 22:21:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1606252898;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=wIZr2dT8FfZXEBvU48oDTvepadKi82zYYnSlXuZYz6k=;
        b=iNsEq/kZPZeUnpgg3mpWD+YwbIBgWYPuDm6PrClGFBPrfmm1RH0PAY6u8HGsDnTn6dbOLn
        pRkF10yQLO3noUOpd6TMG5J+fTxNQyVYxwQW/n5g1LFebsdrj6bOVY5VliMuwWhYBFR4n/
        txZFg+6VJ1YKR7iABpmjyWJPOvZFc84=
From:   Michael Walle <michael@walle.cc>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Yangbo Lu <yangbo.lu@nxp.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH] arm64: dts: freescale: sl28: correct MMC order
Date:   Tue, 24 Nov 2020 22:21:26 +0100
Message-Id: <20201124212126.32218-1-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 342ab37ecaf8 ("arm64: dts: freescale: use fixed index mmcN for
layerscape") hardcoded the order of the MMC devices. This doesn't fit
the sl28 boards, which come with an onboard eMMC. Thus use the more
natural order for the eMMC and SD card. Use /dev/mmcblk0 for the eMMC
and /dev/mmcblk1 for the SD card which is removable by the user.

Please note, that the images for this board already use root=UUID=,
therefore the actual device number doesn't matter for booting.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts
index fbaecf285d05..6da4a28c4d19 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts
@@ -18,6 +18,8 @@
 
 	aliases {
 		crypto = &crypto;
+		mmc0 = &esdhc1;
+		mmc1 = &esdhc;
 		serial0 = &duart0;
 		serial1 = &duart1;
 		serial2 = &lpuart1;
-- 
2.20.1

