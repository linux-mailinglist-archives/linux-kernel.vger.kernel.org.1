Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76BEE2AAD08
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 19:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728876AbgKHSv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 13:51:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728770AbgKHSv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 13:51:27 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15DEC0613CF;
        Sun,  8 Nov 2020 10:51:26 -0800 (PST)
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 6B30D23E55;
        Sun,  8 Nov 2020 19:51:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1604861484;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rQFbSNbCC4d8HsUblJnVNTAfkx/7jXh2YNcs4HFInSI=;
        b=RO01JkhdETuFgEcI3uS2fKcUslY/N+zmEN3k6N/CHKSI8XwRJ9EZRzX5DZEHAKKOWC3qdR
        1mLjJjjytZXCU81x/NXwrn+28ioIHFGOOGsxYY1304Axsa1TaaMvSnKb72PKx3RPXfPoA/
        QJ71NQGuh8BsuuLxdd5UgujoT9xmiS4=
From:   Michael Walle <michael@walle.cc>
To:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        "Y . b . Lu" <yangbo.lu@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>,
        Ashish Kumar <Ashish.Kumar@nxp.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v3 1/9] arm64: dts: ls1028a: fix ENETC PTP clock input
Date:   Sun,  8 Nov 2020 19:51:05 +0100
Message-Id: <20201108185113.31377-2-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201108185113.31377-1-michael@walle.cc>
References: <20201108185113.31377-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the LS1028A the ENETC reference clock is connected to 4th HWA output,
see Figure 7 "Clock subsystem block diagram".

The PHC may run with a wrong frequency. ptp_qoriq_auto_config() will read
the clock speed of the clock given in the device tree. It is likely that,
on the reference board this wasn't noticed because both clocks have the
same frequency. But this must not be always the case. Fix it.

Fixes: 49401003e260 ("arm64: dts: fsl: ls1028a: add ENETC 1588 timer node")
Signed-off-by: Michael Walle <michael@walle.cc>
---
Changes since v2:
 - new patch

 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index 2c831d814572..e22f29aa4658 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -961,7 +961,7 @@
 			ethernet@0,4 {
 				compatible = "fsl,enetc-ptp";
 				reg = <0x000400 0 0 0 0>;
-				clocks = <&clockgen 4 0>;
+				clocks = <&clockgen 2 3>;
 				little-endian;
 				fsl,extts-fifo;
 			};
-- 
2.20.1

