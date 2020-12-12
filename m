Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FEE92D84A9
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Dec 2020 06:16:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731283AbgLLFPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Dec 2020 00:15:42 -0500
Received: from relay4.mymailcheap.com ([137.74.199.117]:38039 "EHLO
        relay4.mymailcheap.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387574AbgLLFPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Dec 2020 00:15:14 -0500
Received: from filter1.mymailcheap.com (filter1.mymailcheap.com [149.56.130.247])
        by relay4.mymailcheap.com (Postfix) with ESMTPS id 079E43F20A;
        Sat, 12 Dec 2020 06:13:32 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by filter1.mymailcheap.com (Postfix) with ESMTP id 3C14B2A379;
        Sat, 12 Dec 2020 00:13:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
        s=default; t=1607750011;
        bh=n5uS2JopEBit3sx7utgqMyfNdLKegsVXVvNEuIizCGI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wbkOGgA719BgPDJLlp4Q+Kl9hOwFH+mrnefam/JN4uBfNDqiKIxlEYVfvkciKCdHu
         IQXsPg24lVhTJ2/y76LAoPrhm2GhgG3HZ7mXyTFkZTQDZhDZFsNCngjF+ehZWXdEBP
         pyYWC2PPF0auMi077aXRGHSkAtQJLiexbTjsOW3g=
X-Virus-Scanned: Debian amavisd-new at filter1.mymailcheap.com
Received: from filter1.mymailcheap.com ([127.0.0.1])
        by localhost (filter1.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id bc1J05pFvXds; Sat, 12 Dec 2020 00:13:30 -0500 (EST)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by filter1.mymailcheap.com (Postfix) with ESMTPS;
        Sat, 12 Dec 2020 00:13:30 -0500 (EST)
Received: from [148.251.23.173] (ml.mymailcheap.com [148.251.23.173])
        by mail20.mymailcheap.com (Postfix) with ESMTP id 2A46C42D9B;
        Sat, 12 Dec 2020 05:13:29 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com;
        dkim=pass (1024-bit key; unprotected) header.d=aosc.io header.i=@aosc.io header.b="rTMCgPT4";
        dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from ice-e5v2.lan (unknown [59.41.161.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail20.mymailcheap.com (Postfix) with ESMTPSA id 26C2642F57;
        Sat, 12 Dec 2020 05:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
        t=1607750002; bh=n5uS2JopEBit3sx7utgqMyfNdLKegsVXVvNEuIizCGI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rTMCgPT4IyF1TEzAOgchJMrLtTuqEUT/QBs9KGmIrddJivXNNRbF1DrwYqwvRQ1Rp
         NFppomOnhpaXROSP616ZFEQauMzB4AQE6ucGwW4d9YO67QC6F8JxzgYMUn9JVBwQB3
         6ixEQWBq1xBDS53Ei4XFf+6JHgabCfmcJJ15702M=
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Icenowy Zheng <icenowy@aosc.io>
Subject: [RFC PATCH 12/12] [DO NOT MERGE] ARM: dts: sun8i: v831: add a device tree file for Y20GA
Date:   Sat, 12 Dec 2020 13:13:10 +0800
Message-Id: <20201212051310.3645299-1-icenowy@aosc.io>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201212040157.3639864-1-icenowy@aosc.io>
References: <20201212040157.3639864-1-icenowy@aosc.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: mail20.mymailcheap.com
X-Spamd-Result: default: False [6.40 / 20.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         R_DKIM_ALLOW(0.00)[aosc.io:s=default];
         RECEIVED_SPAMHAUS_PBL(0.00)[59.41.161.2:received];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         BROKEN_CONTENT_TYPE(1.50)[];
         R_SPF_SOFTFAIL(0.00)[~all:c];
         DMARC_NA(0.00)[aosc.io];
         ML_SERVERS(-3.10)[148.251.23.173];
         DKIM_TRACE(0.00)[aosc.io:+];
         RCPT_COUNT_SEVEN(0.00)[8];
         MID_CONTAINS_FROM(1.00)[];
         DBL_PROHIBIT(0.00)[0.0.0.0:email];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:24940, ipnet:148.251.0.0/16, country:DE];
         RCVD_COUNT_TWO(0.00)[2];
         SUSPICIOUS_RECIPS(1.50)[];
         HFILTER_HELO_BAREIP(3.00)[148.251.23.173,1]
X-Rspamd-Queue-Id: 2A46C42D9B
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yi Y20GA is an IP camera with QG2101A chip (a rebranded Allwinner V831).

Add a device tree for it.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 arch/arm/boot/dts/Makefile                |  3 +-
 arch/arm/boot/dts/sun8i-v831-yi-y20ga.dts | 53 +++++++++++++++++++++++
 2 files changed, 55 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/sun8i-v831-yi-y20ga.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index ce66ffd5a1bb..2b2e93bb9ee2 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1212,7 +1212,8 @@ dtb-$(CONFIG_MACH_SUN8I) += \
 	sun8i-t3-cqa3t-bv3.dtb \
 	sun8i-v3s-licheepi-zero.dtb \
 	sun8i-v3s-licheepi-zero-dock.dtb \
-	sun8i-v40-bananapi-m2-berry.dtb
+	sun8i-v40-bananapi-m2-berry.dtb \
+	sun8i-v831-yi-y20ga.dtb
 dtb-$(CONFIG_MACH_SUN9I) += \
 	sun9i-a80-optimus.dtb \
 	sun9i-a80-cubieboard4.dtb
diff --git a/arch/arm/boot/dts/sun8i-v831-yi-y20ga.dts b/arch/arm/boot/dts/sun8i-v831-yi-y20ga.dts
new file mode 100644
index 000000000000..16f4b6dbe0d2
--- /dev/null
+++ b/arch/arm/boot/dts/sun8i-v831-yi-y20ga.dts
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2020 Icenowy Zheng <icenowy@aosc.io>
+ */
+
+/dts-v1/;
+#include "sun8i-v831.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	model = "Yi Camera Y20GA";
+	compatible = "xiaoyi,y20ga", "allwinner,sun8i-v831";
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	reg_vcc3v3: vcc3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+};
+
+&mmc0 {
+	vmmc-supply = <&reg_vcc3v3>;
+	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;
+	bus-width = <4>;
+	status = "okay";
+};
+
+&spi0 {
+	pinctrl-0 = <&spi0_qspi_pins>, <&spi0_cs_pin>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	flash@0 {
+		compatible = "winbond,w25q128", "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <4000000>;
+	};
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_ph9_ph10_pins>;
+	status = "okay";
+};
-- 
2.28.0
