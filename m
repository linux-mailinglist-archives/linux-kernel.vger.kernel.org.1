Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C02302EF2BA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 13:58:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbhAHM6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 07:58:03 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:44992 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726901AbhAHM6A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 07:58:00 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 92987FB04;
        Fri,  8 Jan 2021 13:57:17 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HlweCpLmBIyH; Fri,  8 Jan 2021 13:57:13 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id DA98C40889; Fri,  8 Jan 2021 13:57:10 +0100 (CET)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Martin Kepplinger <martink@posteo.de>,
        Angus Ainslie <angus@akkea.ca>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Li Yang <leoyang.li@nxp.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Vinod Koul <vkoul@kernel.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        Michael Walle <michael@walle.cc>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org
Subject: [PATCH v3 3/4] arm64: dts: imx8mq-librem5-devkit: Disable snvs_rtc
Date:   Fri,  8 Jan 2021 13:57:09 +0100
Message-Id: <2a07bf798ee8b7914b127841ac6f4e9b5949fce5.1610110514.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1610110514.git.agx@sigxcpu.org>
References: <cover.1610110514.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The board has it's own RTC chip which is backed by the (optional)
battery and hence preserves data/time on poweroff when that is inserted.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
index f35d6897fbf7..05a43ee6d051 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
@@ -897,6 +897,10 @@ &snvs_pwrkey {
 	status = "okay";
 };
 
+&snvs_rtc {
+	status = "disabled";
+};
+
 &sai2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_sai2>;
-- 
2.29.2

