Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5C62FE2E4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 07:31:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbhAUGbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 01:31:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726581AbhAUGNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 01:13:43 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0D3C061799
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 22:12:15 -0800 (PST)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1l2TC4-0006PN-3b; Thu, 21 Jan 2021 07:11:44 +0100
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1l2TC2-00062E-Bo; Thu, 21 Jan 2021 07:11:42 +0100
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
Subject: [PATCH v2 7/7] ARM: dts: imx6dl-plym2m: remove touchscreen-size-* properties
Date:   Thu, 21 Jan 2021 07:11:41 +0100
Message-Id: <20210121061141.23062-8-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210121061141.23062-1-o.rempel@pengutronix.de>
References: <20210121061141.23062-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove touchscreen-size-* properties.  This values are not correct, event if it
works with ts_test tool, it fails to work properly with weston.
And the real range of values reported by the driver (or measured by the
controller) is close to max values and may change with time on resistive
panels. So, it make no sense to keep this values in the device tree.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 arch/arm/boot/dts/imx6dl-plym2m.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6dl-plym2m.dts b/arch/arm/boot/dts/imx6dl-plym2m.dts
index 4d0d3d3386af..c97274f0df07 100644
--- a/arch/arm/boot/dts/imx6dl-plym2m.dts
+++ b/arch/arm/boot/dts/imx6dl-plym2m.dts
@@ -138,8 +138,6 @@ touchscreen@0 {
 		interrupts-extended = <&gpio3 20 IRQ_TYPE_EDGE_FALLING>;
 		pendown-gpio = <&gpio3 20 GPIO_ACTIVE_LOW>;
 
-		touchscreen-size-x = <800>;
-		touchscreen-size-y = <480>;
 		touchscreen-inverted-x;
 		touchscreen-inverted-y;
 		touchscreen-max-pressure = <4095>;
-- 
2.30.0

