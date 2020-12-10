Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 678C62D559E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 09:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387755AbgLJIqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 03:46:47 -0500
Received: from relay4.mymailcheap.com ([137.74.80.156]:33907 "EHLO
        relay4.mymailcheap.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbgLJIqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 03:46:46 -0500
X-Greylist: delayed 440 seconds by postgrey-1.27 at vger.kernel.org; Thu, 10 Dec 2020 03:46:44 EST
Received: from filter1.mymailcheap.com (filter1.mymailcheap.com [149.56.130.247])
        by relay4.mymailcheap.com (Postfix) with ESMTPS id 9D7F43F162;
        Thu, 10 Dec 2020 09:45:13 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by filter1.mymailcheap.com (Postfix) with ESMTP id D33F62A3C9;
        Thu, 10 Dec 2020 03:45:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
        s=default; t=1607589912;
        bh=OAH/72kQAtexFMmJkFN3rsFkzBhidEeqQzj2dxtFf5c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RNGT5aG2kKVcc6f30TfyNdwKuFsx2OXudDU5eN05YxeIOzttE4oavPGPp0fUax0fE
         nG7YB8M/GCc/VcNgZ4EDf21wU2lLYfMF6pKnPnoAPJonGVemoiBLOWqNhcY08rAaiz
         C91UiX/zJ9v7WG8QLBbX/k1gHLJVhOTU6Hnq+wGw=
X-Virus-Scanned: Debian amavisd-new at filter1.mymailcheap.com
Received: from filter1.mymailcheap.com ([127.0.0.1])
        by localhost (filter1.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id FPY8pcTm4gjD; Thu, 10 Dec 2020 03:45:12 -0500 (EST)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by filter1.mymailcheap.com (Postfix) with ESMTPS;
        Thu, 10 Dec 2020 03:45:11 -0500 (EST)
Received: from [148.251.23.173] (ml.mymailcheap.com [148.251.23.173])
        by mail20.mymailcheap.com (Postfix) with ESMTP id ADA6A4119A;
        Thu, 10 Dec 2020 08:45:10 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com;
        dkim=pass (1024-bit key; unprotected) header.d=aosc.io header.i=@aosc.io header.b="Iq2mVeCu";
        dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from ice-e5v2.lan (unknown [59.41.161.121])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail20.mymailcheap.com (Postfix) with ESMTPSA id 7F9294119A;
        Thu, 10 Dec 2020 08:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
        t=1607589903; bh=OAH/72kQAtexFMmJkFN3rsFkzBhidEeqQzj2dxtFf5c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Iq2mVeCuyOKT00pKY4rNgaCE4OZqyoKV7SoCkkzqzrJGkhc1HHdXHTMwwFgVQk53N
         wg/+r/U+GCb1+D8EB2nCqXAE/T8Fo5AHK8wt93rtUB0G2pWucfcRNOlzg6zkLQc1oP
         B3zuMAn3MkOnDLtfBvuqCsX584btnzNP147PNoog=
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Ondrej Jirman <megous@megous.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 2/3] arm64: allwinner: dts: a64: add DT for PineTab with new LCD panel
Date:   Thu, 10 Dec 2020 16:44:50 +0800
Message-Id: <20201210084450.1915234-1-icenowy@aosc.io>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201210083722.1912981-1-icenowy@aosc.io>
References: <20201210083722.1912981-1-icenowy@aosc.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [6.40 / 20.00];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         ARC_NA(0.00)[];
         R_DKIM_ALLOW(0.00)[aosc.io:s=default];
         RECEIVED_SPAMHAUS_PBL(0.00)[59.41.161.121:received];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         BROKEN_CONTENT_TYPE(1.50)[];
         R_SPF_SOFTFAIL(0.00)[~all];
         DMARC_NA(0.00)[aosc.io];
         ML_SERVERS(-3.10)[148.251.23.173];
         DKIM_TRACE(0.00)[aosc.io:+];
         RCPT_COUNT_SEVEN(0.00)[10];
         MID_CONTAINS_FROM(1.00)[];
         DBL_PROHIBIT(0.00)[0.0.0.0:email];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:24940, ipnet:148.251.0.0/16, country:DE];
         RCVD_COUNT_TWO(0.00)[2];
         SUSPICIOUS_RECIPS(1.50)[];
         HFILTER_HELO_BAREIP(3.00)[148.251.23.173,1]
X-Rspamd-Queue-Id: ADA6A4119A
X-Rspamd-Server: mail20.mymailcheap.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Further released PineTabs will have a new LCD panel that is different
with the one used in developers' samples.

Add device tree for PineTab with the new panel.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 arch/arm64/boot/dts/allwinner/Makefile        |  1 +
 .../sun50i-a64-pinetab-new-panel.dts          | 26 +++++++++++++++++++
 2 files changed, 27 insertions(+)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab-new-panel.dts

diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts/allwinner/Makefile
index 211d1e9d4701..83c6d1ea197f 100644
--- a/arch/arm64/boot/dts/allwinner/Makefile
+++ b/arch/arm64/boot/dts/allwinner/Makefile
@@ -13,6 +13,7 @@ dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-pinephone-1.0.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-pinephone-1.1.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-pinephone-1.2.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-pinetab.dtb
+dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-pinetab-new-panel.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-sopine-baseboard.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-teres-i.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a100-allwinner-perf1.dtb
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab-new-panel.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab-new-panel.dts
new file mode 100644
index 000000000000..f3da9653be3e
--- /dev/null
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab-new-panel.dts
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
+	model = "PineTab with new LCD panel";
+	compatible = "pine64,pinetab-new-panel", "allwinner,sun50i-a64";
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
