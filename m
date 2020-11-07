Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A30082AA51B
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 13:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbgKGMyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 07:54:08 -0500
Received: from relay5.mymailcheap.com ([159.100.248.207]:41091 "EHLO
        relay5.mymailcheap.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727494AbgKGMyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 07:54:08 -0500
Received: from relay3.mymailcheap.com (relay3.mymailcheap.com [217.182.119.157])
        by relay5.mymailcheap.com (Postfix) with ESMTPS id B856B260EC;
        Sat,  7 Nov 2020 12:54:05 +0000 (UTC)
Received: from filter2.mymailcheap.com (filter2.mymailcheap.com [91.134.140.82])
        by relay3.mymailcheap.com (Postfix) with ESMTPS id 2E1AE3ECDF;
        Sat,  7 Nov 2020 13:54:03 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by filter2.mymailcheap.com (Postfix) with ESMTP id 0DC472A7DD;
        Sat,  7 Nov 2020 13:54:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
        s=default; t=1604753643;
        bh=nNi1KvzAc00IXvO21wt65MRQZ7lDmDRlFXMh2RjU9Dk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CujcacLMGt6bnTlK0IWoQIv5CLCgse7yOt7zu0FFFwz0PToKOquCit4Df1GhWBbzv
         QHSxrlSxyd4aGHxK07hhADfPtGSpnURlM06vJTU7eHv9+QDN7iOcwdkVpUyzVY20nd
         TZ9bED1wFFEoOhTYueL5uKtCzueUDCo1ARk5UUPE=
X-Virus-Scanned: Debian amavisd-new at filter2.mymailcheap.com
Received: from filter2.mymailcheap.com ([127.0.0.1])
        by localhost (filter2.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id rvsIdDPY0VRU; Sat,  7 Nov 2020 13:54:01 +0100 (CET)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by filter2.mymailcheap.com (Postfix) with ESMTPS;
        Sat,  7 Nov 2020 13:54:01 +0100 (CET)
Received: from [213.133.102.83] (ml.mymailcheap.com [213.133.102.83])
        by mail20.mymailcheap.com (Postfix) with ESMTP id 6C54A40849;
        Sat,  7 Nov 2020 12:54:01 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com;
        dkim=pass (1024-bit key; unprotected) header.d=aosc.io header.i=@aosc.io header.b="fN8gZvPD";
        dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from ice-e5v2.lan (unknown [59.41.162.181])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail20.mymailcheap.com (Postfix) with ESMTPSA id 44A9340849;
        Sat,  7 Nov 2020 12:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
        t=1604753635; bh=nNi1KvzAc00IXvO21wt65MRQZ7lDmDRlFXMh2RjU9Dk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fN8gZvPDQ8dFOYQDRQeVwPfOvb0OEn5tkmNr3FvX/+uctar1JkO6S5NUC7Vs4Uc8l
         iOgx/BlgVR96Gg3owsH1ucyXXcbAN8aw4aVA9WTg1sXpnPszLi7N0+58Rb9f2L5YAM
         78q2Wwq0FWfkK8Nl1MBgCiY0Ap0oxEwKMFBGBv40=
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 3/3] arm64: allwinner: dts: a64: add DT for PineTab developer sample
Date:   Sat,  7 Nov 2020 20:53:32 +0800
Message-Id: <20201107125332.2223197-1-icenowy@aosc.io>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201107124958.2222253-1-icenowy@aosc.io>
References: <20201107124958.2222253-1-icenowy@aosc.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6C54A40849
X-Spamd-Result: default: False [6.40 / 20.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         R_DKIM_ALLOW(0.00)[aosc.io:s=default];
         RECEIVED_SPAMHAUS_PBL(0.00)[59.41.162.181:received];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         BROKEN_CONTENT_TYPE(1.50)[];
         R_SPF_SOFTFAIL(0.00)[~all:c];
         DMARC_NA(0.00)[aosc.io];
         ML_SERVERS(-3.10)[213.133.102.83];
         DKIM_TRACE(0.00)[aosc.io:+];
         RCPT_COUNT_SEVEN(0.00)[9];
         MID_CONTAINS_FROM(1.00)[];
         DBL_PROHIBIT(0.00)[0.0.0.0:email];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:24940, ipnet:213.133.96.0/19, country:DE];
         RCVD_COUNT_TWO(0.00)[2];
         SUSPICIOUS_RECIPS(1.50)[];
         HFILTER_HELO_BAREIP(3.00)[213.133.102.83,1]
X-Rspamd-Server: mail20.mymailcheap.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some developers received PineTab samples that used an old LCD panel.

Add device tree for these samples.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 arch/arm64/boot/dts/allwinner/Makefile        |  1 +
 .../dts/allwinner/sun50i-a64-pinetab-dev.dts  | 28 +++++++++++++++++++
 2 files changed, 29 insertions(+)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab-dev.dts

diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts/allwinner/Makefile
index 211d1e9d4701..a221dcebfad4 100644
--- a/arch/arm64/boot/dts/allwinner/Makefile
+++ b/arch/arm64/boot/dts/allwinner/Makefile
@@ -13,6 +13,7 @@ dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-pinephone-1.0.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-pinephone-1.1.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-pinephone-1.2.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-pinetab.dtb
+dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-pinetab-dev.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-sopine-baseboard.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-teres-i.dtb
 dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a100-allwinner-perf1.dtb
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab-dev.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab-dev.dts
new file mode 100644
index 000000000000..3a4153890f3e
--- /dev/null
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab-dev.dts
@@ -0,0 +1,28 @@
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
+	model = "PineTab Developer Sample";
+	compatible = "pine64,pinetab-dev", "allwinner,sun50i-a64";
+};
+
+&dsi {
+	/delete-node/ panel@0;
+
+	panel@0 {
+		compatible = "feixin,k101-im2ba02";
+		reg = <0>;
+		avdd-supply = <&reg_dc1sw>;
+		dvdd-supply = <&reg_dc1sw>;
+		cvdd-supply = <&reg_ldo_io1>;
+		reset-gpios = <&pio 3 24 GPIO_ACTIVE_HIGH>; /* PD24 */
+		backlight = <&backlight>;
+	};
+};
-- 
2.28.0
