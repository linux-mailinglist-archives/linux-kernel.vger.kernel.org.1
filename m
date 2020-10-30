Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63E172A02CF
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 11:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbgJ3K1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 06:27:25 -0400
Received: from mx1.tq-group.com ([62.157.118.193]:6981 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725993AbgJ3K1X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 06:27:23 -0400
IronPort-SDR: o6O08EGS7bTOtn37NhFXoZFR5YcHzmc4gGGY1zMFH2ElbuKIFMMncMnygFxy3CJehyVQNalOHN
 8Wo+ruTprDRG5Rba9uaxgj/yRSyR0eJ1Xos0Awchi8t0/Bd/cIWVrEourucA+uUZmojAD3lC3u
 hEMWJ1JGU0Pv0GuIpzK2vafhWXcvN07zrN0x78Hwn/x2vpMEBPcelujtoKIbKx7n4oFf0truL6
 0Dszi3ocEzJhx8IxGjh0ELVA8oSr0Cb8CmdHZScLAa78RXN4rCJb3ftGh3u0o+yp+s/1AF2HBt
 /dw=
X-IronPort-AV: E=Sophos;i="5.77,432,1596492000"; 
   d="scan'208";a="14511048"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 30 Oct 2020 11:27:21 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Fri, 30 Oct 2020 11:27:20 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Fri, 30 Oct 2020 11:27:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1604053641; x=1635589641;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=B4aRjAdCIiT+jqxl5xeNc+oGMypf6gdkXGtOqsQkS8E=;
  b=J4m5uUOhm8/eYyzaqdt8o/MotSCu6t4YDjvJyJePQ6Jb7lIw6EBole+H
   pqiH13yXlaMy8MjbkYtyaV4HSky4Oc++0RlatNXAdPszKof3lANFvdC16
   CcBdn2kRReC7ebIg+4n3/Qw+j9TMJU0OP8r6dFdj7dG+uIfp7+iAAoHfd
   xFMR/yM/MKejxecPnMR5eiCVTT3NqXKZJJ7Unmd4R6nP1x5ReKddmDzjD
   lTRSYD7jGKgcAoCH1j3zF/BoV27MykgkGVeQY9KrussoyP2DT4GIphGAZ
   YxPMbb8yB6a5kHrebkQmdK0Nsd2rtOpNydt5SPRXoDa6WfbkQLOGEiwRG
   w==;
IronPort-SDR: 2rw6PDEGMfLEp0p/dSZqqiTww5nauUVCLPDSwcdf2JnQ9aQFtGOEiP+vxQJQfZf6SlEG1milwQ
 hNiOHbeqaSF+uge24txgcBKMovWbB7pAcPcleud1YuAsvC9ldAu8vk6SbG14na027Rwswfk0JG
 W68FmGLWlAOV5AMfJqnKcXWSAVjlRfCyWhoLWOp2t5izdHGTCvvAhDT4BFQ0sIrucNi01gZ7LO
 KdB9oNfxuFexaJsbXamgrCSTRsW8tl1IMi56u9H1LTZgooID7CpHv9BK3LhQ00QH2KqBBBnXHo
 z8k=
X-IronPort-AV: E=Sophos;i="5.77,432,1596492000"; 
   d="scan'208";a="14511046"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 30 Oct 2020 11:27:21 +0100
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.117.48.12])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id EFF03280075;
        Fri, 30 Oct 2020 11:27:20 +0100 (CET)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH v2 2/2] ARM: dts: imx7-mba7: add default SPI-NOR flash partition layout
Date:   Fri, 30 Oct 2020 11:26:36 +0100
Message-Id: <20201030102636.16476-2-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201030102636.16476-1-matthias.schiffer@ew.tq-group.com>
References: <20201030102636.16476-1-matthias.schiffer@ew.tq-group.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the partition layout also used by the bootloader.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 arch/arm/boot/dts/imx7-mba7.dtsi | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

v2: no changes


diff --git a/arch/arm/boot/dts/imx7-mba7.dtsi b/arch/arm/boot/dts/imx7-mba7.dtsi
index c6d1c63f7905..3683f97f946f 100644
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

