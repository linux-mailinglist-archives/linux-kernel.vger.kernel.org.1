Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88BC42A8629
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 19:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731872AbgKEScr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 13:32:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731103AbgKEScm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 13:32:42 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD4EC0613D2
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 10:32:40 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id c16so2572938wmd.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 10:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GrmcKAlls5FheZRNQHIiGXV6iEbsW7+WdRcNPsA3rPY=;
        b=p6IL7ryRG4oCletiq24imhj+mpaT8EUX4G4E9lIKBy2u8IaZVd0KlpEsmnrCmp2lZj
         6gB9t1ohroVMTvQ1am5qOHwk//JTCKXyJjOuRSEwVnEG98zsf15tM5EOoWVvaZcmVPiG
         ntXzRMCxKcdm4Zk9xYRAPk4+c9Hv4r+kc0ZwHEMBxSxF5Pg/d09YGFRNQwMTvJEu2sIJ
         yd94EBwPi7wjxIiGqgeIV2h1Y3xhps9OWH2tth1IMThnHO89yULdCJ/qVwFpCAaYgVH2
         q+yvi30VwVjHQUwLNpMI5yiZP0G2SFDue6WsU+UxtvO9vaU6rHARoZGscoFT75WeOql0
         GNCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GrmcKAlls5FheZRNQHIiGXV6iEbsW7+WdRcNPsA3rPY=;
        b=TETdjGs8ENnrKo4hLDBiZxPHbCNiXTHGWWM2SxAWFB3LX7Gs5MDm9Zlg7ejF2FR1K+
         chcOb5b/qXjTiX942LhzSpPWUc8E9bmTv1qMe/UDnk9taFSgQvlRV2T7FcTcBYvPvjhm
         8JCuG28ygaDctmZ7EV7Ifh678EmOQUjfxNwCxR7cZkHyoqkGgSvvB4pCWJKNzOYtiFQC
         1g0+sgkFAsRIt5BoQm4O3R9EYsDx+6ebJ9hFd3kSXTPau6KfvvZuqENypvDWTpgIKG59
         S9S+TD08DbH4Z4d0h3H78DyR2o8zyAhsCjyil1EK14xAaK4Z8SsU5AvpIT5uJ6sXdq4M
         mYJA==
X-Gm-Message-State: AOAM5316b3nZdqCv/ztxquC9Gn3yDh7EFWjLvu24/e6AHLNHoVwn39yj
        Z26BNzdfGIqCfsxRdixagNU=
X-Google-Smtp-Source: ABdhPJwRFE9yzh1RGiy+0YdYW6x3ea1uHlQxRF/uxtDjcewxWhauUTvOo/OGE2sGpToFXfxnxQCzCQ==
X-Received: by 2002:a1c:e442:: with SMTP id b63mr4341904wmh.10.1604601159012;
        Thu, 05 Nov 2020 10:32:39 -0800 (PST)
Received: from matteo-xps-15-9560.lan ([2a01:4b00:a40c:9900::14e])
        by smtp.gmail.com with ESMTPSA id h8sm3569601wro.14.2020.11.05.10.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 10:32:38 -0800 (PST)
From:   Matteo Scordino <matteo.scordino@gmail.com>
To:     mripard@kernel.org, wens@csie.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Matteo Scordino <matteo.scordino@gmail.com>
Subject: [PATCH v4 1/3] ARM: dts: sun8i: s3: Add dtsi for the Elimo Impetus SoM
Date:   Thu,  5 Nov 2020 18:32:29 +0000
Message-Id: <20201105183231.12952-2-matteo.scordino@gmail.com>
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
 arch/arm/boot/dts/sun8i-s3-elimo-impetus.dtsi | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun8i-s3-elimo-impetus.dtsi

diff --git a/arch/arm/boot/dts/sun8i-s3-elimo-impetus.dtsi b/arch/arm/boot/dts/sun8i-s3-elimo-impetus.dtsi
new file mode 100644
index 000000000000..24d507cdbcf9
--- /dev/null
+++ b/arch/arm/boot/dts/sun8i-s3-elimo-impetus.dtsi
@@ -0,0 +1,44 @@
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
+	compatible = "elimo,impetus", "sochip,s3", "allwinner,sun8i-v3";
+
+	aliases {
+		serial0 = &uart0;
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

