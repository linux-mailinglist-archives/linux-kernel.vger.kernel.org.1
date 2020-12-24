Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 286082E23BE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 03:43:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728781AbgLXCnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 21:43:06 -0500
Received: from relay5.mymailcheap.com ([159.100.241.64]:47680 "EHLO
        relay5.mymailcheap.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728630AbgLXCnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 21:43:06 -0500
Received: from relay2.mymailcheap.com (relay2.mymailcheap.com [217.182.113.132])
        by relay5.mymailcheap.com (Postfix) with ESMTPS id EE4F420100;
        Thu, 24 Dec 2020 02:42:12 +0000 (UTC)
Received: from filter2.mymailcheap.com (filter2.mymailcheap.com [91.134.140.82])
        by relay2.mymailcheap.com (Postfix) with ESMTPS id 76CCB3ECDA;
        Thu, 24 Dec 2020 03:40:39 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by filter2.mymailcheap.com (Postfix) with ESMTP id 52DC12A510;
        Thu, 24 Dec 2020 03:40:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
        s=default; t=1608777639;
        bh=gxipWwX+o4QY7Q5WVFFaIEFTW+q30ON8Op8KUXpt5UM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tV/84nLrLvdEJu2h/4ayoCXXrZaEJLvQ6qqF6iGwHG7iESBn5aJUQ8T4Fb19qhqFj
         cUiRfdfWao60PpydBynZ65On97/zCxVRvhF9vqQ9V8w16vhh0PYmt7yPAoiDv3B3Cz
         6NxHGBgWBCNsroqHLKW4XjYyDIuWTziRGpWmnS+I=
X-Virus-Scanned: Debian amavisd-new at filter2.mymailcheap.com
Received: from filter2.mymailcheap.com ([127.0.0.1])
        by localhost (filter2.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Hm5W1uBRs6Hk; Thu, 24 Dec 2020 03:40:38 +0100 (CET)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by filter2.mymailcheap.com (Postfix) with ESMTPS;
        Thu, 24 Dec 2020 03:40:38 +0100 (CET)
Received: from [148.251.23.173] (ml.mymailcheap.com [148.251.23.173])
        by mail20.mymailcheap.com (Postfix) with ESMTP id C4D4D422D4;
        Thu, 24 Dec 2020 02:40:37 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com;
        dkim=pass (1024-bit key; unprotected) header.d=aosc.io header.i=@aosc.io header.b="QRoMbGZw";
        dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from ice-e5v2.lan (unknown [59.41.162.103])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail20.mymailcheap.com (Postfix) with ESMTPSA id 5537141EFA;
        Thu, 24 Dec 2020 02:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
        t=1608777632; bh=gxipWwX+o4QY7Q5WVFFaIEFTW+q30ON8Op8KUXpt5UM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QRoMbGZwaBz8o3mBU0hVaaYg+XjOkhAQVhAxyjn1uXIcIJcKVOJm9JXu/uO6t7jQC
         iGuuMPLVK5kp7Huphu99LTUoWxvHghrHP51Tdy6inBTnjEhzEicXBD70efDb8oaJk5
         wuSHKBUKNMJsENRri3EUd8HuTxL/n/42XEOAPnOE=
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH v2 2/3] arm64: allwinner: dts: a64: add DT for Early Adopter's PineTab
Date:   Thu, 24 Dec 2020 10:40:00 +0800
Message-Id: <20201224024001.19248-2-icenowy@aosc.io>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201224024001.19248-1-icenowy@aosc.io>
References: <20201224024001.19248-1-icenowy@aosc.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [6.40 / 20.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         R_DKIM_ALLOW(0.00)[aosc.io:s=default];
         RECEIVED_SPAMHAUS_PBL(0.00)[59.41.162.103:received];
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
         RCPT_COUNT_SEVEN(0.00)[9];
         MID_CONTAINS_FROM(1.00)[];
         DBL_PROHIBIT(0.00)[0.0.0.0:email];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:24940, ipnet:148.251.0.0/16, country:DE];
         RCVD_COUNT_TWO(0.00)[2];
         SUSPICIOUS_RECIPS(1.50)[];
         HFILTER_HELO_BAREIP(3.00)[148.251.23.173,1]
X-Rspamd-Queue-Id: C4D4D422D4
X-Rspamd-Server: mail20.mymailcheap.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PineTabs since Early Adopter batch will use a new LCD panel.

Add device tree for PineTab with the new panel.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 arch/arm64/boot/dts/allwinner/Makefile        |  1 +
 .../sun50i-a64-pinetab-early-adopter.dts      | 26 +++++++++++++++++++
 2 files changed, 27 insertions(+)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab-early-adopter.dts

diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts/allwinner/Makefile
index 211d1e9d4701..41ce680e5f8d 100644
--- a/arch/arm64/boot/dts/allwinner/Makefile
+++ b/arch/arm64/boot/dts/allwinner/Makefile
@@ -13,6 +13,7 @@ dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-pinephone-1.0.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-pinephone-1.1.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-pinephone-1.2.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-pinetab.dtb
+dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-pinetab-early-adopter.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-sopine-baseboard.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-teres-i.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a100-allwinner-perf1.dtb
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab-early-adopter.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab-early-adopter.dts
new file mode 100644
index 000000000000..652fc0cce304
--- /dev/null
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab-early-adopter.dts
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2020 Icenowy Zheng <icenowy@aosc.io>
+ *
+ */
+
+/dts-v1/;
+
+#include "sun50i-a64-pinetab.dts"
+
+/ {
+	model = "PineTab, Early Adopter's version";
+	compatible = "pine64,pinetab-early-adopter", "allwinner,sun50i-a64";
+};
+
+&dsi {
+	/delete-node/ panel@0;
+
+	panel@0 {
+		compatible = "feixin,k101-im2byl02";
+		reg = <0>;
+		power-supply = <&reg_dc1sw>;
+		reset-gpios = <&pio 3 24 GPIO_ACTIVE_LOW>; /* PD24 */
+		backlight = <&backlight>;
+	};
+};
-- 
2.28.0
