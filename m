Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3C422A11B7
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 00:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725940AbgJ3Xnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 19:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgJ3Xnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 19:43:51 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC9CC0613D5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 16:43:51 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id k18so4323457wmj.5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 16:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+xND+5es9hPbMkQjtyhjJCb101pS/LAdnzcIt5YLGk0=;
        b=I1/fF8eW/6A52uOu+76LhImJp8CjGnsJ61oEIs2zIyFeOiZegT3V4TwxZv31aMCfCa
         bpqPKnpRANTfIemff0IXXR36V7bx+qxvaOcmYh9I8BHJw6gUY9XhuGhnwtmZiuP/kDlw
         y5aMnvFPzL4MhpPwKiev5k05w+poj1YUNx+Yfx90tNqteb/03O/u58mgWV2Ht6X1horm
         cu3a7fEJ1Mh7XlXsV9BE1Nuvq77dVGxPpWfZJj93V1WvwKIdZXAZAp+aVfsq/kwZjUbT
         R+PQCdCRi5K7+ca54IP7smmCzKiTtaAE8CIxIs01zZOUoA428KWxy6AdkbsBhU+LRyrB
         BoNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+xND+5es9hPbMkQjtyhjJCb101pS/LAdnzcIt5YLGk0=;
        b=Wt/Abt662KMCCw7DLBjsB/C6ptoZ6m2ZhvfAPNBwWDPTvyZUMbdr74Xdvw/zHQmqdY
         9n1BQzq5AM5TBTro6dhUdtenesXc7wS/pfOxJVE8YwldMl4kzb/A3YB9NDuGcrelPfcL
         gf3lWAn/q1gkA2ewIn/tP+jZ7tq9Cl7i9vPyMXtDLVPN8oYBi/Oelsf8DeCsqfjMLXUJ
         wZrMLnPtyWmHiZjefw1FPIGOWBKNVCLl7unK4A+tcLJatxR3yIFsF6jPTt70xrbeQuHF
         DALZWH3M5a4vhSMIWvlsS23IBOlz/W80CAR+xylBbC27ZpPj5oGqbSFYIaJ1eSo6Fire
         bqNw==
X-Gm-Message-State: AOAM530c7KI1PycmGoicRdrDgY+hYzEWUQ1imKwUdgzU/EhHYxJ6eXYh
        OscqgowPdwacz/ezta/Asbs=
X-Google-Smtp-Source: ABdhPJzkjQlaM9b8jhy2rZ6nY5Y6/g9bY5ctJ3649HJLWAYztDv4qcM9V2etYx7GX++LO5qO1ss2qg==
X-Received: by 2002:a1c:7515:: with SMTP id o21mr5496023wmc.5.1604101429730;
        Fri, 30 Oct 2020 16:43:49 -0700 (PDT)
Received: from matteo-xps-15-9560.lan ([2a01:4b00:a40c:9900::14e])
        by smtp.gmail.com with ESMTPSA id z10sm4702381wrp.2.2020.10.30.16.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 16:43:48 -0700 (PDT)
From:   Matteo Scordino <matteo.scordino@gmail.com>
To:     mripard@kernel.org, wens@csie.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Matteo Scordino <matteo.scordino@gmail.com>
Subject: [PATCH v2 3/6] ARM: dts: sun8i: s3: Add dtsi for the Elimo Impetus SoM
Date:   Fri, 30 Oct 2020 23:43:22 +0000
Message-Id: <20201030234325.5865-4-matteo.scordino@gmail.com>
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
index 000000000000..f219188fc9ba
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
+	compatible = "elimo,impetus", "sochip,s3", "allwinner,sun8i-v3";
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

