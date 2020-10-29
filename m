Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A382C29E28C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 03:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404343AbgJ2CUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 22:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729619AbgJ2CUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 22:20:34 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B1BC0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 19:20:32 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id a9so1069251wrg.12
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 19:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p+k5s0WbYkMdEPVPD1bxIF0ipb/LaSS2im3XLKl3Zy8=;
        b=IwJA/uuAP9QM8DtgUAE2YIQQ95Igz8KqHxOG4Kyt82Sf5FsZyf/faRSrft+W8bU5RV
         VrD7wzGL4lRiZLvIFk1dMkCRhjsMy+n7Q0sZtvR0zNULOuz5rpwYqcxqmrrGg8OYHv5J
         aghQcRYtvV5v4yrrW8CmMpwKjPMkRBJC74z1Sr4oLChzD0R38XTw2OagBiDE2QUfbsjD
         +bvaVqivKIGcH2pcrpCoyTz2//U556MJN2qR0Wm/X9C9gjsk9L/t6DLgYKgHbu+APq6I
         sX7AAPgBnEpRpUk3U91iBgoS4/fKQwLK9tkOJvORDYahiMMkwS9OEkOg8S/Q9HxX0l9h
         SHFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p+k5s0WbYkMdEPVPD1bxIF0ipb/LaSS2im3XLKl3Zy8=;
        b=FIjwKc5PFQqkiO/jVXZJ5UcNGdDXvsyoXpNQQcayFvyPiyQha8SbOuu7QjQ9f77gcG
         gNxlCLoRTjiMcY13hd1+1gyliBN7bLlnY1JsMDPSKTLxnrTd4iOGaA8PVH605H1DgXEO
         Nmtr0+y6a+85nxIeFqNEJWtdAXjR6k8iMueDKOWq77sJDICUIuXRNQrq+T36HDKtWGQQ
         xM7aTMndOMBDb/qctwHC4OkPU/Peg+G6z2cl+geH0CP08xMzxwgeW3IC6WotjYm3+KvE
         /4uf9XddrIdjf4s8+Xxwn2Om0jk85UfK96tnsA3UY7wEYGPw3RBn1fucgT40Tce6lf8Y
         rDVA==
X-Gm-Message-State: AOAM530zNu0p7pSydsfslLpn+t42EOvAIfNQXAcO/UTQeUisobX8a/17
        amK8sA3dH13JqFuIJUcmtmU=
X-Google-Smtp-Source: ABdhPJyJAXKV8NbAO/mzng+TOLIO2UsZwWP0PA3YTAgxCW+iHcE0b1wXE3hQ5x38OxeWnhQh+msbbw==
X-Received: by 2002:adf:e5cb:: with SMTP id a11mr2477188wrn.353.1603938031157;
        Wed, 28 Oct 2020 19:20:31 -0700 (PDT)
Received: from matteo-xps-15-9560.lan ([2a01:4b00:a40c:9900::14e])
        by smtp.gmail.com with ESMTPSA id m4sm2138937wrr.47.2020.10.28.19.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 19:20:30 -0700 (PDT)
From:   Matteo Scordino <matteo.scordino@gmail.com>
To:     mripard@kernel.org, wens@csie.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Matteo Scordino <matteo.scordino@gmail.com>
Subject: [PATCH 3/5] ARM: dts: sun8i: s3: Add dtsi for the Elimo Impetus SoM
Date:   Thu, 29 Oct 2020 02:19:58 +0000
Message-Id: <20201029022000.601913-4-matteo.scordino@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201029022000.601913-1-matteo.scordino@gmail.com>
References: <20201029022000.601913-1-matteo.scordino@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Elimo Engineering Impetus is an Open Source Hardware System-on-Module
based on the SoChip S3 SoC.

It is meant for integration into carrier boards or, more generally,
larger designs, and uses an M2 connector to facilitate that.

Interfaces on the M.2/NGFF 42mm connector:
WiFi IEEE 802. 11abgn (on-module Realtek)
Bluetooth 4.2/BLE (on-module Realtek)
RGB LCD Interface (on-module connector)
MIPI Camera Interface (on-module connector)
IEEE 802. 3u Ethernet MAC (external connecto)
USB2.0 (Host, Device, OTG) (external connector)
Audio Line In/Out (external connector)

Signed-off-by: Matteo Scordino <matteo.scordino@gmail.com>
---
 arch/arm/boot/dts/sun8i-s3-elimo-impetus.dtsi | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun8i-s3-elimo-impetus.dtsi

diff --git a/arch/arm/boot/dts/sun8i-s3-elimo-impetus.dtsi b/arch/arm/boot/dts/sun8i-s3-elimo-impetus.dtsi
new file mode 100644
index 000000000000..3550125cf334
--- /dev/null
+++ b/arch/arm/boot/dts/sun8i-s3-elimo-impetus.dtsi
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2020 Matteo Scordino <matteo@elimo.io>
+ */
+
+/dts-v1/;
+#include "sun8i-v3.dtsi"
+#include "sunxi-common-regulators.dtsi"
+
+/ {
+	model = "Elimo Impetus SoM";
+	compatible = "elimo,impetus", "sochip,s3", "allwinner,sun8i-s3";
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
+&mmc0 {
+	broken-cd;
+	bus-width = <4>;
+	vmmc-supply = <&reg_vcc3v3>;
+	status = "okay";
+};
+
+&uart0 {
+	pinctrl-0 = <&uart0_pb_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&uart1 {
+	pinctrl-0 = <&uart1_pg_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&usb_otg {
+	dr_mode = "otg";
+	status = "okay";
+};
+
+&usbphy {
+	usb0_id_det-gpio = <&pio 5 6 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
-- 
2.20.1

