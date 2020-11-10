Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8232ADA96
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 16:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732617AbgKJPio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 10:38:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730231AbgKJPio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 10:38:44 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A909FC0613CF;
        Tue, 10 Nov 2020 07:38:43 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id a25so9305170lfb.2;
        Tue, 10 Nov 2020 07:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r4km4Tls255Bh4L5TRKbqRQTr1tWzdtCkweFdA8HiLE=;
        b=VbX18nLDdMXqme+sMDPUmkry2TvFlm2SiUhCw2cwE6gdQIa8Bn/JdWORAZ9zlMjqQt
         16CQhY3BwLhL3uvwt073lZlQXR07pvETdX2QZsZonFtiWbPoyyqOgxFkNUXZ8AtvUQXP
         ONIoMLuWY9vp/DAQdsgMcm/ANYm/WbPejL10Ji23L+HqgHr3HmF/MxZyZO4A8NPS2pA1
         j4pnk/vdc07ofzgOuThevh/muPqoguzZN7rgyhnYf49m6JMBlXIVnk7SxVCARIGpgSOx
         CNYamxQwBCP2LeR1dB/S/bVdnO67UrHFupmfQI84qobCjU0r/Xi+sVZveIxZjp4zBZSs
         GZTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r4km4Tls255Bh4L5TRKbqRQTr1tWzdtCkweFdA8HiLE=;
        b=D2KDa6R5zkQ57C0PIf2bTDCL0s3Z3xB/WynhPtfl4DCf55OiBDVy+m1UhIgxrTILPb
         i18OKk7hLTBNgkYJuqujM4bb+X9YQ44W0r35Hg5J4SjlpnSRtRw3+MePve4ZdYI8XkOm
         Bzpsn8JWyDTmcssWdcr6Gq6Q0A4rP+TUoWxDH/iZRfxj3/K5xE0+yL7nMYMEhdWTPEN6
         AgsAp1DkqC5mSjQD0xaGzqzh3SAP78ZjRZeeFWnU0KZHmEq7kQzVhQnJwQRTIYBd7mzA
         JKuhqL/C0PNZme4aLopnnxzcN6j5Uco0nwj7oWJDMICK/ZReJPU3UR8P07dViX2NzidB
         yUoA==
X-Gm-Message-State: AOAM533qBzqxkQd6GjuTXoEryngv+RtMObuwNvxrIny13css+6Ie5b5z
        n/rJO8oKV0IDtTasF633Rio=
X-Google-Smtp-Source: ABdhPJwWxtgiwpJILLImQSqLjczvldAvw5Ka9klb9HBrWOQyetqMqDDXrwfMKgEBvhZ2prUm50Ho0Q==
X-Received: by 2002:ac2:598e:: with SMTP id w14mr3946481lfn.187.1605022722230;
        Tue, 10 Nov 2020 07:38:42 -0800 (PST)
Received: from localhost.localdomain ([194.29.183.4])
        by smtp.googlemail.com with ESMTPSA id n26sm1821663lfi.303.2020.11.10.07.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 07:38:41 -0800 (PST)
From:   Tomasz Maciej Nowak <tmn505@gmail.com>
To:     Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Russell King <rmk+kernel@armlinux.org.uk>,
        Alexandra Alth <alexandra@alth.de>
Subject: [PATCH] arm64: dts: mcbin-singleshot: add heartbeat LED
Date:   Tue, 10 Nov 2020 16:38:31 +0100
Message-Id: <20201110153831.5336-1-tmn505@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With board revision 1.3, SolidRun moved the power LED to the middle of
the board. In old place of power LED a GPIO controllable heartbeat LED
was added. This commit only touches Single Shot variant, since only this
variant is all revision 1.3.

Reported-by: Alexandra Alth <alexandra@alth.de>
Signed-off-by: Tomasz Maciej Nowak <tmn505@gmail.com>
---
 .../marvell/armada-8040-mcbin-singleshot.dts  | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-8040-mcbin-singleshot.dts b/arch/arm64/boot/dts/marvell/armada-8040-mcbin-singleshot.dts
index 2e6832d02a59..411d20064271 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040-mcbin-singleshot.dts
+++ b/arch/arm64/boot/dts/marvell/armada-8040-mcbin-singleshot.dts
@@ -5,6 +5,8 @@
  * Device Tree file for MACCHIATOBin Armada 8040 community board platform
  */
 
+#include <dt-bindings/leds/common.h>
+
 #include "armada-8040-mcbin.dtsi"
 
 / {
@@ -12,6 +14,19 @@ / {
 	compatible = "marvell,armada8040-mcbin-singleshot",
 			"marvell,armada8040-mcbin", "marvell,armada8040",
 			"marvell,armada-ap806-quad", "marvell,armada-ap806";
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-0 = <&cp0_led18_pins>;
+		pinctrl-names = "default";
+
+		led18 {
+			gpios = <&cp0_gpio2 1 GPIO_ACTIVE_LOW>;
+			function = LED_FUNCTION_HEARTBEAT;
+			color = <LED_COLOR_ID_GREEN>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
 };
 
 &cp0_eth0 {
@@ -27,3 +42,10 @@ &cp1_eth0 {
 	managed = "in-band-status";
 	sfp = <&sfp_eth1>;
 };
+
+&cp0_pinctrl {
+	cp0_led18_pins: led18-pins {
+		marvell,pins = "mpp33";
+		marvell,function = "gpio";
+	};
+};
-- 
2.29.2

