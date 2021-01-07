Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE5352ECC12
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 09:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbhAGIyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 03:54:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbhAGIyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 03:54:09 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 202C9C0612FA
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 00:52:57 -0800 (PST)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1kxR23-00026o-72; Thu, 07 Jan 2021 09:52:35 +0100
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1kxR22-00044o-BK; Thu, 07 Jan 2021 09:52:34 +0100
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
Subject: [PATCH v2 0/2] mainline Protonic PRTI6G board 
Date:   Thu,  7 Jan 2021 09:52:31 +0100
Message-Id: <20210107085233.15619-1-o.rempel@pengutronix.de>
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

changes v2:
- reorder pinctls

Oleksij Rempel (2):
  dt-bindings: arm: fsl: add Protonic PRTI6G board
  ARM: dts: add Protonic PRTI6G board

 .../devicetree/bindings/arm/fsl.yaml          |   1 +
 arch/arm/boot/dts/Makefile                    |   1 +
 arch/arm/boot/dts/imx6ul-prti6g.dts           | 356 ++++++++++++++++++
 3 files changed, 358 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6ul-prti6g.dts

-- 
2.30.0

