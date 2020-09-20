Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3842717AC
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Sep 2020 21:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbgITT6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 15:58:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:44234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726126AbgITT6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 15:58:05 -0400
Received: from localhost.localdomain (unknown [194.230.155.191])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11A7920866;
        Sun, 20 Sep 2020 19:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600631885;
        bh=NviObDl+2QU6pVZnrJEXzsIrZ5DFivrS2AKyv1LIOG8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=eD+NeZevkzsxuU6pXG2xGIXri3/mnPZm+GHu/k0ZIG+jsuKzTTj49qJf3f2l2yQs2
         Z5ipcVlc/rY9y2ABN9AKvekgI1kAKE6LXxf8I1x3gKyzYWqMdaGJimLLNQ4UFmDIkq
         M7fv3P0ewzuXOYYzFlmJz5WIt4yXTn+LbIdiLnNQ=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Martin Kepplinger <martink@posteo.de>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] arm64: dts: imx8mq-librem5: align GPIO hog names with dtschema
Date:   Sun, 20 Sep 2020 21:57:48 +0200
Message-Id: <20200920195749.26952-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200920195749.26952-1-krzk@kernel.org>
References: <20200920195749.26952-1-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dtschema expects GPIO hogs to end with 'hog' suffix.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v2:
1. None, split from previous patchset using common GPIO schema
---
 arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
index e4dedcb58f76..6cbcee2fb938 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
@@ -249,7 +249,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pmic_5v>;
 
-	pmic-5v {
+	pmic-5v-hog {
 		gpio-hog;
 		gpios = <&gpio1 1 GPIO_ACTIVE_HIGH>;
 		input;
-- 
2.17.1

