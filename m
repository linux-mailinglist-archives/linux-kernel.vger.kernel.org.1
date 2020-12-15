Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 794112DB5D9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 22:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730016AbgLOV1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 16:27:43 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:53707 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbgLOV1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 16:27:17 -0500
Received: from mwalle01.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:fa59:71ff:fe9b:b851])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 362D322FB3;
        Tue, 15 Dec 2020 22:26:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1608067595;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=oOLYs1Po+euDP1vOJWx+fQql3W38JL4DUPMEHPcWbqQ=;
        b=HiQcJdF97WapcZaCJtZLyldD7ZQ49vVy0qsfl8pBq7isvQCs80A8RYmyfawwlepOgJD3yX
        66z0NaJP2pOq3KXbN+6zZddAZJUzRI3cA7PYtIqrxQgylMMUxdCQNG7U8UExNZodMIoa7G
        Tdx4+RHkX3NiV5W4hy5cLijDo1hyOxo=
From:   Michael Walle <michael@walle.cc>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Sudhanshu Gupta <sudhanshu.gupta@nxp.com>,
        Bhaskar Upadhaya <bhaskar.upadhaya@nxp.com>,
        Rai Harninder <harninder.rai@nxp.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH] arm64: dts: ls1028a: fix the offset of the reset register
Date:   Tue, 15 Dec 2020 22:26:22 +0100
Message-Id: <20201215212622.717-1-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The offset of the reset request register is 0, the absolute address is
0x1e60000. Boards without PSCI support will fail to perform a reset:

[   26.734700] reboot: Restarting system
[   27.743259] Unable to restart system
[   27.746845] Reboot failed -- System halted

Fixes: 8897f3255c9c ("arm64: dts: Add support for NXP LS1028A SoC")
Signed-off-by: Michael Walle <michael@walle.cc>
---
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index 045739dbcb17..0a5923e96d7f 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -102,7 +102,7 @@
 	reboot {
 		compatible ="syscon-reboot";
 		regmap = <&rst>;
-		offset = <0xb0>;
+		offset = <0>;
 		mask = <0x02>;
 	};
 
-- 
2.20.1

