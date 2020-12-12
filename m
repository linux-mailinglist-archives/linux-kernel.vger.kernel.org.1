Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 600D32D8439
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Dec 2020 05:08:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438070AbgLLEHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 23:07:00 -0500
Received: from relay5.mymailcheap.com ([159.100.248.207]:33932 "EHLO
        relay5.mymailcheap.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407050AbgLLEGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 23:06:09 -0500
Received: from relay2.mymailcheap.com (relay2.mymailcheap.com [217.182.66.162])
        by relay5.mymailcheap.com (Postfix) with ESMTPS id 6478B260EB;
        Sat, 12 Dec 2020 04:05:14 +0000 (UTC)
Received: from filter2.mymailcheap.com (filter2.mymailcheap.com [91.134.140.82])
        by relay2.mymailcheap.com (Postfix) with ESMTPS id 548103EDEC;
        Sat, 12 Dec 2020 05:03:40 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by filter2.mymailcheap.com (Postfix) with ESMTP id 2CA5E2A5BB;
        Sat, 12 Dec 2020 05:03:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
        s=default; t=1607745820;
        bh=tCgOsg76P+Ko8S868gu/lAWhlOBjttNBR7Znp3KX0Ow=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bE0MnyztCSvy0PtUc8oIt65pYPoX5IgwF7wi5TGg5gxqJw52uzw9k8ArwG9sjqEbN
         9VqOF1JEM4No8V8fRmokkjp/zi+6bU8+iNubkI/MCaOY2H8/r4dWALz25X0IpiF9G5
         BgX9c96MQap1Zhw8dvmIaB3irwt/Vqq/CI9hdh5s=
X-Virus-Scanned: Debian amavisd-new at filter2.mymailcheap.com
Received: from filter2.mymailcheap.com ([127.0.0.1])
        by localhost (filter2.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id mzqLsyATAbzg; Sat, 12 Dec 2020 05:03:38 +0100 (CET)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by filter2.mymailcheap.com (Postfix) with ESMTPS;
        Sat, 12 Dec 2020 05:03:38 +0100 (CET)
Received: from [148.251.23.173] (ml.mymailcheap.com [148.251.23.173])
        by mail20.mymailcheap.com (Postfix) with ESMTP id 9E42542F58;
        Sat, 12 Dec 2020 04:03:38 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com;
        dkim=pass (1024-bit key; unprotected) header.d=aosc.io header.i=@aosc.io header.b="bgxE3xO2";
        dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from ice-e5v2.lan (unknown [59.41.161.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail20.mymailcheap.com (Postfix) with ESMTPSA id 709FD42F57;
        Sat, 12 Dec 2020 04:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
        t=1607745814; bh=tCgOsg76P+Ko8S868gu/lAWhlOBjttNBR7Znp3KX0Ow=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bgxE3xO2QIICNssqIioAso9UlYPXTsvGHb/hNkaKZxQmSJQhcELsdR9g8JWUe0guN
         bZO1KStQ/ODVTm5TJeocfFzkQyAYm1OpAjc6Fi/2pmK5UTuTZzEsP2M4WPz9yCbL1I
         YllB9Y4gMLaP1xSkTjlvqFdz0Fg9EZ2DhkFaV9NY=
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Icenowy Zheng <icenowy@aosc.io>
Subject: [RFC PATCH 02/12] dt-bindings: clk: sunxi-ng: add V833 CCU clock/reset indices headers
Date:   Sat, 12 Dec 2020 12:03:08 +0800
Message-Id: <20201212040318.3640236-1-icenowy@aosc.io>
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
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:24940, ipnet:148.251.0.0/16, country:DE];
         RCVD_COUNT_TWO(0.00)[2];
         SUSPICIOUS_RECIPS(1.50)[];
         HFILTER_HELO_BAREIP(3.00)[148.251.23.173,1]
X-Rspamd-Queue-Id: 9E42542F58
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the device tree needs the clock/reset indices, add them to DT binding
headers.

The driver itself will be then added.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 include/dt-bindings/clock/sun8i-v833-ccu.h | 89 ++++++++++++++++++++++
 include/dt-bindings/reset/sun8i-v833-ccu.h | 52 +++++++++++++
 2 files changed, 141 insertions(+)
 create mode 100644 include/dt-bindings/clock/sun8i-v833-ccu.h
 create mode 100644 include/dt-bindings/reset/sun8i-v833-ccu.h

diff --git a/include/dt-bindings/clock/sun8i-v833-ccu.h b/include/dt-bindings/clock/sun8i-v833-ccu.h
new file mode 100644
index 000000000000..885f3462eab6
--- /dev/null
+++ b/include/dt-bindings/clock/sun8i-v833-ccu.h
@@ -0,0 +1,89 @@
+/* SPDX-License-Identifier: (GPL-2.0+ or MIT) */
+/*
+ * Copyright (C) 2020 Icenowy Zheng <icenowy@aosc.io>
+ */
+
+#ifndef _DT_BINDINGS_CLK_SUN8I_V833_H_
+#define _DT_BINDINGS_CLK_SUN8I_V833_H_
+
+#define CLK_CPUX		14
+
+#define CLK_APB1		19
+
+#define CLK_DE			21
+#define CLK_BUS_DE		22
+#define CLK_G2D			23
+#define CLK_BUS_G2D		24
+#define CLK_CE			25
+#define CLK_BUS_CE		26
+#define CLK_VE			27
+#define CLK_BUS_VE		28
+#define CLK_EISE		29
+#define CLK_BUS_EISE		30
+#define CLK_NPU			31
+#define CLK_BUS_NPU		32
+#define CLK_BUS_DMA		33
+#define CLK_BUS_HSTIMER		34
+#define CLK_AVS			35
+#define CLK_BUS_DBG		36
+#define CLK_BUS_PSI		37
+#define CLK_BUS_PWM		38
+#define CLK_MBUS_DMA		40
+#define CLK_MBUS_VE		41
+#define CLK_MBUS_CE		42
+#define CLK_MBUS_TS		43
+#define CLK_MBUS_NAND		44
+#define CLK_MBUS_G2D		45
+#define CLK_MBUS_EISE		46
+#define CLK_MBUS_VDPO		47
+#define CLK_MMC0		49
+#define CLK_MMC1		50
+#define CLK_MMC2		51
+#define CLK_BUS_MMC0		52
+#define CLK_BUS_MMC1		53
+#define CLK_BUS_MMC2		54
+#define CLK_BUS_UART0		55
+#define CLK_BUS_UART1		56
+#define CLK_BUS_UART2		57
+#define CLK_BUS_UART3		58
+#define CLK_BUS_I2C0		59
+#define CLK_BUS_I2C1		60
+#define CLK_BUS_I2C2		61
+#define CLK_BUS_I2C3		62
+#define CLK_SPI0		63
+#define CLK_SPI1		64
+#define CLK_SPI2		65
+#define CLK_BUS_SPI0		66
+#define CLK_BUS_SPI1		67
+#define CLK_BUS_SPI2		68
+#define CLK_EMAC_25M		69
+#define CLK_BUS_EMAC0		70
+#define CLK_BUS_GPADC		71
+#define CLK_BUS_THS		72
+#define CLK_I2S0		73
+#define CLK_I2S1		74
+#define CLK_BUS_I2S0		75
+#define CLK_BUS_I2S1		76
+#define CLK_AUDIO_CODEC_1X	77
+#define CLK_AUDIO_CODEC_4X	78
+#define CLK_BUS_AUDIO_CODEC	79
+#define CLK_USB_OHCI0		80
+#define CLK_USB_PHY0		81
+#define CLK_BUS_OHCI0		82
+#define CLK_BUS_EHCI0		83
+#define CLK_BUS_OTG		84
+#define CLK_MIPI_DSI_DPHY0_HS	85
+#define CLK_MIPI_DSI_HOST0	86
+#define CLK_BUS_MIPI_DSI	87
+#define CLK_BUS_TCON_TOP	88
+#define CLK_TCON_LCD0		89
+#define CLK_BUS_TCON_LCD0	90
+#define CLK_CSI_TOP		91
+#define CLK_CSI_MCLK0		92
+#define CLK_CSI_MCLK1		93
+#define CLK_ISP			94
+#define CLK_BUS_CSI		95
+#define CLK_DSPO		96
+#define CLK_BUS_DSPO		97
+
+#endif /* _DT_BINDINGS_CLK_SUN8I_V833_H_ */
diff --git a/include/dt-bindings/reset/sun8i-v833-ccu.h b/include/dt-bindings/reset/sun8i-v833-ccu.h
new file mode 100644
index 000000000000..fb2b0e3b287f
--- /dev/null
+++ b/include/dt-bindings/reset/sun8i-v833-ccu.h
@@ -0,0 +1,52 @@
+/* SPDX-License-Identifier: (GPL-2.0+ or MIT) */
+/*
+ * Copyright (C) 2017 Icenowy Zheng <icenowy@aosc.io>
+ */
+
+#ifndef _DT_BINDINGS_RESET_SUN8I_V833_H_
+#define _DT_BINDINGS_RESET_SUN8I_V833_H_
+
+#define RST_MBUS		0
+#define RST_BUS_DE		1
+#define RST_BUS_G2D		2
+#define RST_BUS_CE		3
+#define RST_BUS_VE		4
+#define RST_BUS_EISE		5
+#define RST_BUS_NPU		6
+#define RST_BUS_DMA		7
+#define RST_BUS_HSTIMER		8
+#define RST_BUS_DBG		9
+#define RST_BUS_PSI		10
+#define RST_BUS_PWM		11
+#define RST_BUS_DRAM		12
+#define RST_BUS_MMC0		13
+#define RST_BUS_MMC1		14
+#define RST_BUS_MMC2		15
+#define RST_BUS_UART0		16
+#define RST_BUS_UART1		17
+#define RST_BUS_UART2		18
+#define RST_BUS_UART3		19
+#define RST_BUS_I2C0		20
+#define RST_BUS_I2C1		21
+#define RST_BUS_I2C2		22
+#define RST_BUS_I2C3		23
+#define RST_BUS_SPI0		24
+#define RST_BUS_SPI1		25
+#define RST_BUS_SPI2		26
+#define RST_BUS_EMAC0		27
+#define RST_BUS_GPADC		28
+#define RST_BUS_THS		29
+#define RST_BUS_I2S0		30
+#define RST_BUS_I2S1		31
+#define RST_BUS_AUDIO_CODEC	32
+#define RST_USB_PHY0		33
+#define RST_BUS_OHCI0		34
+#define RST_BUS_EHCI0		35
+#define RST_BUS_OTG		36
+#define RST_BUS_MIPI_DSI	37
+#define RST_BUS_TCON_TOP	38
+#define RST_BUS_TCON_LCD0	39
+#define RST_BUS_CSI		40
+#define RST_BUS_DSPO		41
+
+#endif /* _DT_BINDINGS_RESET_SUN8I_V833_H_ */
-- 
2.28.0
