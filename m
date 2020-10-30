Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC05E2A11B9
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 00:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbgJ3Xn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 19:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgJ3Xnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 19:43:53 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71ED5C0613D5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 16:43:53 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id k10so6832519wrw.13
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 16:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SXDzDs8fzO4AajEJlHRqAUwpi3PQx+E/h45JCZBntuE=;
        b=gHaQmp2PPlPgLs++MQ494dKrTjpvrPpAvCEjTyE7y208GKuRphJZTqsBeF0KGg1WPf
         K9RDao7OnTzhqSjMi/KqERCJYSPpulQRVbJwrrzCtzRcNeWwmgeHryQcS6G8CVTP128Z
         q+1VKm+yirK3U5jr0B9Kwh5+Z8dpSYFp8KPtSrDbY1QnL0f/LkhBeNRZu85ZVHA00AwH
         1DpLa32zKQ1P0b14nfLBwS3+L8vPTnfAYCskN6ooog+pbVEAgTqZzES7IAOsTUpLNm9r
         TsajCCj3wqz0jGaZHu/u5whO25xDulU0lyFTGCgnM+I/rUz6dXA8TCUP5zNGXMcrWaBa
         JW6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SXDzDs8fzO4AajEJlHRqAUwpi3PQx+E/h45JCZBntuE=;
        b=Aa2eqI2SEUpp85J8DyRkeB84EpafdAsO0/+6nUBBo4PyYxPa/uEUYQemFeS43Rbm6L
         idgvoWuqB5217FppJWPaotuuYVnUxlfeaFp890SwGcLvLoIB+hVaBbxUtudexaL/mDfH
         riE1KUJ6T2SGA/VYbd0cAMCcz08jOUpUXH1Ysn8ODnHSz2IJiPF9Eg0+Dbu7cAqyhGq/
         jH2B646EfB00UvXFEXTRblNhQ0Rto63d2gdsAcgz9yLPQcXZjgy8D6ifegVmSdtBJCi1
         qJHxyV3Z/SHjAc+YicrLgHiEKr/K69fWXNZggQ6rUr2CC3uIofgHZ52uOYBerfOirIe0
         j7Nw==
X-Gm-Message-State: AOAM533okFJ/tZGtiLfAlK5z98p2TTLuqL3kXoOhhE4Qlp/gCKm9ZRJl
        aa3g2xK8KHJVfxSuCkcPCegJhJMJVUl7bAZnpQY=
X-Google-Smtp-Source: ABdhPJxdYwhp9HMWqBAqMJ8htVbgH5HwKuDsruSFMKjgHPP0N561IvfUbjzfSQJZNEVCuMqD8OI6gQ==
X-Received: by 2002:a5d:4001:: with SMTP id n1mr6238804wrp.426.1604101432196;
        Fri, 30 Oct 2020 16:43:52 -0700 (PDT)
Received: from matteo-xps-15-9560.lan ([2a01:4b00:a40c:9900::14e])
        by smtp.gmail.com with ESMTPSA id z10sm4702381wrp.2.2020.10.30.16.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 16:43:51 -0700 (PDT)
From:   Matteo Scordino <matteo.scordino@gmail.com>
To:     mripard@kernel.org, wens@csie.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Matteo Scordino <matteo.scordino@gmail.com>
Subject: [PATCH v2 5/6] ARM: dts: sun8i: s3: Add dts for the Elimo Initium SBC
Date:   Fri, 30 Oct 2020 23:43:24 +0000
Message-Id: <20201030234325.5865-6-matteo.scordino@gmail.com>
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
 arch/arm/boot/dts/sun8i-s3-elimo-initium.dts | 28 ++++++++++++++++++++
 2 files changed, 29 insertions(+)
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
index 000000000000..7677ddc07bf9
--- /dev/null
+++ b/arch/arm/boot/dts/sun8i-s3-elimo-initium.dts
@@ -0,0 +1,28 @@
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
+	compatible = "elimo,initium", "elimo,impetus", "sochip,s3",
+    "allwinner,sun8i-v3";
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

