Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1409E2A8161
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 15:50:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731154AbgKEOtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 09:49:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730660AbgKEOtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 09:49:55 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB2DC0613D2
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 06:49:54 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id x12so2074503wrm.8
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 06:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GrmcKAlls5FheZRNQHIiGXV6iEbsW7+WdRcNPsA3rPY=;
        b=kxiycmINXTJFMhqjrjqXez51q2+2eLkvUSx1vx5XDKTaChHJBs+5qpJUvMc/bUc2aL
         2opMS/7Um0GcQ4Hj03wlvXmqZfOvHyGBQKH5bZPcKpa6GDrCLt+0eyVy/KStwrlmooNG
         KPYGH9Qzwo3JByWUNvGi2iL7VGO1lubDzibyFjoiI+NYLYA44GbnHQzOg+nlhywh63vA
         0tjEqlANuz2EcpPAJYH4LMGsvCib8nikY4JeKrR4mAvRXZ/XcrmXqDUxU5HRCtgHDGXG
         QYO5o2W8tsVrWduKx6zY9z1C+zNPHVetc5tjuwVhMxUZmbIJDnRiXzfnzqV1TE5m0Wgu
         bcKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GrmcKAlls5FheZRNQHIiGXV6iEbsW7+WdRcNPsA3rPY=;
        b=ooXd7yWe9m4+y4BAF16Us6gRqpOQTFzCKxoDBRnhG+AeCg52hoHDZCGB1njDXfg02N
         IAAFxRoxKCb+hgRF84c5+Fkz5dIJO3DGZm3B2R+fkUy0x0G9L2cx9KoiMB5xKK9KjaFE
         rwIdxdWEMygkgB5pHOEuDUq/wT9LsH+aQJOj3ye2ASyUydUlbRb4rzUhCuBIF3VERLwL
         T9urlpVuIHAgkynZ/vAhZ60wOlori4rM/QqD6EiKe8fpx9e1A5Ej5us17h0Pqbf7FPlK
         Axe5/CiLIGA/OMPk3TNxSh16nrHNZHi0A9szjxAF2OtrU/A4eL0fQn6Vh+Zv6LGkm9oh
         ktEw==
X-Gm-Message-State: AOAM531143a5deMI48MZbHvy+kXciPKwoFRG6sg0+pPi4fg1hHXqFEDp
        qNGA8ENL4hEgKj7ThG42gLc=
X-Google-Smtp-Source: ABdhPJxQxq4bggcrMpnMfUMpOCblRZBfQdcDxjpwukRvGgrsp9MmtugLrl9BUk1XANQ+uyoYxXrTjg==
X-Received: by 2002:adf:b30c:: with SMTP id j12mr3416322wrd.82.1604587793678;
        Thu, 05 Nov 2020 06:49:53 -0800 (PST)
Received: from matteo-xps-15-9560.lan ([2a01:4b00:a40c:9900::14e])
        by smtp.gmail.com with ESMTPSA id z11sm3055512wrr.66.2020.11.05.06.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 06:49:52 -0800 (PST)
From:   Matteo Scordino <matteo.scordino@gmail.com>
To:     mripard@kernel.org, wens@csie.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Matteo Scordino <matteo.scordino@gmail.com>
Subject: [PATCH v3 1/3] ARM: dts: sun8i: s3: Add dtsi for the Elimo Impetus SoM
Date:   Thu,  5 Nov 2020 14:49:43 +0000
Message-Id: <20201105144945.484592-2-matteo.scordino@gmail.com>
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

