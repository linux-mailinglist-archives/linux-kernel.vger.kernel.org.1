Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B722302BC3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 20:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730891AbhAYTiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 14:38:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731603AbhAYTJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 14:09:14 -0500
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 024BEC061756;
        Mon, 25 Jan 2021 11:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=apAxVfHae0wzCGdNc4Jfqs4ga/AMxkfe4hpTqg3oAhI=; b=DZhKSQziCI4nJrDrhQgCAxLxgM
        ZTY8K+wkl4XUljJEj1+mtJEyfPJFex/Eg/o5W0Z2vdui7GmyuOtPI6a3BBl9/PEQLAozrdVdVawOR
        0TjFuecmk+h2MJZuJ6Bl/QljqzIgcn2SXRZCuw/q70Osgo0sAGk0zTr6ainU2BZnKe64=;
Received: from p200300ccff0a26001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff0a:2600:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1l47Ds-0007Hb-Bq; Mon, 25 Jan 2021 20:08:24 +0100
Received: from andi by aktux with local (Exim 4.92)
        (envelope-from <andreas@kemnade.info>)
        id 1l47Dq-0003HH-A7; Mon, 25 Jan 2021 20:08:22 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, j.neuschaefer@gmx.net
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH] ARM: dts: imx6sl-tolino-shine2hd: Add Netronix embedded controller
Date:   Mon, 25 Jan 2021 20:08:04 +0100
Message-Id: <20210125190804.12552-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210124214127.3631530-8-j.neuschaefer@gmx.net>
References: <20210124214127.3631530-8-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0 (-)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For now, the driver detects an incompatible version, but since
that can be handled by auto-detection, add the controller to the
devicetree now. Only PWM seems to be available, there is no RTC
in that controller.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 arch/arm/boot/dts/imx6sl-tolino-shine2hd.dts | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6sl-tolino-shine2hd.dts b/arch/arm/boot/dts/imx6sl-tolino-shine2hd.dts
index caa279608803..c26bc5e10593 100644
--- a/arch/arm/boot/dts/imx6sl-tolino-shine2hd.dts
+++ b/arch/arm/boot/dts/imx6sl-tolino-shine2hd.dts
@@ -97,8 +97,11 @@ &i2c1 {
 	pinctrl-1 = <&pinctrl_i2c1_sleep>;
 	status = "okay";
 
-	/* TODO: embedded controller at 0x43 (driver missing) */
-
+	ec: embedded-controller@43 {
+		compatible = "netronix,ntxec";
+		reg = <0x43>;
+		#pwm-cells = <2>;
+	};
 };
 
 &i2c2 {
-- 
2.29.2

