Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 725672B3A78
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Nov 2020 23:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728220AbgKOWx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 17:53:29 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:60629 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbgKOWx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 17:53:28 -0500
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 9123622F99;
        Sun, 15 Nov 2020 23:53:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1605480807;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=xHfi6k3pimdKMckwakjwbzYVNKhZX5g7ZRF9IE9zJAY=;
        b=GwVfTzHuKYwdOhbFQBDQxtJnrDS/dJnYXd9k/87VGmROK152IvMTIbJXvvcoYs0cYAApP5
        XNWuOMiqjd/BV1bzr1lYw0FibMXcYD9e6VlvHE9mdGuFlmRixREgvCsU9mSQiJFVOaQ61E
        64jcge68yhrqfbAHT0Ebui7tymaS95g=
From:   Michael Walle <michael@walle.cc>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH] arm64: dts: ls1028a: add optee node
Date:   Sun, 15 Nov 2020 23:53:14 +0100
Message-Id: <20201115225314.8114-1-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the optee node which can either be enabled by a specific board or by
the bootloader.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index 4a1b46bf0854..b5f9525daa89 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -93,6 +93,14 @@
 		clocks = <&osc_27m>;
 	};
 
+	firmware {
+		optee {
+			compatible = "linaro,optee-tz";
+			method = "smc";
+			status = "disabled";
+		};
+	};
+
 	reboot {
 		compatible ="syscon-reboot";
 		regmap = <&rst>;
-- 
2.20.1

