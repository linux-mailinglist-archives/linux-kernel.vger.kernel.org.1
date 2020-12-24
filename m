Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BDF02E2393
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 03:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728591AbgLXCEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 21:04:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728241AbgLXCEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 21:04:49 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2410C06179C
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 18:04:08 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id w6so482165pfu.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 18:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6GGRKwj/V72sgXB5x/GYoZyHZnvC0fUrPze665l1A3Y=;
        b=n0hC6LYXnsWzYbKJUxRHnkLmYFDvKRNXxUglzhk/S0PU1HnlsbU0Tj1R6EYspQLtvj
         fkHGIfnqJfjes5EVeGqBQv6JLaYOBrZP8kpzjviWVmRXLF8qTY8n/EzqhzVyninoIUZ/
         mEvo3x9HtvCN3mWolnSigCoSADbbJmm9KXhdg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6GGRKwj/V72sgXB5x/GYoZyHZnvC0fUrPze665l1A3Y=;
        b=txNuYGDt5zE35Njxu3y+nSdjBKmePUEbY6Hf4JScgU+DkvJxUaQwxQ4EigEP1KMMLE
         BVA3cDPe3bZ78OmFKDg5gfv8AMmlFRj9e00O71y87P7haN0rVI5tjXOi/arqB7DcwGD/
         aLXvN/1bCixtPVVgyKWhbCU0XiYZ+XZOQ6BFPm6o0v/klEPxnX58ytnBI2PKou12XE6W
         M6MUWGqU8Y/c2LRrtN/SRjqfnpuRFjwWpR6q4aEok1AKp2imxiByJPh8qF7VpBpT8esq
         3s33uPSWv0g2lOqDv9m3B7T3qLhyIptjQdLLTzgBR3hZMOqCBFqidqzGqDQQyyUyoLfr
         yAVw==
X-Gm-Message-State: AOAM532eLata9L15nK5kXqv16/eL/n0AQ5dHOzV7xePVjgps9esttQT4
        9oRhDLvhq4I8BfYSdx1ayUXwkg==
X-Google-Smtp-Source: ABdhPJyyxa/q5anc6DBZR2srp741iNm0H7XIBW2Sow3jBUv/Z4CCvkhSAXcwsgVWWhSPbdU3XSb8tg==
X-Received: by 2002:a63:8c15:: with SMTP id m21mr11410215pgd.396.1608775448301;
        Wed, 23 Dec 2020 18:04:08 -0800 (PST)
Received: from shiro.work (p1268123-ipngn200803sizuokaden.shizuoka.ocn.ne.jp. [118.13.124.123])
        by smtp.googlemail.com with ESMTPSA id t1sm745564pju.43.2020.12.23.18.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Dec 2020 18:04:07 -0800 (PST)
From:   Daniel Palmer <daniel@0x0f.com>
To:     soc@kernel.org, devicetree@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, olof@lixom.net, w@1wt.eu,
        Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH v2] ARM: mstar: Unify common parts of BreadBee boards into a dtsi
Date:   Thu, 24 Dec 2020 11:03:54 +0900
Message-Id: <20201224020354.2212037-1-daniel@0x0f.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The BreadBee and the BreadBee Crust are the same PCB with a different
SoC mounted. There are two top level dts to handle this.

To avoid deduplicating the parts that are more related to the PCB than
the SoC (i.e. the voltage regs and LEDs) add a common dtsi that can
be included in both top level dts.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 .../dts/mstar-infinity-breadbee-common.dtsi   | 49 +++++++++++++++++++
 .../mstar-infinity-msc313-breadbee_crust.dts  |  1 +
 .../dts/mstar-infinity3-msc313e-breadbee.dts  |  1 +
 3 files changed, 51 insertions(+)
 create mode 100644 arch/arm/boot/dts/mstar-infinity-breadbee-common.dtsi

diff --git a/arch/arm/boot/dts/mstar-infinity-breadbee-common.dtsi b/arch/arm/boot/dts/mstar-infinity-breadbee-common.dtsi
new file mode 100644
index 000000000000..507ff2fba837
--- /dev/null
+++ b/arch/arm/boot/dts/mstar-infinity-breadbee-common.dtsi
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2020 thingy.jp.
+ * Author: Daniel Palmer <daniel@thingy.jp>
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	vcc_core: fixedregulator@0 {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_core";
+		regulator-min-microvolt = <1000000>;
+		regulator-max-microvolt = <1000000>;
+		regulator-boot-on;
+	};
+
+	vcc_dram: fixedregulator@1 {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_dram";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-boot-on;
+	};
+
+	vcc_io: fixedregulator@2 {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_io";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		red {
+			gpios = <&gpio MSC313_GPIO_SR_IO16 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "activity";
+		};
+		yellow {
+			gpios = <&gpio MSC313_GPIO_SR_IO17 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+};
+
+&cpu0 {
+	cpu-supply = <&vcc_core>;
+};
diff --git a/arch/arm/boot/dts/mstar-infinity-msc313-breadbee_crust.dts b/arch/arm/boot/dts/mstar-infinity-msc313-breadbee_crust.dts
index f9db2ff86f2d..db4910dcb8a7 100644
--- a/arch/arm/boot/dts/mstar-infinity-msc313-breadbee_crust.dts
+++ b/arch/arm/boot/dts/mstar-infinity-msc313-breadbee_crust.dts
@@ -6,6 +6,7 @@
 
 /dts-v1/;
 #include "mstar-infinity-msc313.dtsi"
+#include "mstar-infinity-breadbee-common.dtsi"
 
 / {
 	model = "BreadBee Crust";
diff --git a/arch/arm/boot/dts/mstar-infinity3-msc313e-breadbee.dts b/arch/arm/boot/dts/mstar-infinity3-msc313e-breadbee.dts
index f0eda80a95cc..e64ca4ce1830 100644
--- a/arch/arm/boot/dts/mstar-infinity3-msc313e-breadbee.dts
+++ b/arch/arm/boot/dts/mstar-infinity3-msc313e-breadbee.dts
@@ -6,6 +6,7 @@
 
 /dts-v1/;
 #include "mstar-infinity3-msc313e.dtsi"
+#include "mstar-infinity-breadbee-common.dtsi"
 
 / {
 	model = "BreadBee";
-- 
2.29.2

