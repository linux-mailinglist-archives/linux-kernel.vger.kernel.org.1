Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE762ECD87
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 11:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbhAGKKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 05:10:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbhAGKKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 05:10:01 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8CFDC0612FD
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 02:09:02 -0800 (PST)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1kxSDZ-0004cs-13; Thu, 07 Jan 2021 11:08:33 +0100
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1kxSDY-0007v5-30; Thu, 07 Jan 2021 11:08:32 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>
Subject: [PATCH v6 0/5] mainline Kverneland boards 
Date:   Thu,  7 Jan 2021 11:08:26 +0100
Message-Id: <20210107100831.30389-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

changes v6:
- move startup-delay-us close to gpio property
- rename video@5c to video-decoder@5c
- sort out some spaces
- use defines for linux,code and linux,axis

changes v5:
- reorder kvg prefix
- add Acked-by: Rob Herring.. 

changes v4:
- fix active level of SPI CS GPIOs

changes v3:
- add vicutp board
- change tvnorm to sdtv-standards
- change linux,default-trigger "mmc" to  "disk-activity";
- add power-supply property to the panel node

changes v2:
- add victgo board
- diff fixes for vicut1.dtsi 

Oleksij Rempel (5):
  dt-bindings: vendor-prefixes: Add an entry for Kverneland Group
  dt-bindings: arm: fsl: add Kverneland UT1, UT1Q and UI1P boards
  ARM: dts: add Kverneland UT1, UT1Q and UT1P
  dt-bindings: arm: fsl: add Kverneland TGO board
  ARM: dts: add Kverneland TGO board

 .../devicetree/bindings/arm/fsl.yaml          |   4 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/arm/boot/dts/Makefile                    |   4 +
 arch/arm/boot/dts/imx6dl-victgo.dts           | 850 ++++++++++++++++++
 arch/arm/boot/dts/imx6dl-vicut1.dts           |  13 +
 arch/arm/boot/dts/imx6q-vicut1.dts            |  17 +
 arch/arm/boot/dts/imx6qdl-vicut1.dtsi         | 803 +++++++++++++++++
 arch/arm/boot/dts/imx6qp-vicutp.dts           |  13 +
 8 files changed, 1706 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6dl-victgo.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-vicut1.dts
 create mode 100644 arch/arm/boot/dts/imx6q-vicut1.dts
 create mode 100644 arch/arm/boot/dts/imx6qdl-vicut1.dtsi
 create mode 100644 arch/arm/boot/dts/imx6qp-vicutp.dts

-- 
2.30.0

