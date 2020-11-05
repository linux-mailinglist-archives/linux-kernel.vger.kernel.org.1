Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDE7C2A8163
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 15:50:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731462AbgKEOuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 09:50:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731367AbgKEOt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 09:49:57 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E7DC0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 06:49:57 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id e6so2095936wro.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 06:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+TMsiKU1hFo2u+onujb/+Ek9bBIBIE3r85C1JvvRodw=;
        b=IGY0T6xiWXXuQkcg+4tphWiebv2htdU0MoDflvTHFgywqEVFUDSrSmk/0M28UaJTCR
         nEL8+GLk+TVt855Tob470CG68morOsEmEE+4yVq832i+Vzi5JBOxNOjbiA4fvYSVSm5v
         GWwoVSr9of8aZq2T06ZlKkpXXtMU4ABwgx7sXhbbCFxBcZB9bEC1TioDyndiHL5WR9Dj
         i1zKl9a+8smyYJzBko2rJb8dAuDkVrG1gyPmMRNZUepm+hauJ+De8UOIkJNYSedaRW/L
         M9Emw1j52Y6D6gs8RF6rTUhgwm2zUDVZKUVpIb4/AlRG/f6dYu++xrFTGBEBy0CmF/hX
         dbTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+TMsiKU1hFo2u+onujb/+Ek9bBIBIE3r85C1JvvRodw=;
        b=DGZxnsVxMwB9D9b72WTNLWpPaynQCd4+13PYIkBUTt7jiaVDQp8i8K+7ZHPkiXfo0K
         hCr80QSprEcsb5CaJkHh4viZK8m2HIbnpDgUJ4XbNNpTX1JjyluloVMyhYm7E4A7zVQM
         nzd8eMVR9FWhKaa2O3Fu+KXTAF9+o13PL1kurEPfPNZ7or1LBnncPBPibZJq6yUriIgL
         DFqvCSJ/81XJBDXIQfPwLwx1RRixN8fI7Zr6RrGsQvPhvxCodkV39X/kebhUbsbu18Gv
         EQDr52LvBkToNOVM69mPreg2FL5r6FkJ3YOtuAPsGXCfqLuU44JAuacLoZSlHuHx4Xmz
         ONlA==
X-Gm-Message-State: AOAM532NS6n1D/drtCm2Q4fgOPyJLuJrWyri1THByljUmqtPhvTeVjHa
        n+SxoGXOo9+6+C/Vl8b+pUM=
X-Google-Smtp-Source: ABdhPJxZ5cROXRTN8w5Efg9stzBLvMKO8wot5OMdwVvA6vXM58pUJu5ChkY26vf8vfsH3RdAe5kvOQ==
X-Received: by 2002:adf:e7c1:: with SMTP id e1mr3592471wrn.247.1604587795887;
        Thu, 05 Nov 2020 06:49:55 -0800 (PST)
Received: from matteo-xps-15-9560.lan ([2a01:4b00:a40c:9900::14e])
        by smtp.gmail.com with ESMTPSA id z11sm3055512wrr.66.2020.11.05.06.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 06:49:55 -0800 (PST)
From:   Matteo Scordino <matteo.scordino@gmail.com>
To:     mripard@kernel.org, wens@csie.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Matteo Scordino <matteo.scordino@gmail.com>
Subject: [PATCH v3 3/3] ARM: dts: sun8i: s3: Add dts for the Elimo Initium SBC
Date:   Thu,  5 Nov 2020 14:49:45 +0000
Message-Id: <20201105144945.484592-4-matteo.scordino@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201029022000.601913-1-matteo.scordino@gmail.com>
References: <20201029022000.601913-1-matteo.scordino@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Elimo Engineering Initium is an Open Source Hardware Single Board
Computer based on the Elimo Impetus SoM.

It is meant as the first development platform for the Impetus, providing
convenient access to the peripherals on the Impetus.

It provides:
USB-C power input
UART-to-USB bridge on the USB-C connector, connected to UART1
USB-A connector for USB2.0 (Host, Device, OTG)
Audio Line In/Out
Pin header to access all signals on the M2 connector of the SoM

Signed-off-by: Matteo Scordino <matteo.scordino@gmail.com>
---
 arch/arm/boot/dts/Makefile                   |  1 +
 arch/arm/boot/dts/sun8i-s3-elimo-initium.dts | 34 ++++++++++++++++++++
 2 files changed, 35 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun8i-s3-elimo-initium.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 4f0adfead547..50e438ab8a00 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1208,6 +1208,7 @@ dtb-$(CONFIG_MACH_SUN8I) += \
 	sun8i-r16-nintendo-super-nes-classic.dtb \
 	sun8i-r16-parrot.dtb \
 	sun8i-r40-bananapi-m2-ultra.dtb \
+	sun8i-s3-elimo-initium.dtb \
 	sun8i-s3-lichee-zero-plus.dtb \
 	sun8i-s3-pinecube.dtb \
 	sun8i-t3-cqa3t-bv3.dtb \
diff --git a/arch/arm/boot/dts/sun8i-s3-elimo-initium.dts b/arch/arm/boot/dts/sun8i-s3-elimo-initium.dts
new file mode 100644
index 000000000000..2119403fb65e
--- /dev/null
+++ b/arch/arm/boot/dts/sun8i-s3-elimo-initium.dts
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2020 Matteo Scordino <matteo@elimo.io>
+ */
+
+/dts-v1/;
+#include "sun8i-s3-elimo-impetus.dtsi"
+
+/ {
+	model = "Elimo Initium";
+	compatible = "elimo,initium", "elimo,impetus", "sochip,s3",
+		     "allwinner,sun8i-v3";
+
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart1;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
+
+&uart1 {
+	pinctrl-0 = <&uart1_pg_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&emac {
+	phy-handle = <&int_mii_phy>;
+	phy-mode = "mii";
+	status = "okay";
+};
-- 
2.20.1

