Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EECE2AFC5E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 02:35:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbgKLBff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 20:35:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727895AbgKKXX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 18:23:56 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE9FCC0617A6;
        Wed, 11 Nov 2020 15:23:48 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id k7so1792386plk.3;
        Wed, 11 Nov 2020 15:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DmCrvjpAUpHnNbD1lkcgSKsP0QAPloTIQfmWpnOPB6c=;
        b=reLJJMyPdImrWK05zeLDBEyEa+lRFqCxJL2fiD3yq3ecHIyBqW4XFTT8XcjleNy9m3
         wg0L/IhbV2ukdebXrv9JnMC9XYmn8IAoS/XtVsFrIOygkMGKYDfGho4GtQ2j4RPzMH/a
         UdZQqvA9O2MVjrFxUII1JEl24x88Lnxv4sOSWmc0jmf5cpYT3M0+VybSYXe3beGScVzW
         +YBS8wBYPvBCUXFQJ77x7zxheM8ZNjflJ/cn1GVfLXxtAh7oUZuunYj3hK8aESlD7ts4
         OJozDB2QvkxSJbO2h0LKK0HNo8UBDq/RFggxG6O2iuP/7109ccMkE8fbkecRXrkc5Qgu
         W4lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DmCrvjpAUpHnNbD1lkcgSKsP0QAPloTIQfmWpnOPB6c=;
        b=EoKqYk8beWZVdbqB9ZqK2XVP8vo+aqimUn1sKFpd6XSGTvC5pogeuVSzVW7Q3QAhqF
         5zCNNAf2Hz2RYCtRuy2fVceTFk6XV3+1o0FkZ4+CYoFe4C5tUi06scVyLcCUyUf6CjRA
         WKrkccWo1GpVJoxbNaMPvsgW+mINlQmI6e82FoUFZhWFIrENKWrMy2ZT9kS1J7K7WoWM
         Ywu9OBSR2YuGIc25BDm8NDltijOFuPz+R0SY/SHHoh9JgieVCe1sIU0HWVNh6fgdebA8
         XuZt+LAbmi9wLTnuGpjXLNHEJxDaRqQIJfhDK56a8eg5yM87Iku/OIbgR90ybX883hc7
         SnWA==
X-Gm-Message-State: AOAM531Ucal+GtfxWUUAheipd3A1oPHrJGsK/jqAGTL06ao+6oo8Qn1p
        cnHH5Wnr15imMyMDFknb4aY=
X-Google-Smtp-Source: ABdhPJx7DNOCqgSH2RzbcEL3w1fsullIxZN84n7XV8wUg6NQo+acSWRmrtrjziKiamGQXEM/LOxiUA==
X-Received: by 2002:a17:902:328:b029:d7:eba5:83ce with SMTP id 37-20020a1709020328b02900d7eba583cemr10218120pld.57.1605137028251;
        Wed, 11 Nov 2020 15:23:48 -0800 (PST)
Received: from taoren-ubuntu-R90MNF91.thefacebook.com (c-73-252-146-110.hsd1.ca.comcast.net. [73.252.146.110])
        by smtp.gmail.com with ESMTPSA id a128sm3901431pfb.195.2020.11.11.15.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 15:23:47 -0800 (PST)
From:   rentao.bupt@gmail.com
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, taoren@fb.com
Cc:     Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH 1/4] ARM: dts: aspeed: Common dtsi for Facebook AST2400 Network BMCs
Date:   Wed, 11 Nov 2020 15:23:27 -0800
Message-Id: <20201111232330.30843-2-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201111232330.30843-1-rentao.bupt@gmail.com>
References: <20201111232330.30843-1-rentao.bupt@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tao Ren <rentao.bupt@gmail.com>

This common descirption is included by all Facebook AST2400 Network BMC
platforms to minimize duplicated device entries across Facebook Network
BMC device trees.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
 .../dts/ast2400-facebook-netbmc-common.dtsi   | 117 ++++++++++++++++++
 1 file changed, 117 insertions(+)
 create mode 100644 arch/arm/boot/dts/ast2400-facebook-netbmc-common.dtsi

diff --git a/arch/arm/boot/dts/ast2400-facebook-netbmc-common.dtsi b/arch/arm/boot/dts/ast2400-facebook-netbmc-common.dtsi
new file mode 100644
index 000000000000..73a5503be78c
--- /dev/null
+++ b/arch/arm/boot/dts/ast2400-facebook-netbmc-common.dtsi
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright (c) 2020 Facebook Inc.
+/dts-v1/;
+
+#include "aspeed-g4.dtsi"
+
+/ {
+	aliases {
+		/*
+		 * Override the default uart aliases to avoid breaking
+		 * the legacy applications.
+		 */
+		serial0 = &uart5;
+		serial1 = &uart1;
+		serial2 = &uart3;
+		serial3 = &uart4;
+	};
+
+	memory@40000000 {
+		reg = <0x40000000 0x20000000>;
+	};
+};
+
+&wdt1 {
+	status = "okay";
+	aspeed,reset-type = "system";
+};
+
+&fmc {
+	status = "okay";
+	flash@0 {
+		status = "okay";
+		m25p,fast-read;
+		label = "spi0.0";
+#include "facebook-bmc-flash-layout.dtsi"
+	};
+};
+
+&uart1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_txd1_default
+		     &pinctrl_rxd1_default>;
+};
+
+&uart3 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_txd3_default
+		     &pinctrl_rxd3_default>;
+};
+
+&uart4 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_txd4_default
+		     &pinctrl_rxd4_default
+		     &pinctrl_ndts4_default>;
+};
+
+&uart5 {
+	status = "okay";
+};
+
+&mac1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rgmii2_default &pinctrl_mdio2_default>;
+};
+
+&i2c0 {
+	status = "okay";
+};
+
+&i2c1 {
+	status = "okay";
+};
+
+&i2c2 {
+	status = "okay";
+};
+
+&i2c3 {
+	status = "okay";
+};
+
+&i2c4 {
+	status = "okay";
+};
+
+&i2c5 {
+	status = "okay";
+};
+
+&i2c6 {
+	status = "okay";
+};
+
+&i2c7 {
+	status = "okay";
+};
+
+&i2c8 {
+	status = "okay";
+};
+
+&i2c11 {
+	status = "okay";
+};
+
+&i2c12 {
+	status = "okay";
+};
+
+&vhub {
+	status = "okay";
+};
-- 
2.17.1

