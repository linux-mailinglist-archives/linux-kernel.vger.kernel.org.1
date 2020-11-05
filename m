Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC0C2A8628
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 19:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731837AbgKEScq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 13:32:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731644AbgKEScm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 13:32:42 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B7CC0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 10:32:42 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id d142so2567031wmd.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 10:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8b4XLqKb/1b64uw1dkOkNBT0GLZVNL4KDpKck2q/HjA=;
        b=SblMka5WRWreu2LISg37/lmEVngqr+72OlIXfsEC174dAPRdusVqcyDqtBN0cIxEyC
         3l06JwdQeFVt9OsW+GmvS9DnewvHTgbgPvmqNDcjhwBJZb2rEkurGmKO/SeHiG0IWOmn
         Hefb6oSS1DDqfU5fBHc0kaDZa1PIZ8xn58npKJmdPRtrZ2eQdRTcw/PbJ2uFYoN6Sp7F
         YIhyH2Ua/onieZKQgwE9zbh2uAbb24QyrWaR1x6iCxDt+fgSjMuavt+stefiRyo+P/FN
         jcwn6I5++fR2edQEoql3d43RItJcmoejI2KobiDiqtJNsVXW0+Fl9d/jqk39C4MoEYYl
         8uOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8b4XLqKb/1b64uw1dkOkNBT0GLZVNL4KDpKck2q/HjA=;
        b=tylCh3IWSxfzuOvR0qb2AIDYSqE0HtSHTr9anQaOQcTlCx6aqcjwWL6F5AjqTpn/TM
         QuYMxtQ4Wi+2gcXx2Vckv95s3CfRiffM246OVuil2EBMqGtEx1hBncbxg1maAqUkuk5X
         A7LqBvQncosokJF0YlIOn3JXgRXaI1Mor9t+IhmUjvDdyB1N4IUyw/BrQCx8x0II0xQb
         Vn12VmUHK2SrG0/JivC/47aEsJsbxHtJDqtWzZUIcJhs1ESiwMjA43dUhAgVcVSZ2gwE
         c/s4KiGiQ3fL36I5PaX3fYS/LMPhX24qYWq+D9q5Q8pAPd0IhTDaC+oIn0KJI58mjrvZ
         mZEA==
X-Gm-Message-State: AOAM5304029kAoqAETHTi6wHUJtRnCOe5aSVOHjldedMbReISy58pIuR
        jBrh+VciuCVYYVwpvtogP24=
X-Google-Smtp-Source: ABdhPJyA5LMPZbeW2AKUuyQfFd2B+AnsG8nYmNj5aFUaYLQ1ceiwIRgb8tBgJDuXZr9Ihl+JjpNnDQ==
X-Received: by 2002:a1c:5a06:: with SMTP id o6mr4231660wmb.181.1604601161105;
        Thu, 05 Nov 2020 10:32:41 -0800 (PST)
Received: from matteo-xps-15-9560.lan ([2a01:4b00:a40c:9900::14e])
        by smtp.gmail.com with ESMTPSA id h8sm3569601wro.14.2020.11.05.10.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 10:32:40 -0800 (PST)
From:   Matteo Scordino <matteo.scordino@gmail.com>
To:     mripard@kernel.org, wens@csie.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Matteo Scordino <matteo.scordino@gmail.com>
Subject: [PATCH v4 3/3] ARM: dts: sun8i: s3: Add dts for the Elimo Initium SBC
Date:   Thu,  5 Nov 2020 18:32:31 +0000
Message-Id: <20201105183231.12952-4-matteo.scordino@gmail.com>
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
 arch/arm/boot/dts/sun8i-s3-elimo-initium.dts | 29 ++++++++++++++++++++
 2 files changed, 30 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun8i-s3-elimo-initium.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 4f0adfead547..50e438ab8a00 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1208,6 +1208,7 @@ dtb-$(CONFIG_MACH_SUN8I) += \
 	sun8i-r16-nintendo-super-nes-classic.dtb \
 	sun8i-r16-parrot.dtb \
 	sun8i-r40-bananapi-m2-ultra.dtb \
+	sun8i-s3-elimo-initium.dtb \
 	sun8i-s3-lichee-zero-plus.dtb \
 	sun8i-s3-pinecube.dtb \
 	sun8i-t3-cqa3t-bv3.dtb \
diff --git a/arch/arm/boot/dts/sun8i-s3-elimo-initium.dts b/arch/arm/boot/dts/sun8i-s3-elimo-initium.dts
new file mode 100644
index 000000000000..039677c2cc65
--- /dev/null
+++ b/arch/arm/boot/dts/sun8i-s3-elimo-initium.dts
@@ -0,0 +1,29 @@
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
+		     "allwinner,sun8i-v3";
+
+	aliases {
+		serial1 = &uart1;
+	};
+};
+
+&uart1 {
+	pinctrl-0 = <&uart1_pg_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&emac {
+	phy-handle = <&int_mii_phy>;
+	phy-mode = "mii";
+	status = "okay";
+};
-- 
2.20.1

