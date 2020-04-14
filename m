Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B424A1A761A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Apr 2020 10:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436858AbgDNIaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 04:30:23 -0400
Received: from gloria.sntech.de ([185.11.138.130]:38214 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436827AbgDNI34 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 04:29:56 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1jOGx4-0007Fi-SK; Tue, 14 Apr 2020 10:29:50 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-rockchip@lists.infradead.org
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        mark.rutland@arm.com, christoph.muellner@theobroma-systems.com,
        robin.murphy@arm.com, heiko@sntech.de,
        linux-arm-kernel@lists.infradead.org, kever.yang@rock-chips.com,
        linux-kernel@vger.kernel.org, jbx6244@gmail.com,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Subject: [PATCH v4 1/3] arm64: dts: rockchip: add core devicetree for rk3326
Date:   Tue, 14 Apr 2020 10:29:36 +0200
Message-Id: <20200414082938.2977572-1-heiko@sntech.de>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>

The rk3326 is basically a px30 without the second display controller.
So add a dtsi based on that, that just removes the affected nodes.

Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
---
 arch/arm64/boot/dts/rockchip/rk3326.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3326.dtsi

diff --git a/arch/arm64/boot/dts/rockchip/rk3326.dtsi b/arch/arm64/boot/dts/rockchip/rk3326.dtsi
new file mode 100644
index 000000000000..2ba6da125137
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3326.dtsi
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2020 Fuzhou Rockchip Electronics Co., Ltd
+ */
+
+#include "px30.dtsi"
+
+&display_subsystem {
+	ports = <&vopb_out>;
+};
+
+/delete-node/ &dsi_in_vopl;
+/delete-node/ &lvds_vopl_in;
+/delete-node/ &vopl;
+/delete-node/ &vopl_mmu;
-- 
2.24.1

