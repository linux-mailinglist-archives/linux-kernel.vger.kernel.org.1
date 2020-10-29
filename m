Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB7729E28D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 03:21:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404335AbgJ2CUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 22:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729647AbgJ2CUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 22:20:35 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD5F6C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 19:20:34 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id n15so1127471wrq.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 19:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PqtPf3DHgs6fHCBVvhLshbkSYzOqUzYYfWH2F+Hn7Ao=;
        b=DcQbIJbBLKVuafodlW7ksRLs0ioiE4RCgjgb25fFVZTIdrhSPYsoZ1AqPd34jObL5C
         abdKf32RVUPyiKA4dE0tC9zywi2Z2eJCGLvcgHnAUhHm/0JjMMrqopHLf/JTvnew19K4
         BS9KM5FRuslKTnBMGJQKa9V8xV63+a8jFUPSlLw8ofJV2iOZJRgfPkV1hMJSlCT0EmCA
         rNHtDgAOaOeaS+axkhz8ukgl56dJonLtbFj4bsnJ4O7go2qAQXNAVhQD8pcsZWK8UUUZ
         T+YEusc5VzkzXfFsOGTceMHpAVXoQEjQW4PoyprvtLodnKvK2wO95oEGBGLfUWZSlGW4
         AKuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PqtPf3DHgs6fHCBVvhLshbkSYzOqUzYYfWH2F+Hn7Ao=;
        b=OzHYi9zDHy5fsfmpbXYwX3Qg5gryRkVVTeL7VKBCVlsz15ASDE7OD3fzt/OGIK/bH+
         CRIG1IHzg8NT4mH87/iXmj0jAV8X0C57dDpDee691ZDRKAUFmESye5vtMR775YN00AGg
         UaLV9WczCPMbTr2aArqo1TavDNu5e2EvtqHsQrHN5CDxBpW4IFiERkU90Jn0nfSZhJ0Z
         k0S2HvZnR/G1U8YuWqdAYMkPV1qe45e0STEIyBpnA82s1uhccCL09Aj8gJQY8AGQD2Nz
         qowD2qxlbY5ibKhysJbzetYB5Lgs/xZBN29i0yOmUkJfRT5zbWswksvWnaK1dHVlAHlc
         Z7Jw==
X-Gm-Message-State: AOAM531FqE+QBGa3OkzE+ctDmxdIXkviG5Ib6DLvyZMuO2zWnOyxlVtx
        vO/bkQUGsZR9qBkZY3mZIQ8=
X-Google-Smtp-Source: ABdhPJzL6fIeGSkQ1W3z/90i3PgRoVEaaElUE5FyUTQi8JH+wSgfQ/tKdnbvObTTyW0oQtZ2dGlcMA==
X-Received: by 2002:adf:c101:: with SMTP id r1mr2410810wre.87.1603938033411;
        Wed, 28 Oct 2020 19:20:33 -0700 (PDT)
Received: from matteo-xps-15-9560.lan ([2a01:4b00:a40c:9900::14e])
        by smtp.gmail.com with ESMTPSA id m4sm2138937wrr.47.2020.10.28.19.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 19:20:32 -0700 (PDT)
From:   Matteo Scordino <matteo.scordino@gmail.com>
To:     mripard@kernel.org, wens@csie.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Matteo Scordino <matteo.scordino@gmail.com>
Subject: [PATCH 5/5] ARM: dts: sun8i: s3: Add dts for the Elimo Initium SBC
Date:   Thu, 29 Oct 2020 02:20:00 +0000
Message-Id: <20201029022000.601913-6-matteo.scordino@gmail.com>
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
 arch/arm/boot/dts/sun8i-s3-elimo-initium.dts | 27 ++++++++++++++++++++
 2 files changed, 28 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun8i-s3-elimo-initium.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 4f0adfead547..dcfb8d39c267 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1210,6 +1210,7 @@ dtb-$(CONFIG_MACH_SUN8I) += \
 	sun8i-r40-bananapi-m2-ultra.dtb \
 	sun8i-s3-lichee-zero-plus.dtb \
 	sun8i-s3-pinecube.dtb \
+	sun8i-s3-elimo-initium.dtb \
 	sun8i-t3-cqa3t-bv3.dtb \
 	sun8i-v3s-licheepi-zero.dtb \
 	sun8i-v3s-licheepi-zero-dock.dtb \
diff --git a/arch/arm/boot/dts/sun8i-s3-elimo-initium.dts b/arch/arm/boot/dts/sun8i-s3-elimo-initium.dts
new file mode 100644
index 000000000000..5ddd4dbd636c
--- /dev/null
+++ b/arch/arm/boot/dts/sun8i-s3-elimo-initium.dts
@@ -0,0 +1,27 @@
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
+	compatible = "elimo,initium", "elimo,impetus", "allwinner,sun8i-s3";
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
+&emac {
+	phy-handle = <&int_mii_phy>;
+	phy-mode = "mii";
+	status = "okay";
+};
-- 
2.20.1

