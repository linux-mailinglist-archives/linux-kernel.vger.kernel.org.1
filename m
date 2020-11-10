Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 106E12AD3B0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 11:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730648AbgKJK0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 05:26:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730196AbgKJK0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 05:26:09 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D75FEC0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 02:26:08 -0800 (PST)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <afa@pengutronix.de>)
        id 1kcQqZ-0008HS-KB; Tue, 10 Nov 2020 11:25:55 +0100
Received: from afa by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <afa@pengutronix.de>)
        id 1kcQqZ-00029s-5d; Tue, 10 Nov 2020 11:25:55 +0100
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Cc:     kernel@pengutronix.de, Ahmad Fatoum <a.fatoum@pengutronix.de>,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] ARM: dts: stm32: lxa-mc1: add OSD32MP15x to list of compatibles
Date:   Tue, 10 Nov 2020 11:25:51 +0100
Message-Id: <20201110102552.7270-3-a.fatoum@pengutronix.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201110102552.7270-1-a.fatoum@pengutronix.de>
References: <20201110102552.7270-1-a.fatoum@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: afa@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Earlier commit modified the binding, so the SiP is to be specified
as well. Adjust the device tree accordingly.

Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
---
v1 -> v2:
  - split up binding and device tree change
---
 arch/arm/boot/dts/stm32mp157c-lxa-mc1.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/stm32mp157c-lxa-mc1.dts b/arch/arm/boot/dts/stm32mp157c-lxa-mc1.dts
index 1e5333fd437f..cda8e871f999 100644
--- a/arch/arm/boot/dts/stm32mp157c-lxa-mc1.dts
+++ b/arch/arm/boot/dts/stm32mp157c-lxa-mc1.dts
@@ -15,7 +15,7 @@
 
 / {
 	model = "Linux Automation MC-1 board";
-	compatible = "lxa,stm32mp157c-mc1", "st,stm32mp157";
+	compatible = "lxa,stm32mp157c-mc1", "oct,stm32mp15xx-osd32", "st,stm32mp157";
 
 	aliases {
 		ethernet0 = &ethernet0;
-- 
2.28.0

