Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32C922AACF8
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 19:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728915AbgKHSvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 13:51:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728778AbgKHSv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 13:51:27 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281D6C0613CF;
        Sun,  8 Nov 2020 10:51:27 -0800 (PST)
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 3DD8C23E5D;
        Sun,  8 Nov 2020 19:51:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1604861485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GnntV0MRQf6wUyCrCh0szz6T409KSBLE6RqzK7l90sU=;
        b=Qmwjh446Bpe/TYVpsX6cIs4Ns5v6gmx0IS0CQ93KLWxK/MMklBiR/KhJp64yP3RhUXqVo+
        6eC7InIDyG2PzIaqrwLSVZJlH8gI6M2eLtiYFSrnH7KEBPy8CPvbhe3uFJdmFr7hc/Rau3
        +YXDVBib9zTTdscJktACJyCoFyJWa10=
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
Subject: [PATCH v3 2/9] arm64: dts: ls1028a: fix FlexSPI clock input
Date:   Sun,  8 Nov 2020 19:51:06 +0100
Message-Id: <20201108185113.31377-3-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201108185113.31377-1-michael@walle.cc>
References: <20201108185113.31377-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the LS1028A the FlexSPI clock is connected to the first HWA output,
see Figure 7 "Clock subsystem block diagram".

Fixes: c77fae5ba09a ("arm64: dts: ls1028a: Add FlexSPI support")
Signed-off-by: Michael Walle <michael@walle.cc>
---
Changes since v2:
 - new patch

 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index e22f29aa4658..2f60a6ba7e14 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -318,7 +318,7 @@
 			      <0x0 0x20000000 0x0 0x10000000>;
 			reg-names = "fspi_base", "fspi_mmap";
 			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clockgen 4 3>, <&clockgen 4 3>;
+			clocks = <&clockgen 2 0>, <&clockgen 2 0>;
 			clock-names = "fspi_en", "fspi";
 			status = "disabled";
 		};
-- 
2.20.1

