Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44417295CA5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 12:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896501AbgJVK1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 06:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2896450AbgJVK1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 06:27:42 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41312C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 03:27:42 -0700 (PDT)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1kVXol-0003as-DF; Thu, 22 Oct 2020 12:27:35 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1kVXok-0000ro-FB; Thu, 22 Oct 2020 12:27:34 +0200
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
Subject: [PATCH v4 0/3] mainline LANMCU board
Date:   Thu, 22 Oct 2020 12:27:30 +0200
Message-Id: <20201022102733.3277-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

changes v4:
- rename wifinpd to wifigrp 

changes v3:
- rename led-debug to led-0
- rename bcrmf to wifi 

changes v2:
- add phy-handle
- rename node to touchscreen@38
- reorder reg and status properties

Oleksij Rempel (3):
  dt-bindings: vendor-prefixes: Add an entry for Van der Laan b.v.
  dt-bindings: arm: fsl: add Van der Laan LANMCU board
  ARM: dts: add Van der Laan LANMCU board

 .../devicetree/bindings/arm/fsl.yaml          |   1 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/arm/boot/dts/Makefile                    |   1 +
 arch/arm/boot/dts/imx6dl-lanmcu.dts           | 470 ++++++++++++++++++
 4 files changed, 474 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6dl-lanmcu.dts

-- 
2.28.0

