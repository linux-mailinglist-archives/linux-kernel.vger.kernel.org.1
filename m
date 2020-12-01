Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE8042C9DF3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 10:41:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403780AbgLAJ3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 04:29:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388917AbgLAJ3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 04:29:15 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47AD2C061A04
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 01:28:09 -0800 (PST)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1kk1wn-0000MP-9v; Tue, 01 Dec 2020 10:27:45 +0100
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1kk1wl-0004gL-M5; Tue, 01 Dec 2020 10:27:43 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v4 0/3] mainline Plymovent M2M and BAS board
Date:   Tue,  1 Dec 2020 10:27:36 +0100
Message-Id: <20201201092742.17658-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

changes v5:
- rebase against latest shawngup/for-next
- add patch to fix checkpatch warning on PLYM2M dts

changes v4:
- add PLYBAS board
- PLYM2M: add touchscreen node
- PLYM2M: add rename led nodes to led-x

changes v3:
- use old style copyright text

changes v2:
- fsl.yaml: reorder ply,plym2m
- imx6dl-plym2m.dts: use hyphen instead of underscore in phy-clock

Oleksij Rempel (6):
  dt-bindings: display: simple: Add EDT ETM0700G0BDH6 display
  dt-bindings: vendor-prefixes: Add an entry for Plymovent
  dt-bindings: arm: fsl: add Plymovent M2M board
  ARM: dts: add Plymovent M2M board
  dt-bindings: arm: fsl: add Plymovent BAS board
  ARM: dts: add Plymovent BAS board

 .../devicetree/bindings/arm/fsl.yaml          |   2 +
 .../bindings/display/panel/panel-simple.yaml  |   2 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/arm/boot/dts/Makefile                    |   2 +
 arch/arm/boot/dts/imx6dl-plybas.dts           | 394 ++++++++++++++++
 arch/arm/boot/dts/imx6dl-plym2m.dts           | 446 ++++++++++++++++++
 6 files changed, 848 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6dl-plybas.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-plym2m.dts

-- 
2.29.2

