Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 686F826FB8E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 13:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgIRLeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 07:34:37 -0400
Received: from mx1.tq-group.com ([62.157.118.193]:17964 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726473AbgIRLeF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 07:34:05 -0400
IronPort-SDR: Zxnaki3xnCSWLAIc6ng+qlFkgPUuxN1kgLMzwShO/zsgjMOAxBszXehXyiibHb05w/0lSPXm6B
 ayw5oBix83mV8++7KI043qP6kWMYrjqBZUSlwZg3h2en3iftnjzpqfvIBjVqaHrmA7P3kIK1w9
 3+TPyPmBPGjCIoQx9bXUOw2WGxdQl8FVgoACoruMrWztdb0Mo3SXtbheoKk65rNldUaA3Ubz+C
 q2y5N50T5kxV2XACGyG+kfghvTl4S5b2GDhbdNO3/+Tg3GxyJWWrOSFwGpZrp8/P4Jlo2d3Rz9
 3VI=
X-IronPort-AV: E=Sophos;i="5.77,274,1596492000"; 
   d="scan'208";a="13924492"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 18 Sep 2020 13:31:14 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Fri, 18 Sep 2020 13:31:14 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Fri, 18 Sep 2020 13:31:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1600428674; x=1631964674;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=7IDA/wwgpwIJl3V5tL4w/bw+MbsXMBFTskZJNIV7rBg=;
  b=J6HZ2ryL2WuwImMvv5VQ3EJcxhwRB1iZGDX5IPpxp2NpdZB+UaYiRdpN
   nY8JXr3/maGuRGBryKIaONV+904ifwOQKEBduT5ybtytfKR1Y8zmDqPVr
   e+qiUs0PvJp/olzIx4EZknFX9kB5t2qEUkJaw4qK2JsfhxJhTY1f5Blgt
   rARTieucRTseoRGQuNp669bIS/XZKHzrCnNFHlaYkX8N2AnZjkv14vmrn
   ge2hT1MC3X8FMVA6FbZDVsto9DmPzu3BjA/mgbiqctLmZWvtBoyJCd99f
   ng3RHhLKbxaXfqFf4xTa/OtZOryvcYNXWGjH2G5LCo/iNitTTg722xAC7
   g==;
IronPort-SDR: N0Nwl1+ph9m4zwF4W9Pjiy9MgNTXRW43XBJrgEPrtQHeSuHCgMEWxUmonoMSCoQIoAIcioiaD6
 oJC4FhDB1QKpc8HLI/wy+2Dxct6lpFpGmWsDsSXCjFvW74iZiLri39ek9nJRy2neEdlK1ijYy9
 +Gz3TGaniKSy1d3xJYHWbcOH+ZBQIQeQL1GmzucZt0VjgrrMBiNzV/3pegTZqKOeYIA6lNzPl4
 ffxViWblNZdMg6NeF2L4AYAzBQjFuhS0lK/C7XqNek1kFEGRkJ4tfAzofn0JKpDyTwmJejQfYQ
 PNw=
X-IronPort-AV: E=Sophos;i="5.77,274,1596492000"; 
   d="scan'208";a="13924491"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 18 Sep 2020 13:31:14 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.117.48.12])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id DA7BE280075;
        Fri, 18 Sep 2020 13:31:13 +0200 (CEST)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH 10/13] ARM: dts: imx7-mba7: add default SPI-NOR flash partition layout
Date:   Fri, 18 Sep 2020 13:29:39 +0200
Message-Id: <20200918112942.1367-10-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200918112942.1367-1-matthias.schiffer@ew.tq-group.com>
References: <20200918112942.1367-1-matthias.schiffer@ew.tq-group.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the partition layout also used by the bootloader.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 arch/arm/boot/dts/imx7-mba7.dtsi | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/imx7-mba7.dtsi b/arch/arm/boot/dts/imx7-mba7.dtsi
index 9cfaf0a91100..f1e50bcd21a5 100644
--- a/arch/arm/boot/dts/imx7-mba7.dtsi
+++ b/arch/arm/boot/dts/imx7-mba7.dtsi
@@ -237,6 +237,38 @@
 	};
 };
 
+&flash0 {
+	uboot@0 {
+		label = "U-Boot";
+		reg = <0x0 0xd0000>;
+	};
+
+	env1@d0000 {
+		label = "ENV1";
+		reg = <0xd0000 0x10000>;
+	};
+
+	env2@e0000 {
+		label = "ENV2";
+		reg = <0xe0000 0x10000>;
+	};
+
+	dtb@f0000 {
+		label = "DTB";
+		reg = <0xf0000 0x10000>;
+	};
+
+	linux@100000 {
+		label = "Linux";
+		reg = <0x100000 0x700000>;
+	};
+
+	rootfs@800000 {
+		label = "RootFS";
+		reg = <0x800000 0x3800000>;
+	};
+};
+
 &flexcan1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_flexcan1>;
-- 
2.17.1

