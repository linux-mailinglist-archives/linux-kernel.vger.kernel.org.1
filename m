Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC6A2C2A7D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 15:56:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389341AbgKXOxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 09:53:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389237AbgKXOxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 09:53:45 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F0CC0613D6;
        Tue, 24 Nov 2020 06:53:45 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id x13so2200913wmj.1;
        Tue, 24 Nov 2020 06:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=U85Rj/DRPt7jatgyQvBV2N/elTeJi8YB+AB1/+8bH98=;
        b=BsWfmB+fF8m5306hgWRxHXjKleQcreC92v8fefHpo9f6djstFLrwU6ffb7ajMN1JDI
         NS+DowqTq3C1G4VABHtnEAPRhTFmdA7s8fty4kY7pauWFqgI7nFnbjD7dtjY3Rik2SIN
         xs64HE+hVe/Khp4PzxeWMg8F2HRM38WXkdpX447gmp9HElsK68hB+ly7cS6fIilzHE7Q
         TLAmLWSPuaH3SHAAJxREjliPH6Poeu3/NUGnk9z/dZCWJprpYQ2kasXgxfbxtv07LNdL
         W4SwiSMPuomApTprge70sAjvjmKF8fGH6Ti7jEeXOQCTJC6TCDt19sHS5oWpku0dNIJ+
         pshA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=U85Rj/DRPt7jatgyQvBV2N/elTeJi8YB+AB1/+8bH98=;
        b=QUGPNJTHfjz3JdAGqcszXRoiEjzFwVOC+d0Hcm5LDSH9FFPmXRIZ0bA9OpHtgfbqCy
         a9gOwcUflXV2IcOyCvjbNwE43hLSv1flPudAmG2qPY53/tuBBC2tMrBB217FNQcqocDA
         hKg9RWtIrzes+x8tuDq8hvwv2ucMEzWJ1Gv92HMlajbNBLjQR5bIBqQ55ZazrYpCuMWf
         CE9wU3IvtiDr5keBKxPdDyeeQnb+mOIxURwEWfA8w5eRpieS7HubHfVqY+hlkziiYH9S
         rDSF/zlByGu763d7cK4OjGONB3kcg//USex9PIizr/ySSZvu6HIOlPfHHEcSOLoo6MpU
         HT7A==
X-Gm-Message-State: AOAM530oRqy6u2cE7lW4R/oLEuiqm219zKQ95yxiEjjC6ggEFUi0iyeg
        9R6kstrAdIairkjGoJzurNw=
X-Google-Smtp-Source: ABdhPJwEb0GTsAOC546Ms4Bn278hN/6nwa844FnwPV9Yu6zqQzYMCmJ4XtRlCyJlF/MlNDNwkbSqOw==
X-Received: by 2002:a1c:3d05:: with SMTP id k5mr5042689wma.151.1606229623776;
        Tue, 24 Nov 2020 06:53:43 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id u23sm5749930wmc.32.2020.11.24.06.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 06:53:42 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH] arm64: dts: meson: add rtc aliases to meson-khadas-vim3.dtsi
Date:   Tue, 24 Nov 2020 14:53:38 +0000
Message-Id: <20201124145338.17137-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tweak the node name to make it aliasable, then add aliases for the
on-board RTC chip and meson-vrtc timer so they probe as rtc0 and
rtc1 respectively.

before:

VIM3:~ # dmesg | grep rtc
[    3.622530] meson-vrtc ff8000a8.rtc: registered as rtc0
[    3.622574] meson-vrtc ff8000a8.rtc: setting system clock to 1970-01-01T00:00:03 UTC (3)
[    3.646936] rtc-hym8563 0-0051: no valid clock/calendar values available
[    3.647125] rtc-hym8563 0-0051: registered as rtc1
[    3.852382] rtc-hym8563 0-0051: no valid clock/calendar values available

after:

VIM3:~ # dmesg | grep rtc
[    3.583735] meson-vrtc ff8000a8.rtc: registered as rtc1
[    3.633888] rtc-hym8563 0-0051: no valid clock/calendar values available
[    3.634120] rtc-hym8563 0-0051: registered as rtc0
[    3.635250] rtc-hym8563 0-0051: no valid clock/calendar values available
[    3.635267] rtc-hym8563 0-0051: hctosys: unable to read the hardware clock
[    3.852632] rtc-hym8563 0-0051: no valid clock/calendar values available

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi b/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
index 69e6c03a787c..8f8656262ae7 100644
--- a/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
@@ -14,6 +14,8 @@
 	aliases {
 		serial0 = &uart_AO;
 		ethernet0 = &ethmac;
+		rtc0 = &rtc;
+		rtc1 = &vrtc;
 	};
 
 	chosen {
@@ -333,7 +335,7 @@
 		#gpio-cells = <2>;
 	};
 
-	rtc@51 {
+	rtc: rtc@51 {
 		compatible = "haoyu,hym8563";
 		reg = <0x51>;
 		#clock-cells = <0>;
-- 
2.17.1

