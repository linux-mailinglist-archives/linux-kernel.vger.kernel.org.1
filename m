Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 578B526FB90
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 13:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbgIRLeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 07:34:44 -0400
Received: from mx1.tq-group.com ([62.157.118.193]:17964 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726394AbgIRLeD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 07:34:03 -0400
IronPort-SDR: hH7aTsrUf+zwXkTcUYAH3qH8hN8InvdmqPLEddH5RpGyUmWTTlQx4+smv539F5iAL1Kc6LOT5l
 stTCB80tuzswU3ZCbpCJRXoAAISmnSU5gBdk+s2niaPSCPpakSoAtAsfKoDhaJ9ORS2lUstjeQ
 hM3y1/+tmPSEszPKqfp6GER4zULEhF8NxCbQjk1O6cmzGzQNbMtCv38SPyl9r6nuA6Pd/hiK15
 2d77DvIH0MVOKgqsmR83EP3pL6zxk9La0P1sUPtNUMSU3B3M76XNoxS/q10zwx0Bz5LKVqd/l/
 83E=
X-IronPort-AV: E=Sophos;i="5.77,274,1596492000"; 
   d="scan'208";a="13924486"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 18 Sep 2020 13:31:13 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Fri, 18 Sep 2020 13:31:13 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Fri, 18 Sep 2020 13:31:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1600428673; x=1631964673;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=RhJw7qVs1U+Nud40Q7EXtizW37E1QKriVVP83cxxSj8=;
  b=GQ9hyg4rDz+aYmt3BuycS10m4pGdiONPfpk7JirooyRuCoSUYWw6mbi0
   8oNtqcZOudh6euojwrZ6lQ/8ZfE7gOzQargV6x8OT/a2qNXeYpxVhTkgU
   atxCS9Udpi8Zr8kzEjc5K9tfMvmdrfyMOSzivASJDGHlYO+kRP1D43Fs9
   fgwg0vDBXwVYFWKS4nf0oCz/WJtrD3wzWycyEuBEj98wW8NtVPA3vr1iy
   X+fRIwoCqVNwaro1n9PMyEA6jXSOTCpgNzeQ0z6bWMqeAeOG/oML1EKel
   vIYErjSnBAcHHEJ6B/5qKPnVLgspdIeooh7UJZANo6Pzu9ukmsMXocQ1p
   w==;
IronPort-SDR: C4I4UKC8x5hz4y9YcaJgmzxM2zAky5mpBu3LKpRNZV2V5gr9kCVA2XqddPg9MDFMEnZ404Daer
 Je42DLHemJAW4eY9W7AF1+YDlxRmQPll+bCEZD6QZrRxhm52zhnTW0XpKSieXk0cpBkkUi6ubL
 2IeIZqrRuM2Lwc8YKCjKIIAKTIgnYp3wHeJZujnqaFlN7FC9X5EBb8iypMk187woxrYxgKDP1V
 MV/UfYpuAALy41TcpJA+52WUVsFkS/srllYctszL5fbyS8mMMx5wjfp6kSm/zKNeWdBu1U8QWF
 7PE=
X-IronPort-AV: E=Sophos;i="5.77,274,1596492000"; 
   d="scan'208";a="13924485"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 18 Sep 2020 13:31:13 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.117.48.12])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 3B74C280070;
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
Subject: [PATCH 07/13] ARM: dts: imx7-mba7: configure watchdog
Date:   Fri, 18 Sep 2020 13:29:36 +0200
Message-Id: <20200918112942.1367-7-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200918112942.1367-1-matthias.schiffer@ew.tq-group.com>
References: <20200918112942.1367-1-matthias.schiffer@ew.tq-group.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The external watchdog reset is necessary, as the internal reset is
unreliable on i.MX7.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 arch/arm/boot/dts/imx7-mba7.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/imx7-mba7.dtsi b/arch/arm/boot/dts/imx7-mba7.dtsi
index 9be225bb135a..84b5809f384c 100644
--- a/arch/arm/boot/dts/imx7-mba7.dtsi
+++ b/arch/arm/boot/dts/imx7-mba7.dtsi
@@ -467,6 +467,12 @@
 			MX7D_PAD_LPSR_GPIO1_IO05__GPIO1_IO5	0x59
 		>;
 	};
+
+	pinctrl_wdog1: wdog1grp {
+		fsl,pins = <
+			MX7D_PAD_LPSR_GPIO1_IO00__WDOG1_WDOG_B	0x30
+		>;
+	};
 };
 
 &pwm1 {
@@ -543,3 +549,9 @@
 	no-1-8-v;
 	status = "okay";
 };
+
+&wdog1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdog1>;
+	fsl,ext-reset-output;
+};
-- 
2.17.1

