Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 989B12FD372
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 16:08:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390597AbhATO4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 09:56:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390086AbhATOX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 09:23:58 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F914C061796
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 06:22:42 -0800 (PST)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1l2ENH-0001dA-CO; Wed, 20 Jan 2021 15:22:19 +0100
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1l2ENG-0007jG-3Z; Wed, 20 Jan 2021 15:22:18 +0100
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
        Robin van der Gracht <robin@protonic.nl>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v1 0/7] devicetree fixes for Protonic and Plymovent boards
Date:   Wed, 20 Jan 2021 15:22:10 +0100
Message-Id: <20210120142217.29652-1-o.rempel@pengutronix.de>
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

Oleksij Rempel (7):
  dt-bindings: display: simple: add Innolux G070Y2-T02 panel
  drm: panel-simple: Add support for the Innolux G070Y2-T02 panel
  ARM: dts: imx6dl-prtvt7: Add display and panel nodes
  ARM: dts: imx6dl-prtvt7: add TSC2046 touchscreen node
  ARM: dts: imx6dl-prtvt7: Remove backlight enable gpio
  ARM: dts: imx6dl-prtvt7: fix PWM cell count for the backlight node.
  ARM: dts: imx6dl-plym2m: remove touchscreen-size-* properties

 .../bindings/display/panel/panel-simple.yaml  |  2 +
 arch/arm/boot/dts/imx6dl-plym2m.dts           |  2 -
 arch/arm/boot/dts/imx6dl-prtvt7.dts           | 79 ++++++++++++++++---
 drivers/gpu/drm/panel/panel-simple.c          | 16 ++++
 4 files changed, 86 insertions(+), 13 deletions(-)

-- 
2.30.0

