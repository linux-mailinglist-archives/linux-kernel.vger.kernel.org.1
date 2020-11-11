Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2514F2AFC61
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 02:36:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728671AbgKLBfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 20:35:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727904AbgKKXYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 18:24:32 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C53EC061A47;
        Wed, 11 Nov 2020 15:23:54 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id q5so2727748pfk.6;
        Wed, 11 Nov 2020 15:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3B8siPBqoy9NOw638bUt0dT90coPyLNV0X2/B+nIWhw=;
        b=TZZF18LiB6b8PKG1wKr1RWLPPFjmBF0Puw0O84gbQP8HTwS5mVSZ/9dbuhTTmlsgEI
         iqHTeJo/a8ce0bYENbr7oKAKqkqIWlyx0MlEr7Cis2IMCk5XLbkc0zWDi6ddaUsNUMnC
         /0/ppXyZgeDQCAJ+xJB/Kj1B9D2+D92RKqBEK8DxTw62LKmj3T6b8kHYJxnSzuOO2GHP
         pe4Up+ZTIsD8+L/ZsortJ3S9rNRTvIFxMnzUX0p8aMF116Sxd7zO/ebXbNlXcDCN3pib
         fWlS4fEtvUChT46nP4E9/vEGKcAoujhqu3hDq925pIDQG4gCSwWZi65T7/ypQWvp/1/2
         dM0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3B8siPBqoy9NOw638bUt0dT90coPyLNV0X2/B+nIWhw=;
        b=QVX/6rhLjxLNPCAbNaJaa1kkKtHHGUtxTRzF6jp8+9IgCSeF9BSOdE1B38NSsFi+dd
         SHWacADZZ0aawGxfkkCHxGZheVM67QlYrBBqGNFNNOgBsUE44YT33SIgizLwlhKvaaob
         SCU3SNylf7mPqHp5qkRIzi9eCwmC3tmt51AD+1ZdNn0DppEC0wWVmX/Z0BxRUG9pQU8J
         t4qxm7gVKdPpo0VQAAuS4pErOlPCRjh/iFx8cBZKOdQfLV7t/hVtCuMxddhMuKeUSHDy
         pGjH+84IW6RrWobHLR4Oc7nB89E1nVqjcgjFS/nHoBnlKx7/2fweWfxcXPAT2MGO3wvP
         uKbg==
X-Gm-Message-State: AOAM531lChTIf+z4a2SC8Exvde3RpUCAcAmJk6+6NNqSEZqRPZo4n8Vb
        x2+Cixzv+eGdF9rTiBUfKAk=
X-Google-Smtp-Source: ABdhPJzXSCz0fSwlU9ctg/9/ozst9ZYw73DDH4dg6jtlfrc7nxC+dsB6D0jkvVLejD9FWscsGXPB6g==
X-Received: by 2002:a62:6496:0:b029:155:b152:f0cf with SMTP id y144-20020a6264960000b0290155b152f0cfmr25431894pfb.75.1605137033967;
        Wed, 11 Nov 2020 15:23:53 -0800 (PST)
Received: from taoren-ubuntu-R90MNF91.thefacebook.com (c-73-252-146-110.hsd1.ca.comcast.net. [73.252.146.110])
        by smtp.gmail.com with ESMTPSA id a128sm3901431pfb.195.2020.11.11.15.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 15:23:53 -0800 (PST)
From:   rentao.bupt@gmail.com
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, taoren@fb.com
Cc:     Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH 4/4] ARM: dts: aspeed: Add Facebook Galaxy100 (AST2400) BMC
Date:   Wed, 11 Nov 2020 15:23:30 -0800
Message-Id: <20201111232330.30843-5-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201111232330.30843-1-rentao.bupt@gmail.com>
References: <20201111232330.30843-1-rentao.bupt@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tao Ren <rentao.bupt@gmail.com>

Add initial version of device tree for Facebook Galaxy100 (AST2400) BMC.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
 arch/arm/boot/dts/Makefile                    |  1 +
 .../dts/aspeed-bmc-facebook-galaxy100.dts     | 57 +++++++++++++++++++
 2 files changed, 58 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-facebook-galaxy100.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 21477ef5c5c9..1917cd47204a 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1383,6 +1383,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-bmc-arm-stardragon4800-rep2.dtb \
 	aspeed-bmc-bytedance-g220a.dtb \
 	aspeed-bmc-facebook-cmm.dtb \
+	aspeed-bmc-facebook-galaxy100.dtb \
 	aspeed-bmc-facebook-minipack.dtb \
 	aspeed-bmc-facebook-tiogapass.dtb \
 	aspeed-bmc-facebook-wedge40.dtb \
diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-galaxy100.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-galaxy100.dts
new file mode 100644
index 000000000000..dcf213472749
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-galaxy100.dts
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright (c) 2020 Facebook Inc.
+/dts-v1/;
+
+#include "ast2400-facebook-netbmc-common.dtsi"
+
+/ {
+	model = "Facebook Galaxy 100 BMC";
+	compatible = "facebook,galaxy100-bmc", "aspeed,ast2400";
+
+	chosen {
+		stdout-path = &uart5;
+		bootargs = "console=ttyS0,9600n8 root=/dev/ram rw";
+	};
+
+	ast-adc-hwmon {
+		compatible = "iio-hwmon";
+		io-channels = <&adc 3>, <&adc 4>, <&adc 8>, <&adc 9>;
+	};
+};
+
+&wdt2 {
+	status = "okay";
+	aspeed,reset-type = "system";
+};
+
+&fmc {
+	flash@1 {
+		status = "okay";
+		m25p,fast-read;
+		label = "spi0.1";
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			flash1@0 {
+				reg = <0x0 0x2000000>;
+				label = "flash1";
+			};
+		};
+	};
+};
+
+
+&i2c9 {
+	status = "okay";
+};
+
+&vhub {
+	status = "okay";
+};
+
+&adc {
+	status = "okay";
+};
-- 
2.17.1

