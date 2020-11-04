Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6382A6EBA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 21:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731958AbgKDUaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 15:30:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728305AbgKDUaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 15:30:16 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E7AC0613D3;
        Wed,  4 Nov 2020 12:30:15 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id h12so13152779qtc.9;
        Wed, 04 Nov 2020 12:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ek3K8iI1zMdC0w+5jsCH6CWA0/XrhqEufphNJ3p/9Xs=;
        b=g95i1AqkuuhFXDmh6uyOVur43Q3X0IN8KH+hWF0P8JRIt8xA9tGoFZhZRjyOIe4Pb0
         PB0uGpdbvOd+yBpCFDkqDVDLyNKoODdhWEwLkUGuLo1qxeGpOWiK0ma2XB5mwWMaeJHa
         9siT1uXeb5TtHwNmqSav9B0l4Jqy9liebmtoRXcpEheZtyGluK5YdLTFPzD3pNXsY+7v
         3npQCOHNNEU87YAClonb7YBGx4bBW04JxGpbHGROdj6Mw0PsS+A2zrFn3MjavC7WB+th
         sdR2lkirOBXAe/yu6D+SqbEfKZZmZ0rjI0WjKqupxXIuOWHvM4st0p33rkasyo4mY+pI
         vSTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ek3K8iI1zMdC0w+5jsCH6CWA0/XrhqEufphNJ3p/9Xs=;
        b=bCvYYsC6Ywy24FV5r4fxxAhLopatsKX0GGz1PeAlhsSNyKLU0thlivmbwoK3tsve/Y
         4KfHRRCZdABk06kmtqj6yvf5OLOLgYGLrEpnbD8AV6D7jBFXlk2PlLyw/r/2zMHMxQe2
         uoyMOgnEKo4reYBT6ND2WfborCYsqtEKqLBG1nv94fxLTsFAq5P+pl+WxKDVZIRWvTFJ
         7gL+jbErpDovgz6k+nIqMudUiLAUPkK6nt5Pg5iMbG/XIF0Co+BRmC7Ri3QJu6TUxILz
         Ietfhfu6AGlvm+SYo8clUtyUeAfD+OOqLhXsfg9bboHZecpx7vQglA7WUvbz4icdVHjs
         K9bA==
X-Gm-Message-State: AOAM5312YR3KmGIXHpvYto5k9LSgnnTUmdwSeR1wfVarq2BdoAwGuba6
        DuFZqAKE4b70vQp2GkCLjKc=
X-Google-Smtp-Source: ABdhPJz+3RYoFYd72i+kB98S9EY90DHnUrThzc8ncobrH1obv0E77rdEO9U1qhzKvtPM5K9lR4mijg==
X-Received: by 2002:ac8:74c:: with SMTP id k12mr21133318qth.32.1604521814980;
        Wed, 04 Nov 2020 12:30:14 -0800 (PST)
Received: from ubuntu.localdomain (ool-45785633.dyn.optonline.net. [69.120.86.51])
        by smtp.googlemail.com with ESMTPSA id q14sm930435qtr.20.2020.11.04.12.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 12:30:14 -0800 (PST)
From:   Vivek Unune <npcomplete13@gmail.com>
To:     florian.fainelli@broadcom.com, hauke@hauke-m.de, zajec5@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Vivek Unune <npcomplete13@gmail.com>
Subject: [PATCH v2 1/2] ARM: dts: BCM5301X: pinctrl - use correct driver and define mdio pins
Date:   Wed,  4 Nov 2020 15:29:51 -0500
Message-Id: <20201104202952.783724-2-npcomplete13@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201104202952.783724-1-npcomplete13@gmail.com>
References: <6687de05226dd055ee362933d4841a12b038792d.1601655904.git.npcomplete13@gmail.com>
 <20201104202952.783724-1-npcomplete13@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BCM47094 version of pinmux uses different driver and supports mdio
pinmux pins. Hence, use the correct driver and define the pins.

Signed-off-by: Vivek Unune <npcomplete13@gmail.com>
---
---
 arch/arm/boot/dts/bcm47094.dtsi | 9 +++++++++
 arch/arm/boot/dts/bcm5301x.dtsi | 2 +-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm47094.dtsi b/arch/arm/boot/dts/bcm47094.dtsi
index cdc5ff593adb..747ca030435f 100644
--- a/arch/arm/boot/dts/bcm47094.dtsi
+++ b/arch/arm/boot/dts/bcm47094.dtsi
@@ -8,6 +8,15 @@
 / {
 };
 
+&pinctrl {
+	compatible = "brcm,bcm4709-pinmux";
+
+	pinmux_mdio: mdio {
+		groups = "mdio_grp";
+		function = "mdio";
+	};
+};
+
 &usb3_phy {
 	compatible = "brcm,ns-bx-usb3-phy";
 };
diff --git a/arch/arm/boot/dts/bcm5301x.dtsi b/arch/arm/boot/dts/bcm5301x.dtsi
index 3e55ff4fb550..cfc08cdd590f 100644
--- a/arch/arm/boot/dts/bcm5301x.dtsi
+++ b/arch/arm/boot/dts/bcm5301x.dtsi
@@ -428,7 +428,7 @@ cru@100 {
 			#address-cells = <1>;
 			#size-cells = <1>;
 
-			pin-controller@1c0 {
+			pinctrl: pin-controller@1c0 {
 				compatible = "brcm,bcm4708-pinmux";
 				reg = <0x1c0 0x24>;
 				reg-names = "cru_gpio_control";
-- 
2.25.1

