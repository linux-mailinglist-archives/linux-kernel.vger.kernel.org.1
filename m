Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9F9E24EF01
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Aug 2020 19:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbgHWRVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Aug 2020 13:21:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:51084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726792AbgHWRUg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 13:20:36 -0400
Received: from kozik-lap.proceq-device.com (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4BBF20838;
        Sun, 23 Aug 2020 17:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598203234;
        bh=CqYRHo/0iH7tLsT9o8PS32qjWWTfkPRR9VIUe5p42aw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=KkI3pSZfqHXauZiRrXkKxXbKzIwc0VBqmxokzBy6o6Qfh8yThB3VmWvUtMkmwxMJW
         XL1KfC6b8y+y/1cjD9QFyXL5ltFvj5q6PxLhZKStfYpMwxfZtrx6yWILkpMAhDwbSG
         OfoVAD7/r7oNvFj54Yfbm3+hSlNLEH5Kku5K8YgU=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 4/5] arm64: dts: imx8mm-beacon-som: Fix atmel,24c64 EEPROM compatible
Date:   Sun, 23 Aug 2020 19:20:18 +0200
Message-Id: <20200823172019.18606-4-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200823172019.18606-1-krzk@kernel.org>
References: <20200823172019.18606-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct the EEPROM node compatible to match device tree schema (invalid
space, unknown ID) to fix dtbs_check warnings:

  arch/arm64/boot/dts/freescale/imx8mm-beacon-kit.dt.yaml: eeprom@50:
    compatible: ['microchip, at24c64d', 'atmel,24c64'] is not valid under any of the given schemas
  arch/arm64/boot/dts/freescale/imx8mm-beacon-kit.dt.yaml: eeprom@50:
    compatible:0: 'microchip, at24c64d' does not match '^[a-zA-Z][a-zA-Z0-9,+\\-._]+$'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi
index f627e82ad929..620a124dfb5f 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi
@@ -184,7 +184,7 @@
 	status = "okay";
 
 	eeprom@50 {
-		compatible = "microchip, at24c64d", "atmel,24c64";
+		compatible = "microchip,24c64", "atmel,24c64";
 		pagesize = <32>;
 		read-only;	/* Manufacturing EEPROM programmed at factory */
 		reg = <0x50>;
-- 
2.17.1

